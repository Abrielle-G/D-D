# Phase 0.22 — User-Provided Assets Setup

**Purpose:** Prepare directory structure for images and icons the user will provide.

**Details:**
- Create these directories: `public/images/icons/`, `public/images/heroes/`, `public/images/npcs/`, `public/images/maps/`
- Download Inter Variable font (woff2) from Google Fonts or the official source → save as `public/fonts/Inter-Variable.woff2`
- Download JetBrains Mono Variable font (woff2) → save as `public/fonts/JetBrainsMono-Variable.woff2`
- The user mentioned they'll provide images and icons — the executing agent should check the project directory for any user-provided assets and copy them into the appropriate `public/images/` subdirectories
- If the user provides a custom d20 logo or app icon, use it in the sidebar and auth page instead of the SVG component
