# Phase 6.6 — Sample Image References
**File:** `src/lib/seed/sample-images.ts` — CREATE
**Purpose:** Define paths/URLs for images used by the Tower of Fate seed content.
**Details:**
- Tower of Fate map image: `public/images/maps/tower-of-fate-level-1.jpg`
- Hero banner for DM dashboard: `public/images/heroes/tower-banner.jpg`
- NPC header images: if the user has provided atmospheric images in `public/images/npcs/`, reference them here. Otherwise, generate placeholder gradients per NPC in the NPC card component (already handled in Phase 4).

**Using PROBA PROJECT assets as fallback images:**
- If no dedicated `heroes/tower-banner.jpg` exists, the **Fantasy backdrop** (`/images/themes/fantasy-backdrop.jpg`) can serve as the hero banner for the Tower of Fate campaign — it is a fantasy-themed image and pairs well with the purple Fantasy theme.
- If no dedicated `maps/tower-of-fate-level-1.jpg` exists, use a dark gradient placeholder. Do NOT use the backdrop images as map images — they are landscape/atmospheric images, not dungeon floor plans.
- For NPC placeholder headers, use gradient backgrounds derived from the theme's accent color rather than the backdrop JPGs.

**Icon references:**
- Map marker icons for the Tower of Fate (Phase 5) can be sourced from the Fantasy icon pack at `/images/icons/fantasy/` if that pack contains suitable dungeon/location icons. Refer to the contents extracted in Phase 0.22.

**Tell the executing agent:**
Check `public/images/` for any user-provided files before falling back to placeholders. If the user has added their own JPGs to `heroes/` or `maps/`, use those. The PROBA PROJECT backdrop images in `public/images/themes/` are the most reliably present user assets.
