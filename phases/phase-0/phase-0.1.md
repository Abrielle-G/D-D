# Phase 0.1 — Initialize Next.js Project

**Purpose:** Create the base Next.js project with all dependencies.

**Details:**
- Run `npx create-next-app@latest dice-and-decisions` with options: TypeScript YES, ESLint YES, Tailwind CSS YES, `src/` directory YES, App Router YES, import alias `@/*`
- After creation, install production dependencies:
  - `@supabase/supabase-js` and `@supabase/ssr` — Supabase client for auth and DB
  - `recharts` — charting for probability distributions
  - `@tiptap/react`, `@tiptap/starter-kit`, `@tiptap/extension-placeholder` — rich text editor
  - `lucide-react` — primary icon library
  - `zustand` — lightweight state management for role/theme/UI state
  - `zod` — schema validation
  - `react-hook-form` and `@hookform/resolvers` — form management
  - `clsx` and `tailwind-merge` — conditional class names utility
  - `sonner` — toast notifications (pairs with shadcn)
- No additional dev dependencies beyond what create-next-app provides
