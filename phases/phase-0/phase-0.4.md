# Phase 0.4 — Create Global Styles, Theme System & Noise Texture

**File:** `src/app/globals.css` — MODIFY

**Purpose:** This is the most critical CSS file. It defines the entire visual foundation: CSS custom properties for 5 themes, the noise texture overlay, custom scrollbar, font-face declarations, selection styles, and overrides for shadcn defaults.

**Details:**

**Font-face declarations:**
- Import Inter Variable and JetBrains Mono Variable as local fonts from `public/fonts/` using `@font-face`. Using `next/font/local` in the root layout is preferred for performance (prevents FOUT) — but the `globals.css` should also have fallback `@font-face` rules.
- In the root `layout.tsx`, configure `next/font/local` for both fonts and apply their CSS variable classes to the body.

**@layer base — Default Theme (Fantasy):**
Define CSS custom properties on `:root` for the default Fantasy theme:
- `--color-accent: #7c3aed` (purple)
- `--color-accent-secondary: #06b6d4` (cyan)
- `--color-accent-rgb: 124, 58, 237` (for rgba usage)
- `--color-bg-base: #0a0a0f`
- `--color-bg-elevated: #12121a`
- `--color-bg-sidebar: #0d0d14`
- `--color-border: #1e1e2e`
- `--color-border-hover: #2e2e4e`
- `--color-glow: rgba(124, 58, 237, 0.15)`
- `--color-text-primary: #f1f5f9`
- `--color-text-secondary: #94a3b8`
- `--color-text-muted: #475569`

**Theme Variants — define via `[data-theme="X"]` selectors:**

Each selector overrides the CSS custom properties above:

`[data-theme="fantasy"]` (same as defaults, but explicit):
- Accent: `#7c3aed` purple, secondary `#06b6d4` cyan
- Backgrounds: midnight blue-black base

`[data-theme="scifi"]`:
- Accent: `#06b6d4` cyan, secondary `#3b82f6` blue
- Bg base: `#080d14` (dark navy)
- Border: `#1a2535`
- Glow: `rgba(6, 182, 212, 0.15)`
- Subtle background texture: faint grid lines via CSS repeating-linear-gradient

`[data-theme="western"]`:
- Accent: `#d97706` amber, secondary `#a16207` darker amber
- Bg base: `#0f0b08` (warm dark brown-black)
- Border: `#2a1f14`
- Glow: `rgba(217, 119, 6, 0.15)`
- Texture: subtle parchment-like pattern via CSS

`[data-theme="eldritch"]`:
- Accent: `#16a34a` sickly green, secondary `#15803d` darker green
- Bg base: `#080d08` (near-black with green undertone)
- Border: `#1a2e1a`
- Glow: `rgba(22, 163, 74, 0.15)`

`[data-theme="steampunk"]`:
- Accent: `#ca8a04` gold, secondary `#a16207` bronze
- Bg base: `#0d0a06` (dark bronze-brown)
- Border: `#2e2414`
- Glow: `rgba(202, 138, 4, 0.15)`

**Noise Texture Overlay:**
Add a `body::before` pseudo-element that creates a subtle grain/noise texture over the entire app:
- `content: ''`
- `position: fixed`
- `inset: 0`
- `z-index: 50`
- `pointer-events: none`
- `opacity: 0.03`
- `background-image`: use a base64-encoded tiny SVG noise pattern, OR use a CSS approach with `repeating-conic-gradient` or multiple layered `radial-gradient`s at random positions to simulate film grain
- This noise texture is visible in the mockups and adds depth that prevents the flat-CSS look typical of AI-generated projects

**Custom Scrollbar:**
- Width: 4px
- Thumb: `var(--color-border)` with rounded ends
- Track: transparent
- On hover: thumb brightens slightly

**Selection Styles:**
- `::selection { background: var(--color-accent); color: white; }`

**Override shadcn Defaults:**
- After installing shadcn, its generated CSS variables in `@layer base` will have default slate colors. Override ALL of them with the RPG theme values. The shadcn `--background`, `--foreground`, `--primary`, `--secondary`, `--accent`, `--muted`, `--card`, `--border`, `--input`, `--ring` variables must all map to the dark theme colors. This is critical — leaving shadcn defaults makes the app look generic.
