# Phase 7: Polish, Responsive QA, Error Handling & Deployment

## Context

This is the final phase — the difference between a "good enough" school project and a portfolio-worthy application. This phase covers: loading states for every page and action, error handling for every failure mode, empty states for every possible "no data" scenario, responsive QA across all breakpoints (desktop/tablet/mobile), accessibility basics, performance optimization, the final Vercel deployment, and project documentation. The goal is to make the app feel hand-crafted, not AI-generated. The deadline is April 3, 2026.

## Design Reference Files

- Review ALL 12 mockup screens one final time
- Focus on the micro-details visible in the mockups: card hover lifts, transition animations, the noise texture overlay, the monospace status bar, the specific border glow effects, the serif typography for headers
- Every screen should match its mockup when populated with Tower of Fate data

## Prerequisites

- Phase 0-6 complete (all features built, Tower of Fate seeded, all pages functional)

## Directory Structure

```
src/
├── app/
│   ├── error.tsx                      ← CREATE (global error boundary)
│   ├── not-found.tsx                  ← CREATE (custom 404 page)
│   ├── loading.tsx                    ← CREATE (global loading state)
│   └── (dashboard)/
│       ├── dashboard/loading.tsx      ← CREATE
│       ├── probability/
│       │   └── cards/loading.tsx      ← CREATE
│       └── ... (loading.tsx for each route)
├── components/
│   ├── shared/
│   │   ├── loading-skeleton.tsx       ← CREATE
│   │   ├── loading-spinner.tsx        ← CREATE
│   │   ├── error-card.tsx             ← CREATE
│   │   ├── toast-provider.tsx         ← CREATE
│   │   └── page-transition.tsx        ← CREATE
│   └── layout/
│       └── ... (final refinements)
├── lib/
│   └── errors.ts                      ← CREATE (error utilities)
└── styles/
    └── animations.css                 ← CREATE (keyframe animations)
```

---

## Subphases

| File | Step |
|---|---|
| [phase-7.1.md](./phase-7.1.md) | Step 7.1 — Loading States for Every Page |
| [phase-7.2.md](./phase-7.2.md) | Step 7.2 — Error Handling |
| [phase-7.3.md](./phase-7.3.md) | Step 7.3 — Toast Notifications |
| [phase-7.4.md](./phase-7.4.md) | Step 7.4 — Empty States Audit |
| [phase-7.5.md](./phase-7.5.md) | Step 7.5 — Responsive QA |
| [phase-7.6.md](./phase-7.6.md) | Step 7.6 — Accessibility Basics |
| [phase-7.7.md](./phase-7.7.md) | Step 7.7 — Animations & Micro-Interactions |
| [phase-7.8.md](./phase-7.8.md) | Step 7.8 — Performance Optimization |
| [phase-7.9.md](./phase-7.9.md) | Step 7.9 — "Not AI-Generated" Checklist |
| [phase-7.10.md](./phase-7.10.md) | Step 7.10 — Final Vercel Deployment |
| [phase-7.11.md](./phase-7.11.md) | Step 7.11 — Project Documentation |
| [phase-7.12.md](./phase-7.12.md) | Step 7.12 — Pre-Submission Smoke Test |

## Verification Checklist

After completing this phase, confirm:
- [ ] Every page has a loading skeleton (not a blank screen while data loads)
- [ ] Every database error shows a user-friendly toast message (not a raw error)
- [ ] Every empty state has a themed component with icon, message, and CTA
- [ ] 404 page is custom-themed (not default Next.js 404)
- [ ] Error boundary catches unhandled errors and shows a themed error page
- [ ] Responsive at all breakpoints: desktop (1440, 1280, 1024), tablet (768), mobile (375, 390, 412)
- [ ] Mobile bottom nav works correctly with all icons
- [ ] All animations are smooth (60fps, no jank)
- [ ] Animations respect `prefers-reduced-motion`
- [ ] Keyboard navigation works through all interactive elements
- [ ] All images have alt text
- [ ] Lighthouse scores: Performance 85+, Accessibility 90+, Best Practices 90+
- [ ] No console errors in production
- [ ] The app does NOT look AI-generated — passes the "Not AI-Generated" checklist in Step 7.9
- [ ] All 5 themes apply correctly and thoroughly
- [ ] Toast notifications appear for all CRUD operations
- [ ] Production deployment is live on Vercel
- [ ] README exists with setup and seeding instructions
- [ ] End-to-end smoke test (Step 7.12) passes completely
- [ ] The app matches the 12 mockup screenshots when populated with Tower of Fate data

---

## Rollback Plan

- This is a polish phase — all rollbacks are to the Phase 6 commit
- Individual changes are small and targeted — revert specific files if something breaks
- Vercel maintains previous deployments — roll back to a previous deployment via the Vercel Dashboard if needed

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| Loading skeletons flash briefly then content appears | Data loads faster than expected | This is fine — better to have a brief flash than no loading state at all. Reduce skeleton duration if noticeable. |
| Toast notification not appearing | Toast provider not in the root layout | Ensure `<ToastProvider>` is in `src/app/layout.tsx` |
| Animations janky on mobile | CSS property triggers layout recalculation | Only animate `transform` and `opacity` — never `width`, `height`, `top`, `left` |
| Fonts flicker on page load (FOUT) | next/font not configured correctly | Verify `next/font/local` declarations in layout.tsx with proper `display: 'swap'` |
| Lighthouse Performance low | Large JavaScript bundles | Dynamic import Recharts, Tiptap, and map interaction code |
| Mobile sidebar still showing | Media query breakpoint wrong | Verify `max-width: 767px` for mobile, `min-width: 768px` for tablet |
| Production env vars missing | Not set in Vercel Dashboard | Go to Vercel → Project Settings → Environment Variables and add all 3 Supabase variables |
| Dark theme colors wrong in production | CSS variable specificity issue | Ensure global CSS with theme variables loads before component styles |
