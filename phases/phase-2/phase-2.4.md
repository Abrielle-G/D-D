# Phase 2.4 — Player Dashboard Components

Create all of the following files inside `src/components/dashboard/`.

---

#### 2.4.1 -- Character Banner

**File:** `character-banner.tsx` -- CREATE

**Props:** `character: { name: string, race: string, class: string, level: number, currentHp: number, maxHp: number, ac: number, initiative: number, speed: string, portraitUrl?: string } | null`

**Layout and styling instructions:**

- Full-width card, dark background, rounded corners.
- **If character is not null:**
  - Left side: large circular portrait image, approximately 80px diameter. If `portraitUrl` is provided, render the image. Otherwise, render a placeholder with character initials or a generic icon.
  - To the right of the portrait:
    - Character name in the display/serif font, large (~28-32px), bold, white.
    - Subtitle line: `"[Race] [Class] -- Level [N]"` where the level number is colored in the accent color. Font size ~14-16px, muted gray for the race/class text.
  - **Stat pills row:** Below the subtitle, render a horizontal row of 4 small pill-shaped badges with a gap between them. Each pill has a subtle dark background, rounded-full corners, internal padding, and contains:
    - An icon (small, ~14-16px) on the left.
    - A label and value on the right.
    - Pill 1: green `Heart` icon, text `"HP: [current]/[max]"`.
    - Pill 2: orange `Shield` icon, text `"AC: [ac]"`.
    - Pill 3: yellow/cyan `Zap` icon, text `"INIT: +[initiative]"`.
    - Pill 4: green `Footprints` (or a boot-like icon) icon, text `"SPD: [speed]"`.
  - **Buttons row:** Below the stat pills, two buttons:
    - "Edit Character" -- outlined/ghost variant.
    - "View Full Sheet" -- accent filled variant.
- **If character is null (empty state):**
  - Render the card with centered content: a large muted icon, heading `"Create Your Character"`, a brief description, and a prominent CTA button `"Get Started"` in accent color. This button navigates to the character creation page.

---

#### 2.4.2 -- Campaign Feed

**File:** `campaign-feed.tsx` -- CREATE

**Props:** `feedItems: Array<{ id: string, type: 'session_log' | 'quest' | 'map_update', title: string, description: string, category: string, timestamp: string }>`

**Layout and styling instructions:**

- Occupies the left column (~60% width) in a two-column layout.
- Dark card background, rounded corners, padding.
- **Header:** A row with a `Clock` icon (muted) on the left, "Campaign Feed" heading in bold white, and a "View All" link on the right in accent color.
- **Timeline:** A vertical list of feed items. Each item is laid out as:
  - Left: a vertical timeline line (thin, ~2px, muted dark gray) running the full height, with a circular icon node (small colored circle, ~32px) at each item's position. The circle icon and color vary by type:
    - `session_log`: a scroll/book icon, blue tint.
    - `quest`: a flag/sword icon, green tint.
    - `map_update`: a map icon, amber tint.
  - Right of the timeline: the item content:
    - Title in bold white ~14px.
    - A small category badge (colored pill matching the type color) next to or below the title.
    - Timestamp in muted gray ~12px.
    - Description text in muted gray ~13px, 1-2 lines max.
  - Subtle separator or spacing between items.
- **Empty state:** If `feedItems` is empty, show centered muted text: `"No campaign activity yet"` with a subtle icon.

---

#### 2.4.3 -- Probability Check Widget

**File:** `probability-check-widget.tsx` -- CREATE

**Props:** None required (self-contained with local state). Optionally accept a callback or router push for "Run Full Simulation".

**Layout and styling instructions:**

- Occupies the right column (~40% width) alongside the Campaign Feed.
- Dark card background, rounded corners, padding.
- **Header:** A `Grid3x3` (or `Dices`) icon on the left, "Probability Check" heading in bold white.
- **Quick form:** Below the header, render three input fields stacked vertically with labels:
  1. **"DICE TYPE"** label (uppercase, small, muted, letter-spaced). Below it, a dropdown/select (use shadcn/ui `Select` component) with options: d4, d6, d8, d10, d12, d20, d100. Default selected: d20.
  2. **"MODIFIER"** label. Below it, a number input (shadcn/ui `Input` with `type="number"`). Default value: 0. Allow negative numbers.
  3. **"TARGET DC"** label. Below it, a number input. Default value: 15.
- **Result display:** Below the form, a prominent result section:
  - Small muted label: `"SUCCESS PROBABILITY"`.
  - Large number: the calculated percentage, displayed at ~48px font size, in a gold/amber accent color. Example: `"45%"`. Append the word `"Success"` in smaller muted text next to or below the number.
  - Below the number, a horizontal segmented probability bar (full width, ~8-10px height, rounded). The bar is divided into three color segments: red on the left (failure zone), gray in the middle (borderline zone), and green on the right (success zone). The dividing point between red and green should correspond to the calculated probability.
- **Calculate button:** Below the bar, a full-width button `"Run Full Simulation"` in accent color. For now, this can navigate to the probability calculator page or be a no-op stub with a console log.
- **Calculation logic:** For the quick probability calculation, implement this formula:
  - Parse the die size from the dice type string (e.g., "d20" becomes 20).
  - Success probability = `(dieSize - (targetDC - modifier - 1)) / dieSize`, clamped between 0 and 1.
  - Display as a percentage rounded to the nearest integer.
  - This is a simplified version. The full simulation engine comes in Phase 3. Mark the calculation function with a `// TODO: Replace with Phase 3 probability engine` comment.
- This component must be a client component (`"use client"`) since it has interactive state.

---

#### 2.4.4 -- Inspiration Badge

**File:** `inspiration-badge.tsx` -- CREATE

**Props:** `hasInspiration: boolean`

**Layout and styling instructions:**

- A small card (can be placed above or below the probability widget, or in the character banner area -- match the mockup placement).
- If `hasInspiration` is true:
  - Dark card with a subtle green-tinted left border or top accent.
  - A green `Star` icon (Lucide) on the left, ~20px.
  - Text: `"Inspiration Available"` in green-tinted white, ~14px, semi-bold.
- If false:
  - Same card but fully muted. Gray star icon. Text: `"No Inspiration"` in muted gray.

---

#### 2.4.5 -- Player Dashboard Compositor

**File:** `player-dashboard.tsx` -- CREATE

**Props:** Accept all data objects needed by child components (character, feed items, inspiration status).

**Instructions:**

- Compositional component arranging:
  1. `<CharacterBanner />` -- full width.
  2. `<InspirationBadge />` -- full width (small).
  3. A two-column flex/grid row: `<CampaignFeed />` (left, ~60%) and `<ProbabilityCheckWidget />` (right, ~40%).
- Vertical flex column with consistent gap.
