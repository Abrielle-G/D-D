# Phase 0.17 — Create Empty State Component

**File:** `src/components/shared/empty-state.tsx` — CREATE

**Purpose:** Consistent empty state for pages with no data — prevents blank screens.

**Details:**
- Centered layout (flex column, items-center, justify-center)
- Structure: large muted icon (64px, color `#475569`) → heading (18px, white, medium weight) → description (14px, muted gray, max-width 400px, text-center) → optional CTA button (accent filled)
- Accept props: `{ icon: LucideIcon, title: string, description: string, action?: { label: string, onClick: () => void } }`
- Minimum height: 300px (so it doesn't look squished)
- Used when: no campaigns, no NPCs, no notes, no encounters, no maps, no character
