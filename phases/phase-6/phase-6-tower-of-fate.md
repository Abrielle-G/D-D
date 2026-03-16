# Phase 6: Tower of Fate — Demo Campaign & Seed Data

## Context
This phase creates the "Tower of Fate" pre-built demo campaign (Feature 3.10 from the spec). This is a complete starter campaign that ships with the app, serving as both a tutorial and a showcase of all features. It includes pre-built NPCs, encounters, story notes, Bayes scenarios, and a demo map with markers. The data is seeded via a script that runs against the Supabase database. New users can explore this campaign to see how the app works before creating their own.

## Design Reference Files
- All previous mockup screens serve as reference — the Tower of Fate data should populate the demo data shown in the mockups (the NPCs, encounters, notes, map markers, etc.)

## Prerequisites
- Phase 0-5 complete (all features built — the Tower of Fate campaign uses every feature in the app)
- A Supabase project with all tables and RLS policies created
- At least one user account exists to be the "DM" of the Tower of Fate campaign

## Directory Structure
```
src/
├── lib/
│   └── seed/
│       ├── tower-of-fate.ts            ← CREATE (seed data definitions)
│       ├── seed-runner.ts              ← CREATE (execution script)
│       └── sample-images.ts            ← CREATE (image URL references)
├── app/
│   └── api/
│       └── seed/
│           └── route.ts                ← CREATE (API endpoint to trigger seeding)
supabase/
└── seed.sql                            ← MODIFY (add Tower of Fate data)
public/
└── images/
    ├── themes/
    │   └── fantasy-backdrop.jpg        ← already present from Phase 0.22 (usable as hero banner fallback)
    ├── maps/
    │   └── tower-of-fate-level-1.jpg   ← ADD (user-provided or placeholder)
    └── heroes/
        └── tower-banner.jpg            ← ADD (user-provided; fallback to fantasy-backdrop.jpg)
```

## Subphases

| File | Step |
|---|---|
| [phase-6.1.md](./phase-6.1.md) | Step 6.1 — Define Tower of Fate Campaign Data |
| [phase-6.2.md](./phase-6.2.md) | Step 6.2 — Create the Seed Runner |
| [phase-6.3.md](./phase-6.3.md) | Step 6.3 — Create the Seed API Route |
| [phase-6.4.md](./phase-6.4.md) | Step 6.4 — SQL Seed Alternative |
| [phase-6.5.md](./phase-6.5.md) | Step 6.5 — Onboarding Flow Integration |
| [phase-6.6.md](./phase-6.6.md) | Step 6.6 — Sample Image References |

## Verification Checklist
After completing this phase, confirm:
- [ ] Running the seed script (via API endpoint or SQL) creates the Tower of Fate campaign with all data
- [ ] Running the seed script twice does not create duplicates (idempotent)
- [ ] The DM Dashboard shows the Tower of Fate campaign with correct hero banner
- [ ] Quick stats show: 4 NPCs, 3 encounters, correct player count
- [ ] NPC Manager displays all 4 NPCs with correct roles, stats, and descriptions
- [ ] Morrigan is hidden from players (DM ONLY overlay visible in DM mode)
- [ ] Encounter Builder shows all 3 encounters with correct enemies and DCs
- [ ] Probability cards can be generated from encounter data (Party vs Goblins)
- [ ] Story Notes show all 5 notes with correct tags and content
- [ ] "DM Planning Notes" is tagged as dm_secret and NOT visible in Player mode
- [ ] Bayes Analyzer can load the "Is This Chest Trapped?" scenario from campaign data
- [ ] Map Viewer displays the Tower of Fate Level 1 map with 5 markers
- [ ] Hidden map markers (Trap Corridor, Morrigan's Sanctum) show as DM ONLY
- [ ] The demo character "Thorin" displays correctly in the Character Sheet
- [ ] New user onboarding gives them access to the Tower of Fate campaign
- [ ] All mockup screenshots can be reproduced using the seeded data (the data matches what's shown in the designs)

## Rollback Plan
- Delete the seeded data: `DELETE FROM campaigns WHERE name = 'Tower of Fate' AND is_template = true CASCADE` — the cascade will remove all related NPCs, encounters, notes, etc.
- Remove map images from Supabase Storage manually
- Revert code to Phase 5 commit

## Troubleshooting
| Symptom | Likely Cause | Fix |
|---|---|---|
| Seed fails on foreign key | Wrong insertion order | Ensure campaign is created before NPCs/encounters/notes that reference it |
| Duplicate data after re-seed | Idempotency check missing | Add `WHERE NOT EXISTS` or `ON CONFLICT DO NOTHING` to all inserts |
| Map image not found | Image file not in public/images/maps/ | Check that the user has provided the image or create a placeholder |
| Character not appearing | No user linked | The Thorin character needs a valid user_id — seed after a user has signed up |
| Notes content not rendering | HTML not properly formatted | Ensure the seed content uses valid Tiptap-compatible HTML (p, strong, em, blockquote, ul/li, h1/h2) |

---

**IMPORTANT: Do NOT write any actual code. Write detailed INSTRUCTIONS only.**
