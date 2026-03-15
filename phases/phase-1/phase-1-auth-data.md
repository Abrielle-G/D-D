# Phase 1: Authentication & Database Layer

## Context
This phase implements the entire authentication flow (sign up, sign in, forgot password, session management) using Supabase Auth, creates the complete database schema with all tables and relationships, sets up Row Level Security (RLS) policies, and builds the role switcher (DM/Player). This is the data foundation everything else depends on. Implements features 3.1 (Role Switcher) from the spec.

## Design Reference Files
- Auth page: `stitch_proba_project/stitch_proba_project/dice_decisions_auth_refined/` -- the login/signup screen design
- Settings page: `stitch_proba_project/stitch_proba_project/settings_map_icon_fixed/` -- the profile settings and role switcher design

## Prerequisites
- Phase 0 complete (Next.js project scaffolded, design system configured, sidebar/topbar components created)
- Supabase project created (free tier) with URL and anon key in `.env.local`
- All placeholder pages exist from Phase 0

## Directory Structure
All files this phase creates or modifies:
```
src/
  app/
    (auth)/
      login/page.tsx              MODIFIED (full auth UI)
      signup/page.tsx             MODIFIED (full auth UI)
      layout.tsx                  CREATE   (auth layout, no sidebar)
    (dashboard)/
      layout.tsx                  MODIFIED (add auth guard)
    auth/
      callback/route.ts           CREATE   (Supabase auth callback)
  lib/
    supabase/
      client.ts                   MODIFIED (browser client)
      server.ts                   MODIFIED (server client)
      middleware.ts               CREATE   (auth middleware helper)
    validations/
      auth.ts                     CREATE   (Zod schemas)
  hooks/
    use-auth.ts                   CREATE
    use-role.ts                   MODIFIED
  types/
    database.ts                   CREATE   (Supabase generated types)
  middleware.ts                   CREATE   (Next.js middleware)
supabase/
  migrations/
    001_initial_schema.sql        CREATE
  seed.sql                        CREATE   (minimal seed data)
```

---

## Subphases

| File | Step |
|---|---|
| [phase-1.1.md](./phase-1.1.md) | Step 1.1 — Create Supabase Database Schema |
| [phase-1.2.md](./phase-1.2.md) | Step 1.2 — Create Row Level Security (RLS) Policies |
| [phase-1.3.md](./phase-1.3.md) | Step 1.3 — Set Up Supabase Storage Bucket |
| [phase-1.4.md](./phase-1.4.md) | Step 1.4 — Configure Supabase Client (Browser) |
| [phase-1.5.md](./phase-1.5.md) | Step 1.5 — Configure Supabase Client (Server) |
| [phase-1.6.md](./phase-1.6.md) | Step 1.6 — Create Auth Middleware |
| [phase-1.7.md](./phase-1.7.md) | Step 1.7 — Generate Database Types |
| [phase-1.8.md](./phase-1.8.md) | Step 1.8 — Create Auth Validation Schemas |
| [phase-1.9.md](./phase-1.9.md) | Step 1.9 — Create the Auth Hook |
| [phase-1.10.md](./phase-1.10.md) | Step 1.10 — Build the Auth Pages (Login & Sign Up) |
| [phase-1.11.md](./phase-1.11.md) | Step 1.11 — Auth Callback Route |
| [phase-1.12.md](./phase-1.12.md) | Step 1.12 — Protect Dashboard Routes |
| [phase-1.13.md](./phase-1.13.md) | Step 1.13 — Update the Role Provider with Real Data |
| [phase-1.14.md](./phase-1.14.md) | Step 1.14 — Seed Data Script |

## Verification Checklist

After completing this phase, confirm all of the following:

- [ ] Navigating to `/login` shows the themed auth page matching the mockup design (dark background, purple d20 icon, "Dice & Decisions" heading, themed input fields with "SANCTUM EMAIL" and "SECRET CYPHER" labels, "Enter the Tower" button)
- [ ] Signing up with email/password creates a user in Supabase Auth AND a corresponding row in the `profiles` table (verify in Supabase Dashboard)
- [ ] The profile row has the correct `display_name` from the signup form's "HERO NAME" field
- [ ] Signing in with valid credentials redirects to `/dashboard`
- [ ] Signing in with invalid credentials shows a user-friendly error message (not a raw Supabase error like "AuthApiError")
- [ ] Navigating to any `/dashboard/*` route when not authenticated redirects to `/login`
- [ ] Navigating to `/login` when already authenticated redirects to `/dashboard`
- [ ] The user's display name appears in the sidebar footer after login
- [ ] The role badge in the sidebar shows "DM MODE" or "PLAYER" based on the user's `preferred_role`
- [ ] Toggling the role updates the badge immediately and persists the change in the database
- [ ] All 9 database tables exist in Supabase with correct columns, types, and constraints (verify in Supabase Dashboard > Table Editor)
- [ ] All 7 custom enums exist with the correct values
- [ ] RLS is enabled on all tables (verify: Supabase Dashboard > Authentication > Policies shows policies for every table)
- [ ] RLS policies work correctly: running a query as one user cannot access another user's private data
- [ ] The `dm_secret` note tag trigger works: inserting a note with `tag = 'dm_secret'` automatically sets `is_visible_to_players = false`
- [ ] The `maps` storage bucket exists and accepts image uploads (test via Supabase Dashboard > Storage)
- [ ] `npx tsc --noEmit` compiles with zero TypeScript errors
- [ ] Sign out clears the session and redirects to `/login`
- [ ] The "Forgot password?" link shows a password reset form
- [ ] The auth callback route (`/auth/callback`) correctly exchanges codes for sessions
- [ ] The auth page uses the exact themed UI from the mockup (dark card with `#111119` background, `#16161f` inputs, `#7c3aed` accent, Space Grotesk heading font, DM Sans body font) -- NOT default shadcn white form styling

## Rollback Plan

If this phase breaks something:

**Database rollback:** Drop all tables and re-run the migration. In Supabase Dashboard > SQL Editor, run:
```sql
-- Drop all tables (order matters due to foreign keys, or use CASCADE)
DROP TABLE IF EXISTS map_markers CASCADE;
DROP TABLE IF EXISTS campaign_maps CASCADE;
DROP TABLE IF EXISTS bayes_scenarios CASCADE;
DROP TABLE IF EXISTS notes CASCADE;
DROP TABLE IF EXISTS encounters CASCADE;
DROP TABLE IF EXISTS npcs CASCADE;
DROP TABLE IF EXISTS characters CASCADE;
DROP TABLE IF EXISTS campaigns CASCADE;
DROP TABLE IF EXISTS profiles CASCADE;

-- Drop custom enums
DROP TYPE IF EXISTS marker_icon_type CASCADE;
DROP TYPE IF EXISTS note_tag CASCADE;
DROP TYPE IF EXISTS encounter_status CASCADE;
DROP TYPE IF EXISTS npc_status CASCADE;
DROP TYPE IF EXISTS campaign_status CASCADE;
DROP TYPE IF EXISTS theme_id CASCADE;
DROP TYPE IF EXISTS user_role CASCADE;

-- Drop custom functions
DROP FUNCTION IF EXISTS public.handle_updated_at() CASCADE;
DROP FUNCTION IF EXISTS public.handle_new_user() CASCADE;
DROP FUNCTION IF EXISTS public.enforce_dm_secret_visibility() CASCADE;

-- Drop storage bucket (if needed)
DELETE FROM storage.objects WHERE bucket_id = 'maps';
DELETE FROM storage.buckets WHERE id = 'maps';
```
Then re-run the `001_initial_schema.sql` migration.

**Auth rollback:** Delete test users from Supabase Dashboard > Authentication > Users.

**Code rollback:** Revert to the Phase 0 commit:
```bash
git log --oneline  # find the Phase 0 commit hash
git checkout [phase-0-commit-hash]
```

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| `"Invalid API key"` error on any Supabase call | Wrong or missing environment variables | Verify `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` in `.env.local` match the values in Supabase Dashboard > Settings > API |
| Profile not created when user signs up | The `on_auth_user_created` trigger is not installed | Run the trigger SQL from Step 1.1l manually in Supabase SQL Editor. Verify: `SELECT * FROM pg_trigger WHERE tgname = 'on_auth_user_created';` |
| RLS blocking ALL queries (empty results) | Policies not created, or `auth.uid()` returning NULL | Check that RLS policies exist (Dashboard > Authentication > Policies). Test in SQL Editor: `SET request.jwt.claim.sub = 'your-user-uuid'; SELECT * FROM campaigns;` |
| Infinite redirect loop between `/login` and `/dashboard` | Middleware matching too broadly, or cookies not being set correctly | Ensure the middleware matcher excludes static files and the `/auth/callback` route. Verify `@supabase/ssr` cookie handlers are setting cookies on both request and response in the middleware helper. |
| `"Email not confirmed"` error on sign in | Email confirmation is enabled in Supabase | For development: disable email confirmations in Supabase Dashboard > Authentication > Settings > Email Auth > toggle off "Confirm email". For production, keep it enabled and handle the confirmation flow. |
| `"cookies() is not a function"` or cookie-related errors | `@supabase/ssr` version incompatible with Next.js version | Ensure `@supabase/ssr` is at the latest version (`npm i @supabase/ssr@latest`). In Next.js 14+, `cookies()` must be awaited. Verify the `server.ts` file uses `await cookies()`. |
| TypeScript errors about Database types | Types file does not match the actual schema | Regenerate types with `npx supabase gen types typescript --project-id [id] > src/types/database.ts`, or manually verify each column type in `database.ts` matches `001_initial_schema.sql` |
| Middleware runs on API routes causing issues | Matcher is too broad | Add API routes to the matcher exclusion pattern if needed. The callback route at `/auth/callback` should NOT be blocked by the middleware's auth check. |
| `"relation 'profiles' does not exist"` | Migration not applied | Apply the migration via Supabase Dashboard > SQL Editor by pasting and running the full `001_initial_schema.sql` file |
| Sign out does not clear session | Client-side sign out not calling `router.refresh()` | Ensure `signOut` in the auth hook calls both `supabase.auth.signOut()` AND `router.refresh()` to clear the server-side session cookie |
