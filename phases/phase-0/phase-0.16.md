# Phase 0.16 — Create Stat Display Component

**File:** `src/components/shared/stat-display.tsx` — CREATE

**Purpose:** Reusable stat card for displaying numeric values (HP, AC, ATK, probability percentages, etc.)

**Details:**
- Compact card layout (uses the `stat` variant of RPG Card)
- Structure: optional icon at top (Lucide icon, 20px, colored) → large number below (JetBrains Mono, 28–32px, bold) → label below (uppercase, 10px, muted, letter-spaced)
- Accept props: `{ value: string | number, label: string, icon?: LucideIcon, color?: string, subtitle?: string }`
- The `color` prop tints the number (green for HP, purple for AC, amber for ATK, cyan for probabilities)
- Used across: character sheet ability scores, NPC stat rows, dashboard quick stats, probability percentages, dice visualizer stats
