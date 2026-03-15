# Phase 0.14 — Create the RPG Card Component

**File:** `src/components/shared/rpg-card.tsx` — CREATE

**Purpose:** Custom card component matching the mockup aesthetic. This replaces the default shadcn Card for application-specific usage.

**Details:**
- Base styling:
  - Background: `var(--color-bg-elevated)` (#12121a)
  - Border: `1px solid var(--color-border)` (#1e1e2e)
  - Border radius: 12px
  - Padding: 24px
  - Box shadow: `0 4px 20px rgba(0,0,0,0.3)`
- Hover state:
  - Border: `1px solid var(--color-border-hover)` (#2e2e4e)
  - Box shadow: `0 8px 30px rgba(0,0,0,0.5)`
  - Transform: `translateY(-2px)` — subtle lift
  - Transition: `all 150ms ease`
- Variants (via a `variant` prop):
  - `default` — base card
  - `stat` — smaller padding (16px), centered text, for stat boxes (HP, AC, etc.)
  - `probability` — has a configurable colored left border (4px wide) for probability cards
  - `hero` — full-width, supports a background image via `backgroundImage` prop, has a dark overlay gradient for text readability
  - `interactive` — same as default but with a pointer cursor and more pronounced hover effect
- Optional `glow` prop (boolean): adds `box-shadow: 0 0 20px var(--color-glow)` — a subtle accent-colored ambient glow around the card
- Optional `header` prop: renders a card header section with uppercase title (11px, letter-spaced, muted color) and optional icon on the right
- Compose using `React.forwardRef` for flexibility
