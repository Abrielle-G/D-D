# Phase 1.9 — Create the Auth Hook

**File:** `src/hooks/use-auth.ts` -- CREATE

**Purpose:** A React hook that provides authentication state and operations to any client component.

**Details:**

1. Mark as `'use client'` at the top of the file.

2. Import:
   - `useState`, `useEffect`, `useCallback` from `react`
   - `useRouter` from `next/navigation`
   - `createClient` from `@/lib/supabase/client`
   - `User` type from `@supabase/supabase-js`
   - `Profile` type from `@/types/database`

3. Export a `useAuth()` hook that returns an object with:
   - `user: User | null` -- the Supabase auth user
   - `profile: Profile | null` -- the user's profile from the `profiles` table
   - `isLoading: boolean` -- true while the initial auth state is being determined
   - `signIn(email: string, password: string): Promise<{ error: string | null }>`
   - `signUp(email: string, password: string, displayName: string): Promise<{ error: string | null }>`
   - `signOut(): Promise<void>`
   - `resetPassword(email: string): Promise<{ error: string | null }>`

4. **Implementation details:**

   - Create the Supabase client once at the top of the hook: `const supabase = createClient()`
   - Initialize state: `user` = null, `profile` = null, `isLoading` = true

   - **On mount (`useEffect`):**
     - Call `supabase.auth.getUser()` to get the initial user
     - If a user exists, fetch their profile from `profiles` table
     - Set `isLoading = false`
     - Subscribe to auth state changes with `supabase.auth.onAuthStateChange((event, session) => {...})`
     - On `SIGNED_IN` or `TOKEN_REFRESHED`: update the user state, fetch the profile
     - On `SIGNED_OUT`: set user and profile to null
     - Return the unsubscribe function from the effect cleanup

   - **`signIn` function:**
     - Call `supabase.auth.signInWithPassword({ email, password })`
     - If error, return a user-friendly error message (map common Supabase errors):
       - `"Invalid login credentials"` -> `"Invalid email or password. Please try again."`
       - `"Email not confirmed"` -> `"Please verify your email before signing in."`
       - Default: return the error message as-is
     - If success, call `router.refresh()` to trigger the middleware to re-evaluate and redirect
     - Return `{ error: null }` on success

   - **`signUp` function:**
     - Call `supabase.auth.signUp({ email, password, options: { data: { display_name: displayName } } })`
     - The `data` object in options populates `raw_user_meta_data` which the database trigger (Step 1.1l) reads to set the display name
     - If error, return a user-friendly message:
       - `"User already registered"` -> `"An account with this email already exists."`
       - Default: return the error message as-is
     - If success, call `router.refresh()`
     - Return `{ error: null }`

   - **`signOut` function:**
     - Call `supabase.auth.signOut()`
     - Call `router.push('/login')`
     - Call `router.refresh()`

   - **`resetPassword` function:**
     - Call `supabase.auth.resetPasswordForEmail(email, { redirectTo: window.location.origin + '/auth/callback' })`
     - If error, return the error message
     - If success, return `{ error: null }`
