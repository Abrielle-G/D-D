# Phase 0.21 — ESLint, Prettier & Environment Variables

**File:** `.eslintrc.json` — MODIFY
- Extend: `["next/core-web-vitals", "next/typescript"]`
- Rules: `"no-unused-vars": "error"`, `"@typescript-eslint/no-explicit-any": "warn"`, `"@typescript-eslint/consistent-type-imports": "warn"`

**File:** `.prettierrc` — CREATE
- `{ "singleQuote": true, "semi": true, "tabWidth": 2, "trailingComma": "all", "printWidth": 100 }`

**File:** `.env.example` — CREATE
- `NEXT_PUBLIC_SUPABASE_URL=your-supabase-project-url`
- `NEXT_PUBLIC_SUPABASE_ANON_KEY=your-supabase-anon-key`
- `SUPABASE_SERVICE_ROLE_KEY=your-service-role-key`

**File:** `.env.local` — CREATE (gitignored)
- Copy of `.env.example` with placeholder values
- Instruct the executing agent to obtain actual Supabase credentials from their project dashboard

**Git Setup:**
- Initialize git repo: `git init`
- Create `.gitignore` ensuring: `.env.local`, `node_modules/`, `.next/`, `.vercel/`
- First commit: "Phase 0: Project scaffolding and design system"
- Push to GitHub
- Connect to Vercel via Git Integration for auto-deploy on push to `main`
- Set environment variables in Vercel Dashboard (same as `.env.local`)
