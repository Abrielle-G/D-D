# Phase 1.12 — Protect Dashboard Routes

**File:** `src/app/(dashboard)/layout.tsx` -- MODIFY

**Purpose:** Add server-side auth guard to the dashboard layout. If the user is not authenticated, they are redirected to login before any dashboard page renders.

**Details:**

1. This remains a **server component**.

2. Add these imports at the top:
   - `redirect` from `next/navigation`
   - `createClient` from `@/lib/supabase/server`

3. At the top of the layout function (before any JSX), add the auth check:
   ```
   const supabase = await createClient()
   const { data: { user } } = await supabase.auth.getUser()

   if (!user) {
     redirect('/login')
   }
   ```

4. After confirming the user exists, fetch their profile:
   ```
   const { data: profile } = await supabase
     .from('profiles')
     .select('*')
     .eq('id', user.id)
     .single()
   ```

5. Pass the user and profile data to the sidebar component. The sidebar currently shows a hardcoded user name and role badge. Modify the sidebar rendering so that:
   - The user footer section at the bottom of the sidebar displays `profile.display_name` instead of a hardcoded name
   - The role badge shows `"DM MODE"` if `profile.preferred_role === 'dm'` or `"PLAYER"` if `profile.preferred_role === 'player'`
   - The role badge color remains the purple accent for DM mode (matching the mockup: `bg-arcane-accent text-white`) and could use a different color for Player mode (e.g., `bg-cyan-500/20 text-cyan-400`)

6. If the sidebar is a client component that needs the profile, pass the profile as a serializable prop. Do NOT pass the Supabase client as a prop (it is not serializable).

7. Keep all existing layout structure (sidebar, topbar, main content area) intact. Only add the auth guard at the top and modify the user display section.
