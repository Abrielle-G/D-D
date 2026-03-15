# Phase 0.12 — Create the Dashboard Layout

**File:** `src/app/(dashboard)/layout.tsx` — CREATE

**Purpose:** Shared layout for all authenticated pages — sidebar + topbar + content + status bar.

**Details:**
- This layout wraps everything inside the `(dashboard)/` route group
- Structure: CSS Grid or Flexbox layout
  - Sidebar: fixed or sticky on the left
  - Content area: fills remaining width
    - Topbar: sticky at top of content area
    - Main content: scrollable, padding 32px on desktop, 16px on mobile
    - Status bar: fixed at bottom across full width
- On mobile (<=767px):
  - Sidebar completely hidden
  - Bottom navigation bar appears instead (from `mobile-nav.tsx`)
  - Content area fills full width
  - Add bottom padding to account for mobile nav (64px) and status bar (32px)
- Wrap with `ThemeProvider` and `RoleProvider`
- The noise texture overlay (from globals.css `body::before`) applies here automatically
