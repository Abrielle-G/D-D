# Phase 0: Project Scaffolding, Design System & Tooling

## Context

This phase scaffolds the entire Next.js project, establishes the design system extracted from 12 HTML mockups, configures all tooling (TypeScript strict, ESLint, Prettier), sets up the 5-theme system via CSS custom properties, and creates the foundational component library (sidebar, topbar, status bar, cards, badges). Everything in Phases 1–7 depends on this being correct. The user has provided design mockups in `stitch_proba_project/stitch_proba_project/` — these are the pixel-perfect targets. The user has also provided theme-specific backdrop images, custom fonts, and icon packs in `PROBA PROJECT-20260315T154736Z-3-001/PROBA PROJECT/` — Step 0.22 handles copying these into `public/`. The app must NOT look AI-generated.

## Design Reference Files

The executing agent should study ALL of these mockup folders. Each contains a `code.html` (full markup with inline styles) and `screen.png` (screenshot). These are the pixel-perfect design targets:

| Mockup Folder | Screen |
|---|---|
| `dice_decisions_auth_refined/` | Login / Sign Up page |
| `dm_command_center_refined_fresh_copy/` | DM Dashboard |
| `player_dashboard_sidebar_synced/` | Player Dashboard |
| `probability_cards_logo_refined/` | Probability Cards |
| `dice_visualizer_refined_style/` | Dice Visualizer |
| `bayes_analyzer_textured_background/` | Bayes Analyzer |
| `character_sheet_sidebar_reorganized/` | Character Sheet |
| `npc_manager_refined_header_icons/` | NPC Manager |
| `encounter_builder_refined_styling/` | Encounter Builder |
| `story_notes_refined_style/` | Story Notes |
| `campaign_map_updated_card_color/` | Campaign Map |
| `settings_map_icon_fixed/` | Settings |

All mockups live under: `stitch_proba_project/stitch_proba_project/`

Before starting, the executing agent should open every `screen.png` and read every `code.html` to internalize the exact design language — colors, spacing, typography, card patterns, sidebar structure, active states, and micro-interactions.

## Prerequisites

- Node.js 18+ installed
- npm or pnpm
- GitHub account
- Supabase account (free tier)
- Vercel account (free tier)

## Directory Structure

```
dice-and-decisions/
├── public/
│   ├── fonts/
│   │   ├── Inter-Variable.woff2
│   │   └── JetBrainsMono-Variable.woff2
│   └── images/
│       ├── icons/          (theme icon packs from PROBA PROJECT — organized as icons/{theme}/)
│       ├── heroes/         (dashboard hero banner images)
│       ├── npcs/           (NPC portrait images)
│       ├── maps/           (campaign map images)
│       ├── themes/         (theme backdrop JPGs — fantasy-backdrop.jpg, scifi-backdrop.jpg, etc.)
│       └── designs/        (supplementary design/animation assets per theme)
├── src/
│   ├── app/
│   │   ├── layout.tsx                     (root layout — providers, fonts, metadata)
│   │   ├── page.tsx                       (redirect to /dashboard or /login)
│   │   ├── globals.css                    (theme CSS vars, noise texture, scrollbar, base styles)
│   │   ├── (auth)/
│   │   │   ├── layout.tsx                 (auth layout — no sidebar, centered)
│   │   │   ├── login/page.tsx             (placeholder)
│   │   │   └── signup/page.tsx            (placeholder)
│   │   └── (dashboard)/
│   │       ├── layout.tsx                 (sidebar + topbar + content + status bar)
│   │       ├── dashboard/page.tsx         (placeholder)
│   │       ├── probability/
│   │       │   ├── cards/page.tsx         (placeholder)
│   │       │   ├── dice-visualizer/page.tsx
│   │       │   └── bayes-analyzer/page.tsx
│   │       ├── campaign/
│   │       │   ├── story-notes/page.tsx   (placeholder)
│   │       │   ├── encounters/page.tsx    (placeholder)
│   │       │   └── npcs/page.tsx          (placeholder)
│   │       ├── maps/page.tsx              (placeholder)
│   │       ├── characters/page.tsx        (placeholder)
│   │       └── settings/page.tsx          (placeholder)
│   ├── components/
│   │   ├── ui/                            (shadcn/ui components — customized)
│   │   ├── layout/
│   │   │   ├── sidebar.tsx
│   │   │   ├── topbar.tsx
│   │   │   ├── mobile-nav.tsx
│   │   │   └── status-bar.tsx
│   │   ├── shared/
│   │   │   ├── rpg-card.tsx
│   │   │   ├── badge-rpg.tsx
│   │   │   ├── stat-display.tsx
│   │   │   ├── empty-state.tsx
│   │   │   └── d20-logo.tsx
│   │   └── providers/
│   │       ├── theme-provider.tsx
│   │       └── role-provider.tsx
│   ├── lib/
│   │   ├── supabase/
│   │   │   ├── client.ts                  (browser Supabase client)
│   │   │   ├── server.ts                  (server Supabase client)
│   │   │   └── middleware.ts              (session refresh helper)
│   │   ├── utils.ts                       (cn() helper)
│   │   └── constants.ts                   (dice types, NPC roles, note tags, etc.)
│   ├── hooks/
│   │   ├── use-role.ts
│   │   └── use-theme.ts
│   ├── types/
│   │   └── index.ts                       (shared UI types)
│   └── styles/
│       └── themes.ts                      (5 theme config objects)
├── .env.local                             (gitignored, Supabase keys)
├── .env.example                           (committed, placeholder keys)
├── .eslintrc.json
├── .prettierrc
├── tailwind.config.ts
├── tsconfig.json
├── next.config.js
└── package.json
```

## Subphases

| File | Step |
|---|---|
| [phase-0.1.md](./phase-0.1.md) | Step 0.1 — Initialize Next.js Project |
| [phase-0.2.md](./phase-0.2.md) | Step 0.2 — Configure TypeScript Strict Mode |
| [phase-0.3.md](./phase-0.3.md) | Step 0.3 — Configure Tailwind with Custom Design Tokens |
| [phase-0.4.md](./phase-0.4.md) | Step 0.4 — Create Global Styles, Theme System & Noise Texture |
| [phase-0.5.md](./phase-0.5.md) | Step 0.5 — Set Up shadcn/ui |
| [phase-0.6.md](./phase-0.6.md) | Step 0.6 — Create Theme Configuration Objects |
| [phase-0.7.md](./phase-0.7.md) | Step 0.7 — Create the Theme Provider |
| [phase-0.8.md](./phase-0.8.md) | Step 0.8 — Create the Role Provider |
| [phase-0.9.md](./phase-0.9.md) | Step 0.9 — Create the Sidebar Component |
| [phase-0.10.md](./phase-0.10.md) | Step 0.10 — Create the Topbar Component |
| [phase-0.11.md](./phase-0.11.md) | Step 0.11 — Create the Status Bar Component |
| [phase-0.12.md](./phase-0.12.md) | Step 0.12 — Create the Dashboard Layout |
| [phase-0.13.md](./phase-0.13.md) | Step 0.13 — Create Mobile Bottom Navigation |
| [phase-0.14.md](./phase-0.14.md) | Step 0.14 — Create the RPG Card Component |
| [phase-0.15.md](./phase-0.15.md) | Step 0.15 — Create the RPG Badge Component |
| [phase-0.16.md](./phase-0.16.md) | Step 0.16 — Create Stat Display Component |
| [phase-0.17.md](./phase-0.17.md) | Step 0.17 — Create Empty State Component |
| [phase-0.18.md](./phase-0.18.md) | Step 0.18 — Create D20 Logo Component |
| [phase-0.19.md](./phase-0.19.md) | Step 0.19 — Create Placeholder Pages |
| [phase-0.20.md](./phase-0.20.md) | Step 0.20 — Utility Functions, Constants & Types |
| [phase-0.21.md](./phase-0.21.md) | Step 0.21 — ESLint, Prettier & Environment Variables |
| [phase-0.22.md](./phase-0.22.md) | Step 0.22 — User-Provided Assets Setup |

## Verification Checklist

After completing this phase, confirm:

- [ ] `npm run dev` starts the development server on `localhost:3000` without errors
- [ ] `npx tsc --noEmit` compiles with zero TypeScript errors
- [ ] `npm run lint` passes with zero errors
- [ ] The sidebar renders on the left with all 5 navigation groups (OVERVIEW, PROBABILITY, CAMPAIGN, WORLD, CHARACTERS)
- [ ] Clicking each sidebar nav item navigates to the correct placeholder page
- [ ] The active sidebar item shows: purple left border + tinted background + cyan/accent text color
- [ ] The sidebar collapses to icon-only mode at tablet width (768–1023px) with smooth 200ms transition
- [ ] On mobile (≤767px), the sidebar is hidden and a bottom navigation bar appears
- [ ] The topbar renders with the correct page title and frosted glass backdrop blur
- [ ] The status bar renders at the bottom with monospace text in muted gray
- [ ] Changing the `data-theme` attribute on `<html>` to any of the 5 values changes all accent colors throughout the app
- [ ] The noise texture overlay is visible (very subtle grain on the background — zoom in to 200% to verify)
- [ ] The RPG card component renders with: dark elevated bg, subtle border, shadow, hover lift effect
- [ ] Font rendering: Inter for body text, JetBrains Mono for any stat/number placeholders, serif display font for page titles
- [ ] `.env.example` exists with all 3 Supabase variables documented
- [ ] `.env.local` is gitignored
- [ ] The design feels dark, premium, RPG-themed — NOT like a default Next.js template
- [ ] All 5 theme color schemes apply correctly when `data-theme` is changed manually in DevTools

## Rollback Plan

If this phase breaks something:
- Delete the entire `dice-and-decisions/` directory and re-run `create-next-app` from scratch
- The only external dependency at this point is the Supabase project — that remains unaffected by local code changes
- Fonts can be re-downloaded

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| `create-next-app` fails or hangs | Node.js version too old | Ensure Node.js 18+ is installed: `node --version` |
| Tailwind classes not applying | `content` paths wrong in config | Ensure `content` in `tailwind.config.ts` includes `'./src/**/*.{ts,tsx}'` |
| Fonts not loading / FOUT | Font files missing or `next/font/local` misconfigured | Verify `.woff2` files exist in `public/fonts/`, verify `@font-face` in `globals.css`, verify `next/font/local` setup in `layout.tsx` |
| shadcn components look default/generic | CSS variable overrides not applied or specificity issue | Ensure the RPG theme CSS variables in `globals.css` are in `@layer base` and override the shadcn-generated variables. The RPG values must come AFTER the shadcn defaults. |
| Noise texture not visible | Opacity too low or z-index wrong | Check `body::before`: must be `position: fixed`, `inset: 0`, `z-index: 50`, `pointer-events: none`, `opacity: 0.03`. Zoom to 200% to see the subtle grain. |
| Theme switching doesn't work | `data-theme` selectors don't match | Verify each `[data-theme="scifi"]` etc. selector in `globals.css` matches the exact string set on `<html>`. Check for typos. |
| Sidebar nav links don't navigate | `href` paths don't match file structure | Verify each `page.tsx` exists at the exact folder path matching the `href` in the sidebar (e.g., `/(dashboard)/probability/cards/page.tsx` for href `/probability/cards`) |
| Mobile nav not showing | Media query breakpoint wrong | Verify mobile nav uses `md:hidden` (hidden ≥768px) and sidebar uses `hidden md:flex` (visible ≥768px) |
| Custom scrollbar not styled | Browser doesn't support `::-webkit-scrollbar` | Firefox uses `scrollbar-width: thin; scrollbar-color: ...;` — add both webkit and Firefox variants |
