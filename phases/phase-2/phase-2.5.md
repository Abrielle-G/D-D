# Phase 2.5 — Dashboard Page Router

**File:** `src/app/(dashboard)/dashboard/page.tsx` -- MODIFY

This file should already exist from Phase 0/1 as a placeholder. Replace or update its content.

**Instructions:**

1. This must be an async Server Component.
2. At the top of the component function:
   - Create a Supabase server client.
   - Fetch the authenticated user. If no user, redirect to `/login`.
   - Fetch the user's profile row to get `preferred_role`.
   - Call `getActiveCampaign(userId)` from the dashboard queries.
3. **If no active campaign is found:**
   - Render an onboarding empty state. Full-page centered content with a large icon, heading `"Create Your First Campaign"`, a brief welcoming description, and a prominent CTA button linking to the campaign creation page. Do not render any dashboard components.
4. **If `preferred_role` is `'dm'`:**
   - Fetch all DM dashboard data in parallel using `Promise.all`: `getCampaignStats`, `getNextEncounter`, `getPartyMembers`, `getRecentNotes`.
   - Render `<DMDashboard />` passing all data as props.
5. **If `preferred_role` is `'player'`:**
   - Fetch player dashboard data: `getPlayerCharacter(userId, campaignId)`, feed items (from notes/encounters as a combined feed -- or stub with empty array until the feed system is built), inspiration status from the character row.
   - If the player has no character in this campaign, render a prompt to create one (similar to the character banner empty state but page-level).
   - Otherwise render `<PlayerDashboard />` with all data.
6. Set the page metadata: `export const metadata = { title: "Dashboard | Dice & Decisions" }`.
