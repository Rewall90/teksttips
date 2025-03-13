# Sjekk om Chocolatey er installert
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installerer Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Installer WebP-verktøy hvis det ikke er installert
if (!(Get-Command cwebp -ErrorAction SilentlyContinue)) {
    Write-Host "Installerer WebP-verktøy..."
    choco install webp -y
}

# Funksjon for å konvertere et bilde til WebP
function Convert-ToWebP {
    param(
        [string]$imagePath
    )
    
    $directory = Split-Path -Parent $imagePath
    $filename = [System.IO.Path]::GetFileNameWithoutExtension($imagePath)
    $webpPath = Join-Path $directory "$filename.webp"
    
    # Konverter til WebP med god kvalitet (80)
    cwebp -q 80 $imagePath -o $webpPath
    
    if (Test-Path $webpPath) {
        Write-Host "Konverterte $imagePath til WebP"
        return $true
    }
    return $false
}

# Funksjon for å oppdatere markdown-filer
function Update-MarkdownReferences {
    param(
        [string]$mdFile,
        [string]$oldExt,
        [string]$newExt
    )
    
    $content = Get-Content $mdFile -Raw
    $updated = $content -replace "featured_image: `"([^`"]+)$oldExt`"", "featured_image: `"`$1$newExt`""
    $updated = $updated -replace "!\[([^\]]*)\]\(([^)]+)$oldExt\)", "![$1]($2$newExt)"
    
    Set-Content -Path $mdFile -Value $updated
    Write-Host "Oppdaterte bildereferanser i $mdFile"
}

# Finn alle bilder i content-mappen
$imageExtensions = @("*.jpg", "*.jpeg", "*.png")
$images = Get-ChildItem -Path "content" -Include $imageExtensions -Recurse

# Konverter hvert bilde
foreach ($image in $images) {
    $converted = Convert-ToWebP -imagePath $image.FullName
    
    if ($converted) {
        # Finn og oppdater markdown-filer i samme mappe
        $mdFiles = Get-ChildItem -Path $image.Directory -Filter "*.md"
        foreach ($mdFile in $mdFiles) {
            Update-MarkdownReferences -mdFile $mdFile.FullName -oldExt $image.Extension -newExt ".webp"
        }
    }
}

Write-Host "Konvertering fullført!" 