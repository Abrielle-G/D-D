# Phase 6.3 — Create the Seed API Route
**File:** `src/app/api/seed/route.ts` — CREATE
**Purpose:** API endpoint that triggers the Tower of Fate seed script. Only available in development or to admin users.
**Details:**
- POST endpoint
- Check that the request is authorized: either by checking a secret header (`X-Seed-Secret` matching an env var), or by verifying the user is authenticated and is the first user (admin)
- Call the seed runner with a service-role Supabase client
- Return the seed summary as JSON
- If the Tower of Fate already exists, return a 409 Conflict with message "Tower of Fate already seeded"
