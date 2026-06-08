# Before → After

A gallery of forges across task types. For each: the rough line you type, **the cost of sending
it raw**, and the prompt `better` forges instead — copy-paste ready, with a success criterion
the run can verify itself against.

The shape is the lesson, not the exact words. Adapt freely.

---

## Build

**You type** — `/better a dashboard showing my app's signups`

**Raw, this costs you:** the model picks a chart library you don't use, invents a data shape,
hardcodes a range, and you re-prompt the mismatches one by one.

**Forged**

```
Build a signups dashboard for <app>, in <its stack> (read @package.json + an existing
page first to match patterns).
Show: daily signups (last 30d, line), total + week-over-week delta (stat cards), and a
table of the 20 most recent signups (email, plan, date).
Approach: explore the existing data layer and one similar page, plan briefly, then build.
Reuse the app's components and query patterns — don't introduce a new charting lib if one
exists.
Constraints: read-only; no new dependencies without saying why; match the current design,
don't redesign.
Success: it renders in the running app with real (or seeded) data, the numbers reconcile
against a raw DB count, typecheck + lint are green. Open it in the browser and screenshot
before claiming done.
```

---

## Fix / debug

**You type** — `/better the login redirect loops forever sometimes`

**Raw, this costs you:** the model caps redirects or adds a guard at the first plausible spot —
masking the symptom while the real cause survives and resurfaces later.

**Forged**

```
Fix an intermittent infinite redirect on login.
Repro: <when it happens — e.g. "after the session cookie expires mid-session, /login →
/dashboard → /login …">. Expected: an expired session lands on /login once and stays.
Likely around the auth middleware / session check (confirm before editing).
Approach: find the actual root cause — reproduce it with a failing test that simulates the
expired-session request, then fix it so the test passes. No reducing it to a redirect cap.
Success: the new test passes, the full auth suite stays green, and you've checked the same
guard isn't repeated on other protected routes.
```

---

## Refactor

**You type** — `/better split this 600-line component up`

**Raw, this costs you:** the model "improves" things you didn't ask it to, renames props, and
quietly changes behavior — now you're diffing for regressions instead of reviewing a clean split.

**Forged**

```
Refactor <Component> (~600 lines) into focused units.
Preserve: identical rendered output and props API — nothing user-visible changes.
Change: extract the data-fetching, the form state, and the list rendering into separate
units; the top-level component should read as a composition.
Don't touch: styling, the public export, or any sibling components.
Success: behaviour is identical — the existing tests pass unchanged (add a render test first
if coverage is thin). Surface, don't fix, any unrelated issues you notice along the way.
```

---

## Write / content

**You type** — `/better fast a launch tweet for my open-source CLI`

**Raw, this costs you:** "🚀 Excited to announce…" — a generic announcement that buries what the
tool does under hype no developer reads past.

> Assumptions: developer audience, goal = clicks to the repo, punchy, ≤ 280 chars.

**Forged**

```
Write a launch tweet for <CLI>, a <one-line what it does> open-source tool, for a developer
audience. Goal: get them to the repo.
Lead with the concrete pain it kills, show the one-liner that proves it, end with the link.
≤ 280 chars. Ban: "excited to announce," "game-changer," emoji-spam, hashtag soup.
Success: a dev skimming their feed gets what it does and why they'd try it in one read —
paste-ready, plus 2 alternates with different hooks.
```

---

## Research / decide

**You type** — `/better postgres or sqlite for a desktop note app`

**Raw, this costs you:** a neutral both-sides essay that lists tradeoffs and refuses to actually
decide — leaving you exactly where you started.

**Forged**

```
Decide: Postgres or SQLite for a single-user desktop note-taking app. I want a
recommendation, not a comparison.
Context: offline-first, one user, local data, must stay simple to ship and maintain solo.
Give the call + the main reason in line one, the 3 factors that matter HERE (local/offline,
zero-ops, solo-maintenance), the honest case for the other side, and what would flip it
(e.g. multi-device sync later).
Success: I close this knowing what I'm using and why, in under two minutes.
```

---

## Analysis / data

**You type** — `/better find my biggest churn month from this stripe export`

**Raw, this costs you:** "biggest" is undefined, so the model picks a metric, ignores trials and
refunds, and hands you a number you can't trust or reconcile.

**Forged**

```
From @stripe-export.csv, find the month with the highest customer churn.
Transform: group canceled subscriptions by cancellation month; churn rate = cancellations
that month ÷ active subscriptions at the start of that month.
Output: a small table (month, churn rate, raw counts) sorted by rate, plus a one-line
callout of the worst month.
Edge cases: ignore trials that never converted; treat refunds-within-24h as never-active;
use UTC for month boundaries.
Success: the rate for each month is between 0 and 1 and reconciles against a raw count of
cancellations; spot-check the worst month by hand before reporting.
```

---

## Image

**You type** — `/better an app icon for a meditation timer`

**Raw, this costs you:** a busy, generic icon — clock hands, gradients, drop shadows — that
looks like every other timer app and ignores the platform's shape rules.

**Forged**

```
App icon for a meditation timer, minimal flat-vector style. Composition: a single centered
mark — a soft concentric-ring motif suggesting a timer and calm breath. Lighting & mood:
serene, no harsh contrast. Palette: warm sand + one muted teal accent on an off-white field.
Aspect ratio: 1:1, safe margin for iOS rounding. Exclude: text, gradients-heavy skeuomorphism,
clock hands, drop shadows.
```

---

## The pattern underneath

Every forged prompt does the same three things — that's all prompt engineering really is:

1. **Replaces adjectives with checkable specifics** — "biggest" → a defined formula; "punchy"
   → "≤ 280 chars, lead with the pain."
2. **States a success criterion the run can verify itself against** — the line that lets it loop
   to done instead of stopping at "looks plausible."
3. **Names the verification mechanism** — run it, reconcile against a raw count, screenshot,
   spot-check — *before* claiming done.

`better` applies all three in one shot, every time.
