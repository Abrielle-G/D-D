# Phase 1.6 — Create Auth Middleware

#### Part A: Middleware Helper

**File:** `src/lib/supabase/middleware.ts` -- CREATE

**Purpose:** Helper function that creates a Supabase client within the Next.js middleware context and refreshes the auth session.

**Details:**

1. Import `createServerClient` from `@supabase/ssr`.
2. Import `NextResponse` and `type NextRequest` from `next/server`.
3. Import the `Database` type from `@/types/database`.
4. Export an async function `updateSession(request: NextRequest)` that:
   - Creates a default `NextResponse.next()` response object with the request headers forwarded
   - Creates a Supabase server client with cookie handlers that:
     - `getAll()`: reads cookies from `request.cookies.getAll()`
     - `setAll(cookiesToSet)`: sets cookies on BOTH the request object (`request.cookies.set(...)`) AND the response object (`response.cookies.set(...)`) for each cookie. This is critical -- both must be updated so the server client and the browser stay in sync.
   - Calls `supabase.auth.getUser()` to refresh the session (this is what keeps the JWT alive)
   - **Route protection logic:**
     - If `!user` (not authenticated) AND the request path starts with `/(dashboard)` or any dashboard sub-route (check using `request.nextUrl.pathname`), redirect to `/login` using `NextResponse.redirect(new URL('/login', request.url))`
     - If `user` exists (authenticated) AND the request path is `/login` or `/signup`, redirect to `/dashboard` using `NextResponse.redirect(new URL('/dashboard', request.url))`
   - Returns the response object (with updated cookies)

Important: Use `supabase.auth.getUser()` and NOT `supabase.auth.getSession()`. The `getUser()` method contacts the Supabase Auth server to validate the JWT, while `getSession()` only reads the local JWT without validation (which is insecure for middleware).

#### Part B: Next.js Middleware Entry Point

**File:** `src/middleware.ts` -- CREATE (in the `src/` root, NOT inside `app/`)

**Purpose:** The Next.js middleware entry point that runs on every matching request.

**Details:**

1. Import the `updateSession` function from `@/lib/supabase/middleware`.
2. Import `type NextRequest` from `next/server`.
3. Export an async `middleware(request: NextRequest)` function that simply calls and returns `await updateSession(request)`.
4. Export a `config` object with a `matcher` array that matches all routes EXCEPT:
   - `_next/static` (static files)
   - `_next/image` (image optimization)
   - `favicon.ico` (favicon)
   - Any files with common static extensions (svg, png, jpg, jpeg, gif, webp, ico)

   Use this matcher pattern:
   ```typescript
   matcher: [
     '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp|ico)$).*)',
   ]
   ```
