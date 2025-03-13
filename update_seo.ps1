# PowerShell-skript for å oppdatere SEO-struktur i markdown-filer
# Kjør dette skriptet fra prosjektets rotmappe

# Funksjon for å generere alt-tekst basert på filnavn og kategori
function Get-AltText {
    param (
        [string]$fileName,
        [string]$category
    )
    
    $altTexts = @{
        "bursdagshilsen" = "En festlig bursdagskake med lys som symboliserer feiring og glede"
        "bryllup" = "Et vakkert bryllupsbilde med ringer og blomster som symboliserer kjærlighet og forening"
        "dikt" = "En åpen bok med penn som symboliserer poesi og kreativt uttrykk"
        "visdomsord" = "Et stearinlys som brenner stille, symboliserer refleksjon og visdom"
        "uncategorized" = "Et illustrativt bilde relatert til artikkelens tema"
        "default" = "Et illustrativt bilde relatert til artikkelens tema"
    }
    
    if ($altTexts.ContainsKey($category)) {
        return $altTexts[$category]
    } else {
        return $altTexts["default"]
    }
}

# Funksjon for å generere SEO-metadata basert på filnavn og kategori
function Get-SeoMetadata {
    param (
        [string]$title,
        [string]$category,
        [string]$fileName
    )
    
    $metadata = @{
        "seo_title" = "$title - Teksttips"
        "seo_description" = "Finn de beste tekstene og forslagene for $title. Vi har samlet kreative og personlige tekster for enhver anledning."
        "text_type" = ""
        "occasion" = ""
        "mood" = ""
        "target_audience" = "alle aldre"
        "number_of_texts" = 30
    }
    
    # Sett text_type og occasion basert på kategori
    switch -Regex ($category) {
        "bursdagshilsen" { $metadata["text_type"] = "gratulasjon"; $metadata["occasion"] = "bursdag"; $metadata["mood"] = "festlig" }
        "bryllup" { $metadata["text_type"] = "gratulasjon"; $metadata["occasion"] = "bryllup"; $metadata["mood"] = "kjærlig" }
        "dikt" { $metadata["text_type"] = "dikt"; $metadata["mood"] = "reflekterende" }
        "visdomsord" { $metadata["text_type"] = "visdomsord"; $metadata["mood"] = "reflekterende" }
        "kondolanse" { $metadata["text_type"] = "kondolanse"; $metadata["occasion"] = "dødsfall"; $metadata["mood"] = "medfølende" }
        default { $metadata["text_type"] = "tekst"; $metadata["mood"] = "informativ" }
    }
    
    # Sett occasion basert på filnavn hvis ikke allerede satt
    if ($metadata["occasion"] -eq "") {
        if ($fileName -match "bursdag") { $metadata["occasion"] = "bursdag" }
        elseif ($fileName -match "bryllup") { $metadata["occasion"] = "bryllup" }
        elseif ($fileName -match "dåp|dap") { $metadata["occasion"] = "dåp" }
        elseif ($fileName -match "pensjon") { $metadata["occasion"] = "pensjonering" }
        elseif ($fileName -match "vennskap") { $metadata["occasion"] = "vennskap" }
        elseif ($fileName -match "mamma|mor") { $metadata["occasion"] = "morsdag" }
        elseif ($fileName -match "pappa|far") { $metadata["occasion"] = "farsdag" }
        elseif ($fileName -match "jul") { $metadata["occasion"] = "jul" }
        elseif ($fileName -match "nyttår") { $metadata["occasion"] = "nyttår" }
    }
    
    # Sett mood basert på filnavn hvis ikke allerede satt
    if ($metadata["mood"] -eq "") {
        if ($fileName -match "morsom|humor") { $metadata["mood"] = "morsom" }
        elseif ($fileName -match "kjærlig|kjærlighet") { $metadata["mood"] = "kjærlig" }
        elseif ($fileName -match "trist|sorg") { $metadata["mood"] = "trist" }
        elseif ($fileName -match "inspirerende") { $metadata["mood"] = "inspirerende" }
    }
    
    # Sett target_audience basert på filnavn
    if ($fileName -match "barn") { $metadata["target_audience"] = "barn" }
    elseif ($fileName -match "voksen") { $metadata["target_audience"] = "voksne" }
    elseif ($fileName -match "kollega") { $metadata["target_audience"] = "kollegaer" }
    elseif ($fileName -match "venn") { $metadata["target_audience"] = "venner" }
    elseif ($fileName -match "60|70|80|90") { $metadata["target_audience"] = "eldre" }
    
    # Sett number_of_texts basert på filnavn
    if ($fileName -match "(\d+)") {
        $number = [int]$Matches[1]
        if ($number -gt 0) {
            $metadata["number_of_texts"] = $number
        }
    }
    
    return $metadata
}

# Finn alle markdown-filer i content-mappen
$files = Get-ChildItem -Path "content" -Recurse -Filter "*.md"

foreach ($file in $files) {
    Write-Host "Oppdaterer $($file.FullName)..."
    
    # Les filinnhold
    $content = Get-Content -Path $file.FullName -Raw
    
    # Sjekk om filen har front matter
    if ($content -match "^---\s*\n(.*?)\n---\s*\n") {
        $frontMatter = $Matches[1]
        $category = $file.Directory.Name
        $fileName = $file.BaseName
        
        # Hent tittel
        $title = ""
        if ($frontMatter -match "title:\s*`"([^`"]*)`"") {
            $title = $Matches[1]
        }
        
        # Sjekk om featured_image mangler
        if (-not ($frontMatter -match "featured_image:")) {
            $imageName = $fileName.ToLower().Replace(" ", "-") + ".webp"
            $content = $content -replace "(author:\s*`"[^`"]*`")", "`$1`nfeatured_image: `"$imageName`""
        }
        
        # Sjekk om image_alt mangler
        if (-not ($frontMatter -match "image_alt:")) {
            $altText = Get-AltText -fileName $fileName -category $category
            
            # Sjekk om featured_image finnes
            if ($frontMatter -match "featured_image:\s*`"([^`"]*)`"") {
                $featuredImage = $Matches[1]
                
                # Legg til image_alt etter featured_image
                $content = $content -replace "featured_image:\s*`"([^`"]*)`"", "featured_image: `"$featuredImage`"`nimage_alt: `"$altText`""
            }
        }
        
        # Generer SEO-metadata
        $seoMetadata = Get-SeoMetadata -title $title -category $category -fileName $fileName
        
        # Oppdater seo_title og seo_description hvis de mangler eller er tomme
        if (-not ($frontMatter -match "seo_title:\s*`"[^`"]+`"")) {
            $content = $content -replace "seo_title:\s*`"`"", "seo_title: `"$($seoMetadata["seo_title"])`""
            if (-not ($content -match "seo_title:")) {
                $content = $content -replace "(# SEO\s*\n)", "`$1seo_title: `"$($seoMetadata["seo_title"])`"`n"
            }
        }
        
        if (-not ($frontMatter -match "seo_description:\s*`"[^`"]+`"")) {
            $content = $content -replace "seo_description:\s*`"`"", "seo_description: `"$($seoMetadata["seo_description"])`""
            if (-not ($content -match "seo_description:")) {
                $content = $content -replace "(seo_title:[^\n]*\n)", "`$1seo_description: `"$($seoMetadata["seo_description"])`"`n"
            }
        }
        
        # Oppdater strukturerte metadata hvis de mangler eller er tomme
        if (-not ($frontMatter -match "text_type:\s*`"[^`"]+`"")) {
            $content = $content -replace "text_type:\s*`"`"", "text_type: `"$($seoMetadata["text_type"])`""
        }
        
        if (-not ($frontMatter -match "occasion:\s*`"[^`"]+`"")) {
            $content = $content -replace "occasion:\s*`"`"", "occasion: `"$($seoMetadata["occasion"])`""
        }
        
        if (-not ($frontMatter -match "mood:\s*`"[^`"]+`"")) {
            $content = $content -replace "mood:\s*`"`"", "mood: `"$($seoMetadata["mood"])`""
        }
        
        if (-not ($frontMatter -match "target_audience:\s*`"[^`"]+`"")) {
            $content = $content -replace "target_audience:\s*`"`"", "target_audience: `"$($seoMetadata["target_audience"])`""
        }
        
        if (-not ($frontMatter -match "number_of_texts:\s*[1-9][0-9]*")) {
            $content = $content -replace "number_of_texts:\s*0", "number_of_texts: $($seoMetadata["number_of_texts"])"
        }
        
        # Skriv oppdatert innhold tilbake til filen
        Set-Content -Path $file.FullName -Value $content
    }
}

Write-Host "Oppdatering fullført!" 