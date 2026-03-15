# Phase 0.10 — Create the Topbar Component

**File:** `src/components/layout/topbar.tsx` — CREATE

**Purpose:** Header bar that sits atop the main content area.

**Details:**
- Height: 64px
- Position: sticky top, `z-index: 40`
- Background: `rgba(10, 10, 15, 0.8)` with `backdrop-filter: blur(12px)` — frosted glass effect
- Bottom border: 1px solid `var(--color-border)` at 50% opacity
- Left side: page title in bold white (~20px font size). For major pages (Dashboard, Characters, Maps), use the `display` serif font family. For tool pages, use Inter Bold. Optionally show breadcrumb-style sub-navigation (e.g., "Probability Tools · Cards / Dice Visualizer / Bayes")
- Right side (flex row, gap 12px):
  - Per-page action buttons (passed as props): e.g., "+ New Session" (accent filled button on Dashboard), "+ Upload Map" (accent on Maps), "+ New NPC" (accent on NPCs)
  - Notification bell icon (Lucide `Bell`, 20px, muted color). Optional: small blue dot (`#3b82f6`, 8px circle) positioned top-right of the bell for unread notifications.
  - User avatar circle (32px, first two initials or image)
- Accept props: `{ title: string, breadcrumbs?: { label: string, href?: string, active?: boolean }[], actions?: ReactNode }`
