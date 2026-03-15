# Phase 2.1 — Dashboard Data Queries

**File:** `src/lib/queries/dashboard.ts` -- CREATE

Create this file as the single source of truth for every Supabase query the dashboards need. Each function must be a standalone async function that accepts a Supabase server client (created via `createServerComponentClient`) so these can be called from Server Components.

**Functions to implement:**

1. **`getActiveCampaign(userId: string)`**
   - Query the `campaigns` table for campaigns where the user is the `dm_id`.
   - If none found, query the `characters` table joined to `campaigns` to find any campaign the user has a character in.
   - Return the first matching campaign object, or `null` if the user has no campaigns at all.

2. **`getCampaignStats(campaignId: string)`**
   - Run four queries (or a single RPC if you prefer) against the campaign's related tables:
     - Count of distinct users who have a character in this campaign (active players).
     - Count of rows in the `npcs` table for this campaign.
     - Count of rows in the `encounters` table for this campaign.
     - Average `dc` value across all encounters for this campaign (the "average DC").
   - Return an object: `{ playerCount, npcCount, encounterCount, avgDC }`.
   - If any count is zero, return `0`, not `null`.

3. **`getNextEncounter(campaignId: string)`**
   - Query the `encounters` table filtered by `campaign_id` and `status = 'planned'`, ordered by `created_at` ascending, limit 1.
   - Join to the encounter's enemies sub-table (or JSON column, depending on your Phase 1 schema) to include enemy data.
   - Return the encounter object with its enemies array, or `null`.

4. **`getPartyMembers(campaignId: string)`**
   - Query the `characters` table filtered by `campaign_id`.
   - Join to the `profiles` table to get each character owner's `display_name` and `avatar_url`.
   - Select: character name, class, level, current HP, max HP, plus the profile fields.
   - Order alphabetically by character name.
   - Return an array (possibly empty).

5. **`getRecentNotes(campaignId: string, limit = 3)`**
   - Query the `notes` table filtered by `campaign_id`, ordered by `created_at` descending, limited to the `limit` parameter.
   - Join to `profiles` to get the author's display name.
   - Return an array of note objects including: id, title, content (truncated to 120 chars in the query or in the component -- either is fine), tag/category, created_at, author display name.

6. **`getPlayerCharacter(userId: string, campaignId: string)`**
   - Query the `characters` table for the row matching both `user_id` and `campaign_id`.
   - Return the full character object, or `null` if the player has not created a character in this campaign.

**Error handling:** Every function must wrap its Supabase call in a try/catch. On error, log to `console.error` with the function name and return the empty/null fallback. Never throw from these functions; let the UI handle the null/empty case gracefully.
