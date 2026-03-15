# Phase 3.7 — Probability Cards Page

**File:** `src/app/(dashboard)/probability/cards/page.tsx` -- MODIFY

This page composes three components: the form, the live calculation display, and the recent simulations grid. Import and arrange them in a single-column layout.

**Layout:**
- Page title area at top (handled by sub-nav, see Step 3.12)
- `ProbabilityCardForm` at top
- `LiveCalculation` below the form
- `RecentSimulations` at the bottom

**State management:** Use React `useState` at the page level.
- `currentCard`: `ProbabilityCardData | null` -- the currently calculated card
- `recentCards`: `ProbabilityCardData[]` -- history of calculations

When the form submits, call `calculateSuccessProbability` from dice-math.ts, build a `ProbabilityCardData` object, set it as `currentCard`, and prepend it to `recentCards`.

---

#### Component: Probability Card Form

**File:** `src/components/probability/probability-card-form.tsx` -- CREATE

**Visual structure:**
- A shadcn Card component.
- Header row: accent-colored grid icon (use `var(--color-accent)` for the icon stroke) + title "Create Probability Card" in bold.
- Horizontal row of form fields (use flex/grid, wrap on mobile):
  - **ACTION NAME**: text input. Uppercase label, small text, letter-spaced, muted color. Placeholder: "e.g., Sneak Attack".
  - **DICE**: dropdown/select for dice type (d4 through d20). Same label style.
  - **COUNT**: number input, min 1, max 10. Same label style.
  - **MODIFIER**: number input with +/- support, min -20, max +20. Show a "+" prefix for positive values. Same label style.
  - **TARGET DC**: number input, min 1, max 40. Same label style.
- **"Calculate" button**: accent-colored (the site's primary accent), with a small grid icon. Aligned right.
- Validation: use the `probabilityCardSchema` from Step 3.6. Show red error text below any invalid field on submit attempt.

**Behavior:**
- On form submit, validate all fields.
- If valid, call the parent's `onCalculate` callback with the form data.
- Clear validation errors when user starts editing a field.

---

#### Component: Live Calculation

**File:** `src/components/probability/live-calculation.tsx` -- CREATE

**Props:** `card: ProbabilityCardData | null`

**Empty state:** When `card` is null, show a muted centered message: "Configure a roll above to see probabilities".

**Populated state (when card is not null):**

- **Top row:**
  - Left: action name in bold white text.
  - Right: "TARGET DC 15" in monospace, muted color.

- **Dice notation badge:** A small pill/badge with green border, e.g., "1D20 + 3". Uses the card's dice config.

- **Massive result number:** The success probability displayed as a percentage in ~64px JetBrains Mono font, using `var(--color-accent)`. Example: "45%".

- **Descriptor text:** Below the number, an italic accent-colored descriptor based on probability range:
  - 0%: "Impossible"
  - 1-15%: "Nearly Impossible"
  - 16-30%: "Unlikely"
  - 31-50%: "Possible"
  - 51-70%: "Likely Success"
  - 71-90%: "Very Likely"
  - 91-99%: "Almost Certain"
  - 100%: "Guaranteed"

- **Segmented probability bar:** Use the shared `ProbabilityBar` component from Step 3.8. Four segments:
  - Red: crit fail percentage (nat 1 auto-fail, only for single d20)
  - Gray: normal fail percentage
  - Green: normal success percentage
  - Accent (`var(--color-accent)`): crit success percentage (nat 20 auto-success, only for single d20)
  - For multi-dice: only two segments (fail in gray, success in green).

- **Bar labels:** "CRIT FAIL 5%" in red on the left, "CRIT SUCC 5%" in `var(--color-accent)` on the right (only for single d20).

- **4 stat boxes** in a horizontal row at the bottom:
  - NAT 1: red accent, shows "5%" for single d20, "--" otherwise
  - FAIL RANGE: gray, shows fail percentage
  - SUCCESS RANGE: green, shows success percentage
  - NAT 20: accent color (`var(--color-accent)`), shows "5%" for single d20, "--" otherwise

---

#### Component: Recent Simulations

**File:** `src/components/probability/recent-simulations.tsx` -- CREATE

**Props:** `cards: ProbabilityCardData[]`, `onClear: () => void`

**Header row:**
- Left: "RECENT SIMULATIONS" in uppercase monospace.
- Right: "Clear All" link/button, muted text, clears all stored cards.

**Grid:** 2x2 grid (or responsive: 1 column on mobile, 2 columns on tablet+).

**Each mini card:**
- Action name at top in small bold text.
- Large color-coded percentage number: green if >60%, yellow if 30-60%, red if <30%.
- Dice notation pill below the number, e.g., "2D6 + 1".
- Small progress bar at the bottom of the card showing the success percentage.

**Storage:** Store cards in client-side state. Optionally persist to localStorage so they survive page refresh. Maximum 8 cards; when exceeding, drop the oldest.
