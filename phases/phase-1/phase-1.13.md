# Phase 1.13 — Update the Role Provider with Real Data

**File:** `src/hooks/use-role.ts` -- MODIFY

**Purpose:** Connect the role switcher to the real user profile so the role persists across sessions.

**Details:**

1. The current `use-role.ts` likely stores the role in local state or context. Modify it to:

   - Accept the user's initial `preferred_role` as an argument or read it from a context/prop that the dashboard layout provides.
   - On mount, set the role to the user's `preferred_role` from their profile.

2. When the `setRole` / `toggleRole` function is called:
   - **Optimistically** update the local state immediately (so the UI responds instantly)
   - Fire an async Supabase update in the background:
     ```typescript
     const supabase = createClient()
     const { error } = await supabase
       .from('profiles')
       .update({ preferred_role: newRole })
       .eq('id', userId)
     ```
   - If the update fails:
     - Revert the local state to the previous role
     - Show an error toast (use whatever toast system Phase 0 set up, e.g., shadcn `useToast` or `sonner`)
     - Log the error to the console

3. The role switcher component (wherever it lives -- likely in the sidebar or settings page) should call this hook's `setRole` function. The settings page mockup shows a "Default Role" toggle with "DM" and "Player" buttons (see the settings mockup at `settings_map_icon_fixed/screen.png`):
   - DM button (active): `bg-arcane-accent text-white rounded-md shadow-lg px-4 py-1.5 text-xs font-bold`
   - Player button (inactive): `text-slate-400 hover:text-white px-4 py-1.5 text-xs font-bold`
   - Container: `bg-[#1e1e2e] rounded-lg p-1 flex items-center gap-1`

4. Ensure the role change propagates to all components that depend on it (sidebar badge, any DM-only UI elements, etc.). The role context/provider should trigger a re-render.
