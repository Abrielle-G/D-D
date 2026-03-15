# Phase 0.9 — Create the Sidebar Component

**File:** `src/components/layout/sidebar.tsx` — CREATE

**Purpose:** The persistent left sidebar matching the mockups EXACTLY. This is one of the most visually distinctive elements — it must NOT look generic.

**Details:**

**Dimensions & Behavior:**
- Width: 260px on desktop (>=1024px)
- Collapses to 64px (icon-only) on tablet (768–1023px)
- Fully hidden on mobile (<=767px) — replaced by bottom nav
- Collapse transition: `width` 200ms ease, text opacity fades to 0

**Structure (top to bottom):**

1. **Logo Section** (padding: 20px 16px):
   - Purple d20 icosahedron icon (from `d20-logo.tsx` or user-provided asset), ~32px
   - "Dice & Decisions" in bold white text, 16px, Inter Bold
   - Below the text: a green pill badge (8px padding-y, 12px padding-x) showing "DM MODE" or "PLAYER" depending on the role. Background: `#22c55e` with dark text for DM mode. The badge text changes dynamically with the role provider.

2. **Navigation Groups** — Each group has:
   - Section header: uppercase, accent/muted purple color (`var(--color-accent)` at 60% opacity), `letter-spacing: 0.1em`, `font-size: 11px`, `font-weight: 600`, `margin-bottom: 4px`, `margin-top: 24px` (except first group)
   - Items below the header, each with: icon (Lucide React, 20px) + text label (14px, Inter Regular)

   **Groups and Items:**
   - **OVERVIEW**
     - Dashboard → `/(dashboard)/dashboard` — `LayoutDashboard` icon
   - **PROBABILITY**
     - Probability Cards → `/(dashboard)/probability/cards` — `Flame` icon
     - Dice Visualizer → `/(dashboard)/probability/dice-visualizer` — `Dices` icon
     - Bayes Analyzer → `/(dashboard)/probability/bayes-analyzer` — `BrainCircuit` icon
   - **CAMPAIGN** — DM ONLY (hidden entirely when role is 'player')
     - Story Notes → `/(dashboard)/campaign/story-notes` — `ScrollText` icon
     - Encounters → `/(dashboard)/campaign/encounters` — `Swords` icon
     - NPCs → `/(dashboard)/campaign/npcs` — `Users` icon
   - **WORLD**
     - Maps → `/(dashboard)/maps` — `MapPin` icon
   - **CHARACTERS**
     - Party → `/(dashboard)/characters` — `UserCircle` icon
     - (In Player mode, label changes to "Character Sheet" instead of "Party")

3. **User Profile Footer** (pinned to bottom, padding: 16px):
   - Circular avatar (40px diameter, `overflow: hidden`, `border-radius: full`)
     - If user has an avatar URL: show the image
     - Otherwise: show initials on a purple gradient background
   - To the right of avatar: display_name in white 14px bold, subtitle role/account in gray 12px
   - Far right: Settings gear icon (Lucide `Settings`, 16px, muted gray, links to `/settings`)

**Active State:**
- The currently active nav item has:
  - 3px left border in `var(--color-accent)` (solid, no rounding)
  - Background: `rgba(var(--color-accent-rgb), 0.08)` — very subtle accent tint
  - Text color: `var(--color-accent-secondary)` (cyan) — or the accent color
  - Icon color matches the text
- Determine active state by comparing `usePathname()` from `next/navigation` against each item's `href`

**Hover State:**
- Row background: `#1a1a2e`
- Transition: `background-color 150ms ease`
- Text/icon color: lighten slightly

**Collapsed State (tablet):**
- Only icons visible, centered horizontally in the 64px width
- Section headers hidden
- Logo text hidden, only d20 icon visible
- User footer: only avatar visible
- On hover of collapsed icons: show a tooltip with the page name

**Background:**
- `var(--color-bg-sidebar)` with a subtle bottom-to-top gradient (slightly lighter at the top)
- Right border: 1px solid `var(--color-border)` (very subtle separation from content area)
