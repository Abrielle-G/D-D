# Dice & Decisions — Implementation Guide

> A probability-powered Dungeon Master Command Center for a homebrew D&D-style RPG.
> Built with Next.js 14+ · TypeScript · Tailwind CSS · shadcn/ui · Supabase · Recharts · Tiptap

---

## Project Overview

**What:** A responsive web app combining campaign management (NPCs, encounters, story notes, maps) with real-time probability visualization — showing players the chances of success/failure before they act. Features a Bayes Analyzer, probability cards, dice distribution charts, and a simplified character sheet designed for beginners.

**Who:** School project for a probability class. Two user roles: Dungeon Master (DM) and Player.

**Stack:** Next.js 14+ App Router, TypeScript strict, Tailwind CSS 3, shadcn/ui, Supabase (Auth + Postgres + RLS + Storage), Recharts, Tiptap, Vercel hosting.

**Scope:** MVP — Security tier: school project. Target: prototype by ~March 22, final by April 3.

**Design:** 12 pixel-perfect mockup screens in `stitch_proba_project/stitch_proba_project/`. Premium dark-mode RPG dashboard aesthetic. 5 genre themes (Fantasy, Sci-Fi, Western, Eldritch Horror, Steampunk). Must NOT look AI-generated.

---

## Design Reference

All mockup files are in `stitch_proba_project/stitch_proba_project/`. Each folder contains `code.html` (full markup) and `screen.png` (screenshot):

| Screen | Folder | Phase |
|---|---|---|
| Login / Sign Up | `dice_decisions_auth_refined/` | 1 |
| DM Dashboard | `dm_command_center_refined_fresh_copy/` | 2 |
| Player Dashboard | `player_dashboard_sidebar_synced/` | 2 |
| Probability Cards | `probability_cards_logo_refined/` | 3 |
| Dice Visualizer | `dice_visualizer_refined_style/` | 3 |
| Bayes Analyzer | `bayes_analyzer_textured_background/` | 3 |
| Character Sheet | `character_sheet_sidebar_reorganized/` | 4 |
| NPC Manager | `npc_manager_refined_header_icons/` | 4 |
| Encounter Builder | `encounter_builder_refined_styling/` | 4 |
| Story Notes | `story_notes_refined_style/` | 4 |
| Campaign Map | `campaign_map_updated_card_color/` | 5 |
| Settings | `settings_map_icon_fixed/` | 2 |

**Before starting any phase**, open the relevant `screen.png` files and read the `code.html` to extract exact colors, spacing, typography, and component patterns.

---

## Phase Overview

| Phase | Title | Focus | Key Features |
|---|---|---|---|
| **0** | [Scaffolding & Design System](./phases/phase-0-scaffolding.md) | Project setup, Tailwind config, theme system, sidebar, topbar, status bar, component library | Foundation for everything |
| **1** | [Authentication & Data Layer](./phases/phase-1-auth-data.md) | Supabase Auth, database schema (all 9 tables), RLS policies, role switcher | Features 3.1 |
| **2** | [Core UI Shell & Dashboard](./phases/phase-2-ui-shell.md) | DM Dashboard, Player Dashboard, Settings page, theme selector, responsive polish | Features 3.2, 3.12 |
| **3** | [Probability Engine](./phases/phase-3-probability-engine.md) | Probability Cards, Dice Visualizer (Recharts), Bayes Analyzer — core deliverable | Features 3.4, 3.5 |
| **4** | [Campaign Management](./phases/phase-4-campaign-management.md) | Character Sheet, NPC Manager, Encounter Builder, Story Notes (Tiptap) | Features 3.3, 3.6, 3.7, 3.8 |
| **5** | [Campaign Map Viewer](./phases/phase-5-map-viewer.md) | Map upload, pan/zoom, markers with DM/player visibility, marker popups | Feature 3.11 |
| **6** | [Tower of Fate Demo](./phases/phase-6-tower-of-fate.md) | Pre-built campaign seed data: 4 NPCs, 3 encounters, 5 notes, 2 Bayes scenarios, map + markers | Feature 3.10 |
| **7** | [Polish & Deployment](./phases/phase-7-polish-deploy.md) | Loading states, error handling, empty states, responsive QA, accessibility, animations, Vercel deploy | Launch readiness |

---

## Critical Path

```
Phase 0 ──→ Phase 1 ──→ Phase 2 ──→ Phase 3 ──────────→ Phase 6 ──→ Phase 7
                │                       │
                └──→ Phase 4 ───────────┤
                │                       │
                └──→ Phase 5 ───────────┘
```

- **Phases 0 → 1 → 2 → 3** are strictly sequential (each depends on the previous)
- **Phases 4 and 5** can start after Phase 1 (they need the database) but are best done after Phase 3 (Encounter Builder uses the probability engine)
- **Phase 6** requires all features (0–5) to be complete
- **Phase 7** is the final polish pass

**Prototype deadline (~March 22):** Phases 0 + 1 + 2 + 3 must be complete. This demonstrates: auth + dashboard shell + probability tools (cards, dice visualizer, Bayes analyzer).

---

## Execution Instructions

### For each phase:

1. **Read the phase file completely** before starting any work
2. **Study the referenced mockup screenshots** — open every `screen.png` and `code.html` listed
3. **Follow the steps in order** — they're sequenced by dependency
4. **Run the verification checklist** at the end — every item must pass before moving to the next phase
5. **Commit after each phase** — clean git history with one commit per phase

### Key rules:

- **No code in the guide** — the phase files contain INSTRUCTIONS, not code. You write the code.
- **Match the mockups** — the mockup `code.html` files contain the exact CSS values. Extract colors, sizes, spacing, and shadows from them.
- **Don't look AI-generated** — see the "Not AI-Generated" checklist in Phase 7 (Step 7.9) for specific audit points
- **User-provided assets** — the user will provide images and icons. Place them in `public/images/` subdirectories. Use CSS gradient fallbacks until assets are available.

---

## Tech Stack Quick Reference

| Tool | Purpose | Docs |
|---|---|---|
| Next.js 14+ (App Router) | Framework, SSR, file-based routing | nextjs.org/docs |
| TypeScript (strict) | Type safety | typescriptlang.org |
| Tailwind CSS 3 | Utility-first styling | tailwindcss.com |
| shadcn/ui | Component library (customized) | ui.shadcn.com |
| Supabase | Auth + PostgreSQL + RLS + Storage | supabase.com/docs |
| Recharts | Probability distribution charts | recharts.org |
| Tiptap | Rich text editor for story notes | tiptap.dev |
| Lucide React | Icon library | lucide.dev |
| Zustand | Client state management | zustand-demo.pmnd.rs |
| Zod | Schema validation | zod.dev |
| React Hook Form | Form management | react-hook-form.com |
| Vercel | Hosting & deployment | vercel.com/docs |

---

## Color System (Fantasy Theme — Default)

| Token | Hex | Usage |
|---|---|---|
| Background Base | `#0a0a0f` | Page backgrounds |
| Background Elevated | `#12121a` | Card surfaces |
| Background Sidebar | `#0d0d14` | Sidebar |
| Border | `#1e1e2e` | Card borders, dividers |
| Border Hover | `#2e2e4e` | Hover state borders |
| Accent Purple | `#7c3aed` | Primary accent, buttons, active states |
| Accent Cyan | `#06b6d4` | Secondary accent, data highlights |
| Success Green | `#22c55e` | High probability, active status, HP healthy |
| Warning Amber | `#eab308` | Medium probability, warning |
| Danger Red | `#ef4444` | Low probability, crit fail, danger |
| Text Primary | `#f1f5f9` | Headings, body text |
| Text Secondary | `#94a3b8` | Subtitles, descriptions |
| Text Muted | `#475569` | Labels, placeholders |
| Text Faint | `#3a3a5c` | Status bar, very subtle text |

---

## Typography System

| Role | Font Family | Weight | Size | Usage |
|---|---|---|---|---|
| Display | Georgia / serif | Bold | 28–36px | Page titles, hero headings, character names |
| Heading | Inter | Semibold | 18–24px | Section headings, card titles |
| Body | Inter | Regular | 14–16px | Paragraphs, descriptions, UI labels |
| Label | Inter | Semibold | 11–12px | Uppercase field labels, section headers, badges |
| Data | JetBrains Mono | Bold | 28–96px | Stat numbers, probabilities, dice notation |
| Code | JetBrains Mono | Regular | 11–14px | Status bar, system log, formulas |

---

## Post-Launch Checklist

After Phase 7 is complete and the app is deployed:

- [ ] Production URL is live and accessible
- [ ] All 12 mockup screens are reproduced faithfully with Tower of Fate data
- [ ] End-to-end smoke test passes (Phase 7, Step 7.12)
- [ ] Lighthouse scores: Performance 85+, Accessibility 90+, Best Practices 90+
- [ ] README with setup instructions committed
- [ ] Professor walkthrough prepared: show Probability Cards → Dice Visualizer → Bayes Analyzer → formula breakdowns
- [ ] Tower of Fate demo campaign fully populated and explorable
- [ ] Tested on mobile device (not just DevTools)
- [ ] All 5 themes work correctly end-to-end
- [ ] Zero console errors in production

---

*Generated by BuildCraft — Implementation Strategy Engine*
