# Phase 1.11 — Auth Callback Route

**File:** `src/app/auth/callback/route.ts` -- CREATE

**Purpose:** Handle Supabase auth redirect callbacks. This is the URL that Supabase redirects to after email confirmation, password reset, or OAuth (if added later).

**Details:**

1. This is a Next.js Route Handler. Export an async `GET` function.

2. Import:
   - `NextResponse` from `next/server`
   - `createClient` from `@/lib/supabase/server`

3. **Implementation:**
   - Extract the `code` query parameter from the request URL: `const { searchParams } = new URL(request.url)` then `const code = searchParams.get('code')`
   - Extract the `next` parameter (optional redirect path): `const next = searchParams.get('next') ?? '/dashboard'`
   - If `code` exists:
     - Create the Supabase server client: `const supabase = await createClient()`
     - Exchange the code for a session: `const { error } = await supabase.auth.exchangeCodeForSession(code)`
     - If no error, redirect to `next` (the target page): `return NextResponse.redirect(new URL(next, request.url))`
   - If no code or if the exchange fails:
     - Redirect to `/login` with an error parameter: `return NextResponse.redirect(new URL('/login?error=auth_callback_failed', request.url))`

4. Note: This route is at `/auth/callback`, NOT `/(auth)/callback`. It sits outside the auth route group because it does not use the auth layout -- it is a pure API route that redirects.
