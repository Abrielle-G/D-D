# Phase 5.6 — Map Upload Dialog

**File:** `src/components/maps/map-upload-dialog.tsx` — CREATE

**Props:**
- `isOpen: boolean`
- `onClose: () => void`
- `campaignId: string`
- `onMapCreated: (map: MapData) => void` — callback after successful upload

**Use shadcn/ui Dialog component.**

**Dialog content:**

1. **Title:** "Upload New Map"

2. **Map Name input:**
   - Label: "MAP NAME" in uppercase, small muted text (consistent with the design system's label style)
   - Input field: dark background, subtle border, placeholder "e.g., Tower of Fate — Level 1"
   - Validate on blur: required, 1-100 characters

3. **Image upload area:**
   - A large dashed-border rectangle (~200px tall) serving as a drag-and-drop zone
   - Center content: upload icon (UploadCloud from Lucide), "Drag and drop your map image here" text, "or" separator, "Browse Files" link/button styled in accent color
   - Wire up:
     - `onDragOver`: prevent default, add visual highlight (accent border)
     - `onDragLeave`: remove highlight
     - `onDrop`: extract `e.dataTransfer.files[0]`, validate, set in state
     - Hidden `<input type="file" accept="image/jpeg,image/png,image/webp">` triggered by the "Browse Files" button
   - After a file is selected:
     - Show the file name and formatted size (e.g., "dungeon-map.png — 2.4 MB")
     - Show a thumbnail preview of the selected image (use `URL.createObjectURL(file)` and render in a small `<img>`)
     - Show a "Remove" button/link to clear the selection and return to the drop zone
   - **Immediate validation on file selection:**
     - If the file type is not JPEG/PNG/WebP: show an error below the drop zone in red text: "Only JPG, PNG, and WebP images are supported." Do not set the file in state.
     - If the file size exceeds 5MB: show an error: "Image must be under 5MB. Selected file is [X.X] MB." Do not set the file in state.

4. **Action buttons:**
   - "Cancel" button — ghost/outlined, calls `onClose()`
   - "Upload" button — accent-colored, solid. Disabled if name is empty or no file is selected.
   - On click:
     - Set a loading state (show a spinner or progress bar on the button, disable both buttons)
     - Call `createMap(campaignId, name, file)`
     - On success: call `onMapCreated(newMap)`, call `onClose()`, show a success toast "Map uploaded successfully"
     - On error: show the error message below the form (do NOT close the dialog or clear the file). If it is a network error, show "Upload failed. Please check your connection and try again." with a "Retry" option (which simply re-clicks Upload).

5. **Cleanup:** When the dialog closes (by cancel, success, or clicking outside), revoke the object URL created for the preview to prevent memory leaks: `URL.revokeObjectURL(previewUrl)`.
