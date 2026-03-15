# Phase 6.5 — Onboarding Flow Integration
**Purpose:** When a new user signs up, automatically give them access to the Tower of Fate campaign.
**Details:**
- After signup, check if the Tower of Fate template campaign exists
- If the user selected "DM" as their preferred role: duplicate the Tower of Fate campaign (create a copy owned by the new user, with all NPCs, encounters, notes, scenarios, and map data cloned)
- If the user selected "Player" as their preferred role: create a copy of the Thorin character in the Tower of Fate campaign linked to the new user
- This gives every new user an immediate "populated" experience — they never land on an empty dashboard
- The original template remains unchanged (is_template = true, read-only)
