# Phase 4.7 — Story Notes Queries & Validation

**File: `src/lib/queries/notes.ts`** — CREATE

- `getNotes(campaignId, filters?)` — DM gets all notes. Players only see notes where `is_visible_to_players` is true. Filters support tag (enum) and search string.
- `getNote(id)` — fetch a single note with full content.
- `createNote(campaignId, userId)` — insert a blank note with defaults (empty title, empty content, tag "session_log", visible to players). Return the new record so the UI can select it.
- `updateNote(id, data)` — partial update. Used by auto-save.
- `deleteNote(id)` — delete a note.
- `searchNotes(campaignId, query)` — search across title and stripped HTML content. Use Supabase full-text search or a simple `ilike` on both columns.

**File: `src/lib/validations/note.ts`** — CREATE

| Field | Rules |
|---|---|
| `title` | string, 1-200 chars |
| `content` | string, required (stores HTML from Tiptap) |
| `tag` | enum: `session_log`, `world_lore`, `plot`, `dm_secret` |
| `is_visible_to_players` | boolean |
| `session_number` | integer, optional |
