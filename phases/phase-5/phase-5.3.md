# Phase 5.3 — Map Validation Schemas

**File:** `src/lib/validations/maps.ts` — CREATE

Use Zod (consistent with other phases). Define:

1. **`mapUploadSchema`**
   - `name`: `z.string().min(1, "Map name is required").max(100, "Map name must be 100 characters or fewer")`
   - Note: File validation is handled imperatively in the upload function (Zod does not natively validate `File` objects well). But define constants:
     - `MAX_MAP_FILE_SIZE = 5 * 1024 * 1024` (5MB)
     - `ACCEPTED_IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/webp']`

2. **`markerSchema`**
   - `label`: `z.string().min(1, "Label is required").max(100, "Label must be 100 characters or fewer")`
   - `description`: `z.string().max(500, "Description must be 500 characters or fewer").optional().or(z.literal(''))`
   - `icon_type`: `z.enum(['combat', 'quest', 'shop', 'danger', 'safe'])`
   - `pos_x`: `z.number().min(0).max(1)`
   - `pos_y`: `z.number().min(0).max(1)`
   - `is_visible_to_players`: `z.boolean()`

3. **`mapUpdateSchema`**
   - `name`: `z.string().min(1).max(100).optional()`
   - `sort_order`: `z.number().int().min(0).optional()`
