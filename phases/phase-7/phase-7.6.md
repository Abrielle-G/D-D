# Phase 7.6 — Accessibility Basics

**Purpose:** Ensure the app is minimally accessible (not full WCAG compliance, but the basics).

**Details:**
- All interactive elements must be keyboard-focusable (Tab navigation works through all buttons, inputs, links)
- Focus indicators: visible focus ring on all interactive elements (2px outline in accent color, offset 2px) — don't rely on browser defaults which may be invisible on dark backgrounds
- All images must have alt text (map images: "Campaign map: [map name]", NPC images: "[NPC name] portrait")
- Form labels: all inputs must have associated labels (the uppercase labels in the design serve as visual labels — ensure they're also `<label>` elements with `htmlFor`)
- Color contrast: verify all text meets WCAG AA contrast ratio (4.5:1 for body text, 3:1 for large text) — the dark theme with light text should pass, but verify muted text colors
- Semantic HTML: use `<nav>`, `<main>`, `<section>`, `<article>`, `<header>`, `<footer>` appropriately
- Skip navigation link: hidden link at the top of the page that becomes visible on focus: "Skip to main content"
- Aria labels for icon-only buttons (sidebar collapsed mode, zoom controls, etc.)
