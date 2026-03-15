# Phase 5.2 — Map Queries

**File:** `src/lib/queries/maps.ts` — CREATE

Import the Supabase client and the types from Step 5.1. Implement the following async functions:

1. **`getMaps(campaignId: string): Promise<MapData[]>`**
   - Query the `campaign_maps` table filtered by `campaign_id`, ordered by `sort_order` ascending
   - Return the array of maps (without markers — markers are fetched separately per map)
   - Handle errors by throwing with a descriptive message

2. **`getMapWithMarkers(mapId: string, isDM: boolean): Promise<MapData>`**
   - Fetch the map record from `campaign_maps` by `id`
   - Fetch markers from `map_markers` filtered by `map_id`
   - If `isDM` is false, add an additional filter: `.eq('is_visible_to_players', true)`
   - If `isDM` is true, return all markers (DM sees everything)
   - Combine the map record with the markers array and return
   - Throw a `"Map not found"` error if the map does not exist

3. **`createMap(campaignId: string, name: string, imageFile: File): Promise<MapData>`**
   - **Validate file before uploading:**
     - Check `imageFile.type` is one of `'image/jpeg'`, `'image/png'`, `'image/webp'`. If not, throw `"Only JPG, PNG, and WebP images are supported."`
     - Check `imageFile.size <= 5 * 1024 * 1024` (5MB). If not, throw `"Image must be under 5MB."`
   - Generate a unique file path for storage: `maps/${campaignId}/${crypto.randomUUID()}.${extension}` where extension is derived from the MIME type
   - Upload to Supabase Storage `maps` bucket using `supabase.storage.from('maps').upload(filePath, imageFile)`
   - On upload error, throw with the storage error message
   - Get the public URL: `supabase.storage.from('maps').getPublicUrl(filePath).data.publicUrl`
   - Determine the next `sort_order` by counting existing maps for this campaign and adding 1
   - Insert a record into `campaign_maps` with: `campaign_id`, `name`, `image_url` (the public URL), `sort_order`
   - Return the newly created map record (with empty markers array)

4. **`updateMap(mapId: string, data: { name?: string; sort_order?: number }): Promise<MapData>`**
   - Update the `campaign_maps` record with the provided fields
   - Return the updated record

5. **`deleteMap(mapId: string): Promise<void>`**
   - Fetch the map to get its `image_url`
   - Extract the storage file path from the URL (parse the path after the bucket name)
   - Delete the file from Supabase Storage: `supabase.storage.from('maps').remove([filePath])`
   - Delete the map record from `campaign_maps` (cascading delete should handle markers if set up in Phase 1; if not, explicitly delete all markers with `map_id` first)
   - Handle partial failures: if storage deletion fails but DB deletion succeeds, log a warning

6. **`createMarker(data: MarkerFormData & { map_id: string }): Promise<MapMarkerData>`**
   - Insert into `map_markers` with all fields
   - Return the created marker

7. **`updateMarker(markerId: string, data: Partial<MarkerFormData>): Promise<MapMarkerData>`**
   - Update the `map_markers` record by `id`
   - Return the updated marker

8. **`deleteMarker(markerId: string): Promise<void>`**
   - Delete the marker from `map_markers` by `id`

9. **`toggleMarkerVisibility(markerId: string, visible: boolean): Promise<void>`**
   - Update `map_markers` set `is_visible_to_players = visible` where `id = markerId`
   - This is a convenience function for quick toggling from the marker popup menu
