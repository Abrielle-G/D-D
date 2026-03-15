# Phase 0.7 — Create the Theme Provider

**File:** `src/components/providers/theme-provider.tsx` — CREATE

**Purpose:** React context provider that manages the active theme, applies it to the HTML element, and persists preference.

**Details:**
- Create a `ThemeContext` with `{ theme: ThemeId, setTheme: (id: ThemeId) => void, themes: typeof themes }`
- The `ThemeProvider` component:
  1. On mount: read theme from localStorage (`dd-theme` key), or use DEFAULT_THEME
  2. When theme changes: set `data-theme` attribute on `document.documentElement` (the `<html>` element) — this triggers all CSS variable overrides instantly
  3. Persist to localStorage on change
  4. Accept an optional `initialTheme?: ThemeId` prop. When provided (passed down from the authenticated dashboard layout after fetching the user's `profiles.selected_theme`), call `setTheme(initialTheme)` on mount — this overrides localStorage with the DB value so the theme is consistent across devices. The wiring of this prop is completed in Phase 1.13.
- Export `useTheme()` hook that consumes the context
- Theme switching MUST be instant — zero JS overhead, zero page reload. It's purely a CSS variable swap.
