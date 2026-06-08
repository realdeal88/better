# Forge Anatomy — type skeletons, the craft's reasoning, and worked examples

Read this when forging anything non-trivial. `SKILL.md` carries the method and the rules; this carries the type-specific skeletons, *why* each craft rule exists, a reasoning-frame phrase bank for high-effort Opus runs, and a before→after library. **Adapt, never paste** — scale every skeleton to the actual task and drop any line it doesn't need. A two-line ask must not become a two-page spec.

---

## Why these rules (the grounding, in one line each)

Straight from Anthropic's own prompting/agent guidance:

- **Criteria over procedures** — models loop exceptionally well toward a goal they can check; a step-by-step script fights their own planning. The verifiable goal is the autonomy engine.
- **Structure is signal** — if a reader can't tell context from constraint from output spec, neither can the model. Separate the parts.
- **Instructions don't add capability** — "be accurate" changes nothing; a *mechanism* (a tool, a test, a computation) does. Pair every hard requirement with one.
- **Both sides of a tradeoff** — a capable model optimizes hard for whatever you tell it; a one-sided rule produces exactly the wrong behavior at the boundary. Give it the cost *and* the benefit.
- **Principles over rules** — rule lists break on novel inputs; principles generalize. Write to a sharp teammate's altitude.
- **Plan before acting** — the current Opus plans, reads first, and catches its own faults *while planning* if you give it the frame; you don't script the steps, you invite the plan.
- **Verify as a bug hunt** — "find the problems," not "check that it's fine." Reasons before scores. Don't stop until one fix-and-verify cycle has completed.
- **Don't suppress thinking** — effort is a dial, not a prompt instruction; never tell a hard task to "be concise" (you starve the reasoning). Ask for a concise *answer*, not concise *thinking*.

---

## Type skeletons

Each lists the must-nail ingredients, then a skeleton to adapt.

### Build / feature
**Must nail:** one-line goal · stack & constraints · concrete capabilities · data/state shape · explore-then-plan instruction · success criteria + how to verify · explicit non-goals.
```
Build <X> in <stack>.
Context: <where it lives / how it connects / who uses it; @relevant-files>.
Do: <specific capabilities, each concrete>.
Approach: read <the relevant existing code> first, sketch a short plan, then build.
Constraints / non-goals: <scope edges; what NOT to touch; both sides of any tradeoff>.
Success: <verifiable end state>. Verify by <run the app / tests / open the page> and
fix everything red before claiming done.
```

### Fix / debug
**Must nail:** exact symptom & repro · expected vs actual · likely location · root-cause-first, test-first discipline.
```
Fix: <symptom>. Repro: <steps / input>. Expected <X>, got <Y>.
It likely lives around <area/@file>, but confirm before changing anything.
Approach: find the root cause first; write a failing test that reproduces it, then make
it pass. No band-aids, no masking the symptom.
Success: the new test passes, the existing suite stays green, and the same bug class is
checked for elsewhere in the code.
```

### Refactor
**Must nail:** behaviour to preserve · what to change · what not to touch · green-tests bar.
```
Refactor <target> to <goal>.
Preserve: <behaviour/public API that must not change>.
Change: <what should differ>.  Don't touch: <out-of-scope areas>.
Success: behaviour is identical — the existing tests pass unchanged (add tests first if
coverage is thin). Surface, don't fix, any unrelated issues you notice.
```

### Write / content
**Must nail:** audience · goal/CTA · voice & length · must-hit points · clichés to ban · a voice sample if one exists.
```
Write <artifact> for <audience>, to <goal/CTA>.
Include: <the points that must land>.  Voice: <tone>, <length>.
Ban: <clichés / filler / words to avoid>.  <@sample of the target voice, if any.>
Success: <reader-side outcome> — e.g. "send-ready, no edits needed," or "a skim in
30s tells them <the one thing>."
```

### Research / decide
**Must nail:** the precise question · the decision it informs · hard constraints · what a good answer contains · cite & verify.
```
<The exact question>. I need a recommendation, not a neutral both-sides essay.
Context / constraints: <budget, region, timeframe, who it's for>.
Give: a direct call in the first line + the reason, the 3–4 factors that actually matter
HERE, the strongest case for the option you didn't pick, and what would change the call.
Verify claims against sources; flag anything you're inferring vs. know.
Success: I can decide in two minutes of reading with no lingering doubt.
```

### Image
**Must nail:** subject · style/medium · composition · lighting & mood · palette · aspect ratio · exclusions.
```
<subject>, <style/medium>. Composition: <framing/angle>. Lighting & mood: <...>.
Palette: <colors>.  Aspect ratio: <e.g. 3:2>.  Exclude: <what must not appear>.
```

### Agent / system prompt
**Must nail:** the agent's job · its tools & boundaries · tone · success criteria · failure handling. (Keep the always-true identity lean; push task-specific knowledge to skills/tools rather than bloating the system prompt.)
```
You are <role> whose job is <single clear mission>.
Tools: <what it has; let it decide when to use them — don't pre-route>.
Boundaries: <what it must never do; when to hand back to a human>.
Tone: <...>.
Success per task: <verifiable>. On failure: <reason about what changed and try a
different approach; if genuinely blocked, <escalation>>.
```

### Analysis / data
**Must nail:** the dataset · the question · the transformation · output format · edge cases.
```
From <dataset/@file>, answer <question>.
Transform: <the operation; the columns/keys involved>.
Output: <table / chart / number / json shape>.
Edge cases: <nulls, dupes, timezones, units>.
Success: <a spot-checkable result> — e.g. "totals reconcile to <known figure>."
```

---

## Reasoning-frame phrase bank (for high-effort Opus runs)

Drop these into the **Approach / Verification / When-blocked** lines. They set the frame a strong reasoning model already wants — without scripting its steps or suppressing its thinking.

**Plan first:** "Before writing anything, read the relevant code/material and lay out a short plan." · "Weigh at least one alternative before committing." · "Compose a plan with a high likelihood of success, then execute."

**Self-correct:** "If a step fails, reason about what changed and try a *different* approach — don't repeat the same fix." · "If you spot a better path mid-way, say so and switch."

**Verify:** "Prove it works before claiming done — run <the check>." · "Review your own output as a bug hunt: assume there are problems and find them; list reasons before any verdict." · "Don't stop until one fix-and-verify cycle has completed clean."

**Judgment / ownership:** "Use your judgment — you own the outcome." · "Apply taste here; ship the version a senior would be proud of."

**Avoid (these quietly degrade a hard run):** "be brief / concise / quick" on reasoning-heavy work · "just do exactly these steps" (scripts out the model's planning) · stacking impossible-scenario error handling the task never asked for · one-sided rules with no benefit named.

---

## Worked examples (before → after)

**Build —** `/better a dashboard showing my app's signups`
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

**Fix —** `/better the login redirect loops forever sometimes`
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

**Write —** `/better fast a launch tweet for my open-source CLI`
> Assumptions: developer audience, goal = clicks to the repo, punchy, ≤ 280 chars.
```
Write a launch tweet for <CLI>, a <one-line what it does> open-source tool, for a developer
audience. Goal: get them to the repo.
Lead with the concrete pain it kills, show the one-liner that proves it, end with the link.
≤ 280 chars. Ban: "excited to announce," "game-changer," emoji-spam, hashtag soup.
Success: a dev skimming their feed gets what it does and why they'd try it in one read —
paste-ready, plus 2 alternates with different hooks.
```

**Decide —** `/better postgres or sqlite for a desktop note app`
```
Decide: Postgres or SQLite for a single-user desktop note-taking app. I want a
recommendation, not a comparison.
Context: offline-first, one user, local data, must stay simple to ship and maintain solo.
Give the call + the main reason in line one, the 3 factors that matter HERE (local/offline,
zero-ops, solo-maintenance), the honest case for the other side, and what would flip it
(e.g. multi-device sync later).
Success: I close this knowing what I'm using and why, in under two minutes.
```
