# Phase 0.3 — Configure Tailwind with Custom Design Tokens

**File:** `tailwind.config.ts` — MODIFY

**Purpose:** Complete design token system matching the mockups exactly. This is the visual DNA of the entire app.

**Details:**

Extend the `theme` object with these EXACT values extracted from the mockup CSS:

**Colors:**
- `surface`: `{ base: '#0a0a0f', elevated: '#12121a', sidebar: '#0d0d14', hover: '#1a1a2e', input: '#16161f', overlay: '#08080d' }`
- `border`: `{ DEFAULT: '#1e1e2e', hover: '#2e2e4e', active: '#7c3aed', subtle: '#151520' }`
- `accent`: `{ purple: '#7c3aed', cyan: '#06b6d4', green: '#22c55e', amber: '#eab308', red: '#ef4444', gold: '#ca8a04', sickly: '#16a34a' }`
- `text`: `{ primary: '#f1f5f9', secondary: '#94a3b8', muted: '#475569', faint: '#3a3a5c' }`
- `status`: `{ success: '#22c55e', warning: '#eab308', danger: '#ef4444', info: '#06b6d4' }`

**Font Families:**
- `sans`: `['Inter', 'system-ui', 'sans-serif']` — body text, UI labels, buttons
- `mono`: `['JetBrains Mono', 'monospace']` — stat numbers, dice notation, probabilities, code, status bar
- `display`: `['Georgia', 'Cambria', 'Times New Roman', 'serif']` — page titles, hero headings, character names (the mockups use a serif display font for these)

**Border Radius:**
- `card`: `'12px'`
- `badge`: `'9999px'` (fully rounded pill)
- `button`: `'8px'`

**Box Shadow:**
- `card`: `'0 4px 20px rgba(0,0,0,0.3)'`
- `card-hover`: `'0 8px 30px rgba(0,0,0,0.5)'`
- `glow-purple`: `'0 0 20px rgba(124,58,237,0.15)'`
- `glow-cyan`: `'0 0 20px rgba(6,182,212,0.15)'`

**Spacing extensions:** None needed — Tailwind defaults are sufficient.

Set `darkMode: 'class'`

Ensure `content` array includes: `'./src/**/*.{ts,tsx}'`
