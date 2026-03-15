# Phase 7.8 — Performance Optimization

**Purpose:** Fast load times and smooth interactions.

**Details:**
- **Images:** All images in `public/images/` should use Next.js `<Image>` component with lazy loading, proper width/height/sizes attributes, and WebP format where possible
- **Font loading:** Use `next/font/local` for Inter and JetBrains Mono (loaded from `public/fonts/` as variable fonts) — this prevents font flash (FOIT/FOUT) and is faster than Google Fonts CDN
- **Code splitting:** Each route in the App Router is automatically code-split. Verify that the Tiptap editor, Recharts, and map interaction code are only loaded on the pages that use them (they shouldn't bloat the dashboard bundle).
- **Recharts lazy loading:** Import Recharts components with `dynamic(() => import(...), { ssr: false })` — charts don't need SSR
- **Supabase client:** Verify the client is created once and reused (not recreated on every render)
- **Debouncing:** Verify all auto-save operations use 500ms debounce
- **CSS:** Tailwind's purge should remove unused styles. Verify the production build doesn't include unused CSS.
- Run Lighthouse audit: target scores of 85+ for Performance, 90+ for Accessibility, 90+ for Best Practices
