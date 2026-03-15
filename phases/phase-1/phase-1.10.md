# Phase 1.10 — Build the Auth Pages (Login & Sign Up)

#### Part A: Auth Layout

**File:** `src/app/(auth)/layout.tsx` -- CREATE

**Purpose:** A dedicated layout for auth pages that has NO sidebar and NO topbar -- just a full-screen dark background with centered content.

**Details:**

1. This is a **server component** (no `'use client'` directive needed).
2. Accept `children` as a prop (standard Next.js layout).
3. Render:
   - An outer `<div>` that fills the full viewport: `min-h-screen`, `flex`, `flex-col`, `items-center`, `justify-center`, `p-4`
   - Background color: `bg-[#08080d]` (the "arcane void" color)
   - A noise texture overlay: an absolutely-positioned `<div>` covering the full area with `opacity-[0.02]`, `pointer-events-none`, and a CSS noise SVG background image (use the same inline SVG data URI from the mockup's `.bg-void::before` pseudo-element, but as a regular div since pseudo-elements are harder with Tailwind)
   - Two gradient blobs for ambient lighting (positioned absolutely, behind content):
     - A large centered purple radial gradient: `w-[800px] h-[800px]`, `radial-gradient(circle, rgba(124,58,237,0.04) 0%, transparent 70%)`, `blur(300px)`, positioned at center
     - A smaller cyan radial gradient: `w-[600px] h-[600px]`, `radial-gradient(circle, rgba(6,182,212,0.03) 0%, transparent 70%)`, `blur(250px)`, positioned at bottom-left
   - A `<main>` with `relative z-10 w-full flex flex-col items-center` that wraps `{children}`
4. Do NOT include any sidebar, topbar, or navigation elements.

#### Part B: Login Page

**File:** `src/app/(auth)/login/page.tsx` -- MODIFY (replace placeholder content)

**Purpose:** The sign-in page, matching the design mockup exactly. This is the first screen users see.

**Details:**

1. Mark as `'use client'` -- this page uses form state, the auth hook, and event handlers.

2. **Imports:**
   - `useState` from `react`
   - `useRouter` from `next/navigation`
   - `Link` from `next/link`
   - `useAuth` from `@/hooks/use-auth`
   - `loginSchema` and `LoginFormData` from `@/lib/validations/auth`
   - `Loader2` icon from `lucide-react` (for the loading spinner)

3. **State:**
   - `email: string` (empty initial)
   - `password: string` (empty initial)
   - `errors: Record<string, string>` (field-level validation errors, keyed by field name)
   - `authError: string | null` (top-of-form error from Supabase)
   - `isSubmitting: boolean` (loading state for the button)
   - `showForgotPassword: boolean` (toggles between login form and forgot-password form)

4. **Form submission handler (`handleSubmit`):**
   - Prevent default form submission
   - Clear previous errors
   - Parse the form data through `loginSchema.safeParse({ email, password })`
   - If validation fails, extract the field errors from the Zod result and set them in `errors` state. Format: `{ email: "error message", password: "error message" }`
   - If validation passes, set `isSubmitting = true`, call `signIn(email, password)` from the auth hook
   - If `signIn` returns an error, set `authError` to the error string, set `isSubmitting = false`
   - If success, the hook handles the redirect via `router.refresh()` and the middleware redirects to `/dashboard`

5. **Forgot password handler:**
   - When `showForgotPassword` is true, show a simplified form with just the email field and a "Send Reset Link" button
   - On submit, call `resetPassword(email)` from the auth hook
   - Show a success message: "Check your email for a password reset link"
   - Provide a "Back to Sign In" link to toggle back

6. **JSX structure** (matching the mockup pixel-for-pixel):

   ```
   <header> (centered text, mb-8)
     <div> (centered icon container, mb-3)
       Purple d20 icon -- use a Lucide dice icon or the Font Awesome fa-dice-d20 equivalent.
       Since the project uses Lucide (via shadcn), use the `Dice6` or a custom SVG.
       Alternatively, use an inline SVG of a d20 die shape.
       Style: text-[40px] equivalent size, text-[#7c3aed] color
     </div>
     <h1 class="font-space text-[22px] font-bold text-[#f1f5f9] tracking-tight">
       Dice & Decisions
     </h1>
     <p class="text-[#475569] text-[13px] mt-1">
       Probability-Powered Campaign Command
     </p>
   </header>

   <section class="auth-card"> (the card container)
     Background: bg-[#111119]
     Border: border border-[#1e1e2e], plus a top border with purple tint:
       border-t border-t-purple-500/10
     Shadow: shadow-[0_25px_50px_-12px_rgba(0,0,0,0.5)]
     Width: w-full max-w-[420px]
     Rounded: rounded-xl
     Padding: p-8

     <nav> (tab bar, mb-8)
       Flex container with border-b border-[#1e1e2e]
       Two elements:
       - "Sign In" -- active state: text-[#f1f5f9] font-medium text-sm,
         with border-b-2 border-[#7c3aed] pb-3, flex-1
       - "Sign Up" -- inactive: text-[#475569] font-medium text-sm pb-3 flex-1.
         This is a <Link href="/signup"> so clicking it navigates to the signup page.
         On hover: text-[#94a3b8]
     </nav>

     {authError && (
       <div> (error alert at top of form)
         Red background: bg-red-500/10, border border-red-500/20, rounded-lg, p-3, mb-4
         Text: text-red-400 text-sm
         Display the authError message
       </div>
     )}

     <form onSubmit={handleSubmit} class="space-y-5">

       <div> (email field group)
         <label class="block text-xs font-medium text-[#94a3b8] uppercase tracking-wider mb-2">
           Sanctum Email
         </label>
         <input
           type="email"
           value={email}
           onChange={...}
           placeholder="wizard@citadel.com"
           className: bg-[#16161f] border border-[#1e1e2e] text-[#f1f5f9]
             rounded-lg px-4 py-3 text-sm w-full
             focus:border-[#7c3aed] focus:ring-2 focus:ring-purple-500/20
             focus:outline-none
             placeholder:text-[#475569]
           If errors.email, add border-red-500 instead of border-[#1e1e2e]
         />
         {errors.email && <p class="text-red-400 text-xs mt-1">{errors.email}</p>}
       </div>

       <div> (password field group)
         <div class="flex justify-between items-center mb-2">
           <label class="block text-xs font-medium text-[#94a3b8] uppercase tracking-wider">
             Secret Cypher
           </label>
           <button
             type="button"
             onClick={() => setShowForgotPassword(true)}
             class="text-xs text-[#7c3aed] hover:text-[#a78bfa] transition-colors"
           >
             Forgot password?
           </button>
         </div>
         <input
           type="password"
           value={password}
           onChange={...}
           placeholder="••••••••"
           className: same as email input styling
           If errors.password, add border-red-500
         />
         {errors.password && <p class="text-red-400 text-xs mt-1">{errors.password}</p>}
       </div>

       <button
         type="submit"
         disabled={isSubmitting}
         className: bg-[#7c3aed] hover:bg-[#6d28d9] active:scale-[0.98]
           w-full py-3.5 rounded-lg text-white font-semibold text-sm
           shadow-lg shadow-purple-900/20
           transition-all
           disabled:opacity-50 disabled:cursor-not-allowed
       >
         {isSubmitting ? (
           <Loader2 className="w-4 h-4 animate-spin mx-auto" />
         ) : (
           'Enter the Tower'
         )}
       </button>

       <div> (OR divider)
         <div class="relative py-4 flex items-center">
           <div class="flex-grow border-t border-[#1e1e2e]" />
           <span class="flex-shrink mx-4 text-[#475569] text-xs font-medium uppercase tracking-widest">
             or
           </span>
           <div class="flex-grow border-t border-[#1e1e2e]" />
         </div>
       </div>

       <button
         type="button"
         disabled
         className: w-full flex items-center justify-center gap-3
           bg-transparent border border-[#1e1e2e]
           text-[#475569] py-3 rounded-lg text-sm
           cursor-not-allowed opacity-50
       >
         Google SVG icon (use the same inline SVG from the mockup code.html)
         Continue with Google
       </button>
       <p class="text-center text-[#475569] text-[10px]">Coming soon</p>

     </form>
   </section>

   <footer class="mt-8 text-center">
     <p class="text-[#475569] text-xs font-medium tracking-wide italic">
       Built for DMs who think in probabilities
     </p>
   </footer>
   ```

7. **Font requirements:** The heading "Dice & Decisions" uses the `font-space` class (Space Grotesk). The body text uses DM Sans (the default font). Ensure these fonts are loaded in the root layout or the auth layout. If Phase 0 already configured these fonts, they should be available. If not, import them in the auth layout's `<head>` or via `next/font/google`.

#### Part C: Signup Page

**File:** `src/app/(auth)/signup/page.tsx` -- MODIFY (replace placeholder content)

**Purpose:** The sign-up page -- structurally identical to the login page but with the Sign Up tab active and an additional "Hero Name" field.

**Details:**

1. Mark as `'use client'`.

2. Same imports as login, but use `signupSchema` and `SignupFormData` instead.

3. **State:** Same as login, plus `displayName: string` (empty initial).

4. **Differences from login:**
   - The tab bar has "Sign Up" as the active tab (purple underline) and "Sign In" as inactive (links to `/login`).
   - An additional field appears ABOVE the email field:
     ```
     <label class="...">Hero Name</label>
     <input type="text" value={displayName} placeholder="Gandalf the Grey" ... />
     ```
     The label uses the same uppercase/tracking style: `"HERO NAME"`.
   - The submit button text is `"Begin Your Quest"` instead of `"Enter the Tower"`.
   - On submit, validate with `signupSchema.safeParse({ display_name: displayName, email, password })`.
   - Call `signUp(email, password, displayName)` from the auth hook.
   - On success: if email confirmation is disabled (recommended for MVP), the user is automatically signed in and the middleware redirects to `/dashboard`. If email confirmation IS enabled, show a success message instead of redirecting: "Check your email to verify your account before signing in." Display this in a green-tinted alert box (bg-green-500/10, text-green-400).

5. **Everything else** (card styling, background, header, footer, Google button, error handling) is identical to the login page. Extract shared components if desired, but it is acceptable to duplicate the structure for clarity since there are only two auth pages.
