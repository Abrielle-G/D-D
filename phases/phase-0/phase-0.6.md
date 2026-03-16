# Phase 0.6 — Create Theme Configuration Objects

**File:** `src/styles/themes.ts` — CREATE

**Purpose:** Typed theme configuration objects used by the ThemeProvider and Settings page.

**Details:**
- Export a `themes` constant — an object keyed by theme ID. Each entry includes visual config AND references to user-provided assets (set up in Phase 0.22):
  - `fantasy`: { id: 'fantasy', name: 'Fantasy', emoji: '🏰', description: 'Arcane, magical, medieval vibes for your quest.', accentPrimary: '#7c3aed', accentSecondary: '#06b6d4', bgBase: '#0a0a0f', bgElevated: '#12121a', bgSidebar: '#0d0d14', borderDefault: '#1e1e2e', glowColor: 'rgba(124,58,237,0.15)', backdropImage: '/images/themes/fantasy-backdrop.jpg', themeFont: 'Almendra Display' }
  - `scifi`: { id: 'scifi', name: 'Sci-Fi', emoji: '🚀', description: 'Neon, holographic, futuristic interface.', accentPrimary: '#06b6d4', accentSecondary: '#3b82f6', bgBase: '#080d14', bgElevated: '#0d1520', bgSidebar: '#0a1120', borderDefault: '#1a2535', glowColor: 'rgba(6,182,212,0.15)', backdropImage: '/images/themes/scifi-backdrop.jpg', themeFont: null }
  - `western`: { id: 'western', name: 'Western', emoji: '🤠', description: 'Dusty, rugged, weathered frontier feel.', accentPrimary: '#d97706', accentSecondary: '#a16207', bgBase: '#0f0b08', bgElevated: '#1a1208', bgSidebar: '#130e06', borderDefault: '#2a1f14', glowColor: 'rgba(217,119,6,0.15)', backdropImage: '/images/themes/western-backdrop.jpg', themeFont: 'Rye' }
  - `eldritch`: { id: 'eldritch', name: 'Eldritch Horror', emoji: '👁️', description: 'Unsettling, Lovecraftian, cosmic terror.', accentPrimary: '#16a34a', accentSecondary: '#15803d', bgBase: '#080d08', bgElevated: '#0d150d', bgSidebar: '#0a100a', borderDefault: '#1a2e1a', glowColor: 'rgba(22,163,74,0.15)', backdropImage: '/images/themes/eldritch-backdrop.jpg', themeFont: null }
  - `steampunk`: { id: 'steampunk', name: 'Steampunk', emoji: '⚙️', description: 'Brass, gears, Victorian mechanical aesthetic.', accentPrimary: '#ca8a04', accentSecondary: '#a16207', bgBase: '#0d0a06', bgElevated: '#181208', bgSidebar: '#130e06', borderDefault: '#2e2414', glowColor: 'rgba(202,138,4,0.15)', backdropImage: '/images/themes/steampunk-backdrop.jpg', themeFont: null }
- `backdropImage`: path to the theme's JPG backdrop from the PROBA PROJECT folder (added to `public/images/themes/` in Phase 0.22). Used for hero banner overlays, Settings theme card backgrounds, and any full-bleed atmospheric sections. Serve it with `<Image>` (Next.js) at 70–80% opacity with the theme's base color underneath.
- `themeFont`: the custom display font associated with this theme (installed in Phase 0.22). `null` means use Space Grotesk (the default heading font). When non-null, load this font as the heading font for `h1`/`h2` elements while the theme is active.
- Export type `ThemeId = 'fantasy' | 'scifi' | 'western' | 'eldritch' | 'steampunk'`
- Export `DEFAULT_THEME: ThemeId = 'fantasy'`
- Export `THEME_LIST` as an array of the theme objects (for iterating in the Settings UI)
