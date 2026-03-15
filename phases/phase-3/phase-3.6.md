# Phase 3.6 — Validation Schemas

**File:** `src/lib/validations/probability.ts` -- CREATE

Use Zod for form validation schemas.

**Schemas to define:**

1. **`probabilityCardSchema`** -- Validates the probability card form:
   - `actionName`: string, min 1 character, max 50 characters, required
   - `diceType`: enum of `'d4' | 'd6' | 'd8' | 'd10' | 'd12' | 'd20'`, required
   - `diceCount`: number, integer, min 1, max 10, required
   - `modifier`: number, integer, min -20, max +20, required
   - `targetDC`: number, integer, min 1, max 40, required

2. **`bayesInputSchema`** -- Validates Bayes slider inputs:
   - `prior`: number, min 0, max 1, required
   - `likelihood`: number, min 0, max 1, required
   - `marginalFalse`: number, min 0, max 1, required
