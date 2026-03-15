# Phase 0.11 — Create the Status Bar Component

**File:** `src/components/layout/status-bar.tsx` — CREATE

**Purpose:** The thin monospace terminal-style footer bar — a unique design element from the mockups that adds hand-crafted character. This is one of the details that makes it feel NOT AI-generated.

**Details:**
- Position: fixed to bottom of viewport
- Height: 32px
- Background: `#07070c` (darker than main bg)
- Content: `font-family: 'JetBrains Mono'`, `font-size: 11px`, `color: #3a3a5c` (very muted)
- Items separated by ` · ` (space-centered-dot-space)
- Center-aligned text
- Items change per page — accept an `items: string[]` prop

Default status bar content per page:
- Dashboard: `["SYSTEM_STATUS: NOMINAL", "SESSION: ACTIVE", "PLAYERS: 4", "ENCOUNTERS: 7"]`
- Probability: `["CALC_ENGINE: v4.2", "PRECISION: 10^-6", "MODE: COMBINATORICS", "SEED: 0x8F2A"]`
- Bayes: `["INFERENCE_MODE: LAPLACE_SMOOTHING_OFF", "DUNGEON_BIAS: MINIMAL", "ROGUE_BONUS: +2 PROFICIENCY"]`
- Campaign: `["INK_LEVEL: FULL", "SCROLL_CONDITION: PRISTINE", "SESSION_NOTES: AUTO_SAVE"]`
- Maps: `["SYNCED", "MAP_VERSION: 1.0.4-BETA", "GRID: 32px", "OVERLAY_OPACITY: 0.8"]`
- Character: `["LEVEL_CAP: 20", "STAT_ROLLER: STANDARD_ARRAY", "HP_CALC: AVERAGE"]`
- Settings: `["PREFERENCES: SAVED", "THEME_ENGINE: CSS_VARS_V3", "LATENCY: 12ms"]`
