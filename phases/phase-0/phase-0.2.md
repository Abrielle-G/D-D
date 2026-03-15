# Phase 0.2 — Configure TypeScript Strict Mode

**File:** `tsconfig.json` — MODIFY

**Purpose:** Enforce strict TypeScript throughout.

**Details:**
- Set `"strict": true`
- Set `"noUncheckedIndexedAccess": true`
- Set `"forceConsistentCasingInFileNames": true`
- Verify path alias: `"@/*": ["./src/*"]`
- Ensure `"target"` is `"es2017"` or higher
