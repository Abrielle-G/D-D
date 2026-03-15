# Phase 2.9 — Polish Status Bar

**File:** `src/components/layout/status-bar.tsx` -- MODIFY

The status bar is a thin fixed bar at the very bottom of the viewport (below all content, like an IDE status bar).

**Styling instructions:**

- Fixed position bottom, full width, height 32px.
- Background: `#3a3a5c` or a dark muted purple-gray from the design system.
- Font: JetBrains Mono (or `font-mono` fallback), size 11px, muted gray text color (~`text-gray-400`).
- Content is horizontally padded and vertically centered.
- All text is uppercase.

**Page-specific flavor text:**

The status bar text must change based on the current page. Use `usePathname()` from `next/navigation` to determine the route and display the corresponding text.

- **Dashboard** (`/dashboard`): `"SYSTEM_STATUS: NOMINAL -- SESSION: ACTIVE -- PLAYERS: 4 -- ENCOUNTERS: 7"`
- **Probability** (`/probability`): `"CALC_ENGINE: v4.2 -- PRECISION: 10^-6 -- MODE: COMBINATORICS"`
- **Campaign** (`/campaign`): `"DUNGEON_BIAS: MINIMAL -- SEED: 0x8F2A -- INK_LEVEL: FULL"`
- **Maps** (`/maps`): `"SYNCED -- MAP_VERSION: 1.0.4-BETA -- GRID: 32px"`
- **Settings** (`/settings`): `"CONFIG_MODE: ACTIVE -- CHANGES: UNSAVED -- PROFILE: LOADED"`
- **Default** (any other page): `"READY -- AWAITING INPUT"`

These are purely decorative/atmospheric strings. The numbers do not need to be dynamic (they can be hardcoded for now), but the Dashboard line could optionally pull real player count and encounter count if readily available.

Make the status bar a client component since it needs `usePathname()`.
