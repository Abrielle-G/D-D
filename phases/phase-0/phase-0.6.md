# Phase 0.6 — Create Theme Configuration Objects

**File:** `src/styles/themes.ts` — CREATE

**Purpose:** Typed theme configuration objects used by the ThemeProvider and Settings page.

**Details:**
- Export a `themes` constant — an object keyed by theme ID:
  - `fantasy`: { id: 'fantasy', name: 'Fantasy', emoji: '🏰', description: 'Arcane, magical, medieval vibes for your quest.', accentPrimary: '#7c3aed', accentSecondary: '#06b6d4', bgBase: '#0a0a0f', bgElevated: '#12121a', bgSidebar: '#0d0d14', borderDefault: '#1e1e2e', glowColor: 'rgba(124,58,237,0.15)' }
  - `scifi`: { id: 'scifi', name: 'Sci-Fi', emoji: '🚀', description: 'Neon, holographic, futuristic interface.', accentPrimary: '#06b6d4', ... }
  - `western`: { id: 'western', name: 'Western', emoji: '🤠', description: 'Dusty, rugged, weathered frontier feel.', accentPrimary: '#d97706', ... }
  - `eldritch`: { id: 'eldritch', name: 'Eldritch Horror', emoji: '👁️', description: 'Unsettling, Lovecraftian, cosmic terror.', accentPrimary: '#16a34a', ... }
  - `steampunk`: { id: 'steampunk', name: 'Steampunk', emoji: '⚙️', description: 'Brass, gears, Victorian mechanical aesthetic.', accentPrimary: '#ca8a04', ... }
- Export type `ThemeId = 'fantasy' | 'scifi' | 'western' | 'eldritch' | 'steampunk'`
- Export `DEFAULT_THEME: ThemeId = 'fantasy'`
- Export `THEME_LIST` as an array of the theme objects (for iterating in the Settings UI)
