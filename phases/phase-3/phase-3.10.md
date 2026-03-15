# Phase 3.10 — Bayes Analyzer Page

**File:** `src/app/(dashboard)/probability/bayes-analyzer/page.tsx` -- MODIFY

This is the most visually distinctive page in the application. It uses a two-column layout with inputs on the left and results on the right.

**Layout (desktop):**
```
+----------------------------------+-----------------------------------+
| Scenario Selector (full width spanning both columns)                 |
+----------------------------------+-----------------------------------+
| MODEL INPUTS (sliders)           | POSTERIOR PROBABILITY (big number)|
|                                  |                                   |
+----------------------------------+-----------------------------------+
| SYSTEM LOG (terminal)            | THEOREM BREAKDOWN | EVIDENCE WT   |
|                                  +-----------------------------------+
|                                  | PROBABILITY TREE                  |
+----------------------------------+-----------------------------------+
```

**State management:**
- `selectedScenario`: `BayesScenario | null`
- `input`: `BayesInput` -- the current slider values
- `result`: `BayesResult` -- recalculated on EVERY slider change (use `useMemo`)
- `chainHistory`: `Array<{ round: number; prior: number; posterior: number }>` -- for chaining
- `logEntries`: `string[]` -- system log messages

When a scenario is selected, populate the `input` state with the scenario's default values. When sliders change, immediately recalculate the result. No "Calculate" button -- everything is live.

---

#### Component: Scenario Selector

**File:** `src/components/probability/scenario-selector.tsx` -- CREATE

**Props:** `scenarios: BayesScenario[]`, `selected: BayesScenario | null`, `onSelect: (scenario: BayesScenario | null) => void`

**Visual structure:**
- A dropdown or select component (use shadcn `Select`).
- Positioned in the top bar area of the Bayes page.
- Label: "Scenario:" followed by the dropdown.
- Options: the 3 pre-built scenarios from constants.ts, plus a "Custom Scenario" option.
- When a pre-built scenario is selected, call `onSelect` with the full scenario object. The parent will use this to set slider values.
- When "Custom Scenario" is selected, call `onSelect(null)` -- sliders remain at their current values for manual input.

---

#### Component: Bayes Inputs (Model Inputs)

**File:** `src/components/probability/bayes-inputs.tsx` -- CREATE

**Props:** `input: BayesInput`, `onChange: (input: BayesInput) => void`, `scenario: BayesScenario | null`

**Visual structure:**
- A shadcn Card.
- Header: "MODEL INPUTS" in uppercase monospace, with a sliders icon (Lucide `SlidersHorizontal`).
- Three slider controls, stacked vertically with spacing:

**Each slider control:**
- **Label:** Dynamic based on scenario. Default: "Prior Probability P(H)". With scenario: "Prior Probability P(Trapped)".
- **Value display:** Current value as percentage in `var(--color-accent-secondary)`, e.g., "30%". Positioned to the right of the label.
- **Slider track:** Use shadcn `Slider` component. Style the track with a `var(--color-accent)` to `var(--color-accent-secondary)` gradient (use CSS custom styling on the track). White circular thumb.
- **Range:** 0% to 100% (maps to 0-1 internally). Step: 1% (0.01).
- **Helper text:** Italic, muted color, below each slider. Explains what the input means. If a scenario is active, use the scenario's educational text. Otherwise, use generic text like "The initial probability before considering evidence."

**The three sliders:**
1. "Prior Probability P({hypothesis})" -- maps to `input.prior`
2. "Likelihood P({evidence} | {hypothesis})" -- maps to `input.likelihood`
3. "False Positive P({evidence} | NOT {hypothesis})" -- maps to `input.marginalFalse`

**Behavior:**
- On ANY slider change, immediately call `onChange` with the updated input. This triggers a recalculation of the Bayes result in the parent.
- If slider changes are causing performance issues (unlikely with simple Bayes math), debounce the `onChange` callback by 50ms or use React `useTransition`.

---

#### Component: System Log

**File:** `src/components/probability/system-log.tsx` -- CREATE

**Props:** `entries: string[]`, `isCalculating?: boolean`

This is a cosmetic/flavor component that adds atmosphere to the page. It simulates a terminal log.

**Visual structure:**
- A card with dark background (darker than the page bg), monospace font throughout.
- Header line: `[SYSTEM LOG] CALC_V4.2 READY` in green text.
- Log entries, each prefixed with `> `:
  - Example entries:
    - `> OBSERVATION DETECTED: [VISIBLE_SCRATCHES]`
    - `> LOADING PRIOR DISTRIBUTION...`
    - `> UPDATING BELIEF SYSTEM...`
    - `> APPLYING BAYES THEOREM...`
    - `> CONVERGENCE REACHED IN 12ms`
    - `> POSTERIOR PROBABILITY UPDATED: 0.720`
  - Each entry appears with a slight typing animation or fade-in.
- Keep only the last 5-6 entries visible, auto-scroll to bottom.
- On each slider change, add 2-3 new log entries reflecting the recalculation.
- This is purely decorative -- it does not affect calculations.

---

#### Component: Bayes Result (Posterior Result)

**File:** `src/components/probability/bayes-result.tsx` -- CREATE

**Props:** `result: BayesResult`, `scenario: BayesScenario | null`

**Visual structure:**
- A large shadcn Card, prominent placement.
- Title: "POSTERIOR PROBABILITY P({hypothesis} | {evidence})" in uppercase monospace. Falls back to "P(H | E)" without scenario.
- Optional: a faded/watermark decorative element in one corner (e.g., a large faded percentage sign or Bayes formula).
- **ENORMOUS number:** The posterior probability as a percentage, displayed at 72-96px font size in bold white using JetBrains Mono. Example: "72.0%". Format to one decimal place.
- **Number animation:** When the result changes (slider drag), the number should animate smoothly from the old value to the new value. Implement a count-up/count-down animation:
  - Use `useEffect` + `requestAnimationFrame` or a library like `framer-motion`'s `useSpring`.
  - Duration ~300ms for the transition.
  - The number should visually tick through intermediate values.

**Risk badge:** Below the number, a colored badge:
- **High risk (posterior > 0.66):** Red/danger background, text: "HIGH RISK -- DISARM REQUIRED" (or dynamic text from scenario).
- **Medium risk (0.33-0.66):** Amber/warning background, text: "MODERATE RISK -- PROCEED WITH CAUTION".
- **Low risk (< 0.33):** Green/success background, text: "LOW RISK -- LIKELY SAFE".

---

#### Component: Theorem Breakdown

**File:** `src/components/probability/bayes-formula.tsx` -- CREATE

**Props:** `result: BayesResult`, `input: BayesInput`

**Visual structure:**
- A compact card with monospace text.
- Shows the computed intermediate values:
  - `P(H|E) = 0.720`
  - `P(H)P(E|H) = 0.180`
  - `P(E) = 0.250`
- **Expandable section** (use shadcn `Collapsible` or `Accordion`):
  - When expanded, shows the full formula with actual numbers plugged in:
    ```
    P(H|E) = P(E|H) * P(H) / [P(E|H) * P(H) + P(E|~H) * P(~H)]
    P(H|E) = 0.60 * 0.30 / [0.60 * 0.30 + 0.10 * 0.70]
    P(H|E) = 0.18 / [0.18 + 0.07]
    P(H|E) = 0.18 / 0.25
    P(H|E) = 0.720
    ```
  - Format: each line as a step, values in accent colors, operators in muted.
- **Purpose:** Educational -- shows students exactly how Bayes' Theorem works step by step with their own numbers.

---

#### Evidence Weight (inline in Bayes page, or small sub-component)

**Placement:** Right column, next to or below the theorem breakdown.

**Visual structure:**
- A horizontal stacked bar (similar to the probability bar):
  - Accent segment (`var(--color-accent)`): `P(E|H) * P(H)` -- labeled "True Positive"
  - Red segment: `P(E|~H) * P(~H)` -- labeled "False Positive"
- Total bar width = `P(E)` = sum of both segments.
- Label above: "Likelihood Distribution Scale".
- Segment widths are proportional to their values relative to the total.
- Below the bar, show the actual values: "True Positive: 0.18" and "False Positive: 0.07".
- Can be built inline or as a small dedicated component.

---

#### Component: Probability Tree

**File:** `src/components/probability/bayes-tree.tsx` -- CREATE

**Props:** `input: BayesInput`, `result: BayesResult`, `scenario: BayesScenario | null`

A visual decision tree diagram showing how probabilities flow through Bayes' Theorem branches.

**Tree structure:**
```
                  [Start]
                 /        \
        P(H)=0.3          P(~H)=0.7
           /                    \
    [Trapped]              [Safe]
      /    \                /    \
P(E|H)  P(~E|H)     P(E|~H)  P(~E|~H)
=0.60    =0.40       =0.10     =0.90
  |        |           |         |
[0.18]   [0.12]     [0.07]    [0.63]
```

**Implementation approach:**
- Build with CSS flexbox/grid and absolute/relative positioning for connecting lines. Alternatively, use inline SVG for precise control over lines and nodes.
- **Nodes:** Rounded rectangles with colored borders:
  - Root node: neutral border
  - Hypothesis nodes (Trapped/Safe): green border for prior
  - Evidence nodes: red border for positive evidence, gray for negative
  - Leaf nodes: show the joint probability value
- **Connecting lines:** Thin lines (1-2px) connecting parent to child nodes. Can use CSS `::before`/`::after` pseudo-elements or SVG `<line>` elements.
- **Labels on branches:** Show the probability value along each branch line.
- **Real-time updates:** All values in the tree update immediately when sliders change. Use the same state that drives the rest of the page.
- **Highlighted path:** Optionally highlight the "evidence observed" path (the left branch at each evidence split) with a brighter color or thicker line.

---

#### Chaining Feature

**Placement:** Below the posterior result or as a button within it.

- **"Use as New Prior" button:** When clicked:
  - Takes the current posterior value.
  - Sets it as the new prior in the input sliders.
  - Resets likelihood and false positive to 50% (or keeps them for user to adjust).
  - Adds an entry to `chainHistory`.
  - System log shows: `> CHAINING: POSTERIOR 0.720 -> NEW PRIOR`
- **Chain display:** If `chainHistory` has entries, show a horizontal chain visualization:
  - "Round 1: 30% -> 72% -> Round 2: 72% -> 91% -> ..."
  - Each round shows the prior and posterior with an arrow.
  - Use small colored dots or a step indicator.
- **"Reset Chain" button:** Clears chain history and resets to the original scenario values.
