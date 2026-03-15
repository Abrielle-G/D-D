# Phase 7.10 — Final Vercel Deployment

**Purpose:** Deploy the production build to Vercel.

**Details:**
- Verify all environment variables are set in the Vercel Dashboard:
  - `NEXT_PUBLIC_SUPABASE_URL`
  - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
  - `SUPABASE_SERVICE_ROLE_KEY`
- Push all code to the `main` branch on GitHub
- Vercel auto-deploys from GitHub (configured in Phase 0)
- After deployment:
  - Test the production URL end-to-end: signup → login → dashboard → probability tools → campaign management → maps → settings → logout
  - Verify environment variables are working (Supabase connection)
  - Run the seed script against the production Supabase database (or seed via SQL in the Supabase Dashboard)
  - Test on an actual mobile device (not just DevTools responsive mode)
  - Test on multiple browsers: Chrome, Firefox, Safari (if available)
- Check for console errors in production (should be zero)
- Verify fonts load correctly in production (no FOUT)
