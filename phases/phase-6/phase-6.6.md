# Phase 6.6 — Sample Image References
**File:** `src/lib/seed/sample-images.ts` — CREATE
**Purpose:** Define paths/URLs for images used by the Tower of Fate content.
**Details:**
- Tower of Fate map image: `public/images/maps/tower-of-fate-level-1.jpg`
- Hero banner for dashboard: `public/images/heroes/tower-banner.jpg`
- NPC header images: if the user has provided atmospheric images, reference them here. Otherwise, generate placeholder gradients per NPC in the NPC card component (already handled in Phase 4).
- Note: tell the executing agent to check for user-provided images in the `public/images/` directory. If none exist, create placeholder dark gradient images or use CSS backgrounds.
