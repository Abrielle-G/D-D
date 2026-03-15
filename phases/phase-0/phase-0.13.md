# Phase 0.13 — Create Mobile Bottom Navigation

**File:** `src/components/layout/mobile-nav.tsx` — CREATE

**Purpose:** Bottom navigation bar for mobile screens (<=767px), replacing the sidebar.

**Details:**
- Position: fixed bottom, `z-index: 40`
- Height: 64px
- Background: `rgba(10, 10, 15, 0.9)` with `backdrop-filter: blur(12px)` — matching the frosted glass treatment of the topbar
- Top border: 1px solid `var(--color-border)` at 50% opacity
- Layout: 5 equally spaced icon buttons in a row
- Items:
  1. Dashboard — `LayoutDashboard` icon → `/dashboard`
  2. Probability — `Dices` icon → `/probability/cards`
  3. Campaign — `ScrollText` icon → `/campaign/story-notes` (DM mode) or Maps `MapPin` icon → `/maps` (Player mode)
  4. Maps — `MapPin` icon → `/maps` (DM mode), or hidden/replaced in Player mode
  5. Character — `UserCircle` icon → `/characters`
- Active item: icon in `var(--color-accent)` with a subtle filled circle background
- Inactive: icon in muted gray (`#475569`)
- Only visible on `max-width: 767px` (use `md:hidden` or a media query)
- Each icon is 24px with a small label below (10px, optional)
