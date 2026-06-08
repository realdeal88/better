# Contributing to better

`better` is a methodology, not a black box — the rules live in plain Markdown, so improving them
is just editing prose with care. Contributions of all sizes are welcome, from typo fixes to new
task-type skeletons.

## Ground rules

1. **Cite the source.** `better`'s credibility is that its rules trace to Anthropic's published
   guidance (see [`docs/METHODOLOGY.md`](docs/METHODOLOGY.md)). A new rule or a changed one should
   come with the source it's grounded in — a docs page, a best-practices note, an engineering
   essay. "This works for me" is a starting point for discussion, not a merge.
2. **Keep the altitude.** Write to a sharp teammate, not a lookup table. Principles generalize;
   rigid rule-lists shatter on novel input. If a change reads like a config file, it's probably
   too low.
3. **Match the weight to the task.** The skill's own rule applies to the skill: don't inflate a
   small idea into a two-page spec. Edits should make forges sharper, not longer.
4. **Every forged example needs a verifiable success criterion.** That's the whole point. An
   example prompt without one is a bug.

## What makes a great contribution

- A **vague → verifiable translation** the skill currently fumbles, with the fix.
- A **new task-type skeleton** (or a sharper version of an existing one) in
  `references/forge-anatomy.md`.
- A **concrete ban** that encodes taste better than an adjective ("no X, no Y, no Z").
- A **source citation** that strengthens a rule's grounding in `docs/METHODOLOGY.md`.

## How to contribute

1. Fork and branch (`git checkout -b improve-research-skeleton`).
2. Make the change. Test it by actually running `/better` on a few rough ideas and checking the
   forged output is sharper than before.
3. If you touched a manifest, the CI runs `jq` validation — make sure the JSON is still valid.
4. Open a PR describing **what misfired before** and **why your version forges better**, with the
   source if you changed a rule.

## Reporting a misfire

Open an issue with the exact `/better <input>` you ran and the output you got, plus what you
expected. Concrete repros make the skill better fastest.
