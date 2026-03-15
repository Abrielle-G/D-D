# Phase 1.5 — Configure Supabase Client (Server)

**File:** `src/lib/supabase/server.ts` -- MODIFY

**Purpose:** Create the server-side Supabase client for use in Server Components, Server Actions, and Route Handlers.

**Details:**

1. Import `createServerClient` from `@supabase/ssr`.
2. Import `cookies` from `next/headers`.
3. Import the `Database` type from `@/types/database`.
4. Export an **async** function called `createClient()` that:
   - Awaits `cookies()` to get the cookie store (Next.js 14+ requires awaiting this)
   - Calls `createServerClient<Database>(...)` with:
     - First argument: `process.env.NEXT_PUBLIC_SUPABASE_URL!`
     - Second argument: `process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!`
     - Third argument: an options object with a `cookies` property containing:
       - `getAll()`: returns `cookieStore.getAll()`
       - `setAll(cookiesToSet)`: iterates over `cookiesToSet` and calls `cookieStore.set(name, value, options)` for each. Wrap this in a try/catch because `setAll` can be called from a Server Component where cookies are read-only -- the try/catch silently catches the error (the middleware will handle refreshing the cookie).
   - Returns the resulting typed client
5. Remove any existing placeholder content in this file.

The file should be approximately 25-35 lines.
