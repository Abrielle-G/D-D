# Phase 1.4 — Configure Supabase Client (Browser)

**File:** `src/lib/supabase/client.ts` -- MODIFY

**Purpose:** Create the browser-side Supabase client using `@supabase/ssr` for cookie-based session management with Next.js.

**Details:**

1. Import `createBrowserClient` from `@supabase/ssr`.
2. Import the `Database` type from `@/types/database` (created in Step 1.7).
3. Export a function called `createClient()` that:
   - Calls `createBrowserClient<Database>(...)` with:
     - First argument: `process.env.NEXT_PUBLIC_SUPABASE_URL!`
     - Second argument: `process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!`
   - Returns the resulting typed client
4. The function should create a new client instance each time it is called (the `@supabase/ssr` library handles deduplication internally via the GoTrueClient singleton).
5. Remove any existing placeholder content in this file.

The file should be short -- approximately 10-15 lines. No state management, no React hooks -- this is a pure utility function.
