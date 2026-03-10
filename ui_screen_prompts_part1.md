# Dice & Decisions — Google Stitch UI Prompts (Part 1)

> **Usage:** Paste each prompt into [Google Stitch](https://stitch.withgoogle.com/) to generate pixel-perfect mockups. Each prompt generates one screen at 1440px desktop.

---

## Shared Design System

All screens share these tokens. Each prompt references this system.

**Design Language:** "Arcane Dashboard" — D&D Beyond's structured game-tool aesthetic meets Linear's developer-precision minimalism meets Notion's content-organization intelligence. Every surface feels intentional, data-rich, and premium. No fantasy wallpapers, no medieval clichés — this is a modern SaaS product that happens to manage a fantasy RPG.

**Color Palette (Fantasy Theme — Default):**
| Token | Hex | Usage |
|---|---|---|
| `bg-base` | `#08080d` | Page background |
| `bg-card` | `#111119` | Card/panel surfaces |
| `bg-sidebar` | `#0c0c13` | Sidebar background |
| `bg-input` | `#16161f` | Input fields, wells |
| `border` | `#1e1e2e` | Borders, dividers |
| `border-hover` | `#2d2d44` | Hovered borders |
| `accent-primary` | `#7c3aed` | Primary actions, active states |
| `accent-glow` | `rgba(124,58,237,0.15)` | Glow/focus rings |
| `accent-secondary` | `#06b6d4` | Data, probability, charts |
| `success` | `#22c55e` | High probability, health |
| `warning` | `#eab308` | Medium probability, caution |
| `danger` | `#ef4444` | Low probability, damage |
| `text-primary` | `#f1f5f9` | Headlines, primary text |
| `text-secondary` | `#94a3b8` | Body text, descriptions |
| `text-muted` | `#475569` | Labels, captions |

**Typography:**

- **Display/Headings:** Space Grotesk Bold — 48px hero, 32px H1, 24px H2, 18px H3. Letter-spacing: -0.02em on display sizes.
- **Body:** DM Sans Regular/Medium — 15px body, 14px secondary, 12px caption. Line-height: 1.6.
- **Monospace (dice/stats):** JetBrains Mono Medium — 14-20px. Used for dice notation, stat numbers, probability values.

**Component Tokens:**

- Border-radius: 8px cards, 6px buttons/inputs, 12px modals, 9999px pills
- Shadows: `0 4px 24px rgba(0,0,0,0.4)` cards, `0 8px 40px rgba(0,0,0,0.5)` elevated
- Transitions: `all 200ms ease`
- Icons: Lucide-style outlined, 18-20px, 1.5px stroke weight

---

## Screen 1 — Login / Sign Up

# Login Page — Dark — Desktop 1440px

## Prompt

Design a premium dark login/signup page for "Dice & Decisions", a probability-powered D&D campaign management tool, displayed in a clean browser frame at 1440px.

**Overall Aesthetic:** Arcane minimalism — the login feels like entering a sanctum. A single centered authentication card floats on a deep void background with a subtle atmospheric glow. Think Linear's login simplicity crossed with Blizzard's game-launcher gravitas and Vercel's dark precision. No fantasy imagery — atmosphere comes entirely from light, shadow, and typography.

**Background & Canvas:** Base `#08080d`. A large, soft radial gradient centered behind the card: `#7c3aed` at 4% opacity, 800px diameter, 300px Gaussian blur. A secondary gradient in the bottom-left: `#06b6d4` at 3% opacity, 600px diameter, 250px blur. Subtle noise texture at 2% opacity over the entire background.

**Authentication Card (centered, max-width 420px, padding 40px, bg `#111119`, border 1px solid `#1e1e2e`, border-radius 12px, shadow `0 8px 40px rgba(0,0,0,0.5)`):**

- Top: Logo — a d20 die icon (geometric, outlined, 32px, stroke 1.5px, color `#7c3aed`) next to "Dice & Decisions" in Space Grotesk Bold 22px `#f1f5f9`, letter-spacing -0.02em. Below: tagline "Probability-Powered Campaign Command" in DM Sans Regular 13px `#475569`.
- 24px gap.
- Tab switcher: Two tabs "Sign In" and "Sign Up" side by side. Active tab: DM Sans Semibold 14px `#f1f5f9` with a 2px bottom border in `#7c3aed`. Inactive tab: DM Sans Medium 14px `#475569`, hover color `#94a3b8`. Tabs separated by 24px, full-width bottom border 1px `#1e1e2e`.
- 28px gap.
- **Sign In form:**
  - Email input: label "Email" in DM Sans Medium 12px `#94a3b8` uppercase letter-spacing 0.05em, 6px below label. Input: height 44px, bg `#16161f`, border 1px solid `#1e1e2e`, border-radius 6px, padding 0 14px, DM Sans Regular 15px `#f1f5f9`, placeholder text `#475569`. Focus: border `#7c3aed`, box-shadow `0 0 0 3px rgba(124,58,237,0.15)`.
  - 16px gap.
  - Password input: same styling. Right side: small lock icon (Lucide-style, 16px, `#475569`).
  - 8px gap.
  - "Forgot password?" link: DM Sans Regular 13px `#7c3aed`, hover underline.
  - 24px gap.
  - Submit button: "Enter the Tower" — full width, height 44px, bg `#7c3aed`, border-radius 6px, DM Sans Semibold 15px `#ffffff`. Hover: bg `#6d28d9`, shadow `0 0 20px rgba(124,58,237,0.3)`. Active: bg `#5b21b6`.
  - 20px gap.
  - Divider: horizontal line (1px `#1e1e2e`) with centered text "or" in DM Sans Regular 12px `#475569` on a `#111119` pill background.
  - 20px gap.
  - Social login: "Continue with Google" button — full width, height 44px, bg transparent, border 1px solid `#1e1e2e`, border-radius 6px, DM Sans Medium 14px `#94a3b8`. Left: Google "G" icon style (outlined, 18px). Hover: border `#2d2d44`, bg `#16161f`.

**Footer text (below card, 32px gap):** "Built for DMs who think in probabilities" in DM Sans Regular 12px `#475569`, centered.

**Key Design Notes:**

- Card has a very subtle top-edge highlight: `border-top: 1px solid rgba(124,58,237,0.1)` for depth
- The atmospheric gradients create a sense of "entering a portal" without any literal imagery
- Tab switcher between Sign In/Sign Up avoids a separate page — single-card auth
- Button copy "Enter the Tower" adds thematic flavor without being cheesy
- All inputs have clear focus states with purple glow ring
- Responsive: at 375px mobile, card goes full-width with 20px padding, no browser frame

---

## Screen 2 — DM Dashboard

# DM Dashboard — Dark — Desktop 1440px

## Prompt

Design a premium dark web dashboard for "Dice & Decisions", showing the Dungeon Master's campaign command center, displayed in a clean browser frame at 1440px.

**Overall Aesthetic:** A sophisticated campaign HQ — data-rich but never cluttered. The layout follows D&D Beyond's sidebar + main content structure, executed with Linear's visual precision and Notion's content-block intelligence. Every card is a "panel" in the command center. Generous spacing, clear hierarchy, and information density that feels powerful, not overwhelming.

**Background & Canvas:** `#08080d` full page. Subtle noise texture at 2% opacity.

**Sidebar (fixed left, width 260px, height 100vh, bg `#0c0c13`, border-right 1px solid `#1e1e2e`, padding 20px 16px):**

- Top: Logo — d20 icon (20px, outlined, `#7c3aed`) + "Dice & Decisions" in Space Grotesk Bold 16px `#f1f5f9`. Below: small pill badge "DM MODE" in JetBrains Mono Medium 10px `#7c3aed`, bg `rgba(124,58,237,0.1)`, border-radius 9999px, padding 2px 10px.
- 28px gap.
- Campaign name: "Tower of Fate" in DM Sans Semibold 13px `#f1f5f9`. Below: "Active Campaign" in DM Sans Regular 11px `#475569`.
- 24px gap.
- Nav groups (each group has a label in DM Sans Medium 11px `#475569` uppercase tracking-wide, 12px below label for items):
  - **OVERVIEW:** Dashboard — active state: bg `rgba(124,58,237,0.08)`, text `#f1f5f9`, left 2px border `#7c3aed`, border-radius 6px. Icon: grid 4-square icon, 18px.
  - **PROBABILITY:** Probability Cards (chart-bar icon), Dice Visualizer (bar-chart icon), Bayes Analyzer (brain icon). All: DM Sans Medium 14px `#94a3b8`, padding 8px 12px, hover: bg `#16161f`, text `#f1f5f9`.
  - **CAMPAIGN:** Story Notes (file-text icon), Encounters (swords-crossed icon), NPCs (users icon). Same styling.
  - **WORLD:** Maps (map-pin icon). Same styling.
  - **CHARACTERS:** Party (shield icon). Same styling.
  - 16px gap between groups.
- Bottom of sidebar: Settings gear icon (18px, `#475569`). User avatar circle (32px, `#16161f` bg, initials "DM" in DM Sans Bold 12px `#7c3aed`). "Dungeon Master" in DM Sans Medium 13px `#f1f5f9`. Role switcher: small toggle showing "DM" active (purple) vs "Player" (muted). Toggle: 40px wide, 20px tall, pill shape, bg `#16161f`, active dot 16px circle `#7c3aed`.

**Top Bar (sticky, height 56px, bg `#08080d`, border-bottom 1px solid `#1e1e2e`, padding 0 32px, flex space-between center):**

- Left: "Dashboard" in Space Grotesk Semibold 20px `#f1f5f9`.
- Right: Theme switcher (palette icon, 18px, `#475569`, hover `#94a3b8`). Notification bell icon (18px, `#475569`) with a small 8px dot in `#7c3aed` indicating unread. "New Session" button: bg `#7c3aed`, DM Sans Semibold 13px `#fff`, height 36px, padding 0 16px, border-radius 6px, hover bg `#6d28d9`.

**Main Content (margin-left 260px, padding 24px 32px):**

**Welcome Banner (full-width, bg linear-gradient(135deg, `#111119` 0%, `rgba(124,58,237,0.05)` 100%), border 1px solid `#1e1e2e`, border-radius 8px, padding 24px 28px, flex space-between):**

- Left: "Tower of Fate" in Space Grotesk Bold 28px `#f1f5f9`. Below: "Session 4 — The Descent Begins" in DM Sans Regular 15px `#94a3b8`. Below: "Last session: 2 days ago" in DM Sans Regular 12px `#475569`.
- Right: "Continue Session" button (bg `#7c3aed`, DM Sans Semibold 14px `#fff`, height 40px, padding 0 20px, border-radius 6px) and "Prep Mode" ghost button (border 1px solid `#1e1e2e`, DM Sans Medium 14px `#94a3b8`, same dimensions, hover border `#2d2d44`).

**24px gap.**

**Stats Row (4 cards in a row, CSS Grid 4 columns gap 16px):**
Each card: bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 20px. Hover: border `#2d2d44`, shadow `0 4px 24px rgba(0,0,0,0.3)`.

1. "Active Players" — icon: users (18px, `#7c3aed`). Value: "4" in JetBrains Mono Bold 32px `#f1f5f9`. Label: DM Sans Regular 13px `#475569`.
2. "NPCs Created" — icon: user-circle (18px, `#06b6d4`). Value: "12". Same styling.
3. "Encounters" — icon: swords (18px, `#eab308`). Value: "7".
4. "Avg. Success Rate" — icon: target (18px, `#22c55e`). Value: "47%" in JetBrains Mono. Small bar (100px wide, 4px tall, bg `#16161f`, filled 47% with `#22c55e`).

**20px gap.**

**Two-Column Section (CSS Grid, 2fr 1fr, gap 20px):**

**Left Column — "Next Encounter" card (bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 24px):**

- Header: "Next Encounter" in Space Grotesk Semibold 16px `#f1f5f9`. Right: status pill "PLANNED" in JetBrains Mono Medium 10px `#eab308`, bg `rgba(234,179,8,0.1)`, border-radius 9999px.
- 16px gap.
- Encounter name: "Goblin Ambush at the Bridge" in DM Sans Semibold 18px `#f1f5f9`.
- Description: "A pack of 4 goblins attacks as the party crosses the stone bridge..." in DM Sans Regular 14px `#94a3b8`, max 2 lines.
- 16px gap.
- Enemy list: 3 rows, each row flex with: enemy icon (skull, 14px, `#ef4444`), name in DM Sans Medium 13px `#f1f5f9`, stats in JetBrains Mono Regular 12px `#475569` "HP: 12 | AC: 13 | ATK: +4".
- 16px gap.
- "View Probability Cards" link: DM Sans Medium 13px `#7c3aed`, right arrow icon 14px. Hover: underline.

**Right Column — "Party Overview" card (same card styling):**

- Header: "Party" in Space Grotesk Semibold 16px `#f1f5f9`. Right: "4 members" DM Sans Regular 12px `#475569`.
- 16px gap.
- 4 player rows, each 48px tall, flex center:
  - Avatar circle (32px, bg `#16161f`), character initial in DM Sans Bold 13px (each in a different accent: `#7c3aed`, `#06b6d4`, `#22c55e`, `#eab308`).
  - Name: "Thorin Ironforge" DM Sans Medium 14px `#f1f5f9`. Below name: "Dwarf Fighter · Lv5" DM Sans Regular 12px `#475569`.
  - Right: HP bar (60px wide, 6px tall, bg `#16161f`, filled proportionally with `#22c55e` for high health, `#eab308` for medium, `#ef4444` for low). HP text: JetBrains Mono Regular 11px `#475569` "28/32".
  - 8px gap between rows.

**20px gap.**

**Recent Notes Preview (full-width card, same styling, padding 24px):**

- Header: "Recent Notes" in Space Grotesk Semibold 16px `#f1f5f9`. Right: "View All" link DM Sans Medium 13px `#7c3aed`.
- 16px gap.
- 3 note rows: each with tag pill (color-coded: "SESSION LOG" `#06b6d4`, "PLOT" `#7c3aed`, "DM SECRET" `#ef4444` — all JetBrains Mono 10px, bg at 10% opacity), title in DM Sans Medium 14px `#f1f5f9`, preview text truncated in DM Sans Regular 13px `#475569`, timestamp right-aligned DM Sans Regular 12px `#475569`.

**Key Design Notes:**

- Sidebar uses grouped navigation with uppercase section labels for scannability
- DM Mode badge in sidebar immediately communicates the active role
- Stats row uses monospace numbers for a data-dashboard feel
- HP bars in party overview give instant health status at a glance
- Next Encounter card serves as the primary focus — what's coming up next
- The welcome banner gradient subtly incorporates the purple accent for warmth
- All cards have hover state: brighter border + shadow lift
- Responsive at 768px: sidebar collapses to 64px icon-only. Below 768px: sidebar hidden, bottom tab nav

---

## Screen 3 — Player Dashboard

# Player Dashboard — Dark — Desktop 1440px

## Prompt

Design a premium dark web dashboard for "Dice & Decisions", showing the Player view — a simplified, character-focused dashboard, displayed in a clean browser frame at 1440px.

**Overall Aesthetic:** Same design system as the DM Dashboard but with a narrower scope. The player sees their character, campaign updates, and probability tools — no management features. It feels like a personal character cockpit. Think D&D Beyond's character page meets Linear's clean detail views.

**Background & Canvas:** `#08080d`. Subtle noise 2%.

**Sidebar (same structure as DM Dashboard but with reduced nav):**

- Same logo and branding at top.
- Role badge: "PLAYER" pill in JetBrains Mono 10px `#06b6d4`, bg `rgba(6,182,212,0.1)`.
- Nav groups (reduced):
  - **OVERVIEW:** Dashboard (active)
  - **PROBABILITY:** Probability Cards, Dice Visualizer, Bayes Analyzer
  - **WORLD:** Maps
  - **MY CHARACTER:** Character Sheet
  - No Campaign section (NPCs, Encounters, Story Notes are DM-only management tools — players see them embedded in their dashboard as read-only previews)
- Bottom: Player name "Thorin Ironforge", avatar, role switcher (Player active in cyan).

**Main Content:**

**Character Summary Banner (full-width, bg gradient `#111119` to `rgba(6,182,212,0.03)`):**

- Left: Character avatar (64px circle, bg `#16161f`, letter "T" in DM Sans Bold 24px `#06b6d4`). Name "Thorin Ironforge" Space Grotesk Bold 24px `#f1f5f9`. "Dwarf Fighter · Level 5" DM Sans Regular 14px `#94a3b8`.
- Right cluster: 4 mini stat pills — HP "28/32" (green tint), AC "16" (cyan tint), Initiative "+2" (purple tint), Speed "25ft" (yellow tint). Each: JetBrains Mono Medium 14px, bg at 8% of respective color, border 1px at 15% of respective color, border-radius 6px, padding 6px 12px.
- "Edit Character" ghost button, "View Full Sheet" primary button on far right.

**Two-Column Layout (2fr 1fr):**

**Left — "Campaign Feed" card:** A chronological feed of DM-shared content:

- Session 4 log preview (tagged "SESSION LOG" cyan pill)
- Active quest description
- "DM has updated the Tower of Fate map" feed entry

**Right — "Quick Probability Check" card:** Mini probability calculator:

- Dropdown: dice type (d20 selected)
- Input: modifier (+3)
- Input: target DC (15)
- Result: "45% Success" in large JetBrains Mono Bold 36px `#eab308` (medium probability). Mini bar visualization below.

**Key Design Notes:**

- Player dashboard intentionally simpler than DM — less cognitive load
- Cyan accent replaces purple as the primary accent to differentiate roles
- Character banner gives instant awareness of character state
- Probability tools are front-and-center — this is a probability learning tool
- Campaign feed shows DM-shared content in read-only format

---

## Screen 4 — Probability Cards & Dice Visualizer

# Probability Tools — Dark — Desktop 1440px

## Prompt

Design a premium dark web page for "Dice & Decisions", showing the Probability Cards and Dice Distribution Visualizer — the core probability engine, displayed in a clean browser frame at 1440px.

**Overall Aesthetic:** This is the educational heart of the app. Data-visualization-forward, Bloomberg-terminal-meets-D&D. Charts and probability cards should feel like professional analytics tools themed for RPG combat. Think Robinhood's clean chart style applied to dice probability. Every number in JetBrains Mono. Color-coded by outcome likelihood.

**Background & Canvas:** `#08080d`. Noise 2%.

**Sidebar:** Same as DM Dashboard, with "Probability Cards" nav item active (highlighted purple).

**Top Bar:** Page title "Probability Tools" in Space Grotesk Semibold 20px. Right: tabs "Cards" (active, underlined purple) and "Dice Visualizer" in DM Sans Medium 14px.

**Main Content — Cards Tab:**

**Probability Card Builder (top section, full-width card, bg `#111119`, padding 24px):**

- Header: "Create Probability Card" Space Grotesk Semibold 18px.
- Form row (flex, gap 16px):
  - "Action Name" text input (width 240px, placeholder "Attack the Goblin")
  - "Dice" dropdown (width 120px, options: d4, d6, d8, d10, d12, d20)
  - "Count" number input (width 80px, value "1")
  - "Modifier" number input (width 100px, value "+3", can be negative)
  - "Target (DC)" number input (width 100px, value "15")
  - "Calculate" button (bg `#7c3aed`, DM Sans Semibold 14px, height 44px)
- Inputs: height 44px, bg `#16161f`, border 1px `#1e1e2e`, border-radius 6px, DM Sans Regular 14px `#f1f5f9`. Labels above in DM Sans Medium 11px `#475569` uppercase.

**16px gap.**

**Generated Probability Card (max-width 480px, bg `#111119`, border 1px `#1e1e2e`, border-radius 8px, padding 28px, shadow `0 4px 24px rgba(0,0,0,0.4)`):**

- Top: Action name "Attack the Goblin" Space Grotesk Semibold 18px `#f1f5f9`. Dice notation "1d20 + 3" in JetBrains Mono Medium 14px `#7c3aed`, pill bg `rgba(124,58,237,0.08)`.
- 16px gap.
- Target: "DC 15" in JetBrains Mono Medium 14px `#94a3b8`.
- 20px gap.
- **Success Probability** — large display: "45%" in JetBrains Mono Bold 56px `#eab308` (color-coded: green `#22c55e` if >65%, amber `#eab308` if 35-65%, red `#ef4444` if <35%). Below: "Chance of Success" DM Sans Regular 13px `#475569`.
- 16px gap.
- **Probability Bar:** Full-width, height 12px, border-radius 6px, bg `#16161f`. Three segments: Critical Fail (5%, `#ef4444`), Fail (50%, `#1e1e2e`), Success (40%, `#22c55e`), Critical Success (5%, `#7c3aed`). Segments have 1px gap between them.
- 16px gap.
- **Outcome Breakdown (4-column grid, gap 12px):** Each cell: centered.
  - "Nat 1" — "5.0%" JetBrains Mono 14px `#ef4444`. Label "Crit Fail" DM Sans 11px `#475569`. Small skull icon 14px.
  - "2-11" — "50.0%" JetBrains Mono 14px `#94a3b8`. Label "Failure".
  - "12-19" — "40.0%" JetBrains Mono 14px `#22c55e`. Label "Success". Small check icon 14px.
  - "Nat 20" — "5.0%" JetBrains Mono 14px `#7c3aed`. Label "Crit!" Small star icon 14px.

**Active Probability Cards Grid (below, CSS Grid 3 columns gap 16px):**

- 3-4 pre-existing encounter cards in a compact format (mini version of the full card above): action name, dice, % in large mono text, tiny probability bar. Each from the current encounter. Hover: border `#2d2d44`, slight lift.

**Main Content — Dice Visualizer Tab (show as alternate view):**

**Dice Distribution Chart (full-width card, bg `#111119`, padding 24px):**

- Header: "Dice Distribution Visualizer" Space Grotesk Semibold 18px.
- Controls row: Dice selector buttons (d4, d6, d8, d10, d12, d20 — pill buttons, active one filled `#7c3aed`). Number of dice: "2" input. Total: "2d6" displayed in JetBrains Mono Bold 16px `#7c3aed`.
- 20px gap.
- **Bar Chart:** X-axis: possible outcomes (2 through 12 for 2d6). Y-axis: probability %. Bars: gradient from `#06b6d4` to `#7c3aed`, border-radius 4px top. Hovered bar: brighter, tooltip showing "Value: 7, Probability: 16.67%, Ways: 6/36" in a dark tooltip card. The bar for 7 (highest probability) is tallest. Bell curve shape visible. Axis labels: JetBrains Mono Regular 12px `#475569`. Grid lines: `#1e1e2e` at 10% opacity.
- **Compare Mode:** Toggle "Compare" — shows a second distribution overlaid in `#eab308` amber (e.g., 1d12 vs 2d6 side by side). Legend in top-right: colored squares + labels.

**Key Design Notes:**

- Probability cards use color-coded percentages (green/amber/red) — instantly communicable
- JetBrains Mono for ALL numbers — reinforces the data-tool aesthetic
- Bar chart uses gradient fills for visual richness, not flat colors
- Compare mode is a standout educational feature — visually demonstrates why 2d6 ≠ 1d12
- The probability bar with segmented outcomes is the signature visual element
- Responsive: cards stack to 2-col at 768px, 1-col at 375px. Chart goes full-width

---

_Continue in Part 2 →_
