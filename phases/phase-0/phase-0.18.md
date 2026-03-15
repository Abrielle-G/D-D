# Phase 0.18 — Create D20 Logo Component

**File:** `src/components/shared/d20-logo.tsx` — CREATE

**Purpose:** SVG d20 icosahedron icon used in the sidebar logo and auth page.

**Details:**
- Create a React component that renders an SVG d20 (icosahedron shape)
- Default color: `var(--color-accent)` (purple)
- Accept `size` prop (default 32px) and `className` for customization
- The shape should be recognizable as a 20-sided die — a geometric polygon
- If the user has provided a custom logo image in `public/images/icons/`, use that instead via a prop or check
