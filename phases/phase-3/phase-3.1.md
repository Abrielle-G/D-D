# Phase 3.1 — Probability Types

**File:** `src/types/probability.ts` -- CREATE

Define all TypeScript types and interfaces used throughout the probability engine.

**Types to define:**

- `DiceType` -- Union literal: `'d4' | 'd6' | 'd8' | 'd10' | 'd12' | 'd20'`
- `DiceConfig` -- Object with fields:
  - `type`: `DiceType`
  - `count`: `number`
  - `modifier`: `number`
- `ProbabilityResult` -- Object with fields:
  - `successProbability`: `number` (0-1 range)
  - `critSuccessProb`: `number` (0-1 range)
  - `critFailProb`: `number` (0-1 range)
  - `distribution`: `Array<{ value: number; probability: number }>`
  - `mean`: `number`
  - `standardDeviation`: `number`
  - `min`: `number`
  - `max`: `number`
- `ProbabilityCardData` -- Object with fields:
  - `id`: `string`
  - `actionName`: `string`
  - `diceConfig`: `DiceConfig`
  - `targetDC`: `number`
  - `result`: `ProbabilityResult`
- `BayesInput` -- Object with fields:
  - `prior`: `number` (0-1 range)
  - `likelihood`: `number` (0-1 range)
  - `marginalFalse`: `number` (0-1 range, this is P(Evidence | NOT Hypothesis))
- `BayesResult` -- Object with fields:
  - `posterior`: `number` (0-1 range)
  - `priorTimesLikelihood`: `number`
  - `marginal`: `number`
  - `riskLevel`: `'low' | 'medium' | 'high'`
- `BayesScenario` -- Object with fields:
  - `id`: `string`
  - `title`: `string`
  - `description`: `string`
  - `hypothesis`: `string` (label for the hypothesis, e.g., "Trapped")
  - `evidence`: `string` (label for the evidence, e.g., "Visible Scratches")
  - `input`: `BayesInput`
