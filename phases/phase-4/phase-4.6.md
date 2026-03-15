# Phase 4.6 — Encounter Builder Page

**File: `src/app/(dashboard)/campaign/encounters/page.tsx`** — MODIFY

Use a two-column layout. Left column takes roughly 55% width, right column 45%. On mobile, stack them vertically (form on top, probability stream below).

#### encounter-form.tsx — CREATE (left column)

Wrap everything in a card titled "Create Encounter" (or "Edit Encounter" when editing an existing one).

**Status tabs** at the top of the card:
- Three tab buttons: "PLANNED", "ACTIVE", "COMPLETED".
- The active tab gets a filled accent pill style with a calendar icon (Lucide `Calendar`). Inactive tabs are outlined.
- Changing the tab updates the encounter's status field.

**Form fields:**
- ENCOUNTER NAME — text input.
- DC — number input (difficulty class for skill checks in this encounter).
- DESCRIPTION — textarea.

**Enemies section:**
- Heading: "Enemies" with an "+ ADD ENEMY" link in accent color.
- Render a table with columns: NAME, HP, AC, ATK, DMG.
- Each row has inline inputs for each column. The name field can optionally show as an accent-colored pill/tag.
- Provide a way to remove a row (trash icon on the right of each row).
- Bonus: add a "Pull from NPCs" option that opens a small select/search letting the DM pick an existing NPC, auto-filling that row's stats from the NPC's data.

**Buttons at the bottom:**
- "SAVE ENCOUNTER" — accent/primary filled button. Saves the form data to the database.
- "GENERATE PROBABILITY" — outlined/secondary button. Triggers the probability calculation on the right panel.

#### enemy-table.tsx — CREATE

A reusable table component for the enemies list. Accepts the enemies array and callbacks for add/remove/update. Renders the header row and input rows. Keep this separate from the form so it stays manageable.

#### probability-stream.tsx — CREATE (right column)

Header: "LIVE PROBABILITY STREAM" in a monospace or code-style font, with a small green dot icon to the left (like a live indicator).

When the user clicks "Generate Probability":
- Pull the party characters for the current campaign (from `getPartyCharacters`).
- For each party member vs each enemy, calculate the hit probability using the Phase 3 math engine. The formula is: the player needs to roll `(enemy AC - player ATK bonus)` or higher on a d20. Success probability = `(21 - (AC - ATK)) / 20`, clamped between 0.05 and 0.95 to account for natural 1/20 rules.
- Render a matchup card for each pairing.

**Each matchup card:**
- Heading: "[Player Name] vs [Enemy Name]".
- "SUCCESS CHANCE" label, then a large percentage in bold. Color-code it: green if above 60%, yellow if 30-60%, red if below 30%.
- Formula line in muted monospace: "1d20 + [player ATK] vs AC [enemy AC]".
- A horizontal progress bar filled to the success percentage, colored to match.
- A colored left border on the card (same color as the percentage).

**Empty state:** If no party members exist yet, show a placeholder: "Waiting for player characters to be created..." or similar.

#### dm-insight.tsx — CREATE

Rendered at the bottom of the right column, below the matchup cards.

- Card with a `border-l-[var(--color-accent)]` left border.
- Crystal ball icon (Lucide `Sparkles` or a similar thematic icon) next to the heading "DM Insight" in accent color.
- Body text in italics: a generated summary of the encounter difficulty. Calculate this based on:
  - Total enemy HP vs total party HP ratio.
  - Average success probability across all matchups.
- Map to a difficulty label: TRIVIAL (>80% avg success, low HP ratio), EASY (65-80%), MODERATE (50-65%), CHALLENGING (35-50%), DEADLY (<35%).
- Show something like: "This encounter is rated **CHALLENGING**. Your party has a 42% average chance of hitting, and the enemies have 180 combined HP against the party's 120. Consider adjusting enemy AC or adding healing options."
