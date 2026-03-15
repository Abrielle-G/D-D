# Phase 0.20 — Utility Functions, Constants & Types

**File:** `src/lib/utils.ts` — MODIFY
- Add the `cn()` helper function: accepts any number of class name arguments, processes through `clsx` then `tailwind-merge`, returns the merged class string
- This is used by every component for conditional class application

**File:** `src/lib/constants.ts` — CREATE
- `DICE_TYPES`: array of `{ type: 'd4'|'d6'|..., label: string, sides: number }`
- `ABILITY_SCORES`: array of `{ key: 'strength'|..., label: string, abbreviation: 'STR'|... }`
- `NPC_ROLES`: array of role options for dropdowns
- `NOTE_TAGS`: array of tag options with colors
- `ENCOUNTER_STATUSES`: array of status options
- `NPC_STATUSES`: array of status options
- `MARKER_ICON_TYPES`: array of map marker types with icons and colors

**File:** `src/types/index.ts` — CREATE
- `NavItem`: `{ label: string, href: string, icon: LucideIcon, dmOnly?: boolean }`
- `NavGroup`: `{ title: string, items: NavItem[] }`
- `StatusBarConfig`: `{ [pagePath: string]: string[] }`
- `Role`: `'dm' | 'player'`
- Re-export `ThemeId` from themes.ts
