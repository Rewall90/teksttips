# Teksttips Hugo Theme

Et rent og moderne Hugo-tema spesielt designet for tekstbaserte nettsteder. Temaet er optimalisert for norskspråklige nettsteder med fokus på lesbarhet og brukervennlighet.

## Funksjoner

- Responsivt design som fungerer på alle enheter
- Ren og moderne layout
- Støtte for kategorier og stikkord
- SEO-optimalisert
- Innebygd søkefunksjonalitet
- Sosiale delingsknapper
- Brødsmulesti-navigasjon
- Optimalisert for norsk innhold

## Installasjon

1. Naviger til din Hugo-nettside
2. Kjør følgende kommando:
   ```bash
   git submodule add https://github.com/yourusername/hugo-teksttips-theme.git themes/teksttips
   ```
3. Oppdater din `config.toml`:
   ```toml
   theme = "teksttips"
   ```

## Konfigurasjon

### Nødvendige innstillinger i config.toml

```toml
baseURL = 'https://dinnettside.no/'
languageCode = 'nb-NO'
defaultContentLanguage = 'nb'
title = 'Din Nettside'
theme = 'teksttips'

[params]
  description = 'Din nettstedsbeskrivelse'
  author = 'Ditt Navn'
  mainSections = ['seksjoner', 'her']

[menu]
  [[menu.main]]
    name = 'Hjem'
    url = '/'
    weight = 1
  [[menu.main]]
    name = 'Kategorier'
    url = '/kategorier/'
    weight = 2
  [[menu.main]]
    name = 'Kontakt'
    url = '/kontakt/'
    weight = 3

[taxonomies]
  category = 'kategorier'
  tag = 'stikkord'
```

### Innholdsstruktur

```
content/
├── _index.md
├── kategori1/
│   ├── _index.md
│   ├── artikkel1.md
│   └── artikkel2.md
└── kategori2/
    ├── _index.md
    └── artikkel3.md
```

### Frontmatter for artikler

```yaml
---
title: "Artikkeltittel"
date: 2024-03-05
description: "Kort beskrivelse av artikkelen"
categories: ["Kategori1", "Kategori2"]
tags: ["stikkord1", "stikkord2"]
featured_image: "/images/artikkel-bilde.jpg"
---
```

## Tilpasning

### Farger og typografi

Fargene kan enkelt tilpasses ved å endre CSS-variabler i `static/css/main.css`:

```css
:root {
    --primary-color: #2c5282;
    --secondary-color: #4299e1;
    --text-color: #2d3748;
    --light-text: #718096;
    --background: #ffffff;
    --light-background: #f7fafc;
    --border-color: #e2e8f0;
}
```

## Lisens

Dette temaet er lisensiert under MIT-lisensen.
