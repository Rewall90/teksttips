const sharp = require('sharp');
const fs = require('fs').promises;
const path = require('path');

async function findImages(dir) {
    const files = await fs.readdir(dir, { withFileTypes: true });
    let images = [];

    for (const file of files) {
        const fullPath = path.join(dir, file.name);
        if (file.isDirectory()) {
            images = images.concat(await findImages(fullPath));
        } else if (/\.(jpg|jpeg|png)$/i.test(file.name)) {
            images.push(fullPath);
        }
    }

    return images;
}

async function convertToWebP(imagePath) {
    const outputPath = imagePath.replace(/\.(jpg|jpeg|png)$/i, '.webp');
    try {
        await sharp(imagePath)
            .webp({ quality: 80 })
            .toFile(outputPath);
        console.log(`Konverterte ${imagePath} til WebP`);
        
        // Oppdater markdown-filer i samme mappe
        const dir = path.dirname(imagePath);
        const files = await fs.readdir(dir);
        for (const file of files) {
            if (file.endsWith('.md')) {
                const mdPath = path.join(dir, file);
                let content = await fs.readFile(mdPath, 'utf8');
                const oldExt = path.extname(imagePath);
                content = content.replace(
                    new RegExp(`featured_image: "[^"]+${oldExt}"`, 'g'),
                    `featured_image: "${path.basename(outputPath)}"`
                );
                content = content.replace(
                    new RegExp(`!\\[([^\\]]*)\\]\\(([^)]+)${oldExt}\\)`, 'g'),
                    `![$1]($2.webp)`
                );
                await fs.writeFile(mdPath, content, 'utf8');
                console.log(`Oppdaterte referanser i ${mdPath}`);
            }
        }
    } catch (error) {
        console.error(`Feil ved konvertering av ${imagePath}:`, error);
    }
}

async function main() {
    try {
        const contentDir = path.join(process.cwd(), 'content');
        const images = await findImages(contentDir);
        
        for (const image of images) {
            await convertToWebP(image);
        }
        
        console.log('Konvertering fullført!');
    } catch (error) {
        console.error('Feil under konvertering:', error);
    }
}

main(); 