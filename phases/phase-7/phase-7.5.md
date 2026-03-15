# Phase 7.5 — Responsive QA

**Purpose:** Systematically test and fix every page at 3 breakpoints.

**Details:**

Test at these widths using Chrome DevTools:
- **Desktop:** 1440px, 1280px, 1024px
- **Tablet:** 768px, 900px
- **Mobile:** 375px (iPhone SE), 390px (iPhone 14), 412px (Pixel 7)

For each page at each breakpoint, verify:

**Layout:**
- Desktop: sidebar (260px) + content — no horizontal scroll
- Tablet: sidebar collapses to icons (64px) + full content
- Mobile: no sidebar, bottom nav (64px) + stacked content

**Specific responsive behaviors to verify:**

**Dashboard:**
- Hero banner: full-width at all sizes, text sizes scale down on mobile
- Quick stats: 4 columns desktop → 2 columns tablet → 1 column mobile (stacked)
- Two-column sections (encounter + party): side-by-side desktop → stacked mobile

**Probability Cards:**
- Form fields: horizontal row desktop → stacked mobile
- Live calc + recent sims: side-by-side desktop → stacked mobile

**Dice Visualizer:**
- Dice selector circles: all 6 in a row desktop → wrap to 2 rows mobile
- Chart: full width, touch-friendly tooltips on mobile

**Bayes Analyzer:**
- Two columns → stacked on mobile
- Sliders: must be usable with touch (large enough thumb targets, min 44px touch area)
- Probability tree: horizontal layout desktop → vertical layout mobile (or scrollable)

**Character Sheet:**
- Ability scores: 6 in a row → 3x2 on tablet → 2x3 on mobile
- Cards: 2-column → stacked mobile

**NPC Manager:**
- Cards: 3 columns → 2 columns tablet → 1 column mobile

**Story Notes:**
- 3-panel layout desktop → 2 panels tablet (list collapses to slide-out) → single panel mobile (list view or editor view, toggle between them)

**Maps:**
- Map canvas: full viewport at all sizes → touch gestures on mobile
- Marker touch targets: minimum 44px on mobile

**Settings:**
- Theme cards: 3+2 grid → 2+2+1 mobile → stacked mobile
