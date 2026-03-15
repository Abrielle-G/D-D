# Phase 0.5 — Set Up shadcn/ui

**Purpose:** Initialize shadcn/ui and install base components that will be customized.

**Details:**
- Run `npx shadcn-ui@latest init` — choose: style "Default", base color "Slate", CSS variables YES
- Install these components: `button`, `input`, `select`, `textarea`, `badge`, `card`, `dialog`, `dropdown-menu`, `separator`, `toggle`, `tooltip`, `tabs`, `slider`, `switch`, `avatar`, `sheet` (for mobile sidebar), `command` (for search), `sonner` (for toasts)
- After installation, immediately go to `src/app/globals.css` and verify the shadcn CSS variables are overridden by the RPG theme colors from Step 0.4. If shadcn generated its own `:root` block, merge it with the theme variables — the RPG values take priority.
- Create `src/lib/utils.ts` containing the `cn()` helper function using `clsx` and `tailwind-merge`:
  - This function merges class names with Tailwind conflict resolution
  - This is referenced by every shadcn component
