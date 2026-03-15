# Phase 1.2 — Create Row Level Security (RLS) Policies

**File:** `supabase/migrations/001_initial_schema.sql` -- APPEND to the same migration file from Step 1.1

**Purpose:** Secure every table so that Supabase enforces authorization at the database level. This is what makes the DM/Player permission model work -- players cannot see DM-secret data even if the frontend has a bug.

**Details:**

Enable RLS on every single table: `profiles`, `campaigns`, `characters`, `npcs`, `encounters`, `notes`, `bayes_scenarios`, `campaign_maps`, `map_markers`. Use `ALTER TABLE <table> ENABLE ROW LEVEL SECURITY;` for each.

#### 1.2a: profiles Policies

Create these policies on the `profiles` table:

1. **"Users can read own profile"** -- SELECT policy:
   - `USING (auth.uid() = id)`

2. **"Users can update own profile"** -- UPDATE policy:
   - `USING (auth.uid() = id)`
   - `WITH CHECK (auth.uid() = id)`

3. **"Users can read other profiles display info"** -- SELECT policy:
   - This allows reading the `display_name` and `avatar_url` of any user (needed for party member display and campaign member lists)
   - `USING (true)` -- allow SELECT on all rows
   - IMPORTANT: Since Supabase RLS policies are additive (OR logic) for the same operation, having this broad SELECT policy alongside the own-profile policy is fine. However, to limit which columns are exposed, you should NOT restrict at the RLS level (RLS is row-level, not column-level). Instead, just document that the frontend should only query `display_name` and `avatar_url` when fetching other users' profiles. The first policy (own profile) already covers full access for the user's own row.
   - Alternatively, create a Postgres VIEW called `public.profile_public` that only exposes `id`, `display_name`, and `avatar_url`, and grant SELECT on that view. This is a better approach if you want defense in depth. If you take this approach, create the view and a separate RLS-free policy for it.

For the simpler MVP approach: just use the single broad SELECT `USING (true)` policy and rely on the frontend to select only the needed columns.

#### 1.2b: campaigns Policies

Create these policies on the `campaigns` table:

1. **"DMs can manage their campaigns"** -- ALL policy (SELECT, INSERT, UPDATE, DELETE):
   - `USING (dm_user_id = auth.uid())`
   - `WITH CHECK (dm_user_id = auth.uid())`

2. **"Players can read campaigns they belong to"** -- SELECT policy:
   - `USING (EXISTS (SELECT 1 FROM characters WHERE characters.campaign_id = campaigns.id AND characters.user_id = auth.uid()))`

3. **"Anyone can read template campaigns"** -- SELECT policy:
   - `USING (is_template = true)`

4. **"Authenticated users can create campaigns"** -- INSERT policy:
   - `WITH CHECK (auth.uid() = dm_user_id)`
   - This ensures that when inserting, the `dm_user_id` must be the current user (you cannot create a campaign and assign someone else as DM)

#### 1.2c: characters Policies

Create these policies on the `characters` table:

1. **"Users can manage their own characters"** -- ALL policy:
   - `USING (user_id = auth.uid())`
   - `WITH CHECK (user_id = auth.uid())`

2. **"DMs can read characters in their campaigns"** -- SELECT policy:
   - `USING (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = characters.campaign_id AND campaigns.dm_user_id = auth.uid()))`

3. **"DMs can update characters in their campaigns"** -- UPDATE policy:
   - `USING (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = characters.campaign_id AND campaigns.dm_user_id = auth.uid()))`
   - This allows the DM to adjust HP, apply conditions, etc.

#### 1.2d: npcs Policies

Create these policies on the `npcs` table:

1. **"DMs can manage NPCs in their campaigns"** -- ALL policy:
   - `USING (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = npcs.campaign_id AND campaigns.dm_user_id = auth.uid()))`
   - `WITH CHECK (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = npcs.campaign_id AND campaigns.dm_user_id = auth.uid()))`

2. **"Players can read visible NPCs in their campaigns"** -- SELECT policy:
   - `USING (is_visible_to_players = true AND EXISTS (SELECT 1 FROM characters WHERE characters.campaign_id = npcs.campaign_id AND characters.user_id = auth.uid()))`

#### 1.2e: encounters Policies

Create these policies on the `encounters` table:

1. **"DMs can manage encounters in their campaigns"** -- ALL policy:
   - `USING (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = encounters.campaign_id AND campaigns.dm_user_id = auth.uid()))`
   - `WITH CHECK (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = encounters.campaign_id AND campaigns.dm_user_id = auth.uid()))`

2. **"Players can read encounters in their campaigns"** -- SELECT policy:
   - `USING (EXISTS (SELECT 1 FROM characters WHERE characters.campaign_id = encounters.campaign_id AND characters.user_id = auth.uid()))`

#### 1.2f: notes Policies

Create these policies on the `notes` table:

1. **"DMs can manage all notes in their campaigns"** -- ALL policy:
   - `USING (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = notes.campaign_id AND campaigns.dm_user_id = auth.uid()))`
   - `WITH CHECK (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = notes.campaign_id AND campaigns.dm_user_id = auth.uid()))`

2. **"Players can read visible notes in their campaigns"** -- SELECT policy:
   - `USING (is_visible_to_players = true AND EXISTS (SELECT 1 FROM characters WHERE characters.campaign_id = notes.campaign_id AND characters.user_id = auth.uid()))`

3. **"Players can create notes in their campaigns"** -- INSERT policy:
   - `WITH CHECK (author_id = auth.uid() AND EXISTS (SELECT 1 FROM characters WHERE characters.campaign_id = notes.campaign_id AND characters.user_id = auth.uid()))`
   - This lets players write session logs

4. **"Authors can update their own notes"** -- UPDATE policy:
   - `USING (author_id = auth.uid())`
   - `WITH CHECK (author_id = auth.uid())`

5. **"Authors can delete their own notes"** -- DELETE policy:
   - `USING (author_id = auth.uid())`

#### 1.2g: bayes_scenarios Policies

Create these policies on the `bayes_scenarios` table:

1. **"Anyone can read template scenarios"** -- SELECT policy:
   - `USING (is_template = true)`

2. **"DMs can manage campaign-specific scenarios"** -- ALL policy:
   - `USING (campaign_id IS NOT NULL AND EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = bayes_scenarios.campaign_id AND campaigns.dm_user_id = auth.uid()))`
   - `WITH CHECK (campaign_id IS NOT NULL AND EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = bayes_scenarios.campaign_id AND campaigns.dm_user_id = auth.uid()))`

3. **"Players can read scenarios in their campaigns"** -- SELECT policy:
   - `USING (campaign_id IS NOT NULL AND EXISTS (SELECT 1 FROM characters WHERE characters.campaign_id = bayes_scenarios.campaign_id AND characters.user_id = auth.uid()))`

#### 1.2h: campaign_maps Policies

Create these policies on the `campaign_maps` table:

1. **"DMs can manage maps in their campaigns"** -- ALL policy:
   - `USING (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = campaign_maps.campaign_id AND campaigns.dm_user_id = auth.uid()))`
   - `WITH CHECK (EXISTS (SELECT 1 FROM campaigns WHERE campaigns.id = campaign_maps.campaign_id AND campaigns.dm_user_id = auth.uid()))`

2. **"Players can read maps in their campaigns"** -- SELECT policy:
   - `USING (EXISTS (SELECT 1 FROM characters WHERE characters.campaign_id = campaign_maps.campaign_id AND characters.user_id = auth.uid()))`

#### 1.2i: map_markers Policies

Create these policies on the `map_markers` table:

1. **"DMs can manage markers on their campaign maps"** -- ALL policy:
   - `USING (EXISTS (SELECT 1 FROM campaign_maps JOIN campaigns ON campaigns.id = campaign_maps.campaign_id WHERE campaign_maps.id = map_markers.map_id AND campaigns.dm_user_id = auth.uid()))`
   - `WITH CHECK (EXISTS (SELECT 1 FROM campaign_maps JOIN campaigns ON campaigns.id = campaign_maps.campaign_id WHERE campaign_maps.id = map_markers.map_id AND campaigns.dm_user_id = auth.uid()))`

2. **"Players can read visible markers on maps in their campaigns"** -- SELECT policy:
   - `USING (is_visible_to_players = true AND EXISTS (SELECT 1 FROM campaign_maps JOIN characters ON characters.campaign_id = campaign_maps.campaign_id WHERE campaign_maps.id = map_markers.map_id AND characters.user_id = auth.uid()))`
