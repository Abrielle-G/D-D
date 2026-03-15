# Phase 7.2 — Error Handling

**File:** `src/lib/errors.ts` — CREATE
**Purpose:** Centralized error handling utilities.

**Details:**
- Custom error classes:
  - `AppError` — base class with message, code, and user-friendly message
  - `AuthError` — authentication failures (expired session, invalid credentials)
  - `DatabaseError` — Supabase query failures
  - `ValidationError` — form validation failures
  - `StorageError` — file upload failures
- `getErrorMessage(error: unknown): string` — converts any error into a user-friendly message. NEVER expose internal error messages, stack traces, or database details to the user.
  - Supabase "Invalid login credentials" → "Invalid email or password. Please try again."
  - Network error → "Unable to connect. Check your internet connection and try again."
  - 404 → "This content doesn't exist or has been removed."
  - RLS violation → "You don't have permission to access this content."
  - General → "Something went wrong. Please try again."

**File:** `src/app/error.tsx` — CREATE
**Purpose:** Global error boundary for the app.

**Details:**
- Client component with `"use client"` directive
- Catches unhandled errors in route segments
- Renders a themed error card matching the app's design (NOT a plain white error page):
  - Dark background with the app's design system
  - Error icon (AlertTriangle from Lucide, in red)
  - "Something Went Wrong" heading in display font
  - User-friendly error message
  - "Try Again" button (calls the `reset()` function)
  - "Go to Dashboard" link
- Log errors to console in development, suppress in production

**File:** `src/app/not-found.tsx` — CREATE
**Purpose:** Custom 404 page matching the app's design.

**Details:**
- Themed 404 page (not the default Next.js 404):
  - Dark background with noise texture
  - Large "404" in muted display font
  - "Lost in the Dungeon" heading
  - "The page you're looking for has vanished into the Shadow Realm." description
  - "Return to Dashboard" accent button
  - Optional: d20 logo icon for flair
