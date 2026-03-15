# Phase 3.5 — Pre-Built Bayes Scenarios

**File:** `src/lib/probability/constants.ts` -- CREATE

Define pre-built D&D-themed Bayes scenarios and the dice type constants.

**DICE_TYPES array:**
```
[
  { type: 'd4',  label: 'D4',  sides: 4  },
  { type: 'd6',  label: 'D6',  sides: 6  },
  { type: 'd8',  label: 'D8',  sides: 8  },
  { type: 'd10', label: 'D10', sides: 10 },
  { type: 'd12', label: 'D12', sides: 12 },
  { type: 'd20', label: 'D20', sides: 20 },
]
```

**BAYES_SCENARIOS array (3 scenarios):**

1. **"Is This Chest Trapped?"**
   - `id`: `'trapped-chest'`
   - `title`: `'Is This Chest Trapped?'`
   - `description`: `'You notice scratches around the lock mechanism of an ornate chest. Your rogue wants to determine the probability that the chest is trapped given this visual evidence.'`
   - `hypothesis`: `'Trapped'`
   - `evidence`: `'Visible Scratches'`
   - `input`: `{ prior: 0.30, likelihood: 0.60, marginalFalse: 0.10 }`
   - Expected posterior: ~72.0%
   - `educationalText`: `'The prior of 30% represents base rate of trapped chests in this dungeon. The likelihood of 60% means trapped chests show scratches 60% of the time. The false positive of 10% means safe chests sometimes have scratches too.'`

2. **"Is the Merchant Lying?"**
   - `id`: `'lying-merchant'`
   - `title`: `'Is the Merchant Lying?'`
   - `description`: `'The merchant avoids eye contact while negotiating. Your bard rolled an Insight check. What is the probability the merchant is actually lying given this behavioral evidence?'`
   - `hypothesis`: `'Lying'`
   - `evidence`: `'Avoids Eye Contact'`
   - `input`: `{ prior: 0.20, likelihood: 0.80, marginalFalse: 0.30 }`
   - Expected posterior: ~40.0%
   - `educationalText`: `'Only 20% of merchants are dishonest (prior). Liars avoid eye contact 80% of the time (likelihood), but 30% of honest people also avoid eye contact (false positive). Notice how the high false positive rate keeps the posterior moderate.'`

3. **"Is the Shadow a Friend or Foe?"**
   - `id`: `'shadow-foe'`
   - `title`: `'Is the Shadow a Friend or Foe?'`
   - `description`: `'A shadowy figure has been following your party. It just cast a protective spell on your injured ally. What is the probability the figure is hostile despite this seemingly friendly action?'`
   - `hypothesis`: `'Hostile'`
   - `evidence`: `'Protective Spell Cast'`
   - `input`: `{ prior: 0.50, likelihood: 0.70, marginalFalse: 0.20 }`
   - Expected posterior: ~77.8%
   - `educationalText`: `'Equal prior (50%) since you know nothing about the figure. Hostile entities use deceptive protective spells 70% of the time as a lure. Only 20% of friendly entities would cast a spell without introducing themselves first.'`
