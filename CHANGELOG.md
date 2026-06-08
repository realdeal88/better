# Changelog

All notable changes to `better` are documented here. The format follows
[Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] — 2026-06-08

### Added

- The `better` skill: forge a rough idea into an execution-ready prompt, grounded in
  Anthropic's published prompt-engineering guidance.
- Four modes — default, `fast`, `run`, and tweak — read off the invocation.
- Eight task-type skeletons (build, fix, refactor, write, research/decide, image,
  agent-system, analysis) in `references/forge-anatomy.md`.
- A reasoning-frame phrase bank and a worked before→after example library.
- Distribution as both a Claude Code **plugin** (via marketplace) and a drop-in **skill**.
- `docs/METHODOLOGY.md` mapping every rule to its Anthropic source.
- `examples/before-after.md` showcasing forges across task types.
- CI that validates the plugin and marketplace manifests on every push.

[1.0.0]: https://github.com/realdeal88/better/releases/tag/v1.0.0
