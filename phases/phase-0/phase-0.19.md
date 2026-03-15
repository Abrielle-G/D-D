# Phase 0.19 — Create Placeholder Pages

**Purpose:** Minimal page components for every route so the sidebar navigation works end-to-end from day one.

**Details:**
For each route in the `(dashboard)/` group, create a page component that:
1. Exports a `default` React component
2. Returns the page wrapped in reasonable structure (e.g., a div with the page title and an EmptyState placeholder)
3. The title matches the sidebar label

Routes to create (all inside `src/app/(dashboard)/`):
- `dashboard/page.tsx` — title "Dashboard"
- `probability/cards/page.tsx` — title "Probability Cards"
- `probability/dice-visualizer/page.tsx` — title "Dice Visualizer"
- `probability/bayes-analyzer/page.tsx` — title "Bayes Analyzer"
- `campaign/story-notes/page.tsx` — title "Story Notes"
- `campaign/encounters/page.tsx` — title "Encounters"
- `campaign/npcs/page.tsx` — title "NPCs"
- `maps/page.tsx` — title "Maps"
- `characters/page.tsx` — title "Character Sheet"
- `settings/page.tsx` — title "Settings"

Auth pages (inside `src/app/(auth)/`):
- `login/page.tsx` — title "Sign In"
- `signup/page.tsx` — title "Sign Up"

Auth layout (`src/app/(auth)/layout.tsx`):
- No sidebar, no topbar, no status bar
- Centered content area, max-width ~450px
- Dark background with noise texture
- Used only for the login/signup flow

Root page (`src/app/page.tsx`):
- Redirect to `/dashboard` (which will redirect to `/login` if not authenticated, handled in Phase 1)
