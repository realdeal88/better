# better — Prompt Forge for Claude Code

**Turn a half-formed idea into a prompt so well-scoped the run nails it on the first try — and drives itself to done without babysitting.**

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Claude Code plugin](https://img.shields.io/badge/Claude%20Code-plugin%20%2B%20skill-d97757)](https://code.claude.com/docs/en/plugins)
[![Version](https://img.shields.io/badge/version-1.0.0-success.svg)](CHANGELOG.md)
[![Grounded in Anthropic docs](https://img.shields.io/badge/grounded%20in-Anthropic%20docs-d97757.svg)](docs/METHODOLOGY.md)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![GitHub stars](https://img.shields.io/github/stars/realdeal88/better?style=social)](https://github.com/realdeal88/better)

`better` is a Claude Code slash command. You type `/better <a rough idea>`, it hands back a
clean, copy-paste-ready prompt that a high-effort model can execute without a five-round
interview. No interrogation, no template bloat — it infers the gaps, states its assumptions,
and forges instantly.

The difference from every "prompt tips" gist: **none of this is folklore.** Every rule in
`better` is distilled from Anthropic's *own* published prompt-engineering material — the
documentation, the latest-model best-practices guide, and the engineering essays on building
agents. Original source, not user anecdotes. See [the provenance](docs/METHODOLOGY.md).

---

## See it work

```text
You:   /better fast a script to dedupe my newsletter CSV

better:
       Assumptions: Python, one CSV, dedupe on email (case-insensitive), keep first occurrence.

       ┌─ forged prompt ──────────────────────────────────────────────────────────┐

       Write a Python script that de-duplicates a newsletter CSV.

       Input: a CSV with at least an `email` column; take the path as arg 1.
       Do: drop rows whose email (lowercased, trimmed) was already seen, keeping the
       first occurrence; write the result to <input>-deduped.csv and print
       "<n> dupes removed".
       Constraints: stdlib only (the csv module), don't reorder surviving rows, don't
       mutate the input file.

       Success: on a file with known dupes it produces a CSV containing exactly the
       unique emails, the printed count equals (original rows − unique rows), and
       re-running it on the output removes 0. Verify by running it on a small file
       with a planted duplicate before saying you're done.

       └──────────────────────────────────────────────────────────────────────────┘
       Run it · tweak it · or copy as-is.
```

Notice the last paragraph. **A verifiable success criterion is the whole point** — it's what
lets the downstream run loop to "done" instead of stopping at "looks plausible." A prompt
without one needs babysitting; a prompt with one drives itself.

More in [`examples/before-after.md`](examples/before-after.md).

---

## Install

`better` ships two ways. Pick whichever fits how you run Claude Code.

### Option A — as a plugin (recommended)

Add the marketplace once, then install:

```text
/plugin marketplace add realdeal88/better
/plugin install better@better
```

That's it — `/better` is live. Update later with `/plugin marketplace update better`.

### Option B — as a manual skill (no plugin system)

Drop the skill folder into your personal skills directory:

```bash
git clone https://github.com/realdeal88/better.git
mkdir -p ~/.claude/skills
cp -R better/skills/better ~/.claude/skills/better
```

Restart Claude Code. `/better` is now available. (Project-scoped? Copy into
`<your-project>/.claude/skills/better` instead.)

---

## Usage

```text
/better <idea>            forge now; asks one round only if a gap is truly blocking
/better fast <idea>       never ask — infer everything, state assumptions, forge
/better run <idea>        forge and immediately execute the forged prompt
<reply after a forge>     tweak mode — change the one thing, re-emit, no re-interview
```

It auto-classifies the idea — **build · fix · refactor · write · research/decide · image ·
agent-system · analysis** — and pulls the right structure for that type. A one-line ask stays
one line; a feature gets the full anatomy. Padding a small ask into a two-page spec is a
failure, not thoroughness.

`better` also fires on its own when you hand Claude a vague one-liner it could forge first —
phrases like *"make this prompt better,"* *"rewrite this so the model nails it,"* or
*"prompt-ify this."*

---

## What a forged prompt contains

Included as the task needs them, stable context first:

| Part | What it pins down |
| --- | --- |
| **Goal** | one sentence: what we're making and why |
| **Context** | what the model can't infer — stack, audience, constraints (`@file` refs, not pastes) |
| **The work** | concrete requirements; every adjective replaced with something checkable |
| **Approach** | "explore first, plan briefly, weigh one alternative, then execute" |
| **Success criteria** | *the most important line* — stated so the run can check itself |
| **Verification** | the mechanism that proves the criteria, run as a bug hunt |
| **Constraints / non-goals** | scope edges; both sides of every tradeoff |
| **When blocked** | state the assumption and proceed, or ask one sharp question |
| **Output shape** | the form of the deliverable |

---

## The craft (why forged prompts land)

The eight principles `better` applies, each traceable to Anthropic's guidance
([mapped here](docs/METHODOLOGY.md)):

1. **Criteria over procedures** — give a verifiable goal, not a script. The single biggest lever for an autonomous run.
2. **Specific beats vague** — replace every adjective with something checkable.
3. **Mechanisms, not exhortations** — "be accurate" adds nothing; give the method that *makes* accuracy possible.
4. **Both sides of every tradeoff** — a one-sided rule gets optimized into exactly the wrong behavior.
5. **Taste as negative constraints** — "look professional" is unverifiable; three concrete bans are.
6. **Principles over rule-lists** — write to a sharp teammate's altitude; rule lists shatter on novel input.
7. **Don't suppress reasoning** — never tell a hard task to "be brief"; you starve the thinking the answer depends on.
8. **Invoke ownership** — "use your judgment, you own the outcome" beats timid framing on ambiguous work.

---

## How it's built

```text
better/
├── skills/better/
│   ├── SKILL.md                  # the method + the rules (the command itself)
│   └── references/
│       └── forge-anatomy.md      # type skeletons, the reasoning, a worked-example library
├── docs/METHODOLOGY.md           # every rule mapped to its Anthropic source
├── examples/before-after.md      # vague → forged, across task types
├── .claude-plugin/
│   ├── plugin.json               # plugin manifest
│   └── marketplace.json          # marketplace catalog (this repo is its own marketplace)
└── …
```

A skill is just structured Markdown — open [`skills/better/SKILL.md`](skills/better/SKILL.md)
and read exactly what runs. No hidden weights, no black box. Fork it, tune the bans to your
taste, ship your own.

---

## Why trust the rules — the provenance

This is the part most prompt guides skip. `better` doesn't invent technique; it operationalizes
what Anthropic publishes. The full rule-to-source mapping lives in
**[`docs/METHODOLOGY.md`](docs/METHODOLOGY.md)**. The primary sources:

- [Prompt engineering overview](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview)
- [Claude prompting best practices](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)
- [Define success criteria & build evaluations](https://docs.anthropic.com/en/docs/test-and-evaluate/develop-tests)
- [Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) (Anthropic Engineering)
- [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) (Anthropic Engineering)
- [Prompt engineering interactive tutorial](https://github.com/anthropics/prompt-eng-interactive-tutorial)

---

## Contributing

Found a forge that misfires, or a sharper way to translate vague → verifiable? Open an issue or
PR. Patterns, not just typo fixes, are welcome — see [`CONTRIBUTING.md`](CONTRIBUTING.md).

## License

[MIT](LICENSE). Use it, fork it, ship it.
