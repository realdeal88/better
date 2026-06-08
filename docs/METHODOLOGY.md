# Methodology — what `better` is actually built on

Most "prompt engineering tips" are folklore: one person's lucky run, generalized into a rule,
passed around until it sounds like fact. `better` is built the other way around. Every rule it
applies is distilled from **Anthropic's own published prompt-engineering material** — the
documentation, the latest-model best-practices guide, the evaluation guidance, and the
engineering essays on building agents. Original source, not user anecdotes.

This document exists so you don't have to take that on faith. Below, each principle `better`
uses is mapped to the Anthropic source it comes from.

## Primary sources

| Source | What it grounds |
| --- | --- |
| [Prompt engineering overview](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview) | The "start from success criteria + evals" framing; the whole technique stack |
| [Claude prompting best practices](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices) | Be clear and direct; examples & edge cases; structure; right altitude; explicit modifiers |
| [Define success criteria & build evaluations](https://docs.anthropic.com/en/docs/test-and-evaluate/develop-tests) | Verifiable, measurable success criteria as the foundation of a prompt |
| [Building Effective Agents](https://www.anthropic.com/engineering/building-effective-agents) | Criteria over procedures; give the model tools/mechanisms; let it plan; ownership |
| [Effective Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) | Stable context first; lean, high-signal context; don't bloat the prompt |
| [Prompt engineering interactive tutorial](https://github.com/anthropics/prompt-eng-interactive-tutorial) | The worked, example-first teaching of every technique above |

> Anthropic split its docs across `docs.anthropic.com`, `platform.claude.com`, and
> `code.claude.com` in 2026; the links above are stable and redirect to the current canonical
> pages.

## Rule → source map

**1. Criteria over procedures — state a verifiable goal, not a script.**
Anthropic's guidance opens prompt engineering with *defining success criteria and building
evaluations* before you write the prompt, and *Building Effective Agents* makes the point that
agents loop toward a goal they can check. A step-by-step script fights that loop; a checkable
target feeds it. → *Define success criteria*, *Building Effective Agents*.

**2. Specific beats vague — replace every adjective with something checkable.**
The best-practices guide says to *treat Claude like a new intern on their first day* and give
*clear, explicit instructions with all the necessary detail.* "Fast" becomes "loads in <1s on
3G." → *Claude prompting best practices (be clear and direct)*.

**3. Mechanisms, not exhortations — pair every hard requirement with a method.**
Telling a model to "be accurate" adds no capability. Anthropic's agent guidance is about giving
the model *tools* and the eval guidance is about *measuring* — the mechanism is what makes the
requirement achievable. → *Building Effective Agents*, *Define success criteria*.

**4. Both sides of every tradeoff — name the cost and the benefit.**
The latest-model best practices stress being explicit about what you want, because a capable
model optimizes hard for whatever you specify. A one-sided rule ("never escalate") gets
optimized into exactly the wrong behavior at the boundary; stating the tradeoff lets the model
judge. → *Claude prompting best practices*.

**5. Taste as negative constraints — encode taste as concrete bans.**
The guide recommends *realistic, specific examples — including challenging examples and edge
cases* — so the model knows exactly what you want, and what you don't. "Look professional" is
unverifiable; "no drop shadows, no emoji, no thin accent lines" is. → *Claude prompting best
practices (examples & edge cases)*.

**6. Principles over rule-lists — write to the right altitude.**
Anthropic's agent guidance explicitly calls for instructions *at the right altitude for the
agent* — neither hardcoded logic nor vague gestures. Principles generalize to novel input; rule
lists shatter on it. → *Building Effective Agents*, *Claude prompting best practices*.

**7. Don't suppress reasoning — never tell a hard task to "be brief."**
Anthropic's *let Claude think* / chain-of-thought guidance shows that giving the model room to
reason improves hard-task outcomes. Telling it to "be concise" starves that reasoning. Ask for
a concise *answer*, not concise *thinking*. → *Prompt engineering (let Claude think)*.

**8. Invoke ownership — frame the model as owning the outcome.**
Role and system-prompt guidance shows that a clear identity and mission lift performance on
ambiguous work. "Use your judgment, you own the outcome" outperforms timid framing. → *Prompt
engineering (system prompts / giving Claude a role)*, *Building Effective Agents*.

**9. Structure is signal — separate context from constraint from output spec.**
Anthropic's *use XML tags* / structure guidance: if a reader can't tell the parts apart,
neither can the model. `better` orders a forged prompt stable-context-first so it reads
top-down. → *Prompt engineering (use XML tags / structure)*.

**10. Plan before acting — invite the plan, don't script the steps.**
The latest best practices encourage letting the model plan and self-correct. `better` adds an
*Approach* line ("explore first, plan briefly, weigh one alternative, then execute") rather than
enumerating steps. → *Claude prompting best practices*, *Building Effective Agents*.

**11. Verify as a bug hunt — prove it, don't just assert it.**
The eval-first philosophy carries into verification: "find the problems," reasons before
verdict, one fix-and-verify cycle before "done." → *Define success criteria & build
evaluations*.

**12. Lean, stable context first — high signal, no bloat.**
*Effective Context Engineering* argues for the smallest high-signal context and putting stable
material first. `better` references files with `@path` instead of pasting them, and refuses to
inflate a small ask into a two-page spec. → *Effective Context Engineering for AI Agents*.

## What `better` is *not*

- Not a wrapper that calls an API. It's a Markdown skill — the rules are the artifact.
- Not a guarantee. Anthropic's own guidance notes that not every failing eval is best fixed by
  prompting; sometimes the answer is a different model, a tool, or an eval. `better` makes the
  prompt as strong as the rules allow — it doesn't replace measuring the result.
- Not frozen. As Anthropic publishes new guidance, the rules here should track it. PRs that
  cite a source are the way to evolve it.
