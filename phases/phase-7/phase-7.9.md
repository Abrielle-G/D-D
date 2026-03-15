# Phase 7.9 — "Not AI-Generated" Checklist

**Purpose:** Final audit specifically targeting signs that make projects look AI-generated.

**Details:**

Go through this checklist and fix any violations:

- [ ] **No generic placeholder text.** Replace ALL "Lorem ipsum" or "Enter text here" with RPG-themed placeholder text. "wizard@citadel.com" not "user@email.com". "Search the rogue's gallery..." not "Search..."
- [ ] **No default component library styling.** Every shadcn component should be customized — the buttons should have the right accent gradient, cards should have the custom border/shadow, inputs should have the dark bg.
- [ ] **Consistent typography hierarchy.** Verify the 3 font families are used correctly everywhere: serif display for page titles and hero text, Inter for body/labels/UI, JetBrains Mono for numbers/dice/stats/code.
- [ ] **The noise texture overlay is working.** Very subtle (opacity 0.03) grain texture over the background — adds depth that flat CSS backgrounds lack.
- [ ] **Status bar has page-specific content.** Not the same text on every page — each page has its own flavor text.
- [ ] **Card borders have subtle glow effects.** On hover, the border should have a very faint accent-colored glow (box-shadow with low opacity accent color).
- [ ] **Sidebar active state is distinctive.** Not just a color change — it's a left border + tinted background + text color change.
- [ ] **Color coding is consistent.** Green = success/high/active. Red = danger/low/crit fail. Purple = accent/primary/crit success. Yellow/amber = medium/warning. Cyan = secondary/data. This should be consistent EVERYWHERE.
- [ ] **Monospace numbers.** All stat numbers, probabilities, dice notations, and coordinates use JetBrains Mono — not the body font.
- [ ] **Themed form labels.** All labels are uppercase, letter-spaced (0.05-0.1em), small (11-12px), muted color — matching the mockup aesthetic.
- [ ] **No unstyled native elements.** Every scrollbar, select dropdown, and range slider should be custom-styled.
- [ ] **Theming is thorough.** Switching themes changes: accent colors, card border glows, sidebar active states, probability bar gradients, button colors, status bar text, background texture. It should feel like a different skin, not just one color changing.
- [ ] **Hover effects on every interactive element.** Nothing should feel "dead" — every button, card, link, nav item, toggle should have a hover/active state.
- [ ] **Rounded avatars, not squares.** All user/character avatars are circular.
- [ ] **Proper icon usage.** Icons from Lucide React (or Material Symbols as seen in mockups) — consistently sized (16-20px for inline, 24px for standalone), same stroke width.
