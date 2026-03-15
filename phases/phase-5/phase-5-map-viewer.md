# Phase 5: Campaign Map Viewer

## Context

This phase implements the interactive Campaign Map Viewer (Feature 3.11 from the spec). DMs can upload map images, place markers/pins with labels and descriptions, and toggle marker visibility for players. The map supports pan/zoom via CSS transforms and native browser events. Map images are stored in Supabase Storage. This is one of the most visually impressive features.

## Tech Stack

- **Next.js 14+** with App Router
- **TypeScript** for all files
- **Tailwind CSS 3** for styling
- **shadcn/ui** for dialogs, buttons, toggles, inputs, tooltips
- **Supabase Storage** for map image uploads
- **CSS transforms** for pan/zoom (no libraries)

## Design Reference Files

- Campaign Map: `stitch_proba_project/stitch_proba_project/campaign_map_updated_card_color/` — large map canvas with pannable/zoomable viewport, colored map markers (red=combat, yellow=quest, purple=event, green=safe, gear=trap), marker popup card with details and actions, zoom controls (+/-/reset), map info bar, coordinate display, map upload button

## Prerequisites

- Phase 0 (design system)
- Phase 1 (database schema with `campaign_maps` and `map_markers` tables, RLS, Supabase Storage bucket)
- Phase 2 (dashboard layout, navigation)

## Directory Structure

```
src/
├── app/(dashboard)/
│   └── maps/
│       └── page.tsx                    ← MODIFY
├── components/
│   ├── maps/
│   │   ├── map-viewer.tsx              ← CREATE (main map canvas)
│   │   ├── map-canvas.tsx              ← CREATE (pan/zoom handler)
│   │   ├── map-marker.tsx              ← CREATE (single marker pin)
│   │   ├── marker-popup.tsx            ← CREATE (marker detail popup)
│   │   ├── marker-form.tsx             ← CREATE (create/edit marker dialog)
│   │   ├── map-controls.tsx            ← CREATE (zoom +/- reset)
│   │   ├── map-selector.tsx            ← CREATE (sidebar list of maps)
│   │   ├── map-upload-dialog.tsx       ← CREATE (upload flow)
│   │   ├── coordinate-bar.tsx          ← CREATE (X/Y/Scale display)
│   │   └── map-info-bar.tsx            ← CREATE (bottom info bar)
├── lib/
│   ├── queries/
│   │   └── maps.ts                     ← CREATE
│   └── validations/
│       └── maps.ts                     ← CREATE
├── hooks/
│   └── use-map-interaction.ts          ← CREATE (pan/zoom state)
└── types/
    └── maps.ts                         ← CREATE
```

---

## Subphases

| File | Step |
|---|---|
| [phase-5.1.md](./phase-5.1.md) | Step 5.1 — Map Types |
| [phase-5.2.md](./phase-5.2.md) | Step 5.2 — Map Queries |
| [phase-5.3.md](./phase-5.3.md) | Step 5.3 — Map Validation Schemas |
| [phase-5.4.md](./phase-5.4.md) | Step 5.4 — Pan/Zoom Hook |
| [phase-5.5.md](./phase-5.5.md) | Step 5.5 — Build the Map Page |
| [phase-5.6.md](./phase-5.6.md) | Step 5.6 — Map Upload Dialog |
| [phase-5.7.md](./phase-5.7.md) | Step 5.7 — Marker Form Dialog |
| [phase-5.8.md](./phase-5.8.md) | Step 5.8 — Empty States |

---

## Verification Checklist

After completing this phase, confirm:

- [ ] Uploading a map image (JPEG/PNG/WebP, up to 5MB) stores it in Supabase Storage and displays it on the canvas
- [ ] Uploading an invalid file type (e.g., GIF, BMP, SVG) shows the error: "Only JPG, PNG, and WebP images are supported."
- [ ] Uploading a file larger than 5MB shows the error: "Image must be under 5MB. Selected file is [X.X] MB."
- [ ] Map pan works with mouse drag on desktop
- [ ] Map pan works with single-finger drag on mobile/touch devices
- [ ] Map zoom works with mouse wheel on desktop
- [ ] Map zoom works with pinch-to-zoom gesture on mobile/touch devices
- [ ] Zoom controls (+/-/RESET) in the bottom-right corner work correctly
- [ ] Zoom is bounded between 0.5x and 4.0x — buttons disable at limits
- [ ] Zoom is centered on the cursor position (wheel zoom) or the center (button zoom)
- [ ] Coordinate bar updates X, Y, and Scale values in real-time during pan/zoom/cursor movement
- [ ] Coordinate bar shows dashes for X and Y when the cursor is not over the map
- [ ] Clicking on the map in DM mode opens the marker creation dialog with the correct position
- [ ] Clicking on the map in player mode does NOT open the marker creation dialog
- [ ] Long-press on the map (mobile, DM mode) opens the marker creation dialog
- [ ] Markers appear at their correct percentage positions on the map
- [ ] Markers stay the same visual size regardless of zoom level (inverse scale applied)
- [ ] Clicking a marker opens its popup with label, description, icon badge, and action buttons
- [ ] Clicking a marker does NOT also trigger the map click-to-place-marker behavior (event propagation stopped)
- [ ] DM sees ALL markers, including those hidden from players
- [ ] Hidden markers appear at reduced opacity (0.5) with an eye-slash icon overlay for the DM
- [ ] Player view only shows markers where `is_visible_to_players` is true
- [ ] Toggling marker visibility via the popup menu updates the database and the UI immediately
- [ ] Editing a marker via the popup menu opens the marker form pre-filled with existing data
- [ ] Deleting a marker via the popup menu removes it from the database and the UI (with confirmation)
- [ ] Multiple maps can be uploaded and switched between using tabs or a dropdown
- [ ] Switching maps loads the new map's image and markers
- [ ] Deleting a map removes the image from Supabase Storage and deletes all associated markers
- [ ] Empty state (no maps) displays correctly with the upload CTA
- [ ] Empty state (no markers, DM view) shows the "Click anywhere to place a marker" hint
- [ ] All map interactions are smooth at 60fps — no visible jank or lag
- [ ] The map image does not escape the viewport bounds (`overflow: hidden` works)
- [ ] Marker popups reposition to stay within the viewport when near edges
- [ ] Memory cleanup: object URLs from file previews are revoked when the upload dialog closes

---

## Rollback Plan

- Revert to Phase 4 commit
- Delete uploaded images from Supabase Storage `maps` bucket via the Supabase Dashboard (Storage section)
- Map components are fully isolated in `src/components/maps/` — removing that directory and the associated files in `src/lib/queries/maps.ts`, `src/lib/validations/maps.ts`, `src/hooks/use-map-interaction.ts`, and `src/types/maps.ts` cleanly removes all Phase 5 code
- The maps page route (`src/app/(dashboard)/maps/page.tsx`) can be reverted to its pre-Phase 5 state

---

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---|---|---|
| Map image not loading | Supabase Storage URL wrong or bucket not public | Check bucket visibility in Supabase Dashboard → Storage. Verify the URL format matches `https://<project>.supabase.co/storage/v1/object/public/maps/...`. Ensure the bucket's public access is enabled. |
| Pan is jittery or laggy | Transform causing layout thrashing, or state updates too frequent | Ensure transform is applied via CSS `transform` property, NOT by changing `top`/`left`. Add `will-change: transform` to the transform container. Consider using `requestAnimationFrame` to throttle state updates during drag. |
| Markers in wrong position after pan/zoom | Marker positioning not relative to the map image | Markers must be children of the transform container (so they move with the map). Their `left`/`top` should be percentage-based on the image dimensions, not the viewport. |
| Markers grow/shrink with zoom | Inverse scale not applied | Each marker must have `transform: scale(${1 / mapScale})` to counteract the map zoom. Verify `mapScale` is being passed correctly from the hook. |
| Marker popup cut off at viewport edges | No boundary detection in popup positioning | In the popup component, check the popup's bounding rect against the viewport. If it would overflow, flip the position (e.g., show below instead of above, or shift left/right). |
| Zoom centered on wrong point | Zoom origin calculation incorrect | When zooming via wheel, calculate the cursor position relative to the container (not the page). Then adjust translate so the map point under the cursor stays under the cursor after scaling. See the formula in Step 5.4. |
| Touch zoom not working on mobile | Touch event handlers missing or `preventDefault` not called | Ensure `onTouchStart`, `onTouchMove`, `onTouchEnd` are attached to the container. Call `e.preventDefault()` in touch handlers to prevent browser zoom/scroll. Check that two-finger distance calculation uses `Math.hypot`. |
| Large map images load slowly | No image optimization | Consider resizing very large images client-side before upload (using canvas), or use Supabase's image transformation API (if available) to serve optimized versions. Add a loading skeleton/spinner while the image loads. |
| Upload fails silently | Supabase Storage bucket not configured or RLS blocking | Verify the `maps` bucket exists in Supabase Storage. Check RLS policies allow the authenticated user to upload. Check the browser console for 403/401 errors. |
| Drag-to-pan triggers marker placement | Click not distinguished from drag | Only treat a mouseup as a "click" if the mouse moved fewer than 5 pixels between mousedown and mouseup. The `isDragging` flag should be checked before opening the marker form. |
| File preview causes memory leak | Object URL not revoked | Ensure `URL.revokeObjectURL(previewUrl)` is called when the upload dialog closes, when a new file is selected, or when the component unmounts (useEffect cleanup). |
