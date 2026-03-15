# Phase 4: Campaign Management — Characters, NPCs, Encounters & Story Notes

## Context

This phase builds the four core campaign management screens: Simplified Character Sheet (3.3), NPC Manager (3.6), Story Notes & Session Log (3.7), and Encounter Builder (3.8). Every page has a pinned mockup design and must match it closely. The probability engine from Phase 3 is wired into the Encounter Builder for live combat analysis.

## Design Reference Files

Each feature has a mockup folder under `stitch_proba_project/stitch_proba_project/`:

- **Character Sheet** — `character_sheet_sidebar_reorganized/`
  Header card (avatar + name + race/class/level badges + HP/XP), 6 ability score circles in a row, secondary stats row (AC/initiative/speed), weapons & attacks card, special abilities card, inventory summary card, adventure journal textarea.

- **NPC Manager** — `npc_manager_refined_header_icons/`
  Search bar centered, filter button, 3-column card grid. Each NPC card: header image, role+status badges, name, italic description, stats row (HP/AC/ATK), visibility toggle, overflow menu. Deceased NPCs faded. Hidden NPCs have red "DM ONLY" overlay.

- **Encounter Builder** — `encounter_builder_refined_styling/`
  Two-column layout. Left: form with status tabs (planned/active/completed), name+DC+description, enemies table (name/HP/AC/ATK/DMG), save+generate buttons. Right: live probability stream with matchup cards (player vs enemy, success %, formula, colored bar), DM Insight card at bottom.

- **Story Notes** — `story_notes_refined_style/`
  THREE-panel layout. Panel 1: app sidebar (already exists). Panel 2: notes list (~280px) with search, filter pills, note cards (badge+title+preview+timestamp). Panel 3: Tiptap rich text editor with toolbar (bold/italic/lists/headings/blockquotes).

## Prerequisites

Phases 0 through 3 must be finished before starting here. That means the design system, auth, database schema, and probability engine are all in place.

## Directory Structure

```
src/
├── app/(dashboard)/
│   ├── characters/page.tsx              ← MODIFY
│   ├── campaign/
│   │   ├── npcs/page.tsx                ← MODIFY
│   │   ├── encounters/page.tsx          ← MODIFY
│   │   └── story-notes/page.tsx         ← MODIFY
├── components/
│   ├── characters/
│   │   ├── character-header.tsx         ← CREATE
│   │   ├── ability-scores.tsx           ← CREATE
│   │   ├── secondary-stats.tsx          ← CREATE
│   │   ├── weapons-attacks.tsx          ← CREATE
│   │   ├── special-abilities.tsx        ← CREATE
│   │   ├── inventory-summary.tsx        ← CREATE
│   │   ├── adventure-journal.tsx        ← CREATE
│   │   └── character-form-dialog.tsx    ← CREATE
│   ├── npcs/
│   │   ├── npc-grid.tsx                 ← CREATE
│   │   ├── npc-card.tsx                 ← CREATE
│   │   ├── npc-form-dialog.tsx          ← CREATE
│   │   └── npc-filters.tsx              ← CREATE
│   ├── encounters/
│   │   ├── encounter-form.tsx           ← CREATE
│   │   ├── enemy-table.tsx              ← CREATE
│   │   ├── probability-stream.tsx       ← CREATE
│   │   └── dm-insight.tsx               ← CREATE
│   ├── notes/
│   │   ├── notes-list-panel.tsx         ← CREATE
│   │   ├── note-card.tsx                ← CREATE
│   │   ├── note-editor.tsx              ← CREATE
│   │   ├── note-filters.tsx             ← CREATE
│   │   └── tiptap-toolbar.tsx           ← CREATE
├── lib/
│   ├── queries/
│   │   ├── characters.ts               ← CREATE
│   │   ├── npcs.ts                      ← CREATE
│   │   ├── encounters.ts               ← CREATE
│   │   └── notes.ts                     ← CREATE
│   └── validations/
│       ├── character.ts                 ← CREATE
│       ├── npc.ts                       ← CREATE
│       ├── encounter.ts                 ← CREATE
│       └── note.ts                      ← CREATE
```

---

## Subphases

| File | Step |
|---|---|
| [phase-4.1.md](./phase-4.1.md) | Step 4.1 — Character Sheet Queries & Validation |
| [phase-4.2.md](./phase-4.2.md) | Step 4.2 — Character Sheet Page |
| [phase-4.3.md](./phase-4.3.md) | Step 4.3 — NPC Manager Queries & Validation |
| [phase-4.4.md](./phase-4.4.md) | Step 4.4 — NPC Manager Page |
| [phase-4.5.md](./phase-4.5.md) | Step 4.5 — Encounter Builder Queries & Validation |
| [phase-4.6.md](./phase-4.6.md) | Step 4.6 — Encounter Builder Page |
| [phase-4.7.md](./phase-4.7.md) | Step 4.7 — Story Notes Queries & Validation |
| [phase-4.8.md](./phase-4.8.md) | Step 4.8 — Story Notes Page |

## Verification Checklist

- [ ] Character sheet: all sections render (header, ability scores, secondary stats, weapons, abilities, inventory, journal)
- [ ] Ability score modifiers auto-calculate correctly (`Math.floor((score - 10) / 2)`)
- [ ] Create and edit character saves to the database and reflects on the page
- [ ] Players can only edit their own character; DM can edit any party member
- [ ] NPC cards render in a 3-column grid with correct badges and styling
- [ ] NPC search filters by name, role, and description
- [ ] NPC create/edit/delete works, visibility toggle updates the database
- [ ] Deceased NPCs appear faded/desaturated
- [ ] Hidden NPCs show "DM ONLY" red overlay (DM view only)
- [ ] Encounter form saves with enemies list, status tabs work correctly
- [ ] "Generate Probability" calculates and displays correct matchup percentages
- [ ] DM Insight card shows a difficulty rating based on party vs enemy stats
- [ ] Story notes three-panel layout renders correctly with independent scrolling
- [ ] Tiptap editor supports bold, italic, bullet/numbered lists, headings, and blockquotes
- [ ] Blockquotes render with purple left border and italic text
- [ ] Note auto-saves on a 1-second debounce
- [ ] Category filter pills work and update the notes list
- [ ] DM Secret notes are automatically hidden from player users (enforced by RLS)
- [ ] Search works across note title and content
- [ ] All pages match their respective mockup designs
- [ ] All CRUD operations have proper loading and error states
- [ ] Mobile layouts are usable (responsive grids, stacked panels, back navigation)

## Rollback Plan

If something goes sideways, revert to the Phase 3 commit. All feature components live in their own folders (`components/characters/`, `components/npcs/`, `components/encounters/`, `components/notes/`) so removing them won't affect the rest of the app. The query and validation files in `lib/` are similarly isolated.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| Ability modifier is wrong | Floor division edge case | Check that `Math.floor((9-10)/2)` returns `-1`, not `0`. JavaScript's `Math.floor` handles negatives correctly but double-check your implementation. |
| Tiptap editor doesn't render | Missing extensions or SSR issue | Make sure `StarterKit` is passed to `useEditor`. Tiptap must be client-side only — wrap the editor component in a dynamic import with `ssr: false` if using Next.js app router. |
| Encounter probability numbers seem off | Wrong stats being used | Verify that the player's attack bonus and the enemy's AC are being pulled from the correct fields. Print them to console during development. |
| Auto-save fires too often / causes lag | Missing or broken debounce | Use a `useRef` to store the timeout ID and clear it on each keystroke. Alternatively, use lodash's `debounce` with `{ leading: false, trailing: true }`. |
| Three-panel layout breaks or overflows | CSS grid misconfigured | Set the container to `grid-template-columns: 280px 1fr` with `overflow: hidden` on the container. Each panel needs `overflow-y: auto` and a defined height (e.g., `h-[calc(100vh-64px)]` minus the top nav height). |
| Rich text content doesn't display correctly when viewing saved notes | HTML sanitization stripping tags | Use a safe HTML renderer (like `dangerouslySetInnerHTML` with DOMPurify, or Tiptap's read-only mode) to display saved content. Don't run it through a plain-text strip. |
| NPC card images not loading | Supabase Storage URL issues | Check that the storage bucket is public or that you're generating signed URLs. Verify the URL format matches what Supabase returns. |
| "DM ONLY" overlay shows for players | Query filter not applied | Players should never receive hidden NPCs from the query. The overlay is a visual safety net for the DM's view — but the real protection is the RLS policy and the query filter in `getNPCs`. |
