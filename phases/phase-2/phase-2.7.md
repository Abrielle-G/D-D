# Phase 2.7 — Polish Sidebar to Match Mockup

**File:** `src/components/layout/sidebar.tsx` -- MODIFY

Open the DM Dashboard mockup screenshot and compare the sidebar pixel by pixel. Make the following adjustments:

1. **Logo and role badge:** Ensure the top of the sidebar has the app logo/name and a small role badge (e.g., "DM" or "PLAYER" in a colored pill). The badge color should match the role: accent/purple for DM, green or blue for Player.

2. **Navigation group headers:** Each group of nav links (e.g., "MAIN", "CAMPAIGN", "TOOLS") should have an uppercase label above the group. Style: font size 11px, accent/purple color, letter-spacing `0.15em`, weight semibold. Add some top margin before each group header.

3. **Active link state:** The currently active nav link must have:
   - A 3px solid accent-colored left border.
   - A subtle background tint: `rgba(accent-color, 0.08)`.
   - Text color changes to accent or cyan.
   - The icon also takes the accent color.

4. **Hover state:** On hover (non-active links), apply a background of `#1a1a2e` or similar dark tint. Transition: 150ms ease.

5. **Icon sizing:** All nav icons should be exactly 20px, vertically centered and aligned with the link text. Ensure consistent spacing between icon and text (~12px gap).

6. **Footer/profile section:** At the bottom of the sidebar, render:
   - A 40px circular avatar image.
   - To the right: the user's `display_name` in white, 14px, and below it a subtitle line in gray, 12px (e.g., their email or role).
   - Far right: a gear/settings icon that links to `/settings`.

7. **Role-based visibility:** When the user's role is `"player"`, completely hide the "CAMPAIGN" navigation group (the section that contains DM-only links like "Encounters", "NPCs", "Maps editor"). Use the `useRole()` hook or context to determine this.

8. **Collapse behavior:** The sidebar should support a collapsed state:
   - Expanded width: 260px. Collapsed width: 64px.
   - In collapsed state: all text labels and group headers fade out, only icons remain, centered horizontally.
   - The collapse/expand should animate with a smooth width transition (~200-300ms).
   - Add a collapse toggle button (a chevron icon) at the top or bottom of the sidebar.
