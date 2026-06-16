<div align="center">

# better

### Prompt engineering, in one keystroke.

**A Claude Code skill that forges a half-formed idea into a precise, self-verifying prompt — instantly.**
No five-round interview. One line in, a prompt the model can execute on the first try and drive to *done* on its own.

[![License: CC BY-ND 4.0](https://img.shields.io/badge/license-CC%20BY--ND%204.0-blue.svg)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-plugin%20%2B%20skill-d97757)](https://code.claude.com/docs/en/plugins)
[![Version](https://img.shields.io/badge/version-1.0.0-success.svg)](CHANGELOG.md)
[![Grounded in Anthropic docs](https://img.shields.io/badge/grounded%20in-Anthropic%20docs-d97757.svg)](docs/METHODOLOGY.md)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![GitHub stars](https://img.shields.io/github/stars/realdeal88/better?style=social)](https://github.com/realdeal88/better)

<br>

<img src="assets/demo.gif" alt="better forging a vague 'make my app faster' into a precise, self-verifying prompt with a target, scope, and a verifiable finish condition" width="840">

</div>

---

When you work with a capable model, the prompt *is* the interface. A vague prompt makes it
guess — wrong stack, wrong scope, happy-path only — and you pay for the guess in rework. A
well-engineered prompt makes the right answer obvious and lets the run check its own work.

Prompt engineering is the skill that closes that gap. `better` makes it a reflex: you type
`/better <whatever you've got>`, and it hands back a prompt built the way Anthropic's own
documentation says to build one — specific, structured, and carrying a **verifiable success
criterion** so the run loops to done instead of stopping at "looks plausible."

The whole point is **speed**: you reached for a slash command, so it forges *now*. It infers the
gaps, states its assumptions out loud, and never interrogates you. Rough idea → strong prompt,
in one shot.

<sub>**Contents** · [The difference](#the-difference) · [Install](#install) · [Usage](#usage) · [Anatomy](#what-a-forged-prompt-contains) · [Principles](#the-eight-principles) · [Provenance](#why-trust-it--the-provenance) · [Contributing](#contributing)</sub>

---

## The difference

Same eight words, typed by a developer in a hurry. On the left, what the model actually
receives without `better`. On the right, what `/better` forges from it — instantly.

> **You type:** `/better add password reset to my app`

<table>
<tr>
<th>⛔ The raw prompt (the model guesses)</th>
<th>✅ What <code>better</code> forges (the model knows)</th>
</tr>
<tr>
<td valign="top">

```text
add password reset to my app
```

**What you get back:** the model invents a
stack, picks an email library you don't use,
makes up a token scheme, ships the happy path,
and skips the security parts it wasn't told to
care about — no expiry, no rate limit, no
session invalidation, no tests.

You spend the next hour reviewing and
re-prompting the gaps. The prompt did the
guessing; *you* became the error handler.

</td>
<td valign="top">

```text
Add a password-reset flow to <app>. Read @auth/
and @package.json first and match the existing
session + mailer patterns — don't add a new lib
if one's already wired.

Flow: request reset by email → single-use token
(hashed at rest, 1h expiry) → reset form checks
the token → password updated, all existing
sessions invalidated, confirmation email sent.

Constraints: identical response whether or not
the email exists (no account enumeration);
rate-limit per email and per IP; tokens are
one-time and expire. Don't touch the login flow.

Approach: read the existing auth code, sketch
the token model, then build test-first.

Success: one test drives the whole path —
request → token consumed → password changed →
old sessions rejected → token can't be reused;
invalid / expired / used tokens all covered.
Suite + typecheck green before you call it done.
```

</td>
</tr>
</table>

Look at the last paragraph on the right. **That success criterion is the engine.** It turns an
open-ended request into a goal the run can verify against — so it self-corrects to done instead
of handing you something that merely compiles. Everything else `better` does is in service of
producing that line, fast.

See the gallery — build, fix, refactor, write, research, data, image — in
**[`examples/before-after.md`](examples/before-after.md)**.

---

## Install

Two ways. Pick whichever matches how you run Claude Code.

### As a plugin — recommended

```text
/plugin marketplace add realdeal88/better
/plugin install better@better
```

`/better` is live immediately. Update later with `/plugin marketplace update better`.

### As a manual skill — no plugin system

```bash
git clone https://github.com/realdeal88/better.git
mkdir -p ~/.claude/skills
cp -R better/skills/better ~/.claude/skills/better
```

Restart Claude Code and `/better` is available. For a single project, copy into
`<your-project>/.claude/skills/better` instead.

---

## Usage

Built for one-shot speed. The mode is read off the invocation — you rarely type more than the
idea itself.

| Command | Behavior |
| --- | --- |
| `/better <idea>` | Forge now. Asks **one** round only if a gap would genuinely change the output. |
| `/better fast <idea>` | Never ask. Infer everything, state assumptions in one line, forge. |
| `/better run <idea>` | Forge **and** immediately execute the result. |
| *reply after a forge* | Tweak mode — change the one thing, re-emit, no re-interview. |

It auto-classifies the idea — **build · fix · refactor · write · research/decide · image ·
agent-system · analysis** — and pulls the right structure for that type. Weight scales to the
task: a one-line ask stays one line; a feature gets the full anatomy. Inflating a small request
into a two-page spec is treated as a failure, not thoroughness.

`better` also fires on its own when you hand Claude a vague one-liner it could sharpen first —
*"make this prompt better," "rewrite this so the model nails it," "prompt-ify this."*

---

## What a forged prompt contains

A forge assembles only the parts the task needs, stable context first so it reads top-down:

| Part | What it pins down |
| --- | --- |
| **Goal** | one sentence — what we're making and why |
| **Context** | what the model can't infer: stack, audience, constraints (`@file` refs, never pastes) |
| **The work** | concrete requirements; every adjective replaced with something checkable |
| **Approach** | "explore first, plan briefly, weigh one alternative, then execute" |
| **Success criteria** | *the most important line* — written so the run can verify itself |
| **Verification** | the mechanism that proves it, run as a bug hunt — "don't claim done until it passes" |
| **Constraints / non-goals** | scope edges; both sides of every tradeoff |
| **When blocked** | state the assumption and proceed, or ask one sharp question |
| **Output shape** | the form of the deliverable |

---

## The eight principles

The prompt-engineering rules `better` applies on every forge. Each traces to Anthropic's
published guidance — the full source map is in [`docs/METHODOLOGY.md`](docs/METHODOLOGY.md).

1. **Criteria over procedures** — give a verifiable goal, not a step-by-step script. The single biggest lever for an autonomous run.
2. **Specific beats vague** — replace every adjective with something checkable. "Fast" → "loads in <1s on 3G."
3. **Mechanisms, not exhortations** — "be accurate" adds nothing; give the method that *makes* accuracy possible.
4. **Both sides of every tradeoff** — a one-sided rule gets optimized into exactly the wrong behavior at the boundary.
5. **Taste as negative constraints** — "look professional" is unverifiable; three concrete bans are.
6. **Principles over rule-lists** — write to a sharp teammate's altitude; rigid lists shatter on novel input.
7. **Don't suppress reasoning** — never tell a hard task to "be brief"; you starve the thinking the answer depends on.
8. **Invoke ownership** — "use your judgment, you own the outcome" beats timid framing on ambiguous work.

---

## Why trust it — the provenance

Most prompt guides are folklore: one lucky run generalized into a rule. `better` is the
opposite. It doesn't invent technique — it operationalizes what **Anthropic publishes**. Every
rule is mapped to its source in **[`docs/METHODOLOGY.md`](docs/METHODOLOGY.md)**. The primaries:

- [Prompt engineering overview](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview)
- [Claude prompting best practices](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)
- [Define success criteria & build evaluations](https://docs.anthropic.com/en/docs/test-and-evaluate/develop-tests)
- [Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) — Anthropic Engineering
- [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) — Anthropic Engineering
- [Prompt engineering interactive tutorial](https://github.com/anthropics/prompt-eng-interactive-tutorial)

---

## How it's built

A skill is structured Markdown — no weights, no black box. Open it and read exactly what runs.

```text
better/
├── skills/better/
│   ├── SKILL.md                  # the method, the modes, the craft rules — the command itself
│   └── references/
│       └── forge-anatomy.md      # type skeletons, the reasoning, a worked-example library
├── docs/METHODOLOGY.md           # every rule mapped to its Anthropic source
├── examples/before-after.md      # vague → forged, across task types
└── .claude-plugin/
    ├── plugin.json               # plugin manifest
    └── marketplace.json          # marketplace catalog (this repo is its own marketplace)
```

Fork it, tune the bans to your taste, ship your own. Start at
[`skills/better/SKILL.md`](skills/better/SKILL.md).

---

## Contributing

A sharper vague→verifiable translation, a new task-type skeleton, a better-grounded rule — all
welcome. The one rule: a rule change should cite the Anthropic source it comes from. See
[`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

[CC BY-ND 4.0](LICENSE). Use it and share it freely — unchanged, and credited to me.
