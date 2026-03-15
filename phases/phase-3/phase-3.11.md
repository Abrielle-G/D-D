# Phase 3.11 — Save to Encounter

**Placement:** On the probability cards page, below or beside the live calculation.

**"Save to Encounter" button:**
- Accent-colored button with a save/bookmark icon.
- Only enabled when there is a current calculated card.
- On click, opens a dialog (shadcn `Dialog`):
  - Title: "Save to Encounter"
  - Lists the current user's encounters (fetched from the database, requires Phase 1 auth).
  - Each encounter shown as a selectable row with name and date.
  - "Save" button at the bottom.
- On save, store the `ProbabilityCardData` as JSON within the encounter's data (the exact schema depends on Phase 1's database design -- store it in an array field like `encounter.probabilityCards`).
- Show a success toast on save.
- If user is not logged in, show a message: "Log in to save cards to encounters."
