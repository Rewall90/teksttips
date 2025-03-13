# Teksttips

Teksttips er en norsk nettside som tilbyr inspirerende tekster for alle livets anledninger. Enten du trenger bursdagshilsener, dikt, bryllupstekster eller visdomsord, finner du det her.

## Om prosjektet

Dette er et statisk nettsted bygget med [Hugo](https://gohugo.io/), en rask og moderne statisk nettstedsgenerator. Nettstedet er designet for å være raskt, SEO-vennlig og enkelt å vedlikeholde.

## Funksjoner

- Responsivt design som fungerer på alle enheter
- Kategoriserte tekster for ulike anledninger
- Søkefunksjonalitet
- Nyhetsbrevpåmelding
- Kontaktskjema

## Teknisk stack

- **Hugo**: Statisk nettstedsgenerator
- **Tailwind CSS**: For styling
- **Vanilla JavaScript**: For interaktivitet
- **Markdown**: For innhold

## Lokal utvikling

### Forutsetninger

- [Hugo Extended](https://gohugo.io/installation/) (v0.116.0 eller nyere)
- [Git](https://git-scm.com/)

### Installasjon

1. Klon repositoriet:
   ```bash
   git clone https://github.com/Rewall90/teksttips.git
   cd teksttips
   ```

2. Start Hugo-serveren:
   ```bash
   hugo server -D
   ```

3. Åpne nettleseren din og gå til [http://localhost:1313](http://localhost:1313)

### Bygg for produksjon

For å bygge nettstedet for produksjon:

```bash
hugo --minify
```

Dette vil generere en `public`-mappe med alle filene klare for publisering.

## Mappestruktur

- `content/`: Innholdsfiler i Markdown-format
- `layouts/`: HTML-maler
- `static/`: Statiske filer (bilder, CSS, JS)
- `themes/teksttips/`: Tilpasset tema for nettstedet

## Bidrag

Bidrag, problemer og funksjonsforespørsler er velkomne. Vennligst sjekk issues-siden på GitHub for å se om ditt problem allerede er rapportert.

## Lisens

Dette prosjektet er lisensiert under [MIT-lisensen](LICENSE). 