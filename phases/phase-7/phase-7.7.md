# Phase 7.7 — Animations & Micro-Interactions

**Purpose:** Add the subtle animations that make the app feel alive and hand-crafted. This is what separates an AI-generated project from a human one.

**Details:**

**Page transitions:**
- Fade-in on page load: content fades in from opacity 0 → 1, with a slight translateY from 8px → 0, duration 200ms, ease-out
- Apply to the main content area on route change

**Card hover effects:**
- All cards: hover lifts 2px (translateY(-2px)), border brightens to hover color, shadow deepens, transition 150ms ease
- This should already be in the card component from Phase 0 — verify it works everywhere

**Probability bar animation:**
- Bar segments grow from left to right on load, staggered by 50ms per segment, duration 600ms, ease-out
- The large probability percentage number should count up from 0 to the final value over 400ms

**Sidebar transitions:**
- Collapse animation: width 260px → 64px, text opacity 1 → 0 (fade out), icons stay centered, duration 200ms ease

**Button interactions:**
- Primary buttons: scale(0.98) on active/click (press effect), duration 100ms
- Ghost buttons: background fades in on hover, duration 150ms

**Toggle/Switch animation:**
- Thumb slides smoothly, track color transitions, duration 200ms

**Toast entrance:**
- Slides in from the right, slight bounce, fade in, duration 300ms

**Loading skeletons:**
- Pulse animation: opacity 0.4 → 1.0 → 0.4, duration 1.5s, ease-in-out, infinite

**Bayes sliders:**
- As the user drags a slider, the result number should count up/down smoothly (not jump)
- System log entries should slide in from the top with a slight delay

**Map markers:**
- Markers appear with a subtle pop-in animation when the map loads (scale 0 → 1 with bounce)
- Marker popup fades in with a slight translateY

All animations should respect `prefers-reduced-motion: reduce` — disable all non-essential animations for users who have this OS setting enabled.
