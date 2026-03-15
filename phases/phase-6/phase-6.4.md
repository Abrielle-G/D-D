# Phase 6.4 — SQL Seed Alternative
**File:** `supabase/seed.sql` — MODIFY
**Purpose:** SQL-based seed data as an alternative to the TypeScript runner.
**Details:**
- Write INSERT statements for all the Tower of Fate data
- Use `ON CONFLICT DO NOTHING` to make it idempotent
- Include comments explaining each section
- Note: the campaign needs a dm_user_id — use a placeholder UUID that gets replaced with the actual DM user's ID
- Include instructions: "Before running, replace 'YOUR_DM_USER_UUID' with the UUID of the user who should own this campaign"
