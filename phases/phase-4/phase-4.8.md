# Phase 4.8 — Story Notes Page

**File: `src/app/(dashboard)/campaign/story-notes/page.tsx`** — MODIFY

This page uses a three-panel layout. The app's global sidebar (Panel 1) already exists. You are building Panels 2 and 3.

Set up the page container as a CSS grid: `grid-template-columns: 280px 1fr`. The app sidebar is outside this page's scope, so these two columns fill the content area. Add `overflow: hidden` on the container and `overflow-y: auto` on each panel independently so they scroll separately.

#### notes-list-panel.tsx — CREATE (Panel 2, ~280px)

**Top section:**
- A "+ New Note" button spanning the full width, accent-colored. On click, call `createNote` to insert a blank note in the database, then select it in state so the editor opens.

**Search:**
- An input with a magnifying glass icon (Lucide `Search`), placeholder "Search notes...". Debounce 300ms.

**Filter pills:**
- A horizontal row of pills/chips: "ALL" (accent filled background when active), "SESSION LOG" (green outlined), "WORLD LORE" (accent outlined, `border-[var(--color-accent)] text-[var(--color-accent)]`), "PLOT" (accent filled, `bg-[var(--color-accent)] text-white`), "DM SECRET" (red outlined).
- Only one active at a time. Clicking a pill filters the notes list to that tag. "ALL" removes the filter.

**Note cards** (scrollable list below):
- Each card shows: a small tag badge (colored by tag), the title in bold, a content preview (strip HTML tags, truncate to ~80 characters), and a relative timestamp ("2h ago", "Yesterday", etc. — use a small date utility or `date-fns`'s `formatDistanceToNow`).
- The currently selected note's card gets a highlighted background (slightly lighter or with an accent-tinted left border).
- Sort by `updated_at` descending so the most recently edited note is always on top.

#### note-editor.tsx — CREATE (Panel 3, remaining width)

**Metadata bar** at the top:
- Tag badge (same color coding as the list panel).
- "Updated [relative time] by [author name]" in muted text.
- A save status indicator on the right: "Saving..." (muted) or "Saved" (green checkmark).

**Title:**
- Render the title in a large, bold, serif-style font. It should be editable: clicking the title turns it into an input field (or use a `contentEditable` span). On blur or Enter, save.

**Tiptap editor:**

Install `@tiptap/react`, `@tiptap/starter-kit`, and any additional extensions you need (e.g., `@tiptap/extension-placeholder`).

Initialize the editor with `useEditor` from `@tiptap/react`, passing `StarterKit` (which includes bold, italic, bullet list, ordered list, headings, blockquote, and more).

The editor should have a transparent background so it inherits the dark page background. Text color should be white/light for body text. Links in accent color. Placeholder text in muted color.

**Toolbar** (`tiptap-toolbar.tsx`):
- A horizontal bar above the editor with icon buttons for: Bold (Lucide `Bold`), Italic (Lucide `Italic`), Bullet List (Lucide `List`), Heading (Lucide `Heading` — toggles H1/H2 on repeated clicks or via a small dropdown), Blockquote (Lucide `Quote`).
- Active formatting gets a highlighted/pressed button state.
- Blockquotes should render with a `border-l-[var(--color-accent)]` 3px left border and italic text (configure this in the Tiptap editor's CSS or via a custom extension style).

**Auto-save:**
- On every content change from Tiptap's `onUpdate` callback, reset a debounce timer (1 second). When it fires, call `updateNote` with the current HTML content.
- Show "Saving..." while the request is in flight, then "Saved" with a checkmark on success.

**Tag selector:**
- A dropdown (or small select) somewhere in the metadata bar letting the user change the note's tag.
- Important behavior: if the user selects "DM Secret", automatically set `is_visible_to_players` to false and show a red lock icon (Lucide `Lock`) next to the tag badge. This makes it clear the note is private.

**Empty states:**
- No notes exist at all: show a centered message in the editor panel — "Start documenting your campaign's epic story" with a button/CTA to create the first note.
- No note selected (notes exist but none is active): show "Select a note or create a new one" centered in the editor panel.

**Mobile behavior:**
On small screens, the two panels should not sit side by side. Instead, show the notes list as a full-width view. When the user taps a note card, navigate to (or transition to) the editor view full-width, with a back button/arrow in the top-left to return to the list.
