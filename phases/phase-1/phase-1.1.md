# Phase 1.1 — Create Supabase Database Schema

**File:** `supabase/migrations/001_initial_schema.sql` -- CREATE

**Purpose:** Define ALL database tables, enums, indexes, and triggers for the entire application. This single migration creates the complete data layer so future phases only need to query, not migrate.

**Details:**

Create the `supabase/migrations/` directory at the project root (not inside `src/`). Write the full SQL migration file with the following sections in order.

#### 1.1a: Custom Enums

Define these PostgreSQL enums at the top of the file:

- `user_role` with values: `'dm'`, `'player'`
- `theme_id` with values: `'fantasy'`, `'scifi'`, `'western'`, `'eldritch'`, `'steampunk'`
- `campaign_status` with values: `'active'`, `'archived'`
- `npc_status` with values: `'active'`, `'deceased'`, `'hidden'`
- `encounter_status` with values: `'planned'`, `'active'`, `'completed'`
- `note_tag` with values: `'session_log'`, `'world_lore'`, `'plot'`, `'dm_secret'`
- `marker_icon_type` with values: `'combat'`, `'quest'`, `'shop'`, `'danger'`, `'safe'`

Use `CREATE TYPE public.<enum_name> AS ENUM (...)` syntax for each.

#### 1.1b: profiles Table

This table extends Supabase's built-in `auth.users`. Create `public.profiles` with these columns:

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, REFERENCES `auth.users(id)` ON DELETE CASCADE |
| `email` | `text` | NOT NULL |
| `display_name` | `text` | NOT NULL, DEFAULT `'Adventurer'` |
| `preferred_role` | `user_role` | DEFAULT `'player'` |
| `selected_theme` | `theme_id` | DEFAULT `'fantasy'` |
| `avatar_url` | `text` | NULLABLE |
| `created_at` | `timestamptz` | DEFAULT `now()` |
| `updated_at` | `timestamptz` | DEFAULT `now()` |

#### 1.1c: campaigns Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `name` | `text` | NOT NULL |
| `description` | `text` | NULLABLE |
| `dm_user_id` | `uuid` | NOT NULL, REFERENCES `profiles(id)` ON DELETE CASCADE |
| `is_template` | `boolean` | DEFAULT `false` |
| `status` | `campaign_status` | DEFAULT `'active'` |
| `created_at` | `timestamptz` | DEFAULT `now()` |
| `updated_at` | `timestamptz` | DEFAULT `now()` |

Create an index: `CREATE INDEX idx_campaigns_dm_user_id ON campaigns(dm_user_id);`

#### 1.1d: characters Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `user_id` | `uuid` | NOT NULL, REFERENCES `profiles(id)` ON DELETE CASCADE |
| `campaign_id` | `uuid` | NOT NULL, REFERENCES `campaigns(id)` ON DELETE CASCADE |
| `name` | `text` | NOT NULL |
| `race` | `text` | NOT NULL |
| `char_class` | `text` | NOT NULL |
| `level` | `integer` | DEFAULT `1`, CHECK (`level` >= 1 AND `level` <= 20) |
| `strength` | `integer` | DEFAULT `10`, CHECK (`strength` >= 1 AND `strength` <= 30) |
| `dexterity` | `integer` | DEFAULT `10`, CHECK (`dexterity` >= 1 AND `dexterity` <= 30) |
| `constitution` | `integer` | DEFAULT `10`, CHECK (`constitution` >= 1 AND `constitution` <= 30) |
| `intelligence` | `integer` | DEFAULT `10`, CHECK (`intelligence` >= 1 AND `intelligence` <= 30) |
| `wisdom` | `integer` | DEFAULT `10`, CHECK (`wisdom` >= 1 AND `wisdom` <= 30) |
| `charisma` | `integer` | DEFAULT `10`, CHECK (`charisma` >= 1 AND `charisma` <= 30) |
| `hp_current` | `integer` | NOT NULL |
| `hp_max` | `integer` | NOT NULL |
| `armor_class` | `integer` | NOT NULL |
| `speed` | `integer` | DEFAULT `30` |
| `weapons` | `jsonb` | DEFAULT `'[]'::jsonb` |
| `abilities` | `jsonb` | DEFAULT `'[]'::jsonb` |
| `inventory` | `jsonb` | DEFAULT `'[]'::jsonb` |
| `notes` | `text` | NULLABLE |
| `created_at` | `timestamptz` | DEFAULT `now()` |

Create indexes:
- `CREATE INDEX idx_characters_user_id ON characters(user_id);`
- `CREATE INDEX idx_characters_campaign_id ON characters(campaign_id);`

Add a unique constraint to enforce one character per player per campaign:
- `ALTER TABLE characters ADD CONSTRAINT uq_characters_user_campaign UNIQUE (user_id, campaign_id);`

#### 1.1e: npcs Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `campaign_id` | `uuid` | NOT NULL, REFERENCES `campaigns(id)` ON DELETE CASCADE |
| `name` | `text` | NOT NULL |
| `race` | `text` | NULLABLE |
| `role` | `text` | NULLABLE (e.g. "shopkeeper", "villain") |
| `description` | `text` | NULLABLE |
| `hp` | `integer` | NULLABLE |
| `armor_class` | `integer` | NULLABLE |
| `attack_bonus` | `integer` | NULLABLE |
| `notes` | `text` | NULLABLE |
| `status` | `npc_status` | DEFAULT `'active'` |
| `is_visible_to_players` | `boolean` | DEFAULT `false` |
| `created_at` | `timestamptz` | DEFAULT `now()` |

Create index: `CREATE INDEX idx_npcs_campaign_id ON npcs(campaign_id);`

#### 1.1f: encounters Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `campaign_id` | `uuid` | NOT NULL, REFERENCES `campaigns(id)` ON DELETE CASCADE |
| `name` | `text` | NOT NULL |
| `description` | `text` | NULLABLE |
| `difficulty_class` | `integer` | CHECK (`difficulty_class` >= 1 AND `difficulty_class` <= 30) |
| `enemies` | `jsonb` | DEFAULT `'[]'::jsonb` |
| `status` | `encounter_status` | DEFAULT `'planned'` |
| `created_at` | `timestamptz` | DEFAULT `now()` |

Create indexes:
- `CREATE INDEX idx_encounters_campaign_id ON encounters(campaign_id);`
- `CREATE INDEX idx_encounters_status ON encounters(status);`

#### 1.1g: notes Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `campaign_id` | `uuid` | NOT NULL, REFERENCES `campaigns(id)` ON DELETE CASCADE |
| `author_id` | `uuid` | NOT NULL, REFERENCES `profiles(id)` ON DELETE CASCADE |
| `title` | `text` | NOT NULL |
| `content` | `text` | NULLABLE (stores rich HTML content) |
| `tag` | `note_tag` | NOT NULL |
| `is_visible_to_players` | `boolean` | DEFAULT `true` |
| `session_number` | `integer` | NULLABLE |
| `created_at` | `timestamptz` | DEFAULT `now()` |

Create indexes:
- `CREATE INDEX idx_notes_campaign_id ON notes(campaign_id);`
- `CREATE INDEX idx_notes_tag ON notes(tag);`

Create a trigger that automatically forces `is_visible_to_players = false` whenever `tag = 'dm_secret'`. The trigger function should:
1. Check if `NEW.tag = 'dm_secret'`
2. If so, set `NEW.is_visible_to_players := false`
3. Return `NEW`

Apply the trigger on both INSERT and UPDATE (BEFORE INSERT OR UPDATE).

#### 1.1h: bayes_scenarios Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `campaign_id` | `uuid` | NULLABLE, REFERENCES `campaigns(id)` ON DELETE CASCADE (null = global/template) |
| `title` | `text` | NOT NULL |
| `description` | `text` | NULLABLE |
| `prior_probability` | `float` | CHECK (`prior_probability` >= 0 AND `prior_probability` <= 1) |
| `likelihood` | `float` | CHECK (`likelihood` >= 0 AND `likelihood` <= 1) |
| `marginal_false` | `float` | CHECK (`marginal_false` >= 0 AND `marginal_false` <= 1) |
| `is_template` | `boolean` | DEFAULT `false` |
| `created_at` | `timestamptz` | DEFAULT `now()` |

#### 1.1i: campaign_maps Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `campaign_id` | `uuid` | NOT NULL, REFERENCES `campaigns(id)` ON DELETE CASCADE |
| `name` | `text` | NOT NULL |
| `image_url` | `text` | NOT NULL |
| `sort_order` | `integer` | DEFAULT `0` |
| `created_at` | `timestamptz` | DEFAULT `now()` |

Create index: `CREATE INDEX idx_campaign_maps_campaign_id ON campaign_maps(campaign_id);`

#### 1.1j: map_markers Table

| Column | Type | Constraints |
|---|---|---|
| `id` | `uuid` | PRIMARY KEY, DEFAULT `gen_random_uuid()` |
| `map_id` | `uuid` | NOT NULL, REFERENCES `campaign_maps(id)` ON DELETE CASCADE |
| `label` | `text` | NOT NULL |
| `description` | `text` | NULLABLE |
| `icon_type` | `marker_icon_type` | NOT NULL |
| `pos_x` | `float` | NOT NULL, CHECK (`pos_x` >= 0 AND `pos_x` <= 1) |
| `pos_y` | `float` | NOT NULL, CHECK (`pos_y` >= 0 AND `pos_y` <= 1) |
| `is_visible_to_players` | `boolean` | DEFAULT `false` |
| `created_at` | `timestamptz` | DEFAULT `now()` |

Create index: `CREATE INDEX idx_map_markers_map_id ON map_markers(map_id);`

#### 1.1k: updated_at Trigger Function

Create a reusable function `public.handle_updated_at()` that sets `NEW.updated_at = now()` and returns `NEW`. Apply this trigger BEFORE UPDATE on both the `profiles` and `campaigns` tables (these are the only two tables that have an `updated_at` column).

#### 1.1l: Auto-Create Profile on Signup Trigger

Create a function `public.handle_new_user()` that fires AFTER INSERT on `auth.users`. This function should:
1. Insert a new row into `public.profiles`
2. Set `id` = `NEW.id` (the auth user's UUID)
3. Set `email` = `NEW.email`
4. Set `display_name` = `COALESCE(NEW.raw_user_meta_data->>'display_name', 'Adventurer')` (the signup form passes display_name in the metadata)
5. Use default values for all other columns

Create the trigger: `CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();`
