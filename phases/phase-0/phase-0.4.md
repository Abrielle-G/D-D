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
- `--color-accent: #7c3aed`
- `--color-accent-secondary: #06b6d4`
- `--color-accent-rgb: 124, 58, 237`
- `--color-bg-base: #0a0a0f`
- `--color-bg-elevated: #12121a`
- `--color-bg-sidebar: #0d0d14`
- `--color-border: #1e1e2e`
- `--color-border-hover: #2e2e4e`
- `--color-glow: rgba(124, 58, 237, 0.15)`
- `--color-text-primary: #f1f5f9`
- `--color-text-secondary: #94a3b8`
- `--color-text-muted: #475569`

`[data-theme="scifi"]`:
- `--color-accent: #06b6d4`
- `--color-accent-secondary: #3b82f6`
- `--color-accent-rgb: 6, 182, 212`
- `--color-bg-base: #080d14` (dark navy)
- `--color-bg-elevated: #0d1520`
- `--color-bg-sidebar: #0a1120`
- `--color-border: #1a2535`
- `--color-border-hover: #253548`
- `--color-glow: rgba(6, 182, 212, 0.15)`
- `--color-text-primary: #e2e8f0` (cool white with slight blue tint)
- `--color-text-secondary: #7db5d0`
- `--color-text-muted: #3d6080`
- Texture: faint `repeating-linear-gradient` grid lines at 40px intervals, 2% opacity

`[data-theme="western"]`:
- `--color-accent: #d97706`
- `--color-accent-secondary: #a16207`
- `--color-accent-rgb: 217, 119, 6`
- `--color-bg-base: #0f0b08` (warm dark brown-black)
- `--color-bg-elevated: #1a1208`
- `--color-bg-sidebar: #130e06`
- `--color-border: #2a1f14`
- `--color-border-hover: #3d2e1e`
- `--color-glow: rgba(217, 119, 6, 0.15)`
- `--color-text-primary: #fef3c7` (warm sepia-white)
- `--color-text-secondary: #b58a60`
- `--color-text-muted: #6b4d35`
- Texture: subtle parchment noise via `background-image` with stacked semi-transparent radial gradients

`[data-theme="eldritch"]`:
- `--color-accent: #16a34a`
- `--color-accent-secondary: #15803d`
- `--color-accent-rgb: 22, 163, 74`
- `--color-bg-base: #080d08` (near-black with green undertone)
- `--color-bg-elevated: #0d150d`
- `--color-bg-sidebar: #0a100a`
- `--color-border: #1a2e1a`
- `--color-border-hover: #253e25`
- `--color-glow: rgba(22, 163, 74, 0.15)`
- `--color-text-primary: #dcfce7` (pale sickly green-white)
- `--color-text-secondary: #5aa870`
- `--color-text-muted: #2d5c3a`

`[data-theme="steampunk"]`:
- `--color-accent: #ca8a04`
- `--color-accent-secondary: #a16207`
- `--color-accent-rgb: 202, 138, 4`
- `--color-bg-base: #0d0a06` (dark bronze-brown)
- `--color-bg-elevated: #181208`
- `--color-bg-sidebar: #130e06`
- `--color-border: #2e2414`
- `--color-border-hover: #42341e`
- `--color-glow: rgba(202, 138, 4, 0.15)`
- `--color-text-primary: #fef9ec` (warm brass-white)
- `--color-text-secondary: #c4a35a`
- `--color-text-muted: #7a6040`

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

**Theme Backdrop Image Variable:**
Add a `--theme-backdrop-image` CSS custom property to each `[data-theme="X"]` selector pointing to the user-provided backdrop JPG for that theme (see Phase 0.22). This variable is used by the hero banner, Settings theme cards, and any full-bleed atmospheric sections:

```css
[data-theme="fantasy"]  { --theme-backdrop-image: url('/images/themes/fantasy-backdrop.jpg'); }
[data-theme="scifi"]    { --theme-backdrop-image: url('/images/themes/scifi-backdrop.jpg'); }
[data-theme="western"]  { --theme-backdrop-image: url('/images/themes/western-backdrop.jpg'); }
[data-theme="eldritch"] { --theme-backdrop-image: url('/images/themes/eldritch-backdrop.jpg'); }
[data-theme="steampunk"]{ --theme-backdrop-image: url('/images/themes/steampunk-backdrop.jpg'); }
```

Usage pattern: apply via `background-image: var(--theme-backdrop-image)` on a container, combined with `background-size: cover`, `background-position: center`, and an overlay div set to `bg-[var(--color-bg-base)]/70` for legibility.

**Custom Scrollbar:**
- Width: 4px
- Thumb: `var(--color-border)` with rounded ends
- Track: transparent
- On hover: thumb brightens slightly

**Selection Styles:**
- `::selection { background: var(--color-accent); color: white; }`

**Override shadcn Defaults:**
- After installing shadcn, its generated CSS variables in `@layer base` will have default slate colors. Override ALL of them with the RPG theme values. The shadcn `--background`, `--foreground`, `--primary`, `--secondary`, `--accent`, `--muted`, `--card`, `--border`, `--input`, `--ring` variables must all map to the dark theme colors. This is critical — leaving shadcn defaults makes the app look generic.
