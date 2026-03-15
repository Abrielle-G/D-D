# Phase 5.5 — Build the Map Page

**File:** `src/app/(dashboard)/maps/page.tsx` — MODIFY

This is the main page component. It orchestrates all the map sub-components.

**Data fetching:**
- Use the `useEffect` + state pattern (or React Server Components if loading maps server-side is preferred for initial load)
- Fetch the list of maps for the current campaign using `getMaps(campaignId)`
- Track `selectedMapId` in state. Default to the first map in the list. When a map is selected, fetch it with markers using `getMapWithMarkers(mapId, isDM)`
- Track `isDM` — determine from the user's role in the current campaign (from auth context or session)

**Page layout (full-viewport, no scroll):**
- The page should fill the entire viewport height below the dashboard nav
- Use `h-[calc(100vh-<navHeight>)]` or `flex-1` in a flex column layout
- No page-level scrolling — all interaction is pan/zoom within the map canvas

**Composition (top to bottom):**

1. **Topbar area:**
   - Left: "Maps" heading with an em-dash separator and the campaign name, styled as muted secondary text
   - Right: message icon button, notification bell icon button, "+ Upload Map" button (accent colored, prominent). The upload button opens the `MapUploadDialog` when clicked.

2. **Coordinate Bar** (see Step 5.5a below)

3. **Main content area** (fills remaining space, `position: relative`, `overflow: hidden`):
   - If no maps exist: render the empty state (see Step 5.8)
   - If maps exist: render the `MapViewer` component which contains:
     - `MapCanvas` (fills the area)
     - `MapMarker` components (positioned over the canvas)
     - `MapControls` (bottom-right corner, absolute positioned)
     - `MapInfoBar` (bottom-left corner, absolute positioned)
     - `MarkerPopup` (appears on marker click, absolute positioned)

4. **Map Selector** (if multiple maps): render below the coordinate bar as horizontal tabs or as a dropdown integrated into the info bar

**State management within the page:**
- `maps`: MapData[] — list of all maps for the campaign
- `selectedMapId`: string | null — currently viewed map
- `selectedMap`: MapData | null — the full map data with markers
- `activeMarkerId`: string | null — the marker whose popup is open
- `isUploadOpen`: boolean — controls the upload dialog
- `isMarkerFormOpen`: boolean — controls the marker creation/edit dialog
- `pendingMarkerPosition`: { x: number, y: number } | null — position for a new marker being placed
- `editingMarker`: MapMarkerData | null — marker being edited (null = creating new)

---

#### Step 5.5a: Coordinate Bar

**File:** `src/components/maps/coordinate-bar.tsx` — CREATE

**Props:** `x: number, y: number, scale: number`

**Layout:**
- A thin horizontal bar (height ~28-32px) with a subtle bottom border
- Background: slightly darker than the page background (e.g., `bg-card/50`)
- Content centered: a single line of text in monospace font (`font-mono text-xs text-muted-foreground`)
- Format: `X: 0.45 · Y: 0.72 · Scale: 1.50x` — display X and Y as two-decimal floats, scale as two-decimal with "x" suffix
- Use a middle-dot (`·`) or pipe (`|`) as separators

**Behavior:**
- This component receives its values from the parent page, which tracks the cursor position using the `getMapCoordinates` function from the pan/zoom hook
- Update the coordinate display on mouse move over the map canvas. Use `onMouseMove` on the canvas to call `getMapCoordinates(e.clientX, e.clientY)` and pass the result up to the page state.
- When the cursor is not over the map, display dashes: `X: — · Y: — · Scale: 1.00x` (scale always shows)

---

#### Step 5.5b: Map Selector

**File:** `src/components/maps/map-selector.tsx` — CREATE

**Props:** `maps: MapData[], selectedMapId: string, onSelect: (mapId: string) => void`

**Layout (horizontal tabs variant):**
- A row of tab-style buttons below the coordinate bar
- Each tab shows the map name
- Active tab: accent-colored bottom border, white text
- Inactive tabs: muted text, no border, hover reveals a subtle background
- If there is only one map, still show the tab bar (but with just one tab) so the user knows the concept exists
- If there are no maps, do not render this component

**Layout (dropdown variant, if space is limited):**
- A dropdown select showing "Viewing: [Map Name]"
- Clicking opens a list of all maps
- Can be integrated into the `MapInfoBar` instead of being a separate bar

**Choose the tab variant for desktop and the dropdown variant for narrow screens (responsive).**

---

#### Step 5.5c: Map Viewer (Orchestrator)

**File:** `src/components/maps/map-viewer.tsx` — CREATE

**Props:** `map: MapData, isDM: boolean, onMarkerClick: (marker) => void, onMapClick: (pos: {x, y}) => void, cursorPositionRef: (pos: {x, y} | null) => void`

**Purpose:** This is the orchestrating component that combines the canvas, markers, controls, and info bar into one cohesive unit.

**Details:**
- Initialize the `useMapInteraction` hook
- Render the `MapCanvas` with the hook's event handlers and transform values
- Render `MapMarker` for each marker in `map.markers`, passing the current scale so markers can inverse-scale
- Render `MapControls` with `zoomIn`, `zoomOut`, `resetView` from the hook
- Render `MapInfoBar` with `map.name`
- Handle the `onMouseMove` event to track cursor coordinates (call `getMapCoordinates` and pass to `cursorPositionRef`)
- Handle click-to-place-marker logic:
  - On `onClick` of the canvas: if `isDM` is true and `isDragging` is false (important — do not open marker form after a drag), calculate normalized coordinates and call `onMapClick({ x, y })`
  - Distinguish click from drag: only treat it as a "click" if the mouse moved fewer than 5 pixels between mousedown and mouseup

---

#### Step 5.5d: Map Canvas

**File:** `src/components/maps/map-canvas.tsx` — CREATE

**Props:**
- `imageUrl: string` — the map image URL from Supabase Storage
- `scale: number, translateX: number, translateY: number` — transform values from the hook
- `isDragging: boolean, isResetting: boolean` — state flags
- `onWheel, onMouseDown, onMouseMove, onMouseUp, onMouseLeave` — event handlers from the hook
- `onTouchStart, onTouchMove, onTouchEnd` — touch handlers from the hook
- `children: React.ReactNode` — map markers and other overlays rendered as children
- `onImageLoad: (width: number, height: number) => void` — callback when the image finishes loading (to know the natural dimensions)
- `containerRef: React.RefObject<HTMLDivElement>` — the ref from the hook

**Layout:**
- Outer container: `position: relative`, `overflow: hidden`, `w-full h-full`, `cursor-grab` (or `cursor-grabbing` when dragging)
- Attach the `containerRef` to this outer div
- Attach all mouse/touch/wheel event handlers to this outer div
- Inner transform container: a div that receives the CSS transform. Style: `transform: translate(${translateX}px, ${translateY}px) scale(${scale})`, `transform-origin: 0 0`, `will-change: transform`. If `isResetting`, also add `transition: transform 300ms ease-out`.
- Inside the transform container:
  - `<img>` element: `src={imageUrl}`, `draggable={false}`, `pointer-events: none` (prevents the browser's native image drag), `select-none`. On load, call `onImageLoad` with the image's `naturalWidth` and `naturalHeight`.
  - `{children}` — this is where map markers are rendered. They are inside the transform container so they pan/zoom with the map.

**Important:** The markers are children of the transform container, so they move with the map. However, each marker applies an inverse scale so it stays the same visual size (see Step 5.5e).

---

#### Step 5.5e: Map Marker

**File:** `src/components/maps/map-marker.tsx` — CREATE

**Props:**
- `marker: MapMarkerData` — the marker data
- `mapScale: number` — current zoom level of the map (for inverse scaling)
- `isDM: boolean` — whether the current user is a DM
- `isActive: boolean` — whether this marker's popup is currently open
- `onClick: (marker: MapMarkerData) => void` — click handler

**Layout:**
- Outer div: `position: absolute`, positioned with `left: ${marker.pos_x * 100}%` and `top: ${marker.pos_y * 100}%`
- Apply `transform: translate(-50%, -50%) scale(${1 / mapScale})` — the `translate(-50%, -50%)` centers the marker on the point, and `scale(1/mapScale)` counteracts the map zoom so the marker stays the same visual size
- Set `transform-origin: center center`

**Marker circle:**
- A div sized ~32px by 32px (at 1x scale), rounded-full
- Background color from `MARKER_CONFIG[marker.icon_type].color`
- A subtle drop shadow for depth: `shadow-lg`
- Centered icon inside: use the emoji or a Lucide icon from the config
- Icon color: white, sized ~16px

**DM visibility indicator:**
- If `isDM` is true and `marker.is_visible_to_players` is false:
  - Reduce the marker's opacity to `0.5`
  - Show a small eye-slash (EyeOff from Lucide) icon overlaid in the top-right corner of the marker, sized ~12px, in a tiny dark circle
  - This tells the DM at a glance which markers are hidden from players

**Hover effect:**
- On hover, scale up to `1.2x` (relative to the inverse-scaled size) with `transition-transform duration-150 ease-out`
- Show a tooltip with the marker label (using shadcn/ui Tooltip, or a simple title attribute for simplicity)

**Active state:**
- If `isActive` is true, add an accent-colored ring/border around the marker to indicate it is selected

**Click handling:**
- On click, call `onClick(marker)`. Stop propagation so the click does not also trigger the map's click-to-place-marker logic.

---

#### Step 5.5f: Marker Popup

**File:** `src/components/maps/marker-popup.tsx` — CREATE

**Props:**
- `marker: MapMarkerData` — the marker to display
- `isDM: boolean` — whether to show DM controls
- `mapScale: number` — current map scale (for positioning)
- `onClose: () => void` — close the popup
- `onEdit: (marker: MapMarkerData) => void` — open edit form
- `onDelete: (markerId: string) => void` — delete the marker
- `onToggleVisibility: (markerId: string, visible: boolean) => void` — toggle player visibility

**Layout:**
- A dark card (dark background, subtle border, rounded corners, drop shadow)
- Positioned near the marker. Use absolute positioning. Place it above the marker by default (with an arrow/triangle pointing down to the marker). If the marker is near the top of the viewport, position below instead. If near the left edge, shift right, and vice versa. Implement basic boundary detection to keep the popup fully visible.
- The popup should also apply inverse scaling like the markers: `transform: scale(${1 / mapScale})` so it stays readable at any zoom level
- Width: ~280-320px

**Content structure:**
1. **Header row:**
   - Left: Icon type badge — a small pill/tag showing the icon type in uppercase (e.g., "COMBAT") with the appropriate background color from `MARKER_CONFIG`
   - Right: Three-dot menu button (MoreHorizontal icon from Lucide). On click, show a dropdown menu (shadcn/ui DropdownMenu) with options:
     - "Edit Marker" — calls `onEdit(marker)`
     - "Toggle Visibility" — calls `onToggleVisibility(marker.id, !marker.is_visible_to_players)`. Label reads "Hide from Players" if currently visible, or "Show to Players" if currently hidden.
     - "Delete Marker" — calls `onDelete(marker.id)` with a confirmation step (e.g., "Are you sure?" inline or via a simple confirm dialog)
   - Only show the three-dot menu if `isDM` is true

2. **Label:** The marker's label in bold, white, text-base or text-lg (e.g., "Goblin Ambush")

3. **Description:** The marker's description in muted text, text-sm. If no description, show nothing (do not show a placeholder).

4. **Action buttons row (bottom of card):**
   - "Open Log" button — accent-colored, solid background. This is a future integration point (links to an encounter, note, or session log related to the marker). For now, it can be a placeholder button that does nothing or shows a tooltip "Coming soon."
   - "Dismiss" button — outlined/ghost style, muted. Calls `onClose()`.

5. **Arrow/triangle:** A small CSS triangle pointing from the popup toward the marker, connecting them visually. Use a `::before` or `::after` pseudo-element with border-based triangle technique, or a small rotated square.

---

#### Step 5.5g: Map Controls

**File:** `src/components/maps/map-controls.tsx` — CREATE

**Props:**
- `onZoomIn: () => void`
- `onZoomOut: () => void`
- `onReset: () => void`
- `scale: number` — current scale (to disable buttons at min/max)

**Layout:**
- Positioned in the bottom-right corner of the map viewport: `absolute bottom-4 right-4`
- A vertical stack of three square buttons (~36x36px each) with a small gap between them
- Each button has a dark semi-transparent background (`bg-card/80 backdrop-blur-sm`), subtle border, rounded corners
- Button content:
  - Zoom in: `+` character or Plus icon, white
  - Zoom out: `−` character (not a hyphen — use the minus sign `−` U+2212) or Minus icon, white
  - Reset: "RESET" text in small caps, or a Maximize icon, white
- Disable the zoom-in button when `scale >= 4.0` (reduce opacity, no pointer events)
- Disable the zoom-out button when `scale <= 0.5`

**Interaction:**
- Each button calls its respective handler
- Add hover effects: slightly lighter background on hover
- Add active/pressed effect: slightly darker background

---

#### Step 5.5h: Map Info Bar

**File:** `src/components/maps/map-info-bar.tsx` — CREATE

**Props:**
- `mapName: string`

**Layout:**
- Positioned in the bottom-left corner of the map viewport: `absolute bottom-4 left-4`
- A rounded pill shape (`rounded-full px-4 py-1.5`)
- Dark semi-transparent background (`bg-card/80 backdrop-blur-sm`), subtle border
- Content: "Viewing:" in muted monospace text, followed by the map name in accent-colored monospace text
- Example: `Viewing: Tower of Fate — Level 1`
