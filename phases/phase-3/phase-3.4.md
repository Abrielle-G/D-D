# Phase 3.4 — Distribution Utilities

**File:** `src/lib/probability/distributions.ts` -- CREATE

Helper functions for statistical calculations on distributions (represented as `Map<number, number>` or arrays).

**Functions to implement:**

- **`calculateMean(distribution: Map<number, number>): number`** -- Sum of (value * probability) for all entries.
- **`calculateVariance(distribution: Map<number, number>, mean: number): number`** -- Sum of ((value - mean)^2 * probability) for all entries.
- **`calculateStandardDeviation(distribution: Map<number, number>, mean: number): number`** -- Square root of variance.
- **`calculateCDF(distribution: Map<number, number>, targetValue: number): number`** -- Cumulative probability: sum of all probabilities where value <= targetValue. Returns P(X <= value).
- **`compareDelta(dist1: Map<number, number>, dist2: Map<number, number>): object`** -- Computes:
  - `meanDelta`: mean of dist1 minus mean of dist2
  - `varianceDelta`: variance of dist1 minus variance of dist2
  - `modeDelta`: mode of dist1 minus mode of dist2 (mode = value with highest probability)
