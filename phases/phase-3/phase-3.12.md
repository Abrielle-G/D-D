# Phase 3.12 — Topbar Tab Sub-Navigation

**Placement:** At the top of all probability pages, below the main navigation.

**Visual structure:**
- Main title: "Probability Tools" in the page header area.
- Below it: three tab links in a horizontal row:
  - "Cards" -- links to `/probability/cards`
  - "Dice Visualizer" -- links to `/probability/dice-visualizer`
  - "Bayes Analyzer" -- links to `/probability/bayes-analyzer`
- Active tab: accent-colored text with an accent underline (2-3px bottom border).
- Inactive tabs: muted text, no underline. On hover: slightly brighter text.

**Implementation:**
- Create a shared layout or component that wraps all probability pages.
- Use Next.js `usePathname()` to determine which tab is active.
- Place this in `src/app/(dashboard)/probability/layout.tsx` or as a reusable component imported by each page.
