## What this changes

<One or two sentences. What does a forge do better after this PR?>

## What misfired before

<The concrete behavior you're fixing — paste a `/better` input + the weaker output if you have
it.>

## Why this version forges better

<The reasoning. If you changed or added a rule, cite the Anthropic source that grounds it — see
docs/METHODOLOGY.md.>

## Checklist

- [ ] Every forged example I added carries a **verifiable success criterion**.
- [ ] The change keeps the **right altitude** (principle, not rigid rule-list).
- [ ] It doesn't inflate small asks — weight matches the task.
- [ ] If I touched a manifest, `jq empty` still passes (CI checks this).
- [ ] If I changed a rule, I cited its source.
