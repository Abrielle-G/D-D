# Phase 0.7 — Create the Theme Provider

**File:** `src/components/providers/theme-provider.tsx` — CREATE

**Purpose:** React context provider that manages the active theme, applies it to the HTML element, and persists preference.

**Details:**
- Create a `ThemeContext` with `{ theme: ThemeId, setTheme: (id: ThemeId) => void, themes: typeof themes }`
- The `ThemeProvider` component:
  1. On mount: read theme from localStorage (`dd-theme` key), or use DEFAULT_THEME
  2. When theme changes: set `data-theme` attribute on `document.documentElement` (the `<html>` element) — this triggers all CSS variable overrides instantly
  3. Persist to localStorage on change
  4. When user is authenticated (later in Phase 1), also persist to the user's `selected_theme` DB field
- Export `useTheme()` hook that consumes the context
- Theme switching MUST be instant — zero JS overhead, zero page reload. It's purely a CSS variable swap.
