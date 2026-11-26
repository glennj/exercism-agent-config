# Exercism Track Agent Instructions

## LLM behaviour

Behavioral guidelines to reduce common LLM coding mistakes.
Adapted from [andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills), which is inspired by Andrej Karpathy's observations on LLM coding pitfalls.

**Tradeoff:** These guidelines bias toward caution over speed.
For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume.**
**Don't hide confusion.**
**Surface tradeoffs.**

Before implementing:

- State your assumptions explicitly.
  If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so.
  Push back when warranted.
- If something is unclear, stop.
  Name what's confusing.
  Ask.

### 2. Simplicity First

**Minimum code that solves the problem.**
**Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?"
If yes, simplify.

### 3. Surgical Changes

**Touch only what you must.**
**Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria.**
**Loop until verified.**

Transform tasks into verifiable goals:

- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:

```text
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently.
Weak criteria ("make it work") require constant clarification.

## Scope

This repository maintains an Exercism track: exercises, tests, example solutions, documentation, configuration, and track tooling.

Students solve exercises on the Exercism website or in their own Exercism CLI workspaces.
Do not treat this repository as a student workspace or fill in student stubs with completed solutions.

Follow the track's policies and style guide, as named in the topic docs.
Keep changes scoped to the requested exercise or track component, preserve existing work, and avoid unrelated formatting or generated-file churn.

## Track documentation

Track-specific information lives in `docs/track_topics/`.
Start with `docs/track_topics/README.md`, then read the topic doc for the area you are working in before making changes:

- `track-structure.md`: repository hierarchy and exercise layout.
- `exercise-maintenance.md`: changing exercises, generated tests, and canonical data.
- `<language>-conventions.md`: coding conventions and diagnostic-output rules for the track's language.
- `validation.md`: checks to run after changes.

If a topic doc is missing or contradicts the repository, report it rather than guessing.

## Skills

Task-specific skills live in `.agents/skills/`.
Use a skill when its description matches the task.

## Markdown style

Markdown documents in this repository should use "ventilated prose": one sentence per line.
This keeps diffs focused on the sentences that actually changed, which makes code review easier.
Additionally, ensure that both headers and lists have a blank line before and after them.

## Finishing

Before finishing, inspect the relevant diff and working-tree status.
Run the checks described in the track's validation doc.
Report which checks ran and any that could not run; never claim unrun checks passed.
Do not install global dependencies without approval.
