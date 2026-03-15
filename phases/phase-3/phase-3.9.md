# Phase 3.9 — Dice Visualizer Page

**File:** `src/app/(dashboard)/probability/dice-visualizer/page.tsx` -- MODIFY

This page composes three components: dice selector, distribution chart, and stats cards.

**Layout:**
- `DiceSelector` at top (full width card)
- `DistributionChart` below (full width, tall)
- `DiceStatsCards` at bottom (3-column grid)

**State management:** Use `useState` at page level.
- `primaryConfig`: `DiceConfig` -- the main dice selection
- `comparisonConfig`: `DiceConfig | null` -- optional comparison dice
- `primaryDistribution`: result of `calculateDiceDistribution(primaryConfig)`
- `comparisonDistribution`: result of `calculateDiceDistribution(comparisonConfig)` if comparison is active
- Recalculate distributions whenever configs change (use `useMemo`).

---

#### Component: Dice Selector

**File:** `src/components/probability/dice-selector.tsx` -- CREATE

**Props:** `primaryConfig`, `comparisonConfig`, `onPrimaryChange`, `onComparisonChange`, `onComparisonToggle`

**Visual structure:**
- A shadcn Card.
- Title: "Dice Distribution Visualizer" in bold.
- Subtitle: "Comparing distributions across variance types" in muted text.
- Legend (top-right corner): colored dots showing active dice. Purple dot = "Primary", yellow/orange dot = "Comparison" (only if comparison active).

**Dice buttons row:**
- 6 circular buttons, approximately 48px diameter each.
- Labels: d4, d6, d8, d10, d12, d20.
- Unselected state: transparent background, accent-colored border.
- Selected state: solid accent fill, white text.
- Clicking a button sets the primary dice type.
- For comparison mode: hold Shift+click or use a separate row/toggle to select comparison dice.

**Right side controls:**
- "DICE COUNT" label (uppercase, small, letter-spaced).
- Number stepper (decrement/increment buttons flanking a number display), range 1-10.
- Green-bordered label showing current selection, e.g., "SELECTED: 2d6".

**Comparison toggle:**
- A small button or switch: "Compare" -- enables/disables comparison mode.
- When enabled, show a second row of dice buttons (styled in yellow/orange) for selecting the comparison dice type and count.

---

#### Component: Distribution Chart

**File:** `src/components/probability/distribution-chart.tsx` -- CREATE

**Props:** `primaryData: { value: number; probability: number }[]`, `comparisonData?: { value: number; probability: number }[]`, `primaryLabel: string`, `comparisonLabel?: string`

**IMPORTANT:** Import Recharts using Next.js dynamic import to avoid SSR issues:
```typescript
import dynamic from 'next/dynamic'
const AreaChart = dynamic(() => import('recharts').then(mod => mod.AreaChart), { ssr: false })
// ... same for other Recharts components
```

Alternatively, wrap the entire chart component in a dynamic import at the page level.

**Chart configuration:**
- Use Recharts `AreaChart` (or `ComposedChart` if mixing area + line).
- X-axis: all possible roll values. Tick every integer. Bold the peak value.
- Y-axis: probability as percentage, auto-scaled. Label: "Probability %".
- **Primary distribution:** filled area with accent color, 0.3 fill opacity, solid stroke line.
- **Comparison distribution (when active):** dashed line in yellow/orange, no fill (or very light fill), overlaid on the same chart.
- **Tooltip:** On hover over any bar/point, show a dark-themed tooltip:
  - "Result: 7"
  - "P = 16.67%"
  - "Combinations: 6/36" (calculate: probability * totalCombinations, where totalCombinations = sides^count)
- Chart should animate on data change (Recharts built-in `isAnimationActive`).
- Responsive: use Recharts `ResponsiveContainer` with width="100%" and a fixed height (e.g., 350-400px).
- Theme colors: use CSS variables from the design system.

---

#### Component: Dice Stats Cards

**File:** `src/components/probability/dice-stats-cards.tsx` -- CREATE

**Props:** `primaryDistribution`, `comparisonDistribution?`, `primaryConfig`, `comparisonConfig?`

Three cards in a horizontal row (3-column grid, stack on mobile):

1. **Card 1 -- "MEAN VARIANCE"**
   - Icon: bar chart icon in purple (Lucide `BarChart3`).
   - Main value: mean displayed in monospace, 4 decimal places, e.g., "7.0000".
   - Subtitle: "Standard deviation: 2.4152" in muted text.

2. **Card 2 -- "PROBABILITY OF [X]+"**
   - Icon: percent icon in green (Lucide `Percent`).
   - The `[X]` defaults to the mean (rounded up). Display P(roll >= X) as percentage.
   - Main value: e.g., "58.33%" in monospace.
   - Subtitle: "Cumulative distribution peak" in muted text.
   - Optionally let users click to change the X threshold.

3. **Card 3 -- "COMPARISON DELTA"**
   - Icon: bolt/zap icon in yellow (Lucide `Zap`).
   - Only visible when comparison mode is active. Otherwise show a placeholder: "Enable comparison to see delta".
   - Main value: the mean delta, e.g., "+8.2%" in green (positive) or "-3.1%" in red (negative).
   - Subtitle: additional info like kurtosis difference or variance delta.
