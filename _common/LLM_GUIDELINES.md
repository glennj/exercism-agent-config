# LLM guidelines: where information goes

Coding agents working in this repository are configured through a few files.
This page tells maintainers what information belongs in which file, so each fact lives in one place and the files stay useful to both people and agents.

## Where information goes

| Location | Holds | Audience |
| --- | --- | --- |
| `AGENTS.md` | Rules that apply to _any_ Exercism track: how to behave, scope, finishing checklist, an index of the topic docs | Agents |
| `docs/track_topics/*.md` | Facts about _this_ track: layout, conventions, commands, workflows | Maintainers, contributors, agents |
| `.agents/skills/<name>/SKILL.md` | A repeatable, multi-step procedure with inputs and a defined outcome | Agents |
| `docs/*.md` (existing) | Exercism-facing track docs (syllabus, student guides, maintainer welcome) | Students, maintainers |

Quick test:

- Would the sentence still be true in the Python track? Put it in `AGENTS.md`.
- Is it a fact or convention about this track? Put it in a topic doc.
- Is it a "do these steps in order" recipe? Make it a skill.
- Is it aimed at students or the Exercism website? Use the existing `docs/` files.

## Keeping `AGENTS.md` track-agnostic

- Keep it short; link to topic docs instead of restating them.
- Do not name track tools, languages, file extensions, or directories there.
- When a general rule needs a track-specific detail, state the rule in `AGENTS.md` and the detail in a topic doc.

## Writing a topic doc

- One topic per file, named for the topic (`validation.md`, not `misc.md`).
- Write for humans first; agents benefit from the same clarity.
- One sentence per line, which keeps diffs small.
- Prefer exact, runnable commands in fenced code blocks, and say what prerequisites they need.
- State what is true now; do not describe aspirations.
- Link to existing docs (for example [docs/MAINTAINING.md](docs/MAINTAINING.md)) rather than copying them.
- Add the new doc to the table in [docs/track_topics/README.md](docs/track_topics/README.md) with a "read it when you are..." entry.

## Writing a skill

A skill is a directory `.agents/skills/<name>/` containing a `SKILL.md`.
Use one for a repeatable, multi-step procedure with defined inputs and a defined outcome, such as scaffolding a new exercise.
Facts and conventions belong in a topic doc; a skill should link to them rather than repeat them.

- Agents discover skills by scanning `.agents/skills/*/SKILL.md` and reading the `name` and `description` in each file's frontmatter.
  That is the catalog; do not add a README or an index of skills, because agents will not read it and it would drift out of date.
- Do not list individual skills in `AGENTS.md`.
  It only says that skills live in `.agents/skills/` and should be used when their description matches the task.
- Make `description` say both what the skill does and when to use it, in one or two sentences.
  The agent decides whether to load the skill from the description alone.
- Make `name` match the directory name.
- List the inputs the skill needs and tell the agent to ask for any that are missing.
- Say how to verify the result, using the commands from the validation topic doc.
- Keep `SKILL.md` focused on the procedure.
  Move long reference material into separate files in the skill directory and link to them.
- When a skill's procedure changes, or the facts it relies on change, update it in the same PR.

## Changing the docs

- When a tool, script, or convention changes, update the topic doc in the same PR.
- When you split or rename a doc, fix links in `README.md`, other topic docs, and `AGENTS.md`.
- Delete facts that are no longer true instead of leaving them with caveats.

## Using this layout in another track

1. Use the same `AGENTS.md`; it should need no edits.
2. Add this file at the repository root.
3. Create `docs/track_topics/` with a `README.md` index and topic docs for that track's layout, conventions, validation, and exercise maintenance.
4. Keep the same file names where the topic is the same, so agents find them predictably.
