# Phase 1.7 — Generate Database Types

**File:** `src/types/database.ts` -- CREATE

**Purpose:** Provide TypeScript type safety for all Supabase queries. Every `supabase.from('table')` call will be fully typed.

**Details:**

The ideal approach is to generate this file using the Supabase CLI:
```bash
npx supabase gen types typescript --project-id [your-project-id] > src/types/database.ts
```

If the Supabase CLI is not yet configured or the migration has not been applied, manually write the type file to match the schema from Step 1.1. The file must define:

1. **The `Database` interface** with a `public` property containing:
   - `Tables`: an object where each key is a table name, and the value has:
     - `Row`: the shape of a row returned from a SELECT
     - `Insert`: the shape for INSERT (optional fields use `?`)
     - `Update`: the shape for UPDATE (all fields optional with `?`)
   - `Enums`: an object mapping enum names to their TypeScript union types

2. **Type helper exports:**
   ```typescript
   export type Tables<T extends keyof Database['public']['Tables']> = Database['public']['Tables'][T]['Row']
   export type Enums<T extends keyof Database['public']['Enums']> = Database['public']['Enums'][T]
   ```

3. **Convenience type aliases** for every table:
   ```typescript
   export type Profile = Tables<'profiles'>
   export type Campaign = Tables<'campaigns'>
   export type Character = Tables<'characters'>
   export type NPC = Tables<'npcs'>
   export type Encounter = Tables<'encounters'>
   export type Note = Tables<'notes'>
   export type BayesScenario = Tables<'bayes_scenarios'>
   export type CampaignMap = Tables<'campaign_maps'>
   export type MapMarker = Tables<'map_markers'>
   ```

4. **Enum type aliases:**
   ```typescript
   export type UserRole = Enums<'user_role'>
   export type ThemeId = Enums<'theme_id'>
   export type CampaignStatus = Enums<'campaign_status'>
   export type NpcStatus = Enums<'npc_status'>
   export type EncounterStatus = Enums<'encounter_status'>
   export type NoteTag = Enums<'note_tag'>
   export type MarkerIconType = Enums<'marker_icon_type'>
   ```

Ensure every column from Step 1.1 is represented with the correct TypeScript type. Use `string` for text/uuid/timestamptz, `number` for integer/float, `boolean` for boolean, `Json` (define as `type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[]`) for jsonb, and `null` unions where columns are nullable.
