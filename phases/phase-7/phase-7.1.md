# Phase 7.1 — Loading States for Every Page

**Purpose:** No page should ever show a blank white screen while loading. Every route in the app needs a loading skeleton or spinner.

**Details:**

Create a `loading-skeleton.tsx` shared component that renders animated pulse placeholder elements matching the layout of each page. This is the "skeleton screen" pattern — showing the shape of the content while it loads.

For each route, create a `loading.tsx` file (Next.js auto-detects these):

**Dashboard loading:**
- Skeleton of the hero banner (dark rectangle with pulse animation, 300px height)
- Skeleton of 4 stat cards in a row (small rounded rectangles pulsing)
- Skeleton of 2-column layout below (left: larger rectangle, right: narrower)

**Probability Cards loading:**
- Skeleton of the form card (input-shaped rectangles)
- Skeleton of the live calculation (large square with circle placeholder for the percentage)

**Dice Visualizer loading:**
- Skeleton of dice selector row (6 circles in a row)
- Skeleton of chart area (large rectangle)
- Skeleton of 3 stat cards

**Bayes Analyzer loading:**
- Skeleton of slider inputs (3 horizontal rectangles)
- Skeleton of result panel (large rectangle with circle placeholder)

**Character Sheet loading:**
- Skeleton of character header
- Skeleton of 6 ability score circles in a row
- Skeleton of stat rows

**NPC Manager loading:**
- Skeleton of 3x2 card grid (6 card-shaped rectangles)

**Encounter Builder loading:**
- Skeleton of 2-column layout (form left, probability stream right)

**Story Notes loading:**
- Skeleton of 3-panel layout (sidebar, notes list, editor)

**Maps loading:**
- Skeleton of the map viewport (large centered rectangle)

The skeleton elements should:
- Match the approximate size and position of the real content
- Use a dark gray color (`#1a1a2e`) with a lighter pulse animation (`#2a2a3e`)
- Animate with `@keyframes pulse` — opacity oscillating between 0.4 and 1.0, 1.5s duration
- Have rounded corners matching the content they're replacing
