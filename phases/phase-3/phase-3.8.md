# Phase 3.8 — Shared Probability Bar

**File:** `src/components/shared/probability-bar.tsx` -- CREATE

A reusable horizontal segmented bar component used across probability pages.

**Props:**
- `segments`: Array of `{ percentage: number; color: string; label?: string }` -- each segment's width is proportional to its percentage.
- `variant`: `'four-segment' | 'three-segment'` (optional, for convenience).
- `height`: number, default 8 (in px).
- `animated`: boolean, default true.

**Rendering:**
- Outer container: full width, rounded-full, overflow-hidden, background dark/muted.
- Inner segments: each a `div` with `width` set to `${percentage}%`, background set to the segment color.
- Segments are laid out in a flex row, no gaps.
- Height is 8px by default, rounded-full corners on the outer container.

**Animation:**
- On mount (or when data changes), animate each segment's width from 0% to its target percentage.
- Duration: 600ms, ease-out timing function.
- Use CSS transitions or Tailwind's `transition-all duration-600 ease-out` approach.
- If `animated` is false, render at full width immediately.
