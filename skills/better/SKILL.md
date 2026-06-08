---
name: better
description: Turn a rough, half-formed idea into a powerful, execution-ready prompt — fast. Use whenever the user types /better, or says "make this prompt better", "improve my prompt", "rewrite this so the model nails it", "turn this into a good prompt", "prompt-ify this", or hands over a vague one-liner they want sharpened before running it. Also use proactively when a request is clearly an under-specified prompt the user intends to feed to an AI and would get a far better result if it were forged first. Forges prompts grounded in Anthropic's own prompting guidance and tuned for a high-effort reasoning model (Opus 4.x): every forged prompt carries a verifiable success criterion so the downstream run drives itself to done without babysitting. Optimized for one-shot slash use — forge instantly, ask only when a gap would genuinely change the output.
---

# better — Prompt Forge

Turn a messy idea into a prompt so clear and well-scoped that the downstream run is effective on the first try and can drive itself to "done" without babysitting. The user reached for a slash command — they want this *now*, not after a five-round interview.

This skill encodes how Anthropic actually teaches prompting: state success criteria instead of procedures, wire a way for the run to check its own work, be specific, pair every hard requirement with a mechanism, and give a high-reasoning model room to plan. Type-specific skeletons, the craft's reasoning, and a worked-example library live in `references/forge-anatomy.md` — read it whenever you forge something non-trivial or want a type-specific structure.

## The one rule: forge fast, ask rarely

A weak prompt makes the model guess; a strong one makes the answer obvious. Most rough ideas already carry enough signal to forge — you fill the gaps with smart, *stated* assumptions instead of stopping to ask. Vagueness is the expensive path: a thin prompt forces the downstream run to burn context reconstructing what you meant ("just make it better" is the canonical bad prompt).

Default: **forge immediately.** Only pause when a missing detail would genuinely change what gets built *and* you can't pick a sane default. When you must ask, ask **once** via the `AskUserQuestion` tool (clickable options), 2–4 questions max, then forge. Never run multiple question rounds — that defeats the point of a slash command.

## Modes (read them off the invocation)

- **default** (`/better <idea>`) — forge now; one question round only if truly blocking.
- **fast** (`fast`, `-f`, "just forge it") — never ask. Infer everything, state assumptions in one line above the prompt, forge.
- **run** (`run`, `go`) — forge, skip confirmation, execute the forged prompt immediately.
- **tweak** (user replies after a forge) — change the one thing, re-emit the block, don't re-interview.

If the idea is already detailed, treat it as fast mode even without the flag — there's nothing worth asking.

## Method

1. **Classify** the idea — build / fix / refactor / write / research-decide / image / agent-system / analysis. The type tells you which ingredients are non-negotiable (skeletons in the reference).
2. **Ask only if blocking** — one `AskUserQuestion` round, real options, only for gaps you can't responsibly default.
3. **Forge** — assemble the anatomy below, scaled to the task. A one-line tweak stays one line; a feature gets the full structure. Padding a small ask into a two-page spec is a failure, not thoroughness.
4. **Hand off** — output the prompt as ONE fenced code block (copy-paste ready, no ASCII boxes), then one line: *Run it · tweak it · or copy as-is.* In run mode, skip the menu and execute.

## The anatomy of a forged prompt

Include as many of these as the task needs, roughly in this order (stable context first, so it reads top-down and caches well). Each line should leave a reader with no follow-up question.

- **Goal** — one sentence of intent up front: what we're making and why.
- **Context** — what the executor can't infer: stack, audience, existing system, constraints. Reference files with `@path` rather than pasting them.
- **The work** — concrete, specific requirements. Name domains, numbers, examples — not adjectives ("fast" → "loads in <1s on 3G").
- **Approach** (for anything non-trivial) — "explore the relevant code/material first, make a short plan, weigh one alternative, then execute." A high-effort model plans and self-corrects when you hand it the frame; don't script every step.
- **Success criteria** — *the most important line.* How we'll know it worked, stated so the run can check it itself. This is what lets it loop to done instead of stopping at "looks plausible." Always present for any doing-task.
- **Verification** — the mechanism that proves the criteria: run the tests / open the page / diff the output / self-review *as a bug hunt, not a confirmation* — and "don't claim done until it passes." Pair requirements with mechanisms: "be accurate" is not an instruction; "compute it with X and check against Y" is.
- **Constraints / non-goals** — scope edges and what NOT to do. State both sides of a tradeoff so the model can reason at the boundary ("optimize for clarity over cleverness — but don't ship anything unreadable").
- **When blocked** — what to do instead of stalling: state the assumption and proceed, or surface one sharp question.
- **Output shape** — the form of the deliverable.

## The craft (what makes a forged prompt land)

- **Criteria over procedures.** Give a verifiable goal, not a script. "Write tests for the invalid inputs, then make them pass" beats "add validation." This is the single biggest lever for an autonomous run.
- **Specific beats vague.** Replace every adjective with something checkable. "Clean design" → the palette, the font, the spacing scale.
- **Mechanisms, not exhortations.** Telling a model to "always be correct" adds nothing. Give it the tool/method that makes correctness possible and tell it to use it.
- **Both sides of every tradeoff.** A one-sided rule ("never escalate") gets optimized into exactly the wrong behavior. Name the cost *and* the benefit so it can judge.
- **Taste as negative constraints.** "Look professional" is unverifiable; "no drop shadows, no emoji, no thin accent lines under headings" is. Encode taste as concrete bans.
- **Principles over rule-lists.** Write to the altitude of a sharp new teammate, not a lookup table — flexible reasoning generalizes; rule lists shatter on novel input.
- **Don't suppress reasoning.** On hard tasks, never add "be brief/concise" — it starves the thinking the result depends on. Ask for the concise version of the *answer*, not of the thinking.
- **Invoke ownership.** "Use your judgment, you own the outcome" outperforms timid framing on ambiguous work.

## Translating vague → verifiable (do this every forge)

"Make it good" is not a criterion. Convert it:

- "summarize this" → "5 bullets, decisions and risks over trivia, a boss could act on it in 30 seconds"
- "build the page" → "renders correctly in Chrome, Lighthouse ≥ 90, matches `@design.png`, `npm test` + typecheck green"
- "make it look good" → name 3 concrete bans + 1 reference to match

If you can't name a checkable bar, you don't yet understand the task — *that* is the gap worth one question.

## Anti-patterns

- Interviewing when you could infer. Slash users want speed; assume and state.
- A forged prompt with no success criterion — the downstream run can't self-verify, so it needs babysitting.
- ASCII-art boxes around the prompt — they corrupt on copy and date instantly.
- Inflating a small ask into a bloated template. Match weight to task.
- "Be accurate / high-quality / professional" with no mechanism or bar behind it.

## Example

**Input:** `/better fast a script to dedupe my newsletter CSV`

> Assumptions: Python, one CSV, dedupe on email (case-insensitive), keep first occurrence.

```
Write a Python script that de-duplicates a newsletter CSV.

Input: a CSV with at least an `email` column; take the path as arg 1.
Do: drop rows whose email (lowercased, trimmed) was already seen, keeping the first
occurrence; write the result to <input>-deduped.csv and print "<n> dupes removed".
Constraints: stdlib only (the csv module), don't reorder surviving rows, don't mutate
the input file.

Success: on a file with known dupes it produces a CSV containing exactly the unique
emails, the printed count equals (original rows − unique rows), and re-running it on
the output removes 0. Verify by running it on a small file with a planted duplicate
before saying you're done.
```
> Run it · tweak it · or copy as-is.

For type-specific skeletons (build, fix, refactor, write, research, image, agent, analysis), the reasoning behind each craft rule, and a fuller before→after library, read `references/forge-anatomy.md`.
