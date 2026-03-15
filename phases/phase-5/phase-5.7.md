# Phase 5.7 — Marker Form Dialog

**File:** `src/components/maps/marker-form.tsx` — CREATE

**Props:**
- `isOpen: boolean`
- `onClose: () => void`
- `mapId: string`
- `position: { x: number, y: number }` — normalized position (0-1), pre-filled for new markers
- `existingMarker: MapMarkerData | null` — if editing, pre-fill all fields from this; if null, creating new
- `onMarkerSaved: (marker: MapMarkerData) => void` — callback after create/update

**Use shadcn/ui Dialog component.**

**Dialog content:**

1. **Title:** "New Marker" or "Edit Marker" depending on whether `existingMarker` is null

2. **Label input:**
   - Label: "LABEL" — uppercase, small, muted
   - Input: dark background, placeholder "e.g., Goblin Ambush"
   - Required, 1-100 characters

3. **Description textarea:**
   - Label: "DESCRIPTION" — uppercase, small, muted
   - Textarea: dark background, 3-4 rows, placeholder "e.g., 4 goblins patrol this corridor. DC 14 Stealth to sneak past."
   - Optional, max 500 characters
   - Show a character count below the textarea: "42 / 500" in muted text

4. **Icon Type selector:**
   - Label: "MARKER TYPE" — uppercase, small, muted
   - A horizontal row (or 2x3 grid on narrow screens) of 5 clickable option cards, one for each `MarkerIconType`
   - Each option card shows:
     - The colored circle with icon (same as how it appears on the map)
     - The label below (e.g., "Combat", "Quest", "Shop", "Danger", "Safe Zone")
   - Selected option: accent-colored border, slightly brighter background
   - Unselected options: subtle border, muted
   - Default selection: `'combat'` for new markers, or the existing marker's type for edits

5. **Visible to Players toggle:**
   - Label: "VISIBLE TO PLAYERS" with a shadcn/ui Switch component
   - Default: true for new markers, or the existing value for edits
   - Below the toggle, a helper text: "When hidden, only DMs can see this marker on the map" in muted small text

6. **Position display (read-only):**
   - Small muted text below the toggle: "Position: (0.45, 0.72)" showing the normalized coordinates
   - Not editable — the position is set by clicking on the map (for new markers) or from the existing data (for edits)
   - In future phases, you could allow drag-repositioning, but not now

7. **Action buttons:**
   - "Cancel" — ghost/outlined, calls `onClose()`
   - "Create Marker" or "Save Changes" — accent-colored, solid. Disabled if label is empty or no icon type is selected.
   - On click:
     - Validate all fields using `markerSchema` from Step 5.3
     - If creating: call `createMarker({ map_id: mapId, label, description, icon_type, pos_x: position.x, pos_y: position.y, is_visible_to_players })`
     - If editing: call `updateMarker(existingMarker.id, { label, description, icon_type, is_visible_to_players })`
     - On success: call `onMarkerSaved(marker)`, call `onClose()`, show a success toast
     - On error: show error message inline
