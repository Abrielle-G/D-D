# 🎲 Dice & Decisions

**A probability-powered Dungeon Master Command Center for homebrew RPGs.**

> _Where Bayesian thinking meets dragon slaying._

---

## 📋 Overview

Dice & Decisions is a polished web application that combines **campaign management** with **real-time probability visualization** — helping new and beginner D&D players understand dice probability, outcome likelihood, and the math behind their choices.

DMs get a centralized, modern tool to manage campaigns while teaching probability through gameplay. Players get a simplified, approachable interface that demystifies dice rolls and decision-making.

**Built as a school project for a probability class**, with a focus on making abstract math tangible through RPG gameplay.

---

## ✨ Key Features

### 🎯 Probability Engine & Cards

Visual cards showing the likelihood of success for any dice-based action — color-coded, with outcome breakdowns (critical fail → critical success) and interactive distribution charts.

### 🧠 Bayes Analyzer

An educational Bayesian probability tool with pre-built RPG scenarios (_"Is this chest trapped?"_). Sliders control prior/likelihood inputs and the posterior probability updates live, with a full formula breakdown and tree diagram.

### 📊 Dice Distribution Visualizer

Interactive charts showing probability distributions for any dice combination (1d20, 2d6, 3d8+5). Compare mode lets users visually understand why 2d6 ≠ 1d12.

### 🛡️ Simplified Character Sheet

Beginner-friendly character sheets with the six core stats, auto-calculated modifiers, HP ring, weapons, abilities, and inventory — no D&D expertise required.

### 📝 Campaign Management

- **NPC Manager** — Card-based NPC dossiers with status tracking
- **Encounter Builder** — Create encounters with auto-generated probability cards
- **Story Notes** — Rich-text note-taking with tagging (Session Log, World Lore, Plot, DM Secret)
- **Campaign Map Viewer** — Upload maps, place interactive markers with fog-of-war toggling

### 🏰 Tower of Fate — Demo Campaign

A pre-built starter campaign that ships with the app, showcasing all features with pre-configured NPCs, encounters, Bayes scenarios, and dungeon maps.

### 🎨 Campaign Theme Switcher

5 genre themes that re-skin the **entire app** instantly via CSS custom properties — zero page reload, zero flash. Each theme has its own full color palette (backgrounds, sidebars, borders, text hierarchy, accent glow) and is saved to localStorage so it persists across sessions.

| Theme                  | Accent           | Background             | Text             | Feel                            |
| ---------------------- | ---------------- | ---------------------- | ---------------- | ------------------------------- |
| 🏰 Fantasy _(default)_ | `#7c3aed` purple | `#0a0a0f` midnight     | `#f1f5f9` slate  | Arcane, magical, medieval       |
| 🚀 Sci-Fi              | `#06b6d4` cyan   | `#080d14` dark navy    | `#e2e8f0` cool   | Neon, holographic, futuristic   |
| 🤠 Western             | `#d97706` amber  | `#0f0b08` warm black   | `#fef3c7` sepia  | Dusty, rugged, weathered        |
| 👁️ Eldritch Horror     | `#16a34a` green  | `#080d08` void green   | `#dcfce7` pallid | Unsettling, Lovecraftian, eerie |
| ⚙️ Steampunk           | `#ca8a04` gold   | `#0d0a06` dark bronze  | `#fef9ec` brass  | Brass, gears, Victorian         |

Switched from **Settings → System Preferences**. Active theme is highlighted with a selected card + accent-colored border.

---

## 🎭 User Roles

|                       | Dungeon Master                                            | Player                                       |
| --------------------- | --------------------------------------------------------- | -------------------------------------------- |
| **Dashboard**         | Full campaign overview with stats, encounters, party info | Character-focused cockpit with campaign feed |
| **Probability Tools** | Create & manage probability cards for encounters          | View cards and use the dice visualizer       |
| **Campaign Data**     | Full CRUD on NPCs, encounters, story notes, maps          | Read-only campaign feed                      |
| **Character Sheets**  | View & edit any player's sheet                            | Edit own character sheet                     |

---

## 🛠️ Tech Stack

| Layer               | Technology                                        |
| ------------------- | ------------------------------------------------- |
| **Frontend**        | Next.js 14+ (App Router) · React 18 · TypeScript  |
| **Styling**         | Tailwind CSS 3 · shadcn/ui                        |
| **Charts**          | Recharts + custom SVG                             |
| **Rich Text**       | Tiptap                                            |
| **State**           | Zustand (local state + localStorage persistence)  |
| **Forms**           | React Hook Form · Zod                             |
| **Icons**           | Lucide React                                      |
| **Toasts**          | Sonner                                            |
| **Map Interaction** | CSS transforms + native event handlers            |
| **Hosting**         | Vercel                                            |

---

## 🎨 Design

**Aesthetic:** _"Arcane Dashboard"_ — D&D Beyond meets Linear meets Notion. Premium dark-mode RPG dashboard that feels like a polished SaaS product.

- **Typography:** Space Grotesk (headings) · DM Sans (body) · JetBrains Mono (dice/stats/numbers)
- **Dark-mode only** across all 5 genre themes
- Responsive: desktop sidebar → tablet icon-rail → mobile bottom nav

---

## 🖼️ Asset Folder — PROBA PROJECT

The `PROBA PROJECT-20260315T154736Z-3-001/PROBA PROJECT/` folder (at the `D-D/` root level) contains all user-provided backdrop images, fonts, icon packs, and design/animation assets organized by theme. The executing agent processes these in **Phase 0.22** — copying backdrops to `public/images/themes/`, extracting fonts to `public/fonts/`, and extracting icon packs to `public/images/icons/`.

| Theme | Backdrop Image | Custom Fonts | Icon Packs | Extra Assets |
| ---------------------- | --------------------------------- | ------------------------------------------- | ----------------------------------------- | ---------------------------------- |
| 🏰 Fantasy | `Fantasy/fantasy.jpg` | `Almendra_Display.zip` | medieval-fantasy, creature, game-icons.net | — |
| 🚀 Sci-Fi | `Sci-Fi/scifi.jpg` | — | — | — |
| ⚙️ Steampunk | `Steampunk/backdrop_steampunk.jpg` | — | — | — |
| 🤠 Western | `Western/vecteezy_flat-western-background.../` JPG | `Ewert,Rye,Sancreek,Smokum.zip` | `western.png.zip` | `Wild West.zip` designs |
| 👁️ Eldritch Horror | `Eldritch Horror/eldritchbackdrop.jpg` | `dark_theme_fonts.zip` | `dark_theme_icons.zip` | Animations + dungeon designs + GIF pack |

**Destination paths after copying/extracting:**

| Asset Category | Public Path |
| ------------------- | --------------------------------- |
| Theme backdrops | `public/images/themes/*.jpg` |
| Theme icon packs | `public/images/icons/{theme}/` |
| Custom theme fonts | `public/fonts/` |
| Animation / design assets | `public/images/designs/{theme}/` |

> **Licensing note:** The Western backdrop is a Vecteezy image. Review `Vecteezy-License-Information.pdf` inside the Western folder before publishing — the free Vecteezy license covers personal and educational use.

See **Phase 0.22** for step-by-step copy and extraction instructions.

---

## 📅 Project Timeline

| Phase | Focus                                | Dates                          |
| ----- | ------------------------------------ | ------------------------------ |
| 0–1   | Setup, core UI shell                 | Mar 11–17 ← **In Progress** ✅ |
| 2     | **Probability Engine** _(prototype)_ | Mar 18–22 🎯                   |
| 3–4   | Campaign management + demo content   | Mar 23–29                      |
| 5–6   | Polish, testing, final submission    | Mar 30 – **Apr 3** 🚀          |

---

## 📂 Project Documents

| File                                                     | Description                                                              |
| -------------------------------------------------------- | ------------------------------------------------------------------------ |
| [`implementation_guide.md`](./implementation_guide.md)   | **Agent master file** — design tokens, UI reference, phase instructions, mockup-to-screen mappings |
| [`project_specification.md`](./project_specification.md) | Full project spec — features, data model, architecture, design system    |
| `phases/`                                                | Step-by-step agent instruction files, organized by phase (phase-0 → phase-7) |
| `stitch_proba_project/`                                  | Stitch HTML samples — use as UI/code reference                           |
| `PROBA PROJECT-20260315T154736Z-3-001/PROBA PROJECT/`    | User-provided backdrop images, fonts, and icon packs organized by theme (Fantasy, Sci-Fi, Steampunk, Western, Eldritch Horror) |

---

## 📄 License

School project — not licensed for commercial use.
