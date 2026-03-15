# Phase 3.2 — Core Dice Math Engine

**File:** `src/lib/probability/dice-math.ts` -- CREATE

Pure math functions using exact combinatorics. Every result must be mathematically precise -- no Monte Carlo, no approximations. This is the heart of the probability class deliverable.

**Functions to implement:**

1. **`getDiceMax(type: DiceType): number`**
   - Simple lookup: d4 returns 4, d6 returns 6, d8 returns 8, d10 returns 10, d12 returns 12, d20 returns 20.

2. **`getDiceRange(config: DiceConfig): { min: number; max: number }`**
   - `min` = `config.count + config.modifier` (each die rolls minimum 1)
   - `max` = `config.count * getDiceMax(config.type) + config.modifier`

3. **`calculateSingleDieDistribution(diceMax: number): Map<number, number>`**
   - Returns a Map where each key is a face value (1 through diceMax) and each value is the probability `1 / diceMax`.
   - This is a uniform distribution.

4. **`convolveDistributions(dist1: Map<number, number>, dist2: Map<number, number>): Map<number, number>`**
   - This is the KEY ALGORITHM for computing multi-dice distributions.
   - For every pair `(v1, p1)` from `dist1` and `(v2, p2)` from `dist2`, accumulate: `result[v1 + v2] += p1 * p2`.
   - Returns a new Map with exact probabilities for all possible sums.
   - Example: convolving two d6 distributions produces the classic 2d6 bell curve where P(7) = 6/36.

5. **`calculateDiceDistribution(config: DiceConfig): Map<number, number>`**
   - Start with `calculateSingleDieDistribution(getDiceMax(config.type))`.
   - Convolve this distribution with itself `(config.count - 1)` times. That is, for 3d6: compute d6, convolve with d6 to get 2d6, convolve with d6 again to get 3d6.
   - After convolution, apply the modifier by shifting all keys: create a new Map where each key is `originalKey + config.modifier`.
   - Return the final distribution.

6. **`calculateSuccessProbability(config: DiceConfig, targetDC: number): ProbabilityResult`**
   - Call `calculateDiceDistribution(config)` to get the full distribution.
   - `successProbability`: sum all probabilities where `value >= targetDC`.
   - **Special d20 rules (single d20 only, i.e., config.count === 1 AND config.type === 'd20'):**
     - `critFailProb`: P(natural 1) = 1/20 = 0.05. A natural 1 always fails regardless of modifier or DC.
     - `critSuccessProb`: P(natural 20) = 1/20 = 0.05. A natural 20 always succeeds regardless of modifier or DC.
     - Adjust `successProbability` to account for this: remove the nat-1 result from success (if modifier pushes 1+mod >= DC, it still fails) and ensure nat-20 result is in success (even if 20+mod < DC, it still succeeds).
   - **Multi-dice (count > 1 or type !== 'd20'):** `critSuccessProb` = 0, `critFailProb` = 0. No special crit rules apply.
   - Compute `mean` and `standardDeviation` from the distribution.
   - Compute `min` and `max` from `getDiceRange`.
   - Convert the Map to an array of `{ value, probability }` sorted by value.
   - Return a complete `ProbabilityResult`.

**Edge cases to handle:**
- Modifier makes ALL values >= DC: return 100% success (but still respect nat-1 auto-fail for single d20).
- DC is impossible (higher than max): return 0% success (but still respect nat-20 auto-success for single d20).
- Negative modifier: allowed and supported.
- Count of 0: throw an error -- dice count must be at least 1.
