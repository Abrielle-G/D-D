# Phase 2.8 — Polish Topbar to Match Mockup

**File:** `src/components/layout/topbar.tsx` -- MODIFY

Review the mockup screenshots for the topbar and make these adjustments:

1. **Backdrop blur:** The topbar should have a frosted glass effect: `backdrop-blur-md` or `backdrop-blur-lg` with a semi-transparent background (e.g., `bg-[#0a0a1a]/80`).

2. **Page title:** The main title text on the left should use the display/serif font from the design system. Size ~20-24px, bold, white.

3. **Breadcrumb support:** Below or next to the title, optionally render breadcrumbs if the current page has a parent. Format: `"Dashboard / Encounters / Goblin Ambush"` with the intermediate segments as muted links and the last segment in white. If there is no breadcrumb, just show the title.

4. **Per-page action buttons:** The topbar should accept an optional `actions` prop (or use a slot/portal pattern) that allows each page to inject its own action buttons into the topbar's right section. For example, the Dashboard page might inject a "New Campaign" button; the Encounters page might inject "Create Encounter".

5. **Notification bell:** On the right side, render a bell icon (`Bell` from Lucide). If there are unread notifications, show a small blue dot indicator (a 8px circle positioned at the top-right of the bell icon using absolute positioning). The bell does not need to open anything yet -- it is a visual placeholder.

6. **User avatar:** To the right of the bell, render the user's avatar (small, ~32px circle). Clicking it could open a dropdown or navigate to settings. For now, make it a link to `/settings`.
