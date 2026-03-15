# Phase 4.4 — NPC Manager Page

**File: `src/app/(dashboard)/campaign/npcs/page.tsx`** — MODIFY

Top bar area: page title "NPCs" on the left. Centered: a search input with placeholder "Search the rogue's gallery...". Right side: a Filter button (Lucide `Filter` icon) and a "+ New NPC" button in the accent color.

#### npc-filters.tsx — CREATE

- The search input does full-text matching against name, role, and description. Debounce the input by 300ms before firing.
- The Filter button opens a dropdown (or popover) with:
  - Role: multi-select checkboxes (Quest Giver, Villain, Merchant, Guide, Mercenary).
  - Status: single-select radio (All, Active, Deceased, Hidden).
- Active filters appear as removable chip/pill elements below the search bar. Clicking the "x" on a chip removes that filter.

#### npc-grid.tsx — CREATE

Render NPC cards in a responsive grid: 3 columns on desktop, 2 on tablet, 1 on mobile. Use CSS grid with `gap` for spacing. Pass the filtered/searched NPC array into this component.

#### npc-card.tsx — CREATE

Each card, from top to bottom:

1. **Header image area** (~120px tall): if the NPC has an uploaded portrait, display it as a cover image. Otherwise, render a gradient background (vary the gradient hue by role or use a random seed from the NPC id) with the NPC's first initial in a large centered letter.

2. **Badges** overlaid on the bottom of the header image area:
   - Role badge: red background for villain, purple for quest giver, green for merchant, gray for guide, blue for mercenary.
   - Status badge: green for active, gray for deceased, yellow for hidden.

3. **"DM ONLY" overlay**: if `is_visible_to_players` is false, render a semi-transparent red banner across the top of the card with "DM ONLY" in white caps. Only visible to the DM obviously (players never see these cards at all, thanks to the query filter).

4. **Name**: bold white text. To the right, a small accent circle (`bg-[rgba(var(--color-accent-rgb),0.15)] text-[var(--color-accent)]`) with a pencil icon — clicking it opens the edit dialog.

5. **Description**: italic gray text, truncated to 2 lines with CSS `line-clamp`.

6. **Stats row**: three small stat blocks in a horizontal row:
   - HP: green-tinted text, heart icon.
   - AC: shield icon.
   - ATK: sword icon, show the attack bonus.
   - Use monospace font for the numbers.
   - If the NPC is deceased: show "0" for HP (grayed), and "--" for AC and ATK.

7. **Deceased styling**: the entire card should appear faded. Use `opacity: 0.6` or apply a desaturation filter (`grayscale(50%)`).

8. **Bottom bar**: a "VISIBLE TO PLAYERS" toggle switch (green when on, muted when off) on the left. A three-dot overflow menu (Lucide `MoreVertical`) on the right that opens a dropdown with Edit, Delete, and Duplicate options.

#### npc-form-dialog.tsx — CREATE

A dialog for creating or editing an NPC. Fields: name, race, role (dropdown), description (textarea), HP, AC, ATK (number inputs), internal notes (textarea, DM-only), status (dropdown), visibility toggle.

Optional: an image upload field for the header portrait. Use whatever upload pattern the app already has (Supabase Storage, or a simple file input that converts to a URL).

If the NPC is referenced in an existing encounter and the user tries to delete, show a warning: "This NPC is used in [encounter name]. Deleting will remove them from that encounter."
