# Phase 2.3 — DM Dashboard Components

Create all of the following files inside `src/components/dashboard/`.

---

#### 2.3.1 -- Hero Banner

**File:** `hero-banner.tsx` -- CREATE

**Props:** `campaignName: string`, `sessionNumber: number`, `sessionTitle: string`, `heroImageUrl?: string`

**Layout and styling instructions:**

- Render a full-width card (spanning the entire content area) with a fixed height of approximately 300px.
- Background: if `heroImageUrl` is provided, use it as a `background-image` with `cover` sizing and `center` positioning. Layer a dark gradient overlay on top (`bg-gradient-to-r from-black/80 via-black/50 to-transparent` or similar) so text remains legible. If no image URL is provided, fall back to a purely CSS gradient using the theme's darkest background color transitioning to a slightly lighter shade with a subtle purple tint.
- Position all text content inside the card, vertically centered, left-aligned with generous left padding (around `pl-10` / `pl-12`).
- First line of text: the string `"CURRENT CAMPAIGN:"` followed by the campaign name, all uppercase. Style this as a small label -- font size around 11-12px, letter-spacing of `0.15em`, color set to the theme's purple/accent color. Use a sans-serif font.
- Second line: `"Session [N] -- [Title]"` where N is the session number and Title is the session title. Style in the display/serif font from the design system at approximately 36px, bold weight, white color.
- Below the title, add a row of two buttons with a small gap between them:
  - "Continue Session" -- use the accent/primary filled button variant from shadcn/ui. Medium size.
  - "Session Logs" -- use an outlined/ghost variant with a dark background and subtle border. Medium size.
- The entire card should have rounded corners matching the design system's card radius (likely `rounded-xl` or `rounded-2xl`) and no visible border. Add a subtle box shadow if the mockup shows one.

---

#### 2.3.2 -- Quick Stats Row

**File:** `quick-stats.tsx` -- CREATE

**Props:** `stats: { playerCount: number, npcCount: number, encounterCount: number, avgDC: number, avgSuccessRate: number }`

**Layout and styling instructions:**

- Render a horizontal row of exactly 4 stat cards, each taking equal width. Use a CSS grid with `grid-cols-4` and a gap of `gap-4` or `gap-6` depending on the mockup spacing.
- Each card is a dark-background container (`bg-[#0f0f23]` or your design system's card-bg token) with rounded corners, subtle border (`border border-white/5` or similar), and consistent internal padding.
- Inside each card, arrange from top to bottom:
  1. A colored circular icon container (roughly 40px diameter circle) using the appropriate Lucide icon. The circle background should be a muted version of the icon's color at low opacity.
  2. The stat label in uppercase, small font (11-12px), muted gray color, letter-spaced. Example: `"ACTIVE PLAYERS"`.
  3. The number in large bold text (28-36px), white.
  4. Optionally a small badge beneath the number. For card 1 (Active Players), show a green badge like `"+1 Active"`. For card 4 (Avg. Success Rate), show a gray badge like `"DC [avg] Avg"`. Cards 2 and 3 have no badge.

- **Card definitions (in order):**
  - Card 1: label "ACTIVE PLAYERS", icon `Users` from Lucide, icon circle color green-tinted, value is `playerCount`.
  - Card 2: label "NPCS CREATED", icon `UserPlus` from Lucide, icon circle color blue-tinted, value is `npcCount`.
  - Card 3: label "ENCOUNTERS", icon `Swords` from Lucide, icon circle color red/orange-tinted, value is `encounterCount`.
  - Card 4: label "AVG. SUCCESS RATE", icon `TrendingUp` from Lucide, icon circle color purple-tinted, value is `avgSuccessRate` formatted as a percentage.

- If a stat value is 0 or undefined, still render the card but show `"0"` in a muted/dimmed color rather than hiding the card.

---

#### 2.3.3 -- Next Encounter Card

**File:** `next-encounter-card.tsx` -- CREATE

**Props:** `encounter: { name: string, description: string, status: string, enemies: Array<{ name: string, hp: number, ac: number, attack: number }> } | null`

**Layout and styling instructions:**

- This component occupies the left column (approximately 60% width) of a two-column layout below the quick stats row.
- Dark card background, rounded corners, padding.
- **Header row:** Left-aligned bold heading "Next Encounter" in white, ~18px. To the right of it (or on the same line, right-aligned), render a status badge. If the encounter status is `"planned"`, show the text `"PLANNED"` inside a small pill/badge with a muted background and accent text color.
- **Encounter name:** Below the header, render the encounter name as a card sub-title, bold, ~16px, white.
- **Description:** Below the name, render the encounter description in muted gray text, ~14px, max 2-3 lines.
- **Enemy list:** Below the description, render each enemy as a row:
  - Left: a small red-tinted skull icon (use Lucide `Skull` icon, or if unavailable use a similar icon, tinted red).
  - Middle: enemy name in white, ~14px.
  - Right: stats string in a monospace font (JetBrains Mono or `font-mono`): `"HP: [X] | AC: [Y] | ATK: +[Z]"` in muted gray/green text.
  - Each enemy row should have a subtle bottom border or separator.
- **Footer:** At the bottom of the card, render a link-style text `"View Probability Cards"` followed by a right arrow, in the accent color. This does not need to navigate anywhere yet; it will be wired in Phase 3.
- **Empty state:** If `encounter` is `null`, render the card with the same header but replace the body content with centered muted text: `"No encounters planned yet"` and optionally a subtle icon.

---

#### 2.3.4 -- Party Overview

**File:** `party-overview.tsx` -- CREATE

**Props:** `members: Array<{ name: string, class: string, level: number, currentHp: number, maxHp: number, avatarUrl?: string }>`

**Layout and styling instructions:**

- This component occupies the right column (approximately 40% width) alongside the Next Encounter card.
- Dark card background, rounded corners, padding.
- **Header:** A row with a small purple-tinted icon (Lucide `Users` or `Shield`) on the left, then the heading "Party Overview" in bold white ~18px.
- **Member rows:** For each party member, render a horizontal row containing:
  1. A circular avatar image, 40px diameter. If `avatarUrl` is present, render the image. Otherwise, render a placeholder circle with the character's initials or a generic user icon. Use `next/image` with the avatar or a div with initials.
  2. To the right of the avatar, two lines stacked:
     - Top line: character name in bold white, ~14px.
     - Bottom line: class and level formatted as `"LV.[level] [CLASS]"` where class is uppercase and colored in the accent/purple color. Font size ~12px.
  3. Far right of the row: HP text `"[currentHp]/[maxHp] HP"` in ~12px.
  4. Below the HP text (or spanning the row width below the name), render a thin HP bar (4-6px height, full row width or partial width). The bar's fill color depends on the HP percentage:
     - Above 60%: green (`bg-green-500`).
     - Between 30% and 60%: yellow/amber (`bg-yellow-500`).
     - Below 30%: red (`bg-red-500`).
     - The bar background (unfilled portion) should be a very dark gray.
  - Rows should have subtle separators between them (a thin border or spacing).
- **Empty state:** If the `members` array is empty, show centered muted text: `"No party members yet"`.

---

#### 2.3.5 -- Recent Notes Row

**File:** `recent-notes-row.tsx` -- CREATE

**Props:** `notes: Array<{ id: string, title: string, content: string, tag: string, createdAt: string, authorName: string }>`

**Layout and styling instructions:**

- Full-width section below the encounter/party two-column area.
- **Header row:** "Recent Notes" bold heading on the left. On the right, a link-style text `"VIEW ALL"` followed by a right arrow, in accent color. The "VIEW ALL" link navigates to `/notes` (or wherever the notes page will be).
- **Note cards:** Render 2-3 cards in a horizontal row (grid `grid-cols-3` or flex with equal sizing). Each card:
  - Dark card background, rounded corners, padding.
  - Top: a small colored tag badge (use different subtle background colors per tag category -- e.g., blue for "Session", green for "Quest", purple for "Lore"). The tag text should be uppercase, ~10-11px.
  - Middle: the note title in bold white, ~14-15px. Below it, a truncated preview of the content in muted gray, ~13px, max 2 lines (use `line-clamp-2`).
  - Bottom: relative timestamp in small muted text (e.g., "2 hours ago", "Yesterday"). Use a date formatting utility.
- **Empty state:** If no notes, show a single full-width muted message: `"Start documenting your campaign"` with a subtle icon.

---

#### 2.3.6 -- DM Dashboard Compositor

**File:** `dm-dashboard.tsx` -- CREATE

**Props:** Accept all the data objects needed by the child components (campaign, stats, encounter, party members, notes).

**Instructions:**

- This is a purely compositional component. It arranges the sub-components in the correct layout order:
  1. `<HeroBanner />` -- full width.
  2. `<QuickStats />` -- full width, 4-column grid.
  3. A two-column flex/grid row: `<NextEncounterCard />` (left, ~60%) and `<PartyOverview />` (right, ~40%).
  4. `<RecentNotesRow />` -- full width.
- Use a vertical flex column or stack with consistent gap (`gap-6` or similar) between each section.
- Pass the appropriate data props down to each child.
