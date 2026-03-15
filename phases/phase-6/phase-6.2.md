# Phase 6.2 — Create the Seed Runner
**File:** `src/lib/seed/seed-runner.ts` — CREATE
**Purpose:** A function that executes all the seed data insertions in the correct order.
**Details:**
- The function should accept a Supabase admin client (using the SERVICE_ROLE_KEY for bypassing RLS)
- Insertion order (respecting foreign keys):
  1. Create the campaign (Tower of Fate)
  2. Create NPCs (linked to campaign)
  3. Create encounters (linked to campaign)
  4. Create notes (linked to campaign, author = DM user)
  5. Create Bayes scenarios (linked to campaign)
  6. Upload map image to storage (if file exists), create campaign_maps record
  7. Create map markers (linked to map)
  8. Create the demo character "Thorin" (linked to campaign, needs a user to link to)
- Include error handling: if any insert fails, log the error but continue with remaining inserts (so partial seeding works)
- Include an "upsert" check: before creating, check if a Tower of Fate campaign already exists (by name + is_template). If it does, skip to avoid duplicate seeding.
- Return a summary: { campaignId, npcCount, encounterCount, noteCount, scenarioCount, mapId, markerCount }
