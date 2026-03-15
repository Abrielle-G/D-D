# Phase 4.5 — Encounter Builder Queries & Validation

**File: `src/lib/queries/encounters.ts`** — CREATE

- `getEncounters(campaignId, status?)` — list encounters, optionally filtered by status.
- `getEncounter(id)` — single encounter with its enemies array.
- `createEncounter(data)` — insert encounter + enemies.
- `updateEncounter(id, data)` — update encounter fields and upsert enemies.
- `deleteEncounter(id)` — delete encounter and cascade-delete its enemies.
- `updateEncounterStatus(id, status)` — quick status change (planned/active/completed).

**File: `src/lib/validations/encounter.ts`** — CREATE

| Field | Rules |
|---|---|
| `name` | string, required |
| `description` | string, optional |
| `difficulty_class` | integer, 1-30 |
| `enemies` | array of `{ name, hp, ac, attack_bonus, damage_dice }` |
| `status` | enum: `planned`, `active`, `completed` |
