# Phase 2.6 — Settings Page

**File:** `src/app/(dashboard)/settings/page.tsx` -- MODIFY

This file should already exist as a placeholder. Replace or update its content.

**Instructions:**

1. Async Server Component.
2. Fetch the user profile (display name, email, avatar URL, preferred role, selected theme).
3. Render the settings page as a single scrollable column with sections separated by generous vertical spacing.
4. Section order (top to bottom):
   - `<ThemeSelector />` -- with the current theme passed as prop.
   - `<ProfileForm />` -- with current profile data.
   - `<SystemPreferences />` -- with current preferred role.
   - `<AccountManagement />`.

---

#### 2.6.1 -- Theme Selector

**File:** `src/components/settings/theme-selector.tsx` -- CREATE

**Must be a client component** (`"use client"`).

**Props:** `currentTheme: string`

**Layout and styling instructions:**

- Section heading: `"Theme"` in bold white ~20px. Below it, a muted description: `"Choose your visual experience"` or similar.
- Render 5 theme cards in a responsive grid: 3 columns on the first row, 2 columns on the second row (centered). On mobile, stack to 1 column.
- Each theme card is approximately 200px wide (or flex-grow to fill the grid cell) and approximately 120-140px tall.
- **Card contents:**
  - Background: a gradient fill unique to the theme (covering the full card). The gradient should use the theme's two or three primary colors.
  - Centered vertically: a Lucide icon (~32px) above the theme name.
  - Theme name in bold white ~16px.
  - A short one-line description in smaller muted text ~12px.
- **Theme definitions:**
  1. **Fantasy** -- Purple gradient (`from-purple-900 to-indigo-800`), `Sparkles` icon, description "Classic fantasy adventure".
  2. **Sci-Fi** -- Cyan/dark blue gradient (`from-cyan-900 to-blue-950`), `Rocket` icon, description "Futuristic space theme".
  3. **Western** -- Amber/brown gradient (`from-amber-900 to-yellow-800`), `Star` icon, description "Rugged frontier style".
  4. **Eldritch** -- Green/dark gradient (`from-emerald-900 to-gray-950`), `Eye` icon, description "Dark cosmic horror".
  5. **Steampunk** -- Gold/brown gradient (`from-yellow-800 to-stone-900`), `Cog` icon, description "Victorian industrial".
- **Selected state:** The currently selected theme card gets:
  - A green checkmark icon (`Check` or `CheckCircle`) positioned in the top-right corner of the card.
  - An accent-colored border (2px solid accent color).
  - Slightly elevated shadow or brightness.
- **Click behavior:** When a card is clicked:
  - Update local state immediately (optimistic UI -- the checkmark moves instantly).
  - Call the ThemeProvider's `setTheme()` function (from Phase 0's theme context) so the entire app re-renders with the new theme's CSS variables immediately.
  - Fire a Supabase update to save the selected theme to the user's profile row. Use a debounced or fire-and-forget approach so the UI does not wait for the DB round-trip.
  - If the DB update fails, show a small toast notification but do not revert the theme (the user can try again).

---

#### 2.6.2 -- Profile Form

**File:** `src/components/settings/profile-form.tsx` -- CREATE

**Must be a client component.**

**Props:** `profile: { displayName: string, email: string, avatarUrl: string | null }`

**Layout and styling instructions:**

- Section heading: `"Profile"` in bold white ~20px.
- **Avatar area:**
  - Display a circular image, approximately 80px diameter, showing the current avatar. If no avatar, show a placeholder with user initials or a generic icon on a dark background.
  - Below or beside the avatar, render a small `"Upload"` button or clickable area.
  - Helper text below: `"JPG or PNG. Max 2MB."` in muted gray ~12px.
  - On upload: use Supabase Storage to upload the image to a `avatars` bucket, then update the profile row's `avatar_url` with the public URL. Show a loading spinner on the avatar during upload.
- **Display Name input:**
  - Label: `"DISPLAY NAME"` (uppercase, small, muted, letter-spaced).
  - A shadcn/ui `Input` component with dark background styling, pre-filled with the current display name.
- **Email input:**
  - Label: `"EMAIL ADDRESS"` (same label style).
  - A shadcn/ui `Input` component, pre-filled with the email, but with `disabled` attribute and a visually distinct "read-only" appearance (even more muted than normal, perhaps with a lock icon).
- **Save button:**
  - Below the form fields, a `"Save Changes"` button in accent color.
  - On click: validate that display name is not empty (1-50 characters). If invalid, show inline error text.
  - Submit the update to Supabase (update the profile row). Show loading state on the button. On success, show a success toast. On failure, show an error toast.
  - After successful save, trigger a refetch of the sidebar's user data so the display name and avatar update there too.

---

#### 2.6.3 -- System Preferences

**File:** `src/components/settings/system-preferences.tsx` -- CREATE

**Must be a client component.**

**Props:** `currentRole: 'dm' | 'player'`

**Layout and styling instructions:**

- Section heading: `"System Preferences"` in bold white ~20px.
- **Default Role setting:**
  - A row with: label `"Default Role"` on the left in white ~16px, and a brief description below it in muted text: `"Choose which dashboard view loads by default"`.
  - On the right side of the row: a segmented toggle with two segments:
    - Left segment: `"DM"`.
    - Right segment: `"Player"`.
  - The active segment has an accent-colored filled background with white text. The inactive segment has a dark background with muted text.
  - Build this toggle using two adjacent buttons wrapped in a container with `overflow-hidden` and rounded corners. Or use a shadcn/ui `ToggleGroup` if available and style it accordingly.
- **Click behavior:** When the toggle changes:
  - Update local state immediately.
  - Fire a Supabase update to set `preferred_role` on the user's profile.
  - Update the RoleProvider context (from Phase 0/1) so the sidebar and other role-aware components re-render immediately.
  - No need to redirect; the change takes effect next time the user visits the dashboard.

---

#### 2.6.4 -- Account Management

**File:** `src/components/settings/account-management.tsx` -- CREATE

**Must be a client component.**

**Props:** None.

**Layout and styling instructions:**

- Section heading: `"Account"` in bold white ~20px.
- **Sign Out button:**
  - A full-width button with dark background (not accent-colored -- use a muted/secondary variant). Text: `"Sign Out"`.
  - On click: call Supabase `signOut()`, then redirect to the login page using `router.push('/login')` or `router.refresh()`.
- **Danger Zone:**
  - Below the sign-out button, add a visually separated "danger zone" area with:
    - A heading in red: `"Danger Zone"` in bold ~16px.
    - A warning paragraph in muted text: `"Deleting your account is permanent and cannot be undone. All your campaigns, characters, and data will be lost."`.
    - A `"Request Deletion"` button with a red border, red text, transparent background. Not filled red -- just outlined in red.
    - On click: show a confirmation dialog (use shadcn/ui `AlertDialog`) that forces the user to type "DELETE" to confirm. If confirmed, call a server action or API route that handles account deletion (can be stubbed for now with a toast saying "Deletion requested -- this feature is coming soon"). Do not actually delete anything yet.
