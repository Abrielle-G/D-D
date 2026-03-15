# Phase 2: Core UI Shell, Dashboard & Settings

## Context

This phase constructs the DM Dashboard, Player Dashboard, and Settings page (theme selector, profile editing, role switcher). It delivers features 3.2 (Campaign Dashboard), 3.1 (Role Switcher), and 3.12 (Theme Switcher). Every component described below must be built by referencing the mockup screenshots pixel-for-pixel; do not invent your own layout or spacing.

**Tech stack:** Next.js 14+, TypeScript, Tailwind CSS 3, shadcn/ui, Supabase, Lucide React.

## Design Reference Files

Open these mockup directories and keep them visible while building every component. Match them exactly.

| Screen | Mockup Path |
|---|---|
| DM Dashboard | `stitch_proba_project/stitch_proba_project/dm_command_center_refined_fresh_copy/` |
| Player Dashboard | `stitch_proba_project/stitch_proba_project/player_dashboard_sidebar_synced/` |
| Settings | `stitch_proba_project/stitch_proba_project/settings_map_icon_fixed/` |

**Key visual elements to match:**

- **DM Dashboard:** hero banner with atmospheric image and campaign title overlaid, a row of 4 quick-stat cards, a next encounter section on the left, party overview on the right, recent notes spanning the full width below.
- **Player Dashboard:** character banner with a large circular portrait and stat pills, a campaign feed timeline on the left, a probability check widget on the right, and an inspiration badge.
- **Settings:** a grid of 5 theme cards (3 on the top row, 2 on the bottom row), a profile form with avatar upload and display name and email, system preferences with a DM/Player toggle, and an account management section with sign out and delete account.

## Prerequisites

- Phase 0 fully complete (design system tokens, layout shell components, navigation skeleton).
- Phase 1 fully complete (Supabase auth, database schema, RLS policies, user profile row creation).

---

## Directory Structure

```
src/
├── app/(dashboard)/
│   ├── dashboard/page.tsx               ← MODIFY
│   └── settings/page.tsx                ← MODIFY
├── components/
│   ├── dashboard/
│   │   ├── dm-dashboard.tsx             ← CREATE
│   │   ├── player-dashboard.tsx         ← CREATE
│   │   ├── hero-banner.tsx              ← CREATE
│   │   ├── quick-stats.tsx              ← CREATE
│   │   ├── next-encounter-card.tsx      ← CREATE
│   │   ├── party-overview.tsx           ← CREATE
│   │   ├── recent-notes-row.tsx         ← CREATE
│   │   ├── character-banner.tsx         ← CREATE
│   │   ├── campaign-feed.tsx            ← CREATE
│   │   ├── probability-check-widget.tsx ← CREATE
│   │   └── inspiration-badge.tsx        ← CREATE
│   ├── settings/
│   │   ├── theme-selector.tsx           ← CREATE
│   │   ├── profile-form.tsx             ← CREATE
│   │   ├── system-preferences.tsx       ← CREATE
│   │   └── account-management.tsx       ← CREATE
│   └── layout/
│       ├── sidebar.tsx                  ← MODIFY (polish)
│       ├── topbar.tsx                   ← MODIFY (polish)
│       └── status-bar.tsx               ← MODIFY (polish)
├── hooks/
│   └── use-campaign.ts                  ← CREATE
└── lib/
    └── queries/
        └── dashboard.ts                 ← CREATE
```

---

## Subphases

| File | Step |
|---|---|
| [phase-2.1.md](./phase-2.1.md) | Step 2.1 — Dashboard Data Queries |
| [phase-2.2.md](./phase-2.2.md) | Step 2.2 — useCampaign Hook |
| [phase-2.3.md](./phase-2.3.md) | Step 2.3 — DM Dashboard Components |
| [phase-2.4.md](./phase-2.4.md) | Step 2.4 — Player Dashboard Components |
| [phase-2.5.md](./phase-2.5.md) | Step 2.5 — Dashboard Page Router |
| [phase-2.6.md](./phase-2.6.md) | Step 2.6 — Settings Page |
| [phase-2.7.md](./phase-2.7.md) | Step 2.7 — Polish Sidebar to Match Mockup |
| [phase-2.8.md](./phase-2.8.md) | Step 2.8 — Polish Topbar to Match Mockup |
| [phase-2.9.md](./phase-2.9.md) | Step 2.9 — Polish Status Bar |
| [phase-2.10.md](./phase-2.10.md) | Step 2.10 — Mobile Bottom Navigation |

## Verification Checklist

Work through each item after completing the implementation. Do not skip any.

- [ ] DM dashboard renders the hero banner, all 4 stat cards, next encounter, party overview, and recent notes.
- [ ] Player dashboard renders the character banner, campaign feed, probability check widget, and inspiration badge.
- [ ] Switching the role in Settings from DM to Player changes which dashboard renders on `/dashboard`.
- [ ] Dashboard displays real data from the database, or shows appropriate empty states when no data exists.
- [ ] Quick stat cards show correct counts that match the database.
- [ ] Party member HP bars are color-coded correctly (green above 60%, yellow 30-60%, red below 30%).
- [ ] Settings page shows all 5 theme cards with correct gradient backgrounds.
- [ ] Clicking a theme card applies the theme instantly across the entire application.
- [ ] Profile form saves display name and avatar to the database, and the sidebar reflects the changes.
- [ ] Role toggle in system preferences updates the database `preferred_role` field.
- [ ] Sign Out button logs the user out and redirects to the login page.
- [ ] Sidebar matches the mockup: group headers, active state with 3px left border, hover states, footer profile section.
- [ ] Status bar shows different flavor text depending on the current page.
- [ ] On mobile viewports: bottom nav bar is visible, sidebar is hidden, content stacks vertically.
- [ ] All empty states are user-friendly with descriptive messages and call-to-action buttons.

---

## Rollback Plan

All dashboard components are isolated in `src/components/dashboard/` and settings components in `src/components/settings/`. If this phase needs to be reverted:

1. Revert `src/app/(dashboard)/dashboard/page.tsx` and `src/app/(dashboard)/settings/page.tsx` to their Phase 1 state.
2. Delete the `src/components/dashboard/` and `src/components/settings/` directories.
3. Delete `src/hooks/use-campaign.ts` and `src/lib/queries/dashboard.ts`.
4. Revert sidebar, topbar, and status bar modifications to their Phase 1 state.

No database schema changes are introduced in this phase, so no migration rollback is needed.

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| Dashboard page is completely blank | RLS policies are blocking the Supabase queries silently | Check that the authenticated user has SELECT permission on campaigns, characters, encounters, npcs, and notes tables for rows they should be able to access. Test queries directly in the Supabase SQL editor with the user's JWT. |
| Theme selection does not persist across page reloads | The Supabase profile update for the theme field is failing or the ThemeProvider is not reading the saved theme on mount | Verify that the RLS policy allows the user to UPDATE their own profile row. Check the ThemeProvider's initialization logic reads the theme from the profile on first load. |
| Sidebar navigation links do not change when role is toggled | The sidebar is not consuming the RoleProvider context, or it is reading a stale value | Verify that the sidebar component calls `useRole()` and conditionally renders the CAMPAIGN nav group based on the role value. Ensure the RoleProvider updates its state when the system preferences toggle fires. |
| Hero banner shows no image, just a dark box | There is no image file in `public/images/heroes/` and the CSS gradient fallback is not implemented | Add a fallback: if no `heroImageUrl` is provided, apply a CSS gradient background instead of an `<img>` tag. Alternatively, add a default hero image to `public/images/heroes/default.jpg`. |
| Status bar overlaps page content at the bottom | The main content layout does not account for the 32px status bar height | Add `pb-8` (32px) bottom padding to the main content area, or set the content container's height to `calc(100vh - topbar - statusbar)`. |
| Probability widget shows NaN or Infinity | Division by zero when die size is 0 or the formula inputs are invalid | Add input validation: clamp die size to minimum 1, clamp the final probability between 0 and 1. Handle edge cases where `targetDC - modifier` exceeds the die size or is less than 1. |
| Mobile bottom nav is visible on desktop | The responsive class is missing or the breakpoint is wrong | Ensure the bottom nav container has `className="md:hidden"` and verify your Tailwind config has the standard `md: 768px` breakpoint. |
| Avatar upload fails silently | The Supabase Storage bucket `avatars` does not exist or its policies block uploads | Create the `avatars` bucket in Supabase Storage with public read access. Add an INSERT policy that allows authenticated users to upload to their own folder (e.g., `avatars/{user_id}/`). |
