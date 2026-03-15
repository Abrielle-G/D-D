# Phase 4.2 — Character Sheet Page

**File: `src/app/(dashboard)/characters/page.tsx`** — MODIFY

This page should be a server component that fetches the current user's character (or all party members if DM). Pass data down to the client components below. If the user has no character yet, render an empty state with a "Create Your Character" call-to-action that opens the form dialog.

**Permissions:**
- A player can only view and edit their own character sheet.
- The DM can view and edit any party member's sheet (use a dropdown or tabs to switch between them).

Now build each component section, laid out vertically on the page in the order they appear in the mockup.

#### character-header.tsx — CREATE

- Left side: a large accent-colored circle (~80px, `bg-[var(--color-accent)]`) showing the character's first initial in white. If the character has an uploaded avatar image, show that instead. Place a small blue pencil icon (Lucide `Pencil` or `Edit`) overlaid on the bottom-right of the circle — clicking it opens the form dialog.
- Center: the character's name in a large, bold display-weight font. Below the name, render race, class, and level as small pill badges with accent borders (`border-[var(--color-accent)]`) and muted text (e.g., "Half-Elf", "Ranger", "Level 7").
- Right side: two stat boxes side by side. HP box shows `hp_current / hp_max` in large text with the label "HP" underneath. XP box shows current XP / next-level threshold in the same format with the label "XP" underneath. Use monospace or tabular-nums for the numbers.

#### ability-scores.tsx — CREATE

Render exactly 6 cards in a single horizontal row (flexbox, equal width). On mobile, let them wrap to 2 rows of 3.

Each card:
- Top: the abbreviated ability name in uppercase muted text (STR, DEX, CON, INT, WIS, CHA).
- Center: a circle roughly 64px diameter with an accent border (`border-[var(--color-accent)]`). Inside, display the calculated modifier.
- Bottom: the raw score value in smaller muted text.

Modifier formula: `Math.floor((score - 10) / 2)`. Format as "+3", "-1", or "0" (no plus sign for zero). If the modifier is negative, color it red.

#### secondary-stats.tsx — CREATE

Three cards in a row, styled similarly to the ability scores but without circles.

- ARMOR CLASS — shows the `ac` value, shield icon from Lucide.
- INITIATIVE — auto-calculated from the DEX modifier. Don't store it separately.
- SPEED — shows the speed value followed by "ft". Use a footprints or movement icon.

Use large monospace numbers for the values.

#### weapons-attacks.tsx — CREATE

A card titled "WEAPONS & ATTACKS" with a "+" button to add a weapon (max 2 — primary and secondary).

Each weapon row:
- Sword/weapon icon on the left.
- Name in bold, properties in muted text below it (e.g., "Slashing, Versatile").
- Attack bonus displayed as an accent pill (`bg-[rgba(var(--color-accent-rgb),0.2)] text-[var(--color-accent)]`): "+6 ATK". Auto-calculate this as `ability modifier + proficiency bonus`. Proficiency bonus by level: +2 at levels 1-4, +3 at 5-8, +4 at 9-12, +5 at 13-16, +6 at 17-20.
- Damage dice on the right: "1d8+3".

Let the user choose which ability score drives the weapon (STR for melee, DEX for finesse/ranged). Default to STR.

#### special-abilities.tsx — CREATE

A card titled "SPECIAL ABILITIES".

Each ability entry:
- Name rendered in `var(--color-accent-secondary)` text.
- Usage badge to the right of the name: "1/LONG REST" with a green background, "1/SHORT REST" with a red background, "AT WILL" with a muted background.
- Description text below in regular body color.
- A 3px accent left border (`border-l-[var(--color-accent)]`) on each ability block (like a left-bordered div).
- Maximum 4 abilities.

#### inventory-summary.tsx — CREATE

A card titled "INVENTORY SUMMARY".

- Top-right of the card header: weight display like "72/160 lbs". Color it green when under capacity, yellow near limit, red over limit.
- Item rows: small icon (use generic Lucide icons like `Package`, `Gem`, `Shield`), item name, quantity on the right.
- Maximum 15 item slots.
- At the bottom, a "VIEW ALL EQUIPMENT" link in the accent color. For now this can be a placeholder that scrolls to or opens a full inventory view later.

#### adventure-journal.tsx — CREATE

A card titled "ADVENTURE JOURNAL & NOTES". Next to the title, show an auto-save status indicator: "Auto-saving..." (muted, pulsing) or "Saved" (green).

- A large textarea (at least 6 rows tall) with placeholder text "Describe recent events, discoveries, and plans...".
- Debounced auto-save: after 500ms of no typing, fire an update to the database. Use a `useRef` timeout pattern or lodash `debounce`.
- No submit button needed — the auto-save handles it.

#### character-form-dialog.tsx — CREATE

A shadcn Dialog/Sheet that opens for creating or editing a character.

- Contains all fields from the validation schema, organized into logical sections (basic info, ability scores, combat stats).
- Use shadcn form components with react-hook-form and the Zod resolver.
- On submit, call the appropriate query function (create or update).
- Show validation errors inline.
