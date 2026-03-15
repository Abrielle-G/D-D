# Phase 5.1 — Map Types

**File:** `src/types/maps.ts` — CREATE

Define the following TypeScript types and constants:

1. **`MarkerIconType`** — A union type of the five marker categories:
   - `'combat'` — red circle, crossed swords icon (⚔️)
   - `'quest'` — yellow/amber circle, exclamation mark or flag icon (❗)
   - `'shop'` — blue/cyan circle, store or bag icon (🏪)
   - `'danger'` — dark red circle, skull icon (☠️)
   - `'safe'` — green circle, home or shield icon (🏠)

2. **`MARKER_CONFIG`** — A constant record mapping each `MarkerIconType` to an object with:
   - `label`: human-readable name (e.g., `"Combat"`, `"Quest"`, `"Shop"`, `"Danger"`, `"Safe Zone"`)
   - `icon`: the emoji or Lucide icon name to display inside the marker circle
   - `color`: the Tailwind background color class for the marker circle (e.g., `"bg-red-600"`, `"bg-amber-500"`, `"bg-cyan-500"`, `"bg-red-900"`, `"bg-emerald-500"`)
   - `borderColor`: the border class for the selected state — use `border-[var(--color-accent)]` for all marker types so the selection ring always matches the active theme (not type-specific)
   - `badgeLabel`: uppercase label for the popup badge (e.g., `"COMBAT"`, `"QUEST"`)

3. **`MapMarkerData`** — Interface representing a single marker:
   - `id`: string (UUID)
   - `map_id`: string (UUID, FK to campaign_maps)
   - `label`: string (1-100 chars)
   - `description`: string | null (up to 500 chars)
   - `icon_type`: MarkerIconType
   - `pos_x`: number (normalized 0-1, percentage of image width)
   - `pos_y`: number (normalized 0-1, percentage of image height)
   - `is_visible_to_players`: boolean
   - `created_at`: string (ISO timestamp)

4. **`MapData`** — Interface representing a map:
   - `id`: string (UUID)
   - `campaign_id`: string (UUID)
   - `name`: string
   - `image_url`: string (Supabase Storage public URL)
   - `sort_order`: number
   - `created_at`: string (ISO timestamp)
   - `markers`: MapMarkerData[] (populated by joins or separate queries)

5. **`MapViewState`** — Interface for the pan/zoom state:
   - `scale`: number (zoom level, 0.5 to 4.0, default 1.0)
   - `translateX`: number (horizontal pan offset in pixels)
   - `translateY`: number (vertical pan offset in pixels)
   - `isDragging`: boolean

6. **`MarkerFormData`** — Interface for the marker creation/edit form:
   - `label`: string
   - `description`: string
   - `icon_type`: MarkerIconType
   - `pos_x`: number
   - `pos_y`: number
   - `is_visible_to_players`: boolean

7. **`MapUploadFormData`** — Interface for the map upload form:
   - `name`: string
   - `file`: File | null
