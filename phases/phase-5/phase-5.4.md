# Phase 5.4 — Pan/Zoom Hook

**File:** `src/hooks/use-map-interaction.ts` — CREATE

Create a custom React hook `useMapInteraction` that manages all map pan/zoom interaction state. This hook must NOT use any third-party pan/zoom library — it relies entirely on native browser events and CSS transforms.

**State:**
- `scale`: number — current zoom level, initialized to `1.0`, clamped between `0.5` and `4.0`
- `translateX`: number — horizontal pan offset in pixels, initialized to `0`
- `translateY`: number — vertical pan offset in pixels, initialized to `0`
- `isDragging`: boolean — true while the user is actively dragging the map

**Internal refs (useRef):**
- `dragStartX`, `dragStartY` — mouse/touch position at the start of a drag
- `lastTranslateX`, `lastTranslateY` — translate values at the start of a drag (so we can compute the delta)
- `initialPinchDistance` — for two-finger pinch-to-zoom on touch devices
- `initialPinchScale` — scale at the start of a pinch gesture
- `containerRef` — ref to the map container element (passed back for attachment)

**Mouse handlers:**

- **`onMouseDown(e: React.MouseEvent)`**:
  - If left button (`e.button === 0`): set `isDragging` to true, record `e.clientX` / `e.clientY` as drag start, record current `translateX`/`translateY` as last translate
  - Prevent default to avoid image selection/drag

- **`onMouseMove(e: React.MouseEvent)`**:
  - If not dragging, return early
  - Calculate delta: `deltaX = e.clientX - dragStartX`, `deltaY = e.clientY - dragStartY`
  - Set `translateX = lastTranslateX + deltaX`, `translateY = lastTranslateY + deltaY`
  - Apply bounds constraining (see below)

- **`onMouseUp()`**:
  - Set `isDragging` to false

- **`onMouseLeave()`**:
  - Set `isDragging` to false (so dragging stops if cursor leaves the container)

**Wheel handler:**

- **`onWheel(e: React.WheelEvent)`**:
  - Prevent default scroll behavior (`e.preventDefault()`)
  - Determine zoom direction: `e.deltaY < 0` means zoom in, `e.deltaY > 0` means zoom out
  - Zoom increment: `0.25` per wheel step
  - Calculate the new scale: `newScale = clamp(scale + (direction * 0.25), 0.5, 4.0)`
  - **Zoom toward cursor** (critical for natural feel):
    - Get the cursor position relative to the container: `cursorX = e.clientX - containerRect.left`, `cursorY = e.clientY - containerRect.top`
    - Calculate the point on the map the cursor is over: `pointX = (cursorX - translateX) / scale`, `pointY = (cursorY - translateY) / scale`
    - After applying the new scale, adjust translate so the same map point is still under the cursor: `newTranslateX = cursorX - pointX * newScale`, `newTranslateY = cursorY - pointY * newScale`
  - Update `scale`, `translateX`, `translateY`

**Touch handlers:**

- **`onTouchStart(e: React.TouchEvent)`**:
  - If 1 touch: start single-finger pan (same as mouse drag start, using `e.touches[0]`)
  - If 2 touches: start pinch-to-zoom. Calculate initial distance between the two fingers: `Math.hypot(t1.clientX - t2.clientX, t1.clientY - t2.clientY)`. Record as `initialPinchDistance`. Record current scale as `initialPinchScale`.

- **`onTouchMove(e: React.TouchEvent)`**:
  - If 1 touch and not pinching: calculate delta from drag start, update translate (same as mouse move)
  - If 2 touches: calculate current distance between fingers. New scale = `initialPinchScale * (currentDistance / initialPinchDistance)`, clamped to 0.5-4.0. Center the zoom between the two fingers.
  - Prevent default to stop browser zoom/scroll

- **`onTouchEnd(e: React.TouchEvent)`**:
  - If touches drop to 0: stop dragging, reset pinch state
  - If touches drop to 1: transition from pinch back to single-finger pan

**Utility functions:**

- **`zoomIn()`**: increase scale by 0.25 (clamped), zoom toward center of the container
- **`zoomOut()`**: decrease scale by 0.25 (clamped), zoom toward center of the container
- **`resetView()`**: animate back to `scale: 1.0, translateX: 0, translateY: 0`. Set a `isResetting` flag that adds a CSS transition class (`transition-transform duration-300 ease-out`) temporarily. Clear the flag after the transition ends (300ms timeout).

**Bounds constraining:**
- After any translate update, check that the map image is still at least partially visible in the container
- Compute the visible area: if the map (at current scale) would be entirely off-screen in any direction, clamp the translate to keep at least 20% of the map visible
- This prevents the user from panning the map completely out of view

**Coordinate tracking:**
- **`getMapCoordinates(clientX: number, clientY: number)`**: given a screen-space client coordinate, return the normalized (0-1) coordinates on the map image. Formula: `normalizedX = (clientX - containerRect.left - translateX) / (imageWidth * scale)`, same for Y. Clamp to 0-1. This is used for placing markers and for the coordinate bar display.

**Return value from the hook:**
```typescript
{
  scale, translateX, translateY, isDragging, isResetting,
  containerRef,
  onWheel, onMouseDown, onMouseMove, onMouseUp, onMouseLeave,
  onTouchStart, onTouchMove, onTouchEnd,
  zoomIn, zoomOut, resetView,
  getMapCoordinates,
}
```
