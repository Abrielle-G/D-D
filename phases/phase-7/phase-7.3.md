# Phase 7.3 — Toast Notifications

**File:** `src/components/shared/toast-provider.tsx` — CREATE
**Purpose:** Toast notification system for success/error/info messages.

**Details:**
- Use shadcn/ui Toast component (Sonner) or implement a simple toast system
- Toast types: success (green accent), error (red accent), info (cyan accent), warning (amber accent)
- Position: top-right of the viewport
- Auto-dismiss after 4 seconds
- Dark-themed toasts matching the app's design (NOT white default toasts)
- Usage throughout the app:
  - "Character saved" (success) after editing character sheet
  - "NPC created" (success) after creating an NPC
  - "Failed to save" (error) on database errors
  - "Encounter deleted" (info) after deletion
  - "Theme updated" (success) after switching themes
  - "Please fill in all required fields" (warning) on validation errors
