# Phase 3.3 — Bayesian Calculator

**File:** `src/lib/probability/bayes.ts` -- CREATE

Implements Bayes' Theorem calculations. All functions are pure with no side effects.

**Functions to implement:**

1. **`calculatePosterior(input: BayesInput): BayesResult`**
   - Apply Bayes' Theorem:
     ```
     P(A|B) = P(B|A) * P(A) / [ P(B|A) * P(A) + P(B|~A) * P(~A) ]
     ```
   - Where:
     - `P(A)` = `input.prior`
     - `P(B|A)` = `input.likelihood`
     - `P(B|~A)` = `input.marginalFalse`
     - `P(~A)` = `1 - input.prior`
   - Compute intermediate values:
     - `priorTimesLikelihood` = `P(B|A) * P(A)`
     - `marginal` = `P(B|A) * P(A) + P(B|~A) * (1 - P(A))` (this is the total P(B))
   - `posterior` = `priorTimesLikelihood / marginal`
   - `riskLevel` = result of `getRiskLevel(posterior)`
   - Return a complete `BayesResult`.

2. **`getRiskLevel(posterior: number): 'low' | 'medium' | 'high'`**
   - Less than 0.33: return `'low'`
   - 0.33 to 0.66 inclusive: return `'medium'`
   - Greater than 0.66: return `'high'`

3. **`chainBayes(previousPosterior: number, newLikelihood: number, newMarginalFalse: number): BayesResult`**
   - Uses the previous posterior as the new prior.
   - Calls `calculatePosterior({ prior: previousPosterior, likelihood: newLikelihood, marginalFalse: newMarginalFalse })`.
   - Returns the new `BayesResult`.

**Edge cases to handle:**
- `marginal === 0` (i.e., P(B) = 0): this means the evidence is impossible. Throw an error or return a special result indicating "Impossible evidence -- this observation cannot occur under either hypothesis."
- `prior === 0`: posterior is always 0 regardless of evidence. Return 0.
- `prior === 1`: posterior is always 1 regardless of evidence. Return 1.
