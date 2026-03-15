# Phase 1.14 — Seed Data Script

**File:** `supabase/seed.sql` -- CREATE

**Purpose:** Provide minimal seed data for development. This is NOT the Tower of Fate template campaign (that comes in Phase 6) -- just enough data to test queries and UI rendering.

**Details:**

Write the seed file with the following structure:

1. **Header comment block** explaining usage:
   ```sql
   -- =============================================================
   -- SEED DATA FOR DEVELOPMENT
   -- =============================================================
   -- INSTRUCTIONS:
   -- 1. First, sign up a test account through the app UI at /signup
   -- 2. Go to Supabase Dashboard > Authentication > Users
   -- 3. Copy the UUID of your test user
   -- 4. Replace 'YOUR_USER_UUID_HERE' below with the actual UUID
   -- 5. Run this file in Supabase Dashboard > SQL Editor
   -- =============================================================
   ```

2. **A placeholder variable** (use a SQL variable or just a comment telling the developer to find-and-replace):
   ```sql
   -- Replace this UUID with your test user's UUID from Supabase Auth:
   -- YOUR_USER_UUID_HERE
   ```

3. **A test campaign:**
   ```sql
   INSERT INTO campaigns (id, name, description, dm_user_id, status)
   VALUES (
     'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
     'The Lost Mines of Probability',
     'A starter campaign for testing. Features goblins who understand Bayesian inference.',
     'YOUR_USER_UUID_HERE',
     'active'
   );
   ```

4. **A test NPC:**
   ```sql
   INSERT INTO npcs (campaign_id, name, race, role, description, hp, armor_class, attack_bonus, status, is_visible_to_players)
   VALUES (
     'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
     'Barthen the Merchant',
     'Human',
     'shopkeeper',
     'A friendly merchant who runs a general store in Phandalin.',
     15, 10, 0, 'active', true
   );
   ```

5. **A test encounter:**
   ```sql
   INSERT INTO encounters (campaign_id, name, description, difficulty_class, enemies, status)
   VALUES (
     'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
     'Goblin Ambush',
     'A band of goblins attacks on the road to Phandalin.',
     13,
     '[{"name": "Goblin", "hp": 7, "ac": 15, "count": 4}]'::jsonb,
     'planned'
   );
   ```

6. **A test note:**
   ```sql
   INSERT INTO notes (campaign_id, author_id, title, content, tag, is_visible_to_players)
   VALUES (
     'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
     'YOUR_USER_UUID_HERE',
     'Session 0 Notes',
     '<p>The party meets at the Stonehill Inn. Each player rolls for initiative on their backstory.</p>',
     'session_log',
     true
   );
   ```

7. **A test Bayes scenario:**
   ```sql
   INSERT INTO bayes_scenarios (campaign_id, title, description, prior_probability, likelihood, marginal_false, is_template)
   VALUES (
     'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
     'Is the innkeeper secretly a cultist?',
     'The innkeeper has been seen leaving town at midnight. What is the probability they are part of the cult?',
     0.1, 0.8, 0.3, false
   );
   ```

8. Add a closing comment:
   ```sql
   -- After running this seed, you should be able to:
   -- 1. Log in with your test account
   -- 2. See "The Lost Mines of Probability" campaign in the dashboard
   -- 3. See NPCs, encounters, and notes populated for testing
   ```
