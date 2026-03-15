# Phase 3: Probability Engine, Dice Visualizer & Bayes Analyzer

## Context

The most important phase -- probability tools are the core deliverable for the probability class. Implements Probability Cards (Feature 3.4), Dice Distribution Visualizer (3.4), and Bayes Analyzer (Feature 3.5). ALL calculations are client-side using exact combinatorics (no simulation). Must be working by prototype deadline ~March 22.

## Design Reference Files

- **Probability Cards:** `stitch_proba_project/stitch_proba_project/probability_cards_logo_refined/`
  - Form with action name / dice / count / modifier / DC inputs
  - Live calculation showing massive percentage number with segmented color bar
  - Recent simulations 2x2 grid of mini cards
- **Dice Visualizer:** `stitch_proba_project/stitch_proba_project/dice_visualizer_refined_style/`
  - Circular dice type buttons (d4-d20)
  - Area/bar chart distribution
  - 3 stats cards (mean/variance, P(>=X), comparison delta)
  - Comparison overlay support
- **Bayes Analyzer:** `stitch_proba_project/stitch_proba_project/bayes_analyzer_textured_background/`
  - THREE slider inputs (prior / likelihood / false positive) with gradient tracks and cyan value displays
  - Terminal-style system log
  - ENORMOUS posterior result (~72-96px number)
  - Risk level badge
  - Theorem breakdown showing formula with real numbers
  - Evidence weight stacked bar
  - Probability tree diagram with branching nodes

## Prerequisites

- Phase 0 (design system, navigation)
- Phase 1 (auth, database -- for saving probability cards to encounters)

## Tech Stack

- Next.js 14+
- TypeScript
- Tailwind CSS 3
- shadcn/ui
- Recharts (for charts)

## Directory Structure

```
src/
├── app/(dashboard)/probability/
│   ├── cards/page.tsx                  <- MODIFY
│   ├── dice-visualizer/page.tsx        <- MODIFY
│   └── bayes-analyzer/page.tsx         <- MODIFY
├── components/probability/
│   ├── probability-card-form.tsx       <- CREATE
│   ├── live-calculation.tsx            <- CREATE
│   ├── recent-simulations.tsx          <- CREATE
│   ├── dice-selector.tsx               <- CREATE
│   ├── distribution-chart.tsx          <- CREATE
│   ├── dice-stats-cards.tsx            <- CREATE
│   ├── bayes-inputs.tsx                <- CREATE
│   ├── bayes-result.tsx                <- CREATE
│   ├── bayes-tree.tsx                  <- CREATE
│   ├── bayes-formula.tsx               <- CREATE
│   ├── system-log.tsx                  <- CREATE
│   └── scenario-selector.tsx           <- CREATE
├── components/shared/
│   └── probability-bar.tsx             <- CREATE
├── lib/probability/
│   ├── dice-math.ts                    <- CREATE
│   ├── bayes.ts                        <- CREATE
│   ├── distributions.ts                <- CREATE
│   └── constants.ts                    <- CREATE
├── lib/validations/
│   └── probability.ts                  <- CREATE
└── types/
    └── probability.ts                  <- CREATE
```

---

## Subphases

| File | Step |
|---|---|
| [phase-3.1.md](./phase-3.1.md) | Step 3.1 — Probability Types |
| [phase-3.2.md](./phase-3.2.md) | Step 3.2 — Core Dice Math Engine |
| [phase-3.3.md](./phase-3.3.md) | Step 3.3 — Bayesian Calculator |
| [phase-3.4.md](./phase-3.4.md) | Step 3.4 — Distribution Utilities |
| [phase-3.5.md](./phase-3.5.md) | Step 3.5 — Pre-Built Bayes Scenarios |
| [phase-3.6.md](./phase-3.6.md) | Step 3.6 — Validation Schemas |
| [phase-3.7.md](./phase-3.7.md) | Step 3.7 — Probability Cards Page |
| [phase-3.8.md](./phase-3.8.md) | Step 3.8 — Shared Probability Bar |
| [phase-3.9.md](./phase-3.9.md) | Step 3.9 — Dice Visualizer Page |
| [phase-3.10.md](./phase-3.10.md) | Step 3.10 — Bayes Analyzer Page |
| [phase-3.11.md](./phase-3.11.md) | Step 3.11 — Save to Encounter |
| [phase-3.12.md](./phase-3.12.md) | Step 3.12 — Topbar Tab Sub-Navigation |

## Verification Checklist

- [ ] `1d20+3` DC 15 results in exactly 45% success probability
- [ ] `2d6` mean is exactly 7.0 and the distribution peaks at 7 with P(7) = 16.67%
- [ ] `1d12` shows a flat/uniform distribution where every value has equal probability
- [ ] Natural 1 and natural 20 special rules apply only for single d20 rolls
- [ ] When modifier guarantees all values >= DC, success is 100% (minus nat-1 for single d20)
- [ ] When DC is unreachable (higher than max), success is 0% (plus nat-20 for single d20)
- [ ] Comparison mode works: selecting a second dice type overlays both distributions on the chart
- [ ] Stats cards display correct mean, standard deviation, and cumulative probability
- [ ] Bayes "Is This Chest Trapped?" scenario shows approximately 72% posterior with default values
- [ ] All three Bayes sliders update the posterior result in real-time as the user drags
- [ ] Probability tree diagram updates all node values when sliders change
- [ ] Formula breakdown shows correct numbers plugged into each step
- [ ] System log adds new entries on each recalculation
- [ ] All three pre-built scenarios load correctly and populate sliders
- [ ] Recent simulations persist in localStorage and show up to 8 cards
- [ ] All probability bars animate their segments on load (600ms ease-out)
- [ ] Recharts charts are responsive at different viewport widths
- [ ] Tab sub-navigation correctly highlights the active page
- [ ] All three pages visually match their respective mockup references

## Rollback Plan

Revert to Phase 2 commit. All probability code is isolated in:
- `src/lib/probability/` (pure math, no side effects)
- `src/components/probability/` (UI components)
- `src/types/probability.ts` (type definitions)

No other phases are affected by reverting Phase 3.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| Wrong probabilities displayed | Bug in convolution algorithm | Test: 2d6 P(7) must be exactly 6/36 = 16.67%. Log intermediate convolution steps. |
| Recharts not rendering | Missing dependency or wrong import | Ensure `recharts` is installed (`npm install recharts`). Use dynamic import with `{ ssr: false }`. |
| Slider dragging feels laggy | Too many re-renders on input change | Debounce the `onChange` callback by 50ms, or wrap the calculation in `React.useTransition`. |
| Chart shows empty/blank area | Data format mismatch with Recharts | Recharts expects an array of objects. Each object must have keys matching the `dataKey` props on Area/Line components. |
| Bayes result shows NaN | Division by zero in P(E) calculation | Guard: if `marginal === 0`, display "Impossible evidence" message instead of NaN. |
| Probability tree layout broken | CSS flexbox spacing issues | Use `justify-between` for horizontal branch spacing. Use absolute positioning for connecting lines. Test at multiple viewport widths. |
| Number animation stutters | Too many state updates during animation | Use `requestAnimationFrame` for smooth frame-by-frame updates. Avoid setting state on every frame -- use a ref for the animated value and only set state on completion. |
| localStorage cards not loading | Hydration mismatch (SSR vs client) | Load localStorage data in a `useEffect` (client-only), not during initial render. Use a loading state to prevent hydration errors. |
