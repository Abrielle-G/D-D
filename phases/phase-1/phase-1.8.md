# Phase 1.8 — Create Auth Validation Schemas

**File:** `src/lib/validations/auth.ts` -- CREATE

**Purpose:** Zod validation schemas for the login and signup forms. These run on the client side before any Supabase call, providing instant feedback.

**Details:**

1. Import `z` from `zod`.

2. **`loginSchema`:**
   ```
   email: z.string().email('Please enter a valid email address')
   password: z.string().min(6, 'Password must be at least 6 characters')
   ```

3. **`signupSchema`:**
   ```
   display_name: z.string()
     .min(2, 'Hero name must be at least 2 characters')
     .max(50, 'Hero name must be under 50 characters')
   email: z.string().email('Please enter a valid email address')
   password: z.string()
     .min(6, 'Password must be at least 6 characters')
     .regex(/[a-zA-Z]/, 'Password must contain at least one letter')
     .regex(/[0-9]/, 'Password must contain at least one number')
   ```

4. **`forgotPasswordSchema`:**
   ```
   email: z.string().email('Please enter a valid email address')
   ```

5. Export the inferred TypeScript types from each schema:
   ```typescript
   export type LoginFormData = z.infer<typeof loginSchema>
   export type SignupFormData = z.infer<typeof signupSchema>
   export type ForgotPasswordFormData = z.infer<typeof forgotPasswordSchema>
   ```
