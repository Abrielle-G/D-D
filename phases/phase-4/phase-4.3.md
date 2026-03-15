# Phase 4.3 — NPC Manager Queries & Validation

**File: `src/lib/queries/npcs.ts`** — CREATE

- `getNPCs(campaignId, filters?)` — the DM gets all NPCs. Players only see NPCs where `is_visible_to_players` is true. The `filters` argument should support filtering by role (array), status (single value), and a search string.
- `createNPC(data)` — insert a new NPC.
- `updateNPC(id, data)` — partial update.
- `deleteNPC(id)` — delete. Before deleting, check if the NPC is referenced in any encounter. If so, warn (but the actual warning happens in the UI — the query function can return a flag or throw a specific error).
- `toggleNPCVisibility(id, isVisible)` — shorthand to flip the visibility boolean.

**File: `src/lib/validations/npc.ts`** — CREATE

| Field | Rules |
|---|---|
| `name` | string, required |
| `race` | string, optional |
| `role` | enum: `quest_giver`, `villain`, `merchant`, `guide`, `mercenary` — required |
| `description` | string, optional |
| `hp` | integer, optional |
| `ac` | integer, optional |
| `attack_bonus` | integer, optional |
| `status` | enum: `active`, `deceased`, `hidden` |
| `is_visible_to_players` | boolean, default true |
