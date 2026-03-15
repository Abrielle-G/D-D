# Phase 0.8 — Create the Role Provider

**File:** `src/components/providers/role-provider.tsx` — CREATE

**Purpose:** React context provider for the DM/Player role state.

**Details:**
- Create a `RoleContext` with `{ role: 'dm' | 'player', setRole: (r: 'dm' | 'player') => void, isDM: boolean, isPlayer: boolean }`
- The `RoleProvider` component:
  1. On mount: read from localStorage (`dd-role` key), or default to `'player'`
  2. When role changes: persist to localStorage, and (when authenticated) update the user's `preferred_role` DB field
  3. Role determines what the user sees — DM shows all tools, Player shows limited view
- Export `useRole()` hook
- The role is stored per-user and changes immediately upon toggle
