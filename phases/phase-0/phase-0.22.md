# Phase 0.22 — User-Provided Assets Setup

**Purpose:** Copy and organize all user-provided assets from the PROBA PROJECT folder into the correct `public/` directories, download the base fonts, and make everything ready for the theme system to reference.

**Asset Source:** `PROBA PROJECT-20260315T154736Z-3-001/PROBA PROJECT/` — this folder sits at the `D-D/` root level (one directory above the Next.js project root `dice-and-decisions/`).

---

## Step 1 — Create Public Directory Structure

Create these directories inside the Next.js project before copying anything:

```
public/
├── fonts/
└── images/
    ├── icons/
    │   ├── fantasy/
    │   ├── western/
    │   └── eldritch/
    ├── heroes/
    ├── npcs/
    ├── maps/
    ├── themes/
    └── designs/
        ├── western/
        └── eldritch/
```

---

## Step 2 — Copy Theme Backdrop Images

Each theme has one backdrop image. Copy these files to `public/images/themes/` and rename them to the standard naming convention:

| Theme | Source File (relative to `PROBA PROJECT/`) | Destination |
|---|---|---|
| Fantasy | `Fantasy/fantasy.jpg` | `public/images/themes/fantasy-backdrop.jpg` |
| Sci-Fi | `Sci-Fi/scifi.jpg` | `public/images/themes/scifi-backdrop.jpg` |
| Steampunk | `Steampunk/backdrop_steampunk.jpg` | `public/images/themes/steampunk-backdrop.jpg` |
| Western | `Western/vecteezy_flat-western-background-landscape-cowboys-in-desert-horse_11114102_615/vecteezy_flat-western-background-landscape-cowboys-in-desert-horse_11114102.jpg` | `public/images/themes/western-backdrop.jpg` |
| Eldritch Horror | `Eldritch Horror/eldritchbackdrop.jpg` | `public/images/themes/eldritch-backdrop.jpg` |

These paths are used by `src/styles/themes.ts` (`backdropImage` field) and may optionally be referenced in CSS as background overlays for hero banners and Settings theme cards.

---

## Step 3 — Download Base Fonts (Always Loaded)

These two fonts are the app-wide base fonts, required regardless of theme:

- **Inter Variable** — Download the `Inter-Variable.woff2` file from [fonts.google.com/specimen/Inter](https://fonts.google.com/specimen/Inter) → save as `public/fonts/Inter-Variable.woff2`
- **JetBrains Mono Variable** — Download the `JetBrainsMono-Variable.woff2` file from [fonts.google.com/specimen/JetBrains+Mono](https://fonts.google.com/specimen/JetBrains+Mono) → save as `public/fonts/JetBrainsMono-Variable.woff2`

These are referenced in `src/app/globals.css` via `@font-face` and in `src/app/layout.tsx` via `next/font/local`.

---

## Step 4 — Extract and Copy Theme Custom Fonts

Three themes provide custom font ZIPs. Extract each ZIP and copy the `.woff2` (or `.ttf` if no woff2 is available) files to `public/fonts/`:

| Theme | Font ZIP | Font Family Name(s) |
|---|---|---|
| Fantasy | `Fantasy/Assets/FONT/Almendra_Display.zip` | Almendra Display |
| Western | `Western/Assets/FONT/Ewert,Rye,Sancreek,Smokum.zip` | Ewert, Rye, Sancreek, Smokum |
| Eldritch Horror | `Eldritch Horror/Assets/FONT/dark_theme_fonts.zip` | (inspect ZIP — likely a horror/gothic display font) |

**After extracting**, add `@font-face` declarations inside each theme's `[data-theme="X"]` block in `globals.css`, or scope them globally if the font files are small. The theme fonts are used for display headings only — body text always uses DM Sans / Inter.

Sci-Fi and Steampunk do not have custom font ZIPs — use Space Grotesk for headings and DM Sans for body in those themes (same as base).

---

## Step 5 — Extract and Copy Icon Packs

Three themes provide icon PNG archives. Extract each ZIP and copy the PNG files into the theme's icon subfolder under `public/images/icons/`:

| Theme | Icon ZIP | Destination |
|---|---|---|
| Fantasy | `Fantasy/Assets/ICONS/medieval-fantasy.png.zip` | `public/images/icons/fantasy/` |
| Fantasy | `Fantasy/Assets/ICONS/creature.png.zip` | `public/images/icons/fantasy/` |
| Fantasy | `Fantasy/Assets/ICONS/game-icons.net.png.zip` | `public/images/icons/fantasy/` |
| Western | `Western/Assets/ICONS/western.png.zip` | `public/images/icons/western/` |
| Eldritch Horror | `Eldritch Horror/Assets/ICONS/dark_theme_icons.zip` | `public/images/icons/eldritch/` |

These icon PNGs supplement Lucide React icons for thematic flavor. Use them in: map marker icons (Phase 5), NPC card decorations (Phase 4), and empty state illustrations. The primary UI icon library is still Lucide React.

---

## Step 6 — Extract and Copy Design / Animation Assets (Optional)

Some themes include supplementary design packs. Extract and review their contents — if they contain background textures, decorative elements, or SVG patterns, copy them to the designs directory. These are optional and not required for any specific phase.

| Theme | Asset ZIP | Destination |
|---|---|---|
| Eldritch Horror | `Eldritch Horror/Assets/ANIMATION/dark_theme_animations.zip` | `public/images/designs/eldritch/` |
| Eldritch Horror | `Eldritch Horror/Assets/DESIGNS/dark_dungeon_theme_.zip` | `public/images/designs/eldritch/` |
| Eldritch Horror | `Eldritch Horror/Assets/DESIGNS/dungeon_animated_themes_gif_pack.zip` | `public/images/designs/eldritch/` |
| Western | `Western/Assets/DESIGNS/Wild West.zip` | `public/images/designs/western/` |

If the Eldritch GIF pack contains animated GIFs useful for loading states or atmospheric overlays, reference them in the Eldritch theme components.

---

## Step 7 — Western Backdrop Licensing

The Western backdrop image is sourced from Vecteezy and includes a license file:

```
Western/vecteezy_flat-western-background-landscape-cowboys-in-desert-horse_11114102_615/Vecteezy-License-Information.pdf
```

Read this PDF before using the image. The free Vecteezy license covers personal and educational use — appropriate for this school project — but not commercial redistribution. Attribution may be required; if so, add a hidden comment in the component that uses the image or a Credits section in the README.

---

## Step 8 — Asset Reference in themes.ts

After copying all backdrop images, the `src/styles/themes.ts` file (built in Phase 0.6) includes a `backdropImage` field on each theme object. Verify the paths match:

```ts
fantasy:    { backdropImage: '/images/themes/fantasy-backdrop.jpg', ... }
scifi:      { backdropImage: '/images/themes/scifi-backdrop.jpg', ... }
steampunk:  { backdropImage: '/images/themes/steampunk-backdrop.jpg', ... }
western:    { backdropImage: '/images/themes/western-backdrop.jpg', ... }
eldritch:   { backdropImage: '/images/themes/eldritch-backdrop.jpg', ... }
```

---

## Complete Asset Summary

| File | Theme | Type | Public Path After Copy |
|---|---|---|---|
| `fantasy.jpg` | Fantasy | Backdrop | `/images/themes/fantasy-backdrop.jpg` |
| `Almendra_Display.zip` → extract | Fantasy | Font | `/fonts/AlmendraDisplay-Regular.woff2` (etc.) |
| `medieval-fantasy.png.zip` → extract | Fantasy | Icons | `/images/icons/fantasy/` |
| `creature.png.zip` → extract | Fantasy | Icons | `/images/icons/fantasy/` |
| `game-icons.net.png.zip` → extract | Fantasy | Icons | `/images/icons/fantasy/` |
| `scifi.jpg` | Sci-Fi | Backdrop | `/images/themes/scifi-backdrop.jpg` |
| `backdrop_steampunk.jpg` | Steampunk | Backdrop | `/images/themes/steampunk-backdrop.jpg` |
| `vecteezy_flat-western-background...jpg` | Western | Backdrop | `/images/themes/western-backdrop.jpg` |
| `Ewert,Rye,Sancreek,Smokum.zip` → extract | Western | Fonts | `/fonts/Ewert-Regular.woff2` etc. |
| `western.png.zip` → extract | Western | Icons | `/images/icons/western/` |
| `Wild West.zip` → extract | Western | Designs | `/images/designs/western/` |
| `eldritchbackdrop.jpg` | Eldritch | Backdrop | `/images/themes/eldritch-backdrop.jpg` |
| `dark_theme_fonts.zip` → extract | Eldritch | Font | `/fonts/` |
| `dark_theme_icons.zip` → extract | Eldritch | Icons | `/images/icons/eldritch/` |
| `dark_theme_animations.zip` → extract | Eldritch | Animations | `/images/designs/eldritch/` |
| `dark_dungeon_theme_.zip` → extract | Eldritch | Designs | `/images/designs/eldritch/` |
| `dungeon_animated_themes_gif_pack.zip` → extract | Eldritch | GIF Anims | `/images/designs/eldritch/` |
| `Inter-Variable.woff2` (download) | All | Font | `/fonts/Inter-Variable.woff2` |
| `JetBrainsMono-Variable.woff2` (download) | All | Font | `/fonts/JetBrainsMono-Variable.woff2` |
