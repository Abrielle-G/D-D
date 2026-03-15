# Phase 5.8 — Empty States

**No maps uploaded:**
- Displayed when `maps.length === 0`
- Takes up the full content area (where the map canvas would be)
- Center-aligned content:
  - A large muted icon (Map or Globe icon from Lucide, ~64px, `text-muted-foreground/30`)
  - Heading: "Upload Your First Map" — `text-xl font-bold text-foreground`
  - Description: "Bring your campaign world to life with interactive maps. Upload a map image and place markers for points of interest, encounters, and more." — `text-sm text-muted-foreground max-w-md`
  - CTA button: "Upload Map" — accent-colored, solid, with an Upload icon. On click, open the `MapUploadDialog`.

**No markers on a map (DM view only):**
- The map is displayed normally (it has been uploaded), but there are no markers
- Show a subtle hint overlaid on the map, positioned in the center:
  - Semi-transparent dark pill: "Click anywhere on the map to place your first marker"
  - Styled with `bg-card/60 backdrop-blur-sm rounded-lg px-4 py-2 text-sm text-muted-foreground`
  - This hint should disappear after the first marker is placed
  - Do NOT show this hint to players — players just see the map without markers
