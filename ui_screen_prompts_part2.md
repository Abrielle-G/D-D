# Dice & Decisions — Google Stitch UI Prompts (Part 2)

> Continuation of Part 1. Same design system tokens apply. See Part 1 for color palette, typography, and component specs.

---

## Screen 5 — Bayes Analyzer

# Bayes Analyzer — Dark — Desktop 1440px

## Prompt

Design a premium dark web page for "Dice & Decisions", showing the Bayes Analyzer — an interactive educational Bayesian probability tool, displayed in a clean browser frame at 1440px.

**Overall Aesthetic:** An educational data tool that feels like a Bloomberg terminal designed for RPG probability. Split into two halves — a scenario input panel on the left and a live-updating visualization on the right. The layout communicates "this is a serious math tool" while the RPG scenario descriptions keep it accessible. Think Desmos calculator's interactivity meets Linear's dark precision.

**Background & Canvas:** `#08080d`. Noise 2%.

**Sidebar:** Same as DM Dashboard with "Bayes Analyzer" active (brain icon highlighted).

**Top Bar:** "Bayes Analyzer" Space Grotesk Semibold 20px. Right: dropdown "Select Scenario" (DM Sans Medium 14px, bg `#16161f`, border `#1e1e2e`, width 280px), options: "Is This Chest Trapped?", "Is the Merchant Lying?", "Custom Scenario". And an info icon (circle-i, 18px, `#475569`) that would show a Bayes' theorem explainer tooltip.

**Main Content (2-column grid, 1fr 1fr, gap 24px):**

**Left Column — Scenario & Inputs Card (bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 28px):**
- Active scenario: "Is This Chest Trapped?" Space Grotesk Semibold 20px `#f1f5f9`.
- Narrative: "Your party finds an ornate chest in the dungeon. Before opening it, you want to estimate the probability it's trapped..." DM Sans Regular 14px `#94a3b8`, italic. A small shield-alert icon (18px, `#eab308`) beside it.
- 24px gap.
- **Input Section:**
  - **Prior Probability P(Trapped):**
    - Label: "Prior — What % of dungeon chests are trapped?" DM Sans Medium 13px `#f1f5f9`. Helper: "Based on your experience in this dungeon" DM Sans Regular 12px `#475569`.
    - Slider: full-width, track bg `#16161f` height 6px border-radius 3px. Filled portion: gradient `#7c3aed` to `#06b6d4`. Thumb: 20px circle, bg `#fff`, border 2px `#7c3aed`, shadow `0 2px 8px rgba(0,0,0,0.3)`. Current value displayed above thumb: "30%" JetBrains Mono Bold 16px `#7c3aed`.
    - Below slider: "0%" and "100%" at ends, JetBrains Mono 11px `#475569`.
  - 20px gap.
  - **Likelihood P(Scratches | Trapped):**
    - Label: "Evidence — You notice scratch marks around the lock" DM Sans Medium 13px `#f1f5f9`.
    - "If the chest IS trapped, how likely are scratch marks?" DM Sans Regular 12px `#475569`.
    - Same slider styling. Value: "60%" in `#06b6d4`.
  - 20px gap.
  - **False Positive P(Scratches | Not Trapped):**
    - Label: "False Positive — Scratch marks on safe chests" DM Sans Medium 13px `#f1f5f9`.
    - "If the chest is NOT trapped, how likely are scratch marks?" DM Sans Regular 12px `#475569`.
    - Same slider. Value: "10%" in `#94a3b8`.
  - 24px gap.
  - "Update Posterior" button: full-width, bg `#7c3aed`, height 44px, border-radius 6px, DM Sans Semibold 15px `#fff`. Hover: bg `#6d28d9`, glow.

**Right Column — Visualization & Results Card (bg `#111119`, padding 28px):**
- **Posterior Result (hero display):**
  - "Posterior Probability" DM Sans Medium 12px `#475569` uppercase tracking-wide.
  - "72.0%" JetBrains Mono Bold 64px `#ef4444` (since >60% = likely trapped = danger). Animated from prior (30%) to posterior (72%) on calculate.
  - "P(Trapped | Scratches)" JetBrains Mono Regular 13px `#94a3b8`.
  - Arrow animation from "30%" → "72%" with a curved arrow, indicating the update. Prior shown in `#475569`, posterior in `#ef4444`.
- 24px gap.
- **Formula Breakdown Card (bg `#16161f`, border 1px `#1e1e2e`, border-radius 8px, padding 20px):**
  - "Bayes' Theorem" DM Sans Semibold 14px `#f1f5f9`.
  - Formula in JetBrains Mono Regular 14px `#94a3b8`:
  - `P(A|B) = P(B|A) × P(A) / [P(B|A) × P(A) + P(B|¬A) × P(¬A)]`
  - 12px gap.
  - "With your values:" DM Sans Regular 13px `#475569`.
  - `P(Trapped|Scratches) = 0.60 × 0.30 / [0.60 × 0.30 + 0.10 × 0.70]`
  - `= 0.18 / [0.18 + 0.07]`
  - `= 0.18 / 0.25 = 0.720`
  - Numbers colored: prior values `#7c3aed`, likelihood `#06b6d4`, result `#ef4444`.
- 24px gap.
- **Tree Diagram (visual):** Simple probability tree: Root splits into "Trapped (30%)" and "Safe (70%)". Trapped branch splits into "Scratches (60%)" and "No Scratches (40%)". Safe splits into "Scratches (10%)" and "No Scratches (90%)". Highlighted path: Trapped → Scratches glows in `#ef4444`. Branch lines are 1px, nodes are 8px circles. JetBrains Mono 11px labels.
- 16px gap.
- "Chain Evidence" button: ghost style (border `#1e1e2e`, DM Sans Medium 13px `#94a3b8`). Tooltip: "Use this posterior as a new prior with additional evidence."

**Key Design Notes:**
- The 72% posterior in large mono red text is the visual climax — unmissable
- Sliders use gradient fills to feel premium and interactive
- Formula breakdown shows real numbers so students see EXACTLY how Bayes works
- Tree diagram provides a second visual representation of the same math
- RPG scenario framing makes abstract probability feel tangible and fun
- "Chain Evidence" enables multi-step Bayesian updates for advanced learning

---

## Screen 6 — Character Sheet

# Character Sheet — Dark — Desktop 1440px

## Prompt

Design a premium dark character sheet page for "Dice & Decisions", showing a simplified, beginner-friendly D&D-style character sheet, displayed in a clean browser frame at 1440px.

**Overall Aesthetic:** A streamlined character dossier — not the overwhelming full D&D sheet, but a focused dashboard of what matters. Think a personnel file at a premium agency: clean sections, clear data hierarchy, everything editable inline. D&D Beyond's character page concept but radically simplified.

**Sidebar:** Same, "Character Sheet" active under MY CHARACTER.

**Main Content (max-width 1000px, centered, padding 32px):**

**Character Header (full-width, bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 28px, flex space-between):**
- Left: Avatar circle (72px, bg `#16161f`, "T" initial in DM Sans Bold 28px `#7c3aed`). Right of avatar: Name "Thorin Ironforge" Space Grotesk Bold 28px `#f1f5f9` (editable, click-to-edit pencil icon 14px `#475569`). Below: Race "Dwarf" pill (`#06b6d4` 10%, 12px) · Class "Fighter" pill (`#7c3aed` 10%, 12px) · "Level 5" pill (`#eab308` 10%, 12px). All DM Sans Medium 12px.
- Right: HP display — circular progress ring (80px diameter, stroke 4px, bg `#16161f`, filled stroke `#22c55e`). Center: "28" JetBrains Mono Bold 24px `#f1f5f9`, "/32" JetBrains Mono Regular 14px `#475569`. Below ring: "Hit Points" DM Sans Regular 11px `#475569`. + and - buttons (20px circles, `#16161f` bg, `#94a3b8` icon) beside the ring.

**20px gap.**

**Ability Scores Grid (CSS Grid 6 columns, gap 12px):**
Each ability: card (bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 16px, text-center, width ~150px).
- Ability name: DM Sans Medium 11px `#475569` uppercase tracking-wide. ("STR", "DEX", "CON", "INT", "WIS", "CHA")
- Score: JetBrains Mono Bold 28px `#f1f5f9`. Editable number input, no border, bg transparent.
- Modifier: calculated auto. Circle (36px, border 2px `#7c3aed`, border-radius 50%). Modifier value in JetBrains Mono Bold 16px `#7c3aed` (e.g., "+2", "-1"). Negative modifiers show in `#ef4444`.
- Values: STR 16(+3), DEX 14(+2), CON 15(+2), INT 10(0), WIS 12(+1), CHA 8(-1).

**20px gap.**

**Two-Column Layout (1fr 1fr, gap 20px):**

**Left — Derived Stats + Combat (bg `#111119`, padding 24px):**
- **Derived Stats Row (3 items, flex, gap 16px):** AC "16" (shield icon, cyan tint), Initiative "+2" (zap icon, purple), Speed "25 ft" (footprints icon, amber). Each: bg `#16161f`, padding 12px 16px, border-radius 6px. Value in JetBrains Mono Bold 20px `#f1f5f9`, label DM Sans 11px `#475569`.
- 20px gap.
- **Weapons:** Header "Weapons" Space Grotesk Semibold 14px.
  - Primary: "Battleaxe" DM Sans Medium 14px `#f1f5f9`. Damage: "1d8 + 3" JetBrains Mono 13px `#ef4444`. Type: "Slashing" pill DM Sans 11px `#475569`.
  - Secondary: "Handaxe" — same format. Damage: "1d6 + 3".

**Right — Abilities & Inventory (bg `#111119`, padding 24px):**
- **Abilities:** Header "Special Abilities" (max 4).
  - "Second Wind" — DM Sans Semibold 14px `#f1f5f9`. Desc: "Regain 1d10+5 HP as a bonus action" DM Sans Regular 13px `#94a3b8`.
  - "Action Surge" — same format.
  - "+" add button (dashed border circle, 32px, `#475569`).
- 20px gap.
- **Inventory:** Header "Inventory" + count "(6/15 slots)".
  - Simple list: item name + quantity. "Healing Potion ×3", "Rope (50ft) ×1", etc. DM Sans Regular 14px `#f1f5f9`, quantity in JetBrains Mono 13px `#475569`.

**Full-width Notes Card below:** "Character Notes" with a textarea, DM Sans Regular 14px, bg `#16161f`, min-height 100px.

**Key Design Notes:**
- Ability score cards with circular modifiers are the visual signature — instantly recognizable
- HP ring provides at-a-glance health without reading numbers
- Inline editing means no separate "edit mode" — always editable
- 6-column ability grid is the only dense section — everything else is spacious
- Responsive: ability grid goes 3×2 at 768px, 2×3 at 375px

---

## Screen 7 — NPC Manager

# NPC Manager — Dark — Desktop 1440px

## Prompt

Design a premium dark web page for "Dice & Decisions" showing the NPC (Non-Player Character) Manager — a card grid of NPCs the DM has created, displayed in a browser frame at 1440px.

**Overall Aesthetic:** A rogue's gallery. NPCs displayed as dossier cards in a masonry-like grid. Each card reveals key info at a glance with status indicators. Think Notion's database gallery view meets a fantasy intelligence board.

**Sidebar:** Same, "NPCs" active under CAMPAIGN.

**Top Bar:** "NPCs" Space Grotesk Semibold 20px. Right: Search input (width 240px, placeholder "Search NPCs...", magnifying glass icon), Filter dropdown ("All Roles"), + "New NPC" button bg `#7c3aed`.

**Main Content — Card Grid (CSS Grid auto-fit minmax(300px, 1fr), gap 16px):**

6 NPC cards. Each card (bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 20px, hover: border `#2d2d44`, shadow lift):
- Top row: Avatar circle (40px, bg `#16161f`, initials) + Name Space Grotesk Semibold 16px `#f1f5f9` + Status pill (right-aligned). Status: "ACTIVE" `#22c55e` bg 10%, "DECEASED" `#ef4444` bg 10% with strikethrough name, "HIDDEN" `#475569` bg 10%.
- Role pill: "Villain" `#ef4444`, "Merchant" `#eab308`, "Quest Giver" `#7c3aed`, "Guide" `#06b6d4`. JetBrains Mono 10px, pill bg.
- Description: 2 lines max truncated, DM Sans Regular 13px `#94a3b8`.
- Stats row (only if has stats): "HP 45 | AC 16 | ATK +6" JetBrains Mono 12px `#475569`.
- Bottom: "Visible to Players" toggle (small, 32px wide). Eye icon (open/closed, 14px).
- Hover reveals: "Edit" and "Delete" icon buttons (pencil, trash, 14px, `#475569`).

Sample NPCs: "Morrigan the Witch" (Villain, Active), "Guildmaster Henrick" (Quest Giver, Active), "Old Barlow" (Merchant, Active), "The Shadow" (Guide, Hidden), "Captain Rourke" (Quest Giver, Deceased).

**Key Design Notes:**
- Status-colored pills give instant NPC state recognition
- Role pills use color-coding consistent with the design system
- Hover-reveal edit/delete prevents visual clutter
- Cards are scannable — DM can find any NPC in seconds
- "Hidden" NPCs show with reduced opacity (60%) + dotted border

---

## Screen 8 — Campaign Map Viewer

# Campaign Map Viewer — Dark — Desktop 1440px

## Prompt

Design a premium dark web page for "Dice & Decisions" showing the Campaign Map Viewer — an interactive map image with placed markers, displayed in a browser frame at 1440px.

**Overall Aesthetic:** An explorer's cartography table. The map occupies most of the viewport with a thin sidebar listing available maps. Markers float on the map image with icon badges and popup details. Think Google Maps' clean pin system applied to a fantasy dungeon map, wrapped in the app's dark dashboard shell.

**Sidebar:** Same, "Maps" active under WORLD.

**Main Content (2-panel: 240px left panel + full remaining width for map):**

**Left Panel — Map List (bg `#111119`, border-right 1px `#1e1e2e`, padding 16px):**
- "Maps" Space Grotesk Semibold 14px. "+ Upload Map" button (ghost, full-width, dashed border, DM Sans Medium 13px `#475569`).
- 12px gap.
- Map list items (stacked, 8px gap): Each: thumbnail (48px × 32px, bg `#16161f`, border-radius 4px, showing tiny map preview), name DM Sans Medium 13px `#f1f5f9`, "5 markers" DM Sans Regular 11px `#475569`. Active map: bg `rgba(124,58,237,0.08)`, left 2px border `#7c3aed`.
- Maps: "Tower of Fate — Level 1" (active), "Tower of Fate — Level 2", "World Overview".

**Map Canvas (full remaining width, bg `#0c0c13`, overflow hidden):**
- A dungeon-style map image fills the canvas (imagine a hand-drawn dungeon floor plan with rooms, corridors, a central chamber, rendered in muted parchment tones that still look good on dark bg).
- **Zoom controls:** Bottom-right, vertical stack: "+" and "−" buttons (32px squares, bg `#111119`, border 1px `#1e1e2e`, DM Sans Bold 16px `#f1f5f9`, border-radius 6px). "Reset" text button below. Current zoom: "125%" JetBrains Mono 11px `#475569`.
- **Markers on the map (5 markers at various positions):**
  - Each marker: 28px circle, bg `#111119`, border 2px colored by type, shadow `0 2px 8px rgba(0,0,0,0.4)`. Icon centered (14px):
    - Crossed-swords icon, border `#ef4444` — "Goblin Ambush" combat marker
    - Exclamation icon, border `#7c3aed` — "The Sealed Door" quest marker
    - Shopping-bag icon, border `#eab308` — "Hidden Cache" shop/loot marker
    - Skull icon, border `#475569`, dashed border, opacity 50% — "Boss Chamber" hidden from players (DM-only)
    - House icon, border `#22c55e` — "Safe Room" safe zone marker
  - Hovered marker: scale 1.15, border brightens, tooltip appears.
- **Active Marker Popup (shown for one marker, bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 16px, width 240px, shadow `0 8px 32px rgba(0,0,0,0.5)`, positioned near marker with a small triangle pointer):**
  - Type pill: "COMBAT" JetBrains Mono 10px `#ef4444`, bg 10%.
  - Name: "Goblin Ambush" DM Sans Semibold 15px `#f1f5f9`.
  - Description: "4 goblins patrol this corridor. DC 14 Stealth to sneak past." DM Sans Regular 13px `#94a3b8`.
  - Bottom: Eye-toggle "Visible to players" + Edit pencil + Delete trash icons.

**Key Design Notes:**
- Map canvas uses CSS `transform: scale()` and `translate()` for pan/zoom — no library
- Markers use percentage-based positioning (pos_x, pos_y) so they scale with the map
- Hidden markers shown to DM with dashed border + 50% opacity — clear fog-of-war indicator
- Popup anchored to marker with a CSS triangle pointer
- Upload area in left panel uses drag-and-drop with dashed border visual cue

---

## Screen 9 — Encounter Builder

# Encounter Builder — Dark — Desktop 1440px

## Prompt

Design a premium dark web page for "Dice & Decisions" showing the Encounter Builder — a form for creating RPG encounters with enemies and linked probability cards, in a browser frame at 1440px.

**Overall Aesthetic:** A mission-planning interface. Split layout: encounter details on the left, live-generated probability cards on the right. Feels like a tactical operations planner. D&D Beyond's encounter builder concept executed with Notion's form elegance.

**Sidebar:** Same, "Encounters" active.

**Main Content (2-column: 1.2fr 0.8fr, gap 24px):**

**Left — Encounter Form Card (bg `#111119`, padding 28px):**
- "Create Encounter" Space Grotesk Bold 22px. Status selector: pills "Planned" / "Active" / "Completed".
- Inputs: Name ("Goblin Ambush at the Bridge"), Description (textarea, 3 lines), Difficulty Class (number, "14").
- **Enemy List:** Header "Enemies" + "+ Add Enemy" ghost button. 3 enemy rows, each a mini card (bg `#16161f`, padding 12px, border-radius 6px, flex): Name input, HP input, AC input, ATK Bonus input, Damage Dice dropdown. Remove "×" button per row. All inputs compact (height 36px).
- "Save Encounter" primary button + "Generate Probability Cards" secondary button.

**Right — Live Probability Preview:** Auto-generated mini probability cards for each player-vs-enemy matchup when "Generate" is clicked. 4 mini cards stacked. Each: player name vs enemy name, dice notation, % outcome in color-coded JetBrains Mono, tiny probability bar.

**Key Design Notes:**
- Split layout lets DM see probability impact as they adjust encounter stats
- Enemy rows are repeatable form elements — add/remove dynamically
- Compact inputs keep the form scannable despite many fields

---

## Screen 10 — Story Notes

# Story Notes — Dark — Desktop 1440px

## Prompt

Design a premium dark web page for "Dice & Decisions" showing the Story Notes system — a Notion-like note list with rich text editor, in a browser frame at 1440px.

**Overall Aesthetic:** A DM's journal — organized, searchable, tagged. Left panel lists notes, right panel shows the active note in a rich text editor. Think Notion's page structure meets Bear Notes' dark elegance. Content-first, tools fade to the background.

**Sidebar:** Same, "Story Notes" active.

**Main Content (2-panel: 300px note list + remaining editor):**

**Left — Note List (bg `#111119`, border-right 1px `#1e1e2e`, padding 16px):**
- Search input + "+ New Note" button.
- Tag filters: pills "ALL", "SESSION LOG" (cyan), "WORLD LORE" (purple), "PLOT" (green), "DM SECRET" (red). Active: filled bg.
- Note items (stacked, 4px gap): Tag pill + title (DM Sans Semibold 14px) + preview (13px `#475569`, 1 line) + timestamp. Active note: bg `rgba(124,58,237,0.06)`, left border purple.

**Right — Editor (bg `#08080d`, padding 40px, max-width 720px, centered):**
- Title: "Session 4 — The Descent Begins" contenteditable, Space Grotesk Bold 28px `#f1f5f9`.
- Tag dropdown + visibility toggle ("DM Secret" vs "Visible to Players" — eye icon).
- Toolbar: bold/italic/bullet/heading/quote icons (18px, `#475569`, hover `#f1f5f9`), bg `#111119`, border-radius 6px, padding 4px 8px. Floating on focus.
- Body text: DM Sans Regular 16px `#94a3b8`, line-height 1.7. Rendered with bold, italic, headers, and bullet lists visible.

**Key Design Notes:**
- 720px max-width for editor matches optimal reading line length (65-75 chars)
- Tag-colored notes in left panel allow instant visual filtering
- "DM Secret" notes show a small lock icon + red tint in the list

---

## Screen 11 — Theme Switcher (Settings)

# Theme Switcher — Dark — Desktop 1440px

## Prompt

Design a premium dark settings page for "Dice & Decisions" showing the Theme Switcher — a grid of genre theme cards the user can select, at 1440px.

**Overall Aesthetic:** A polished settings page with the theme selector as the hero element. Theme cards are large, visual, and immediately communicate each genre's vibe. Think Spotify's "Your Library" card grid energy applied to RPG aesthetic themes.

**Sidebar:** Same, "Settings" active.

**Main Content (max-width 800px, centered):**

**Section: "Campaign Theme"** Space Grotesk Semibold 20px. Subtitle: "Choose a visual theme that matches your campaign's genre" DM Sans Regular 14px `#94a3b8`.

**Theme Cards Grid (CSS Grid 3-col first row, 2-col second row centered, gap 16px):**
Each card (width ~240px, height 160px, border-radius 8px, padding 20px, cursor pointer, transition 200ms):
1. **Fantasy** (active): bg gradient `#0a0a0f` → `#12121a`, accent bar 3px `#7c3aed` at top, border 2px `#7c3aed`. Castle icon (32px, outlined, `#7c3aed`). "Fantasy" Space Grotesk Semibold 16px `#f1f5f9`. "Arcane, magical, medieval" DM Sans 12px `#94a3b8`. Checkmark badge (16px circle, `#7c3aed`, white check) top-right. Subtle glow: `0 0 30px rgba(124,58,237,0.15)`.
2. **Sci-Fi**: bg dark navy gradient, accent bar `#06b6d4`. Rocket icon. Border `#1e1e2e` (not active). "Neon, holographic, futuristic". Hover: border `#06b6d4` faint.
3. **Western**: bg warm dark-brown gradient, accent bar `#d97706`. Star-badge icon. "Dusty, rugged, weathered". Hover: border `#d97706` faint.
4. **Eldritch Horror**: bg dark green-black gradient, accent bar `#16a34a`. Eye icon. "Unsettling, Lovecraftian". Hover: border `#16a34a` faint.
5. **Steampunk**: bg bronze-brown gradient, accent bar `#ca8a04`. Cog/gear icon. "Brass, gears, Victorian". Hover: border `#ca8a04` faint.

Below grid: "Theme changes apply instantly across the app" DM Sans Regular 12px `#475569`, info icon.

**Other Settings Sections below (compact):**
- "Profile" — display name, email (read-only), avatar upload.
- "Role Preference" — DM/Player default toggle.
- "Account" — sign out, delete account (danger zone with red border).

**Key Design Notes:**
- Active theme card has a purple border + glow + checkmark — unmistakable selection state
- Each card's background gradient subtly previews the theme's color feel
- 3+2 grid centering keeps the layout balanced with 5 items
- Non-active cards have a uniform border but unique accent bar previewing their color
- Settings page keeps theme as the hero section — it's the most visually interesting setting
