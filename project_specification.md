# Project Specification: Dice & Decisions

## 1. Executive Summary

- **Product:** Dice & Decisions — A probability-powered Dungeon Master Command Center for a homebrew D&D-style RPG
- **Problem:** New and beginner D&D players struggle to understand dice probability, outcome likelihood, and the math behind their choices. DMs lack a centralized, modern tool to manage campaigns while teaching probability through gameplay.
- **Solution:** A polished web app that combines campaign management (NPCs, encounters, story notes) with real-time probability visualization — showing players the chances of success/failure before they act. Features a Bayes Analyzer, probability cards, dice distribution charts, and a simplified character sheet designed for beginners.
- **Platform:** Responsive web app (laptop, tablet, phone)
- **Target Launch:** Prototype by ~March 22, 2026 · Final by April 3, 2026 (23 days from March 11)
- **Scope:** MVP (school project for probability class)

---

## 2. User Personas & Workflows

### **Dungeon Master (DM)**

- **Primary goal:** Prepare and run a campaign session with probability tools at their fingertips
- **Key workflow:**
  1. Log in → lands on **DM Dashboard** (campaign overview)
  2. **Prep phase:** Create/edit NPCs, write story notes, set up encounters with probability rules (e.g., "Goblin attack: player must roll ≥14 on d20 to dodge")
  3. **Live session:** Switch to **Session Mode** — track combat, trigger dice rolls, see real-time probability outcomes, manage initiative order
  4. **Post-session:** Review session log, update story notes, adjust encounters for next session
- **Frequency:** Multiple times per week (prep + live sessions)
- **Pain points:** Existing tools are either too complex (D&D Beyond for homebrew) or too basic (spreadsheets, paper notes)

### **Player**

- **Primary goal:** View their character, understand probability of outcomes, and engage with the campaign
- **Key workflow:**
  1. Log in → lands on **Player Dashboard** (character overview + campaign feed)
  2. View and edit their **own character sheet** (stats, inventory, notes)
  3. During live sessions: see **Probability Cards** showing outcome chances for their actions
  4. View dice distribution visualizations to learn the math behind rolls
- **Frequency:** During game sessions + occasional character management
- **Pain points:** New players are overwhelmed by complex character sheets and don't understand why "rolling a 12 on a d20" matters

---

## 3. Feature Specification

### MVP Features (Must Ship)

---

#### **3.1 Role Switcher (DM / Player Toggle)**

- **Description:** Global toggle in the header/sidebar to switch between DM mode and Player mode. Changes the entire UI experience.
- **User story:** "As a user, I want to switch between DM and Player views so that I can use the app in either role."
- **Inputs:** Toggle selection (DM or Player)
- **Outputs:** UI reconfigures — DM sees full management tools; Player sees read-only campaign data + editable character sheet
- **Business rules:**
  - DM mode shows all campaigns, NPCs, encounters, notes, full probability tools
  - Player mode shows only: their character sheet (editable), campaign info (read-only), probability visualizations (read-only)
  - Role preference persists in localStorage
- **Edge cases:** If a user has no character sheet created, Player mode prompts them to create one
- **Dependencies:** None (local state)

---

#### **3.2 Campaign Dashboard**

- **Description:** Central hub showing campaign overview. Card-based layout with sections for active quest, recent notes, party overview, and quick actions.
- **User story:** "As a DM, I want to see my campaign at a glance so I can quickly jump into prep or a live session."
- **Inputs:** None (auto-loads active campaign)
- **Outputs:** Card grid: Active Quest card, Party Members card, Recent Notes card, Next Encounter card, Quick Stats card
- **Business rules:**
  - DM sees all cards with full edit access
  - Players see a simplified version (active quest, their character summary, session notes)
  - Support for **one active campaign at a time** in MVP (multi-campaign is V1.1)
- **Edge cases:** New user with no campaign sees an onboarding wizard / "Create Your First Campaign" CTA
- **Dependencies:** Campaign data model

---

#### **3.3 Simplified Character Sheet**

- **Description:** A beginner-friendly character sheet with the essential D&D stats, pared down to reduce complexity.
- **User story:** "As a new player, I want a simple character sheet that shows me what matters without overwhelming me."
- **Fields (simplified from full D&D):**
  - **Identity:** Name, Race, Class, Level
  - **Core Stats (6):** Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma — each with a score and modifier
  - **Derived Stats:** Hit Points (current/max), Armor Class, Initiative Bonus, Speed
  - **Combat:** One primary weapon (name, damage dice, modifier), one secondary (optional)
  - **Abilities:** Up to 4 special abilities/spells (name + description)
  - **Inventory:** Simple list (item name, quantity) — max 15 slots
  - **Notes:** Free-text field for player notes
- **Business rules:**
  - Modifiers auto-calculate from ability scores using standard formula: `modifier = floor((score - 10) / 2)`
  - Players can only edit their own sheet
  - DM can view and edit any player's sheet
- **Edge cases:** Blank character → show placeholder prompts in each field ("Enter your character's name...")
- **Dependencies:** Local state (Zustand)

---

#### **3.4 Probability Engine & Probability Cards**

- **Description:** The core probability feature. Visual cards that show the likelihood of outcomes for any dice-based action.
- **User story:** "As a player, I want to see the probability of my action succeeding so I can make informed decisions."
- **Components:**
  - **Probability Card:** A styled card showing:
    - Action name (e.g., "Attack the Goblin")
    - Dice required (e.g., "d20 + 3")
    - Target number (Difficulty Class / DC, e.g., 15)
    - **Success probability** as a percentage and visual bar (e.g., "45% chance of success")
    - **Outcome breakdown:** Critical success (nat 20), success, failure, critical failure (nat 1)
  - **Dice Distribution Visualizer:** Interactive chart showing the probability distribution for any dice combination (1d20, 2d6, 3d8+5, etc.)
    - Bar chart or histogram
    - Hover to see exact probability per outcome
    - Compare distributions (e.g., 2d6 vs 1d12 side-by-side)
- **Inputs:**
  - Dice type and count (e.g., 2d6)
  - Modifier (e.g., +3)
  - Target number / DC (e.g., 15)
- **Outputs:**
  - Probability percentage
  - Visual probability bar (green/yellow/red zones)
  - Distribution chart
- **Business rules:**
  - Probability calculated using exact combinatorics (not simulation)
  - For single die: P(success) = (die_max - DC + 1 + modifier) / die_max
  - For multiple dice: use convolution of uniform distributions
  - Nat 1 always fails, nat 20 always succeeds (on d20 rolls) — display these as special cases
  - DM can create Probability Cards for encounters in advance
  - Players see Probability Cards during live sessions
- **Edge cases:**
  - Modifier so high that success is guaranteed → show "100% (Auto-Success)" with gold styling
  - Target so high it's impossible → show "0% (Impossible)" with red styling
  - Invalid dice input → validation error with helpful message
- **Dependencies:** None (pure math, client-side)

---

#### **3.5 Bayes Analyzer**

- **Description:** An educational Bayesian probability tool that updates beliefs based on new evidence. Demonstrates how prior knowledge + observed outcomes refine probability estimates.
- **User story:** "As a student learning probability, I want to see how Bayes' theorem works in a real RPG scenario so I understand conditional probability."
- **Scenarios (pre-built examples):**
  1. **"Is this chest trapped?"** — Prior: 30% of dungeon chests are trapped. Evidence: You notice scratch marks (60% of trapped chests have marks, 10% of safe chests do). Posterior: Updated probability using Bayes' theorem.
  2. **"Is the merchant lying?"** — Prior: 20% of merchants lie. Evidence: Their price is 50% above market (80% of liars overprice, 30% of honest merchants do). Posterior: Updated probability.
  3. **Custom scenario builder** — DM inputs their own prior, evidence, and likelihoods
- **Inputs:**
  - Prior probability P(A) — slider or number input (0-100%)
  - Likelihood P(B|A) — "probability of seeing this evidence IF the hypothesis is true"
  - Marginal P(B|¬A) — "probability of seeing this evidence IF the hypothesis is false"
- **Outputs:**
  - Posterior probability P(A|B) — calculated via Bayes' theorem
  - Visual: animated probability bar updating from prior → posterior
  - Step-by-step formula breakdown showing the math
  - Tree diagram / area model visualization
- **Business rules:**
  - Formula: P(A|B) = P(B|A) × P(A) / [P(B|A) × P(A) + P(B|¬A) × P(¬A)]
  - Show the formula with actual numbers plugged in
  - Allow "chaining" — use the posterior as a new prior with additional evidence
  - Pre-built RPG scenarios ship with the app for educational value
- **Edge cases:**
  - P(B) = 0 → display "Impossible evidence — cannot update" error
  - All inputs at 0% or 100% → handle gracefully with explanatory text
- **Dependencies:** None (pure math, client-side)

---

#### **3.6 NPC Manager**

- **Description:** Create and manage Non-Player Characters for the campaign.
- **User story:** "As a DM, I want to create and organize NPCs so I can reference them quickly during sessions."
- **Fields per NPC:**
  - Name, Race, Role (e.g., "Merchant", "Villain", "Quest Giver")
  - Description (free text)
  - Key stats (optional): HP, AC, Attack Bonus
  - Notes (free text — motivations, secrets, relationships)
  - Status: Active / Deceased / Hidden
- **Business rules:**
  - DM-only (players cannot see NPC list — unless DM reveals specific NPCs)
  - Searchable and filterable by role, status
  - Card-based layout consistent with the rest of the app
- **Edge cases:** Deleting an NPC referenced in an encounter should show a warning
- **Dependencies:** Campaign data model

---

#### **3.7 Story Notes & Session Log**

- **Description:** Rich-text note-taking for campaign planning and session logs.
- **User story:** "As a DM, I want to keep session notes organized so I can track the story across multiple sessions."
- **Features:**
  - Create notes with title + rich text body (bold, italic, bullet lists, headers)
  - Tag notes: "Session Log", "World Lore", "Plot", "DM Secret"
  - Chronological session log view
  - Player-visible notes vs. DM-only notes (toggle per note)
- **Business rules:**
  - Notes tagged "DM Secret" are never visible to Players
  - Notes tagged "Session Log" are visible to all
  - Rich text editor — use a lightweight library (e.g., Tiptap or similar)
- **Edge cases:** Empty note → don't save, show validation
- **Dependencies:** Local state, Campaign

---

#### **3.8 Encounter Builder**

- **Description:** Create encounters with enemies, difficulty ratings, and linked probability cards.
- **User story:** "As a DM, I want to set up encounters in advance so I can run combat smoothly during sessions."
- **Fields per Encounter:**
  - Name (e.g., "Goblin Ambush in the Forest")
  - Description / narrative text
  - Enemies: list of enemies (name, HP, AC, attack bonus, damage dice)
  - Difficulty Class (DC) for skill checks
  - Linked Probability Cards (auto-generated from enemy stats + player stats)
  - Status: Planned / Active / Completed
- **Business rules:**
  - When an encounter becomes "Active," probability cards auto-generate for each player-enemy matchup
  - DM can adjust DC and see probability update in real-time
- **Edge cases:** Encounter with no enemies → purely narrative encounter, no probability cards needed
- **Dependencies:** Probability Engine, NPC Manager (enemies can be pulled from NPCs)

---

#### **3.9 Sidebar Navigation**

- **Description:** Persistent sidebar with hierarchical navigation, inspired by D&D Beyond / Notion.
- **Sections:**
  - 🏠 Dashboard
  - 📊 Probability Tools (Probability Cards, Dice Visualizer, Bayes Analyzer)
  - ⚔️ Campaign (Story Notes, Encounters, NPCs) — DM only
  - 🗺️ Maps (Campaign Map Viewer)
  - 🧙 Characters (Character Sheet)
  - ⚙️ Settings (Role Switch, Profile, Theme Switcher)
- **Business rules:**
  - Collapses to icon-only on mobile
  - Campaign section hidden in Player mode
  - Active page highlighted
  - Smooth transitions

---

#### **3.10 Tower of Fate — Demo Campaign**

- **Description:** A pre-built campaign called "Tower of Fate" that ships with the app. Serves as a tutorial and demo showing all features in action.
- **Contents:**
  - 3-4 pre-built NPCs (e.g., a quest giver, a villain, a merchant, a mysterious guide)
  - 2-3 encounters with pre-configured probability cards
  - Story notes with lore about the Tower of Fate
  - 2 pre-built Bayes scenarios tied to the campaign
  - 1 demo map image (Tower of Fate dungeon) with pre-placed markers
- **Business rules:**
  - Available to all new users as a "starter campaign"
  - DM can duplicate and modify it
  - Read-only in its default state
- **Dependencies:** All other features

---

#### **3.11 Campaign Map Viewer**

- **Description:** Interactive map system where the DM uploads map images (world maps, dungeon floors, town layouts) and places markers/pins on points of interest. Players see the revealed map with labeled markers, giving a strong visual anchor to the campaign.
- **User story:** "As a DM, I want to upload maps and mark locations so my players can visually explore the campaign world."
- **Components:**
  - **Map Canvas:** Displays the uploaded map image with pan and zoom (pinch-to-zoom on mobile)
  - **Marker System:** DM places pins/markers on the map with:
    - Label (e.g., "Dragon's Lair", "Town of Ashfall")
    - Description (tooltip/popup on click)
    - Icon type (combat ⚔️, quest ❗, shop 🏪, danger ☠️, safe zone 🏠)
    - Visibility toggle: revealed / hidden from players
  - **Map Selector:** Sidebar or tab list showing all maps for the campaign (DM can have multiple maps: world map, dungeon level 1, dungeon level 2, etc.)
- **Inputs:**
  - Map image upload (JPG, PNG, WebP — max 5MB)
  - Marker position (x,y coordinates on the image, placed via click/tap)
  - Marker metadata (label, description, icon, visibility)
- **Outputs:**
  - Pannable/zoomable map with interactive markers
  - Click a marker → popup with label + description
  - DM view shows all markers (hidden ones displayed with reduced opacity)
  - Player view shows only revealed markers
- **Business rules:**
  - DM can upload multiple maps per campaign
  - DM can toggle marker visibility during live sessions ("fog of war" lite)
  - Maps stored as object URLs in local state (files are loaded into memory from local disk)
  - Image upload validates file type and size before loading
  - Markers are saved in local state, linked to a specific map
- **Edge cases:**
  - Image too large → show size limit error with compression suggestion
  - No maps uploaded → show placeholder with "Upload Your First Map" CTA
  - Mobile: use touch gestures for pan/zoom, long-press to place markers (DM mode)
- **Dependencies:** Local state, Campaign

---

#### **3.12 Campaign Theme Switcher**

- **Description:** A toggle that changes the entire visual vibe of the app — colors, accent tones, subtle background textures, and icon styling shift to match a chosen genre theme. The layout and structure stay the same, but the _feel_ transforms.
- **User story:** "As a DM, I want to switch the visual theme to match my campaign's genre so the tool feels immersive for my players."
- **Themes (MVP — 5 themes):**

| Theme                    | Accent Color           | Background Vibe                      | Feel                                    |
| ------------------------ | ---------------------- | ------------------------------------ | --------------------------------------- |
| 🏰 **Fantasy** (default) | `#7c3aed` purple       | Deep midnight blue-black             | Classic D&D — arcane, magical, medieval |
| 🚀 **Sci-Fi**            | `#06b6d4` cyan         | Dark navy with subtle grid lines     | Neon-tinged, holographic, futuristic    |
| 🤠 **Western**           | `#d97706` amber        | Warm dark brown-black                | Dusty, rugged, weathered parchment feel |
| 👁️ **Eldritch Horror**   | `#16a34a` sickly green | Near-black with dark green undertone | Unsettling, Lovecraftian, eerie         |
| ⚙️ **Steampunk**         | `#ca8a04` gold         | Dark bronze-brown                    | Brass, gears, Victorian industrial      |

- **What changes per theme:**
  - Primary accent color (buttons, active states, highlights)
  - Secondary accent color
  - Background tones (subtle hue shift, not a full palette rewrite)
  - Card border glow color
  - Sidebar active indicator color
  - Probability bar gradient colors
  - Subtle background texture/pattern (CSS repeating gradients — no image files)
- **What stays the same:** Layout, typography, component structure, all functionality
- **Inputs:** Theme selector (grid of theme cards in Settings, or a dropdown in the sidebar)
- **Outputs:** Entire app re-themes instantly via CSS custom properties
- **Business rules:**
  - Theme preference stored in localStorage
  - Theme applies immediately on selection (no page reload — CSS variables)
  - Default theme: Fantasy
  - All themes maintain WCAG AA contrast ratios for accessibility
  - Theme is cosmetic only — zero impact on game mechanics or data
- **Edge cases:**
  - New user → defaults to Fantasy theme
  - Missing localStorage value → graceful fallback to Fantasy
- **Technical approach:** CSS custom properties (`--color-accent`, `--color-bg-base`, etc.) defined per theme. Switching theme = swapping a `data-theme` attribute on `<html>`. Tailwind integrates with CSS variables. Zero JS overhead at runtime.
- **Dependencies:** None (pure CSS/styling)

---

### V1.1 Features (Post-Submission Enhancements)

- **Multi-campaign support** — DMs can manage more than one campaign
- **Initiative tracker** — automated turn-order for combat
- **Dice roller** — animated 3D dice rolling with physics
- **Loot tables** with probability distributions
- **Player-to-player visibility** — players can view each other's character sheets
- **Export to PDF** — character sheets, session logs
- **Campaign sharing** — invite players to a campaign via link code

### Future Considerations

- Real-time collaborative sessions via WebSockets (DM and players see updates live)
- Monte Carlo simulation mode (run 10,000 rolls and show empirical vs. theoretical distribution)
- AI-powered encounter suggestions based on party level/composition
- Mobile native app wrapper (Capacitor/PWA)
- Community campaign sharing marketplace

### Anti-Features (Explicitly Out of Scope for MVP)

- ❌ **Full D&D 5e SRD rules engine** — this is a homebrew tool, not a rules lawyer
- ❌ **Real-time multiplayer sync** — V1.1+ feature (MVP users refresh to see updates)
- ❌ **Voice/video chat integration** — use Discord/Zoom alongside
- ❌ **Full battle grid with token movement** — too complex; map viewer with markers is sufficient for MVP
- ❌ **Payment / monetization** — school project
- ❌ **Mobile native app** — web-only for MVP

---

## 4. Technical Architecture

### Stack

| Layer               | Technology                                       | Justification                                                                                                                                 |
| ------------------- | ------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------- |
| **Frontend**        | Next.js 14+ (App Router) + React 18 + TypeScript | SSR/SSG flexibility, file-based routing, React Server Components for performance, massive ecosystem                                           |
| **Styling**         | Tailwind CSS 3                                   | Utility-first, rapid prototyping, excellent responsive design support, easy dark mode                                                         |
| **UI Components**   | shadcn/ui                                        | Beautiful, accessible, customizable components built on Radix UI — perfect for the premium dashboard aesthetic                                |
| **Charts**          | Recharts + custom SVG                            | Lightweight, React-native charting for probability distributions and Bayes visualizations                                                     |
| **State / Storage** | Zustand + localStorage                           | Lightweight client state management with built-in persistence via localStorage — no backend required                                          |
| **Rich Text**       | Tiptap (headless editor)                         | Lightweight, extensible, works perfectly with React — for story notes                                                                         |
| **Map Interaction** | CSS transforms + event handlers                  | Pan/zoom via native browser APIs — lightweight, no extra library needed                                                                       |
| **Hosting**         | Vercel (free tier)                               | Optimized for Next.js, automatic previews, generous free tier                                                                                 |
| **CI/CD**           | Vercel Git Integration                           | Push to GitHub → auto deploy. Zero config.                                                                                                    |

### System Architecture

```
┌─────────────────────────────────────────────────────┐
│                    BROWSER CLIENT                    │
│  Next.js App (React + TypeScript + Tailwind)         │
│  ┌──────────┐ ┌──────────┐ ┌────────────────────┐   │
│  │ Dashboard │ │ Prob.    │ │ Campaign Manager   │   │
│  │          │ │ Engine   │ │ (Notes/NPCs/Enc.)  │   │
│  └──────────┘ └──────────┘ └────────────────────┘   │
│  ┌──────────┐ ┌──────────┐ ┌────────────────────┐   │
│  │ Char.    │ │ Bayes    │ │ Role Switcher      │   │
│  │ Sheet    │ │ Analyzer │ │ (DM/Player)        │   │
│  └──────────┘ └──────────┘ └────────────────────┘   │
│                                                      │
│  ┌──────────────────────────────────────────────┐   │
│  │  Zustand Store (in-memory + localStorage)    │   │
│  │  All campaign, character, and app state      │   │
│  └──────────────────────────────────────────────┘   │
└──────────────────────┬──────────────────────────────┘
                       │ Vercel CDN / SSG
                       ▼
┌─────────────────────────────────────────────────────┐
│                    VERCEL                            │
│  Hosting + Edge Functions + CDN                      │
└─────────────────────────────────────────────────────┘
```

### Data Model (Key Entities)

> All data is stored in **Zustand** (in-memory) and persisted to **localStorage**. No backend, no database. IDs are generated client-side using `crypto.randomUUID()` or `nanoid`.

#### **AppSettings**

| Field          | Type    | Notes                                                                      |
| -------------- | ------- | -------------------------------------------------------------------------- |
| activeRole     | string  | `'dm'` \| `'player'`, default `'player'`                                   |
| selectedTheme  | string  | `'fantasy'` \| `'scifi'` \| `'western'` \| `'eldritch'` \| `'steampunk'`, default `'fantasy'` |

#### **Campaign**

| Field       | Type     | Notes                                              |
| ----------- | -------- | -------------------------------------------------- |
| id          | string   | `crypto.randomUUID()`                              |
| name        | string   | Required                                           |
| description | string   | Optional                                           |
| isTemplate  | boolean  | Default false (true for Tower of Fate)             |
| status      | string   | `'active'` \| `'archived'`                        |
| createdAt   | string   | ISO date string                                    |
| updatedAt   | string   | ISO date string                                    |

#### **Character**

| Field        | Type    | Notes                                        |
| ------------ | ------- | -------------------------------------------- |
| id           | string  | `crypto.randomUUID()`                        |
| campaignId   | string  | Reference to Campaign.id                     |
| name         | string  | Required                                     |
| race         | string  | Required                                     |
| charClass    | string  | Required                                     |
| level        | number  | Default 1, min 1, max 20                     |
| strength     | number  | 1–30, default 10                             |
| dexterity    | number  | 1–30, default 10                             |
| constitution | number  | 1–30, default 10                             |
| intelligence | number  | 1–30, default 10                             |
| wisdom       | number  | 1–30, default 10                             |
| charisma     | number  | 1–30, default 10                             |
| hpCurrent    | number  | Min 0                                        |
| hpMax        | number  | Min 1                                        |
| armorClass   | number  | Min 0                                        |
| speed        | number  | Default 30                                   |
| weapons      | array   | `{name, damageDice, modifier}[]`             |
| abilities    | array   | `{name, description}[]`                      |
| inventory    | array   | `{name, quantity}[]`                         |
| notes        | string  | Optional                                     |
| createdAt    | string  | ISO date string                              |

#### **NPC**

| Field               | Type    | Notes                                    |
| ------------------- | ------- | ---------------------------------------- |
| id                  | string  | `crypto.randomUUID()`                    |
| campaignId          | string  | Reference to Campaign.id                 |
| name                | string  | Required                                 |
| race                | string  | Optional                                 |
| role                | string  | Merchant, Villain, Quest Giver, etc.     |
| description         | string  | Optional                                 |
| hp                  | number  | Optional                                 |
| armorClass          | number  | Optional                                 |
| attackBonus         | number  | Optional                                 |
| notes               | string  | Optional                                 |
| status              | string  | `'active'` \| `'deceased'` \| `'hidden'` |
| isVisibleToPlayers  | boolean | Default false                            |
| createdAt           | string  | ISO date string                          |

#### **Encounter**

| Field           | Type    | Notes                                             |
| --------------- | ------- | ------------------------------------------------- |
| id              | string  | `crypto.randomUUID()`                             |
| campaignId      | string  | Reference to Campaign.id                          |
| name            | string  | Required                                          |
| description     | string  | Optional                                          |
| difficultyClass | number  | Min 1, max 30                                     |
| enemies         | array   | `{name, hp, ac, attackBonus, damageDice}[]`       |
| status          | string  | `'planned'` \| `'active'` \| `'completed'`        |
| createdAt       | string  | ISO date string                                   |

#### **Note**

| Field               | Type    | Notes                                                   |
| ------------------- | ------- | ------------------------------------------------------- |
| id                  | string  | `crypto.randomUUID()`                                   |
| campaignId          | string  | Reference to Campaign.id                                |
| title               | string  | Required                                                |
| content             | string  | Rich text (HTML from Tiptap)                            |
| tag                 | string  | `'session_log'` \| `'world_lore'` \| `'plot'` \| `'dm_secret'` |
| isVisibleToPlayers  | boolean | Default true (false for dm_secret)                      |
| sessionNumber       | number  | Optional                                                |
| createdAt           | string  | ISO date string                                         |

#### **BayesScenario**

| Field            | Type    | Notes                                          |
| ---------------- | ------- | ---------------------------------------------- |
| id               | string  | `crypto.randomUUID()`                          |
| campaignId       | string  | Optional (null for global/template scenarios)  |
| title            | string  | Required                                       |
| description      | string  | Required                                       |
| priorProbability | number  | 0.0–1.0                                        |
| likelihood       | number  | 0.0–1.0                                        |
| marginalFalse    | number  | 0.0–1.0                                        |
| isTemplate       | boolean | Default false                                  |
| createdAt        | string  | ISO date string                                |

#### **CampaignMap**

| Field      | Type   | Notes                                         |
| ---------- | ------ | --------------------------------------------- |
| id         | string | `crypto.randomUUID()`                         |
| campaignId | string | Reference to Campaign.id                      |
| name       | string | Required (e.g., "Tower of Fate — Level 1")    |
| imageData  | string | Base64-encoded image data URL                 |
| sortOrder  | number | Default 0 (for ordering maps in sidebar)      |
| createdAt  | string | ISO date string                               |

#### **MapMarker**

| Field               | Type    | Notes                                               |
| ------------------- | ------- | --------------------------------------------------- |
| id                  | string  | `crypto.randomUUID()`                               |
| mapId               | string  | Reference to CampaignMap.id                         |
| label               | string  | Required                                            |
| description         | string  | Optional                                            |
| iconType            | string  | `'combat'` \| `'quest'` \| `'shop'` \| `'danger'` \| `'safe'` |
| posX                | number  | 0.0–1.0 (percentage position on image)              |
| posY                | number  | 0.0–1.0 (percentage position on image)              |
| isVisibleToPlayers  | boolean | Default false                                       |
| createdAt           | string  | ISO date string                                     |

### API Design Philosophy

- **No backend, no API** — all data lives in Zustand stores persisted to localStorage
- All probability calculations run **client-side** (pure math, no server needed)
- All CRUD operations are synchronous Zustand store mutations that auto-persist to localStorage
- Error handling: validate with Zod before writes; display user-friendly error toasts on validation failure
- Data export/import: users can export their campaign as a JSON file and re-import it

### Third-Party Integrations

| Service      | Purpose                           | Tier/Cost                             |
| ------------ | --------------------------------- | ------------------------------------- |
| Vercel       | Hosting + CDN + Serverless        | Free (100GB bandwidth)                |
| Google Fonts | Typography (Inter/JetBrains Mono) | Free                                  |
| Recharts     | Probability visualizations        | Free (MIT)                            |
| Tiptap       | Rich text editor for notes        | Free (open source)                    |
| shadcn/ui    | UI component library              | Free (open source)                    |

---

## 5. Design Direction

- **Aesthetic:** Premium dark-mode RPG dashboard. Think **D&D Beyond** meets **Notion** meets **Linear**. Clean, structured, intentional. No fantasy wallpapers or cheesy medieval fonts. This should feel like a **polished SaaS product** that happens to manage a fantasy game.
- **Color palette:**
  - **Background (Primary):** `#0a0a0f` (near-black with blue undertone)
  - **Background (Elevated/Cards):** `#12121a` (slightly lighter for card surfaces)
  - **Background (Sidebar):** `#0d0d14`
  - **Border/Divider:** `#1e1e2e` (subtle separation)
  - **Primary Accent:** `#7c3aed` (vibrant purple — magic/arcane feel)
  - **Secondary Accent:** `#06b6d4` (cyan — probability/data feel)
  - **Success:** `#22c55e` (green for high probability)
  - **Warning:** `#eab308` (amber for medium probability)
  - **Danger:** `#ef4444` (red for low probability / critical failure)
  - **Text Primary:** `#f1f5f9` (near-white)
  - **Text Secondary:** `#94a3b8` (muted gray-blue)
  - **Text Muted:** `#475569` (darker gray)
- **Typography:**
  - **Headings:** `Inter` (clean, modern, highly legible at all sizes)
  - **Body:** `Inter`
  - **Monospace (dice/stats):** `JetBrains Mono` (for probability numbers, dice notations, stat values)
- **Themes:** Dark mode only (all themes are dark-base) with 5 genre themes: Fantasy, Sci-Fi, Western, Eldritch Horror, Steampunk. Theme switching via CSS custom properties — see Feature 3.12.
- **Key screens (priority order):**
  1. DM Dashboard (campaign overview with cards)
  2. Probability Tools (dice visualizer + probability cards)
  3. Bayes Analyzer (interactive educational tool)
  4. Campaign Map Viewer (uploadable maps + interactive markers)
  5. Character Sheet (simplified, editable)
  6. NPC Manager (card grid)
  7. Encounter Builder (form + linked probability cards)
  8. Story Notes (list + editor)
  9. Settings (role switch, theme)
- **Responsive strategy:**
  - **Desktop (≥1024px):** Full sidebar + main content area
  - **Tablet (768px–1023px):** Collapsible sidebar (icon-only), full content
  - **Mobile (≤767px):** Bottom navigation bar, stacked cards, no sidebar
- **Animation/motion:** Subtle transitions only — card hover lifts, page transitions, probability bar animations. No heavy animation.
- **Card design:** Rounded corners (8px), subtle border (`#1e1e2e`), slight shadow (`0 4px 20px rgba(0,0,0,0.3)`), hover: slight elevation + brighter border

---

## 6. Security & Compliance

- **Security tier:** MVP / School Project
- **No authentication required** — the app runs entirely client-side with no user accounts
- **Role switching:** DM/Player role stored in localStorage; accessible to anyone using the app on that device
- **Data handling:**
  - All data stored in localStorage (browser-only, never transmitted)
  - No PII collected — no accounts, no emails, no passwords
  - No payment data
  - No environment secrets needed (no external services)
- **HTTPS:** Enforced by Vercel for production deployment
- **Rate limiting:** Not applicable (no server-side endpoints)
- **Audit logging:** Not required for MVP

---

## 7. Infrastructure & DevOps

- **Environments:**
  - **Development:** Local (`npm run dev`) — no external services needed
  - **Production:** Vercel deployment (static/SSG Next.js app)
  - No staging needed for a school project
- **Deployment strategy:**
  - GitHub repo → Vercel Git Integration → auto-deploy on push to `main`
  - Preview deployments on PRs (automatic with Vercel)
- **Monitoring:**
  - Vercel Analytics (free tier — Core Web Vitals)
  - Browser console for debugging
- **Backup:** Users can export their campaign data as JSON at any time
- **Scaling:** Not a concern — school project with <50 users, fully static

---

## 8. Project Phases & Milestones

| Phase | Focus                   | Duration                 | Key Deliverables                                                                                                                                                       |
| ----- | ----------------------- | ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **0** | Project setup & tooling | Day 1-2 (Mar 11-12)      | Next.js scaffold, Tailwind config, GitHub repo, Vercel deployment, design system (colors, typography, card components)                                                 |
| **1** | Core UI Shell           | Day 3-5 (Mar 13-15)      | Sidebar navigation, dashboard layout, role switcher (DM/Player), responsive breakpoints, card component system, empty states                                           |
| **2** | Probability Engine      | Day 6-10 (Mar 16-22)     | Probability calculator, Probability Cards UI, Dice Distribution Visualizer (Recharts), Bayes Analyzer with pre-built scenarios — **🎯 PROTOTYPE DEADLINE (~March 22)** |
| **3** | Campaign Management     | Day 11-15 (Mar 23-27)    | Character sheet (CRUD), NPC manager (CRUD), Story Notes (rich text with Tiptap), Encounter Builder, Campaign Map Viewer (image upload + markers)                       |
| **4** | Tower of Fate Demo      | Day 16-17 (Mar 28-29)    | Pre-built campaign data (NPCs, encounters, story notes, Bayes scenarios), seeding via initial store state                                                              |
| **5** | Polish & Testing        | Day 18-20 (Mar 30-Apr 1) | Responsive QA, bug fixes, loading states, error handling, empty states, transitions                                                                                    |
| **6** | Final Submission        | Day 21-22 (Apr 2-3)      | Final deployment, README, project documentation, demo walkthrough                                                                                                      |

> [!IMPORTANT]
> **Prototype (Phase 2 deadline ~March 22):** The prototype should demonstrate the **probability tools** (probability cards, dice visualizer, Bayes Analyzer) + the **dashboard shell**. Campaign management features come after.

---

## 9. Open Questions & Risks

### Open Questions

- [ ] Will design mockups (from Google Stitch) arrive before or during development? If delayed, we proceed with the design system defined in this spec.
- [ ] Does the professor require specific probability concepts to be demonstrated? (e.g., must include expected value, variance, or specific theorems beyond Bayes)
- [ ] Should the Tower of Fate campaign content be educational (explaining probability concepts in-story) or purely gameplay?
- [ ] How many players need to be supported per campaign? (MVP default: up to 6)

### Technical Risks

| Risk                                        | Impact                                 | Mitigation                                                                             |
| ------------------------------------------- | -------------------------------------- | -------------------------------------------------------------------------------------- |
| localStorage size limit (~5MB)              | Large campaigns with map images may exceed limit | Store map images as compressed base64 or use IndexedDB for large assets   |
| Tailwind + shadcn/ui learning curve         | Slower UI development                  | Both have excellent docs, component copy-paste workflow                                |
| Rich text editor complexity (Tiptap)        | Story notes take too long to implement | Fall back to plain textarea with Markdown if Tiptap is too complex                     |
| Responsive design takes longer than planned | Mobile experience incomplete           | Prioritize desktop/laptop first, mobile as stretch goal                                |
| Design mockups arrive late                  | Misalignment with designer's vision    | Start with spec's design system, refactor when mockups land                            |

---

## 10. Success Metrics

| Metric                                         | Target                                                                            | How to Measure                                |
| ---------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------- |
| **All probability tools functional**           | Probability Cards, Dice Visualizer, Bayes Analyzer working correctly              | Manual testing of calculations                |
| **Professor can understand probability demos** | Bayes Analyzer shows formula breakdown, distribution charts are clear             | Professor feedback                            |
| **Beginner-friendly**                          | New player can create a character and understand a probability card in <2 minutes | User testing with a classmate                 |
| **Responsive**                                 | Usable on laptop and phone                                                        | Test on Chrome DevTools responsive mode       |
| **Professional aesthetic**                     | Looks like a real SaaS product                                                    | Visual comparison against D&D Beyond / Linear |
| **Prototype on time**                          | Probability tools + dashboard shell working by ~March 22                          | Deployed Vercel URL                           |
| **Final submission on time**                   | All MVP features working by April 3                                               | Deployed Vercel URL                           |

---

## 11. Recommended Skills

| Phase                 | Skills                                                                                           | Purpose                                                                        |
| --------------------- | ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| Phase 0: Setup        | `clean-code`, `cc-skill-coding-standards`, `environment-setup-guide`                             | Establish code standards, linting, project structure                           |
| Phase 1: Core UI      | `react-patterns`, `tailwind-patterns`, `ui-ux-pro-max`, `frontend-design`, `scroll-experience`   | Component architecture, styling system, premium design quality                 |
| Phase 2: Probability  | `javascript-mastery`, `claude-d3js-skill`, `react-ui-patterns`                                   | Math engine implementation, interactive chart visualizations, card UI patterns |
| Phase 3: Campaign     | `react-best-practices`, `cc-skill-frontend-patterns`, `nextjs-best-practices`                    | CRUD patterns, form handling, optimistic updates, local state                  |
| Phase 4: Demo Content | `documentation-templates`, `concise-planning`                                                    | Structured seed data, content organization                                     |
| Phase 5: Polish       | `web-performance-optimization`, `testing-patterns`, `lint-and-validate`, `web-design-guidelines` | Performance audit, cross-browser testing, responsive QA                        |
| Phase 6: Deploy       | `vercel-deployment`, `deployment-procedures`                                                     | Production deployment, domain setup                                            |
