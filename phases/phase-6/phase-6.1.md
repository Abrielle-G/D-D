# Phase 6.1 — Define Tower of Fate Campaign Data
**File:** `src/lib/seed/tower-of-fate.ts` — CREATE
**Purpose:** All the seed data for the Tower of Fate campaign, defined as typed TypeScript objects.
**Details:**

**Campaign:**
- Name: "Tower of Fate"
- Description: "An ancient tower rises from the mist, its secrets guarded by forgotten magic. Your party has been summoned to unravel the mystery of the Tower of Fate — a probabilities-driven adventure where every choice has a calculable outcome."
- is_template: true (read-only template, users can duplicate it)
- status: "active"

**NPCs (4):**

1. **Aldric the Sage** (Quest Giver)
   - Race: Human
   - Role: quest_giver
   - Description: "An elderly scholar who has spent decades studying the Tower. He hires the party to retrieve the Probability Codex — an ancient tome said to predict all possible futures. Soft-spoken but urgently motivated."
   - HP: 28, AC: 10, Attack Bonus: +1
   - Status: active
   - Visible to players: true
   - Notes: "Secret: Aldric is hiding that the Codex was originally his — he lost it to the Tower's guardian 30 years ago."

2. **Morrigan the Witch** (Villain)
   - Race: Half-Elf
   - Role: villain
   - Description: "Ancient sorceress of the marsh who has claimed the Tower's upper floors as her lair. She uses probability magic to manipulate dice and outcomes, making her an unpredictable enemy."
   - HP: 120, AC: 16, Attack Bonus: +8
   - Status: active
   - Visible to players: false
   - Notes: "Morrigan knows Bayes' theorem intuitively — she updates her battle tactics based on observed player behavior."

3. **Guildmaster Henrick** (Quest Giver)
   - Race: Dwarf
   - Role: quest_giver
   - Description: "Leader of the Ironwood Guild, known for his fair but firm hand in merchant disputes. Offers the party supplies and information in exchange for clearing a goblin camp near the Tower."
   - HP: 85, AC: 14, Attack Bonus: +4
   - Status: active
   - Visible to players: true

4. **Old Barlow** (Merchant)
   - Race: Halfling
   - Role: merchant
   - Description: "A grizzled traveling merchant with a cart full of potions and oddities. His prices seem suspiciously high — but is he lying about the rarity of his goods, or does he truly have the only healing potions for miles?"
   - HP: 42, AC: 10, Attack Bonus: +2
   - Status: active
   - Visible to players: true
   - Notes: "Perfect NPC for the 'Is the Merchant Lying?' Bayes scenario."

**Encounters (3):**

1. **Goblin Ambush at the Bridge**
   - Description: "The party reaches the old stone bridge over the Whispering Gorge. Three goblins hide behind the crumbling pillars, waiting to ambush anyone who crosses."
   - Difficulty Class: 14
   - Status: planned
   - Enemies:
     - Goblin Scout: HP 7, AC 15, ATK +4, DMG 1d6+2
     - Goblin Archer: HP 5, AC 13, ATK +4, DMG 1d6+2
     - Goblin Boss: HP 21, AC 17, ATK +5, DMG 2d6+3

2. **The Hall of Mirrors**
   - Description: "A circular chamber filled with enchanted mirrors that reflect distorted versions of the party. Each mirror has a 30% chance of spawning a shadow clone when touched."
   - Difficulty Class: 12
   - Status: planned
   - Enemies:
     - Shadow Clone: HP 15, AC 12, ATK +3, DMG 1d8
     - Shadow Clone: HP 15, AC 12, ATK +3, DMG 1d8

3. **Morrigan's Probability Gambit**
   - Description: "The final confrontation. Morrigan challenges the party to a game of wits — she'll manipulate the odds unless the party can outsmart her using Bayesian reasoning."
   - Difficulty Class: 18
   - Status: planned
   - Enemies:
     - Morrigan the Witch: HP 120, AC 16, ATK +8, DMG 2d10+4
     - Fate Golem: HP 50, AC 14, ATK +6, DMG 1d12+3

**Story Notes (5):**

1. **"Session 1 — The Call to Adventure"** (tag: session_log, visible to players, session_number: 1)
   - Rich text content: Narrative description of how the party meets Aldric, learns about the Tower, and sets out. Include a blockquote from Aldric: "The Tower doesn't care about your strength or your magic. It cares about probability. Every choice is a bet — and the Tower always knows the odds."

2. **"The Tower of Fate — Lore"** (tag: world_lore, visible to players)
   - Content about the Tower's history, its construction by an ancient order of probability mages, and how it tests adventurers by manipulating chance itself.

3. **"Session 2 — The Goblin Bridge"** (tag: session_log, visible to players, session_number: 2)
   - Recap of the goblin encounter at the bridge. Reference specific probability outcomes.

4. **"DM Planning Notes"** (tag: dm_secret, NOT visible to players)
   - Secret DM notes about Morrigan's weakness (she can be defeated by applying Bayes' theorem to predict her attack pattern), loot table, and endgame twist.

5. **"The Probability Codex"** (tag: plot, visible to players)
   - Description of the artifact the party is seeking — a book that shows all possible outcomes of any action as probability distributions.

**Bayes Scenarios (2 campaign-specific + reference to the 3 global ones):**

1. **"Is This Chest Trapped?"** (linked to Tower of Fate campaign)
   - Same as the pre-built global scenario, but here it's contextualized within the Tower
   - Prior: 0.30, Likelihood: 0.60, Marginal False: 0.10

2. **"Does Morrigan Know We're Coming?"**
   - Prior: 0.50 (50-50 chance she's aware)
   - Likelihood: 0.85 (if she knows, 85% chance her minions are posted at the entrance)
   - Marginal False: 0.20 (even if she doesn't know, 20% chance there are guards by default)
   - Description: "As you approach the upper levels, you notice armed sentinels at the corridor entrance. Update your belief about whether Morrigan has been warned."

**Demo Map:**
- Name: "Tower of Fate — Level 1"
- Image: use the image from `public/images/maps/tower-of-fate-level-1.jpg` (user-provided). If no image is available, the seed script should note that a placeholder is needed.
- Sort order: 0

**Map Markers (5):**
1. Label: "Goblin Bridge", Type: combat, pos_x: 0.25, pos_y: 0.35, visible to players: true, description: "The old stone bridge — site of the goblin ambush. DC 14 Stealth to bypass."
2. Label: "Aldric's Camp", Type: safe, pos_x: 0.10, pos_y: 0.80, visible to players: true, description: "Where the party first met the sage. A safe resting point."
3. Label: "Trap Corridor", Type: danger, pos_x: 0.55, pos_y: 0.45, visible to players: false, description: "Hidden blade traps. DC 16 Perception to detect, DC 14 Thieves' Tools to disarm."
4. Label: "Barlow's Cart", Type: shop, pos_x: 0.40, pos_y: 0.75, visible to players: true, description: "Old Barlow's traveling merchant cart. Healing potions, rope, and suspicious deals."
5. Label: "Morrigan's Sanctum", Type: quest, pos_x: 0.80, pos_y: 0.15, visible to players: false, description: "The final confrontation. Only revealed when the party reaches the upper floors."

**Demo Character (for Player mode testing):**
- Name: "Thorin Ironforge"
- Race: Dwarf, Class: Fighter, Level: 5
- Stats: STR 16, DEX 14, CON 15, INT 10, WIS 12, CHA 8
- HP: 28/32, AC: 16, Speed: 25
- Weapons: Battleaxe (1d8+3, +6 ATK), Handaxe (1d6+3, +6 ATK)
- Abilities: "Second Wind" (1/long rest), "Action Surge" (1/short rest)
- Inventory: Healing Potion x3, Silk Rope (50ft) x1, Torch x5, Rations x3
- Notes: "Thorin seeks vengeance against the goblins who destroyed his home forge."
