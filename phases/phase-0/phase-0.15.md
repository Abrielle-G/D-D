# Phase 0.15 — Create the RPG Badge Component

**File:** `src/components/shared/badge-rpg.tsx` — CREATE

**Purpose:** RPG-themed badge/pill component for status indicators, role tags, note categories, dice notation, etc.

**Details:**

All badges share: `border-radius: 9999px` (pill), `font-size: 11px`, `text-transform: uppercase`, `letter-spacing: 0.05em`, `font-weight: 600`, `padding: 4px 10px`, `display: inline-flex`, `align-items: center`, `gap: 4px` (for icon + text)

Variants (via a `variant` prop):
- `role-dm`: bg `#22c55e`, text `#052e16` — "DM MODE"
- `role-player`: bg `#22c55e`, text `#052e16` — "PLAYER"
- `status-active`: border `1px solid #22c55e`, text `#22c55e`, bg transparent — "ACTIVE"
- `status-deceased`: border `1px solid #475569`, text `#475569` — "DECEASED"
- `status-hidden`: border `1px solid #475569`, text `#475569` — "HIDDEN"
- `status-planned`: border `1px solid var(--color-accent)`, text `var(--color-accent)` — "PLANNED"
- `note-session`: bg `#22c55e20`, text `#22c55e`, border `1px solid #22c55e40` — "SESSION LOG"
- `note-lore`: bg transparent, border `1px solid var(--color-accent)`, text accent — "WORLD LORE"
- `note-plot`: bg `var(--color-accent)`, text white — "PLOT"
- `note-secret`: bg `#ef444430`, text `#ef4444`, border `1px solid #ef444460` — "DM SECRET" (with Lucide `Lock` icon 12px)
- `npc-villain`: bg `#ef444420`, text `#ef4444` — "VILLAIN"
- `npc-quest-giver`: bg `var(--color-accent)20`, text accent — "QUEST GIVER"
- `npc-merchant`: bg `#22c55e20`, text `#22c55e` — "MERCHANT"
- `npc-guide`: bg `#47556920`, text `#94a3b8` — "GUIDE"
- `dice`: border `1px solid #22c55e`, text `#22c55e`, bg transparent — "2d6 + 5" (dice notation)
- `difficulty`: border `1px solid #eab308`, text `#eab308` — "DC 15"

Accept a `children` prop for the text content and an optional `icon` prop for prepending a Lucide icon.
