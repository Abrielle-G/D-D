# Phase 4.1 — Character Sheet Queries & Validation

**File: `src/lib/queries/characters.ts`** — CREATE

Write the following Supabase query functions:

- `getCharacter(userId, campaignId)` — fetch the character belonging to a specific user within a campaign. Return null if none exists.
- `createCharacter(data)` — insert a new character row. The `data` argument should be the validated form output. Return the new record.
- `updateCharacter(id, data)` — partial update by character ID. Only send changed fields.
- `deleteCharacter(id)` — soft-delete or hard-delete the character row. If the campaign uses soft-deletes elsewhere, stay consistent.
- `getPartyCharacters(campaignId)` — fetch all characters in a campaign. Used by the encounter builder to list party members.

All functions should use the typed Supabase client from `lib/supabase`. Handle errors by throwing or returning `{ error }` — just keep it consistent with whatever pattern the rest of the app uses.

**File: `src/lib/validations/character.ts`** — CREATE

Define a Zod schema covering:

| Field | Rules |
|---|---|
| `name` | string, 1-50 chars, required |
| `race` | string, required |
| `char_class` | string, required |
| `level` | integer, 1-20 |
| `strength` | integer, 1-30 |
| `dexterity` | integer, 1-30 |
| `constitution` | integer, 1-30 |
| `intelligence` | integer, 1-30 |
| `wisdom` | integer, 1-30 |
| `charisma` | integer, 1-30 |
| `hp_current` | integer, >= 0 |
| `hp_max` | integer, >= 1 |
| `ac` | integer, >= 0 |
| `speed` | integer, >= 0 |
| `weapons` | array of objects `{ name, damage_dice, modifier }` |
| `abilities` | array, max length 4 |
| `inventory` | array, max length 15 |

Export the schema and a TypeScript type inferred from it.
