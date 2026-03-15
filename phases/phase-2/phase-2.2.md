# Phase 2.2 — useCampaign Hook

**File:** `src/hooks/use-campaign.ts` -- CREATE

This is a client-side React hook that provides the active campaign context to any client component that needs it.

**Implementation instructions:**

1. Mark the file `"use client"`.
2. Use `useState` to hold the campaign object, a loading boolean, and an error string or null.
3. Use `useEffect` to call a Supabase client-side query on mount (use `createClientComponentClient` from `@supabase/auth-helpers-nextjs`) that mirrors the `getActiveCampaign` logic from Step 2.1.
4. Expose a `refetch` function that re-runs the query and updates state.
5. Return `{ campaign, isLoading, error, refetch }`.
6. If you already have a CampaignProvider context from Phase 0 or Phase 1, integrate this hook into that provider instead of creating a duplicate context. The hook itself should still exist as the logic layer; the provider simply wraps it and exposes the value via `useContext`.
