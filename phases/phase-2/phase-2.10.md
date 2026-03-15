# Phase 2.10 — Mobile Bottom Navigation

**File:** Create a new component `src/components/layout/mobile-bottom-nav.tsx` or add to an existing mobile layout component.

**Purpose:** On mobile screen sizes (below `md` breakpoint / 768px), the sidebar is hidden and a bottom navigation bar appears instead.

**Styling instructions:**

- Fixed position bottom (above the status bar, or replacing it on mobile).
- Height: 64px.
- Background: frosted/blurred dark background (`backdrop-blur-md bg-[#0a0a1a]/90`).
- Top border: subtle 1px border in `border-white/5`.

**Navigation items:** Exactly 5 icons in a horizontal row, evenly spaced:

1. **Dashboard** -- `LayoutDashboard` icon, label "Dashboard", links to `/dashboard`.
2. **Probability** -- `Dices` icon (or `Calculator`), label "Probability", links to `/probability`.
3. **Campaign** -- `BookOpen` icon, label "Campaign", links to `/campaign`.
4. **Maps** -- `Map` icon, label "Maps", links to `/maps`.
5. **Character** -- `User` icon, label "Character", links to `/character`.

**Active state:** The active item's icon and label are colored in the accent color. Inactive items are muted gray.

**Layout:** Each item is a vertical stack: icon (24px) on top, label text (10px) below. Centered within each item's column.

**Responsive behavior:** This component must only be visible on screens narrower than the `md` breakpoint. Use `className="md:hidden"` on the container. Conversely, the desktop sidebar should have `className="hidden md:flex"` (or whatever breakpoint it currently uses).

Adjust the main content area's bottom padding on mobile to account for the 64px bottom nav bar so content is not obscured.
