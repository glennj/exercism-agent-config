# Track structure

How the MoonScript track repository is organized.
Read this before adding, moving, or editing track content.

## Repository hierarchy

- `exercises/practice/<slug>/`: practice exercises.
- `exercises/shared/.docs/`: `help.md` and `tests.md`, shown to students on every exercise.
- `exercises/shared/templates/generator.tmpl`: starting point for a new exercise's test generator.
- `exercises/concept/` and `concepts/`: empty placeholders; the track has no concepts or concept exercises yet.
- `config.json`: track-level configuration.
- `docs/`: track-level documentation for students and the website, indexed by `docs/config.json`.
- `bin/`: track tooling (see below).
- `lib/`: Lua helpers for test generator templates.
  `spec_helpers.moon` formats test data, and `spec_helpers/assertions.moon` holds custom assertions.
- `canonical-data/`: local, git-ignored cache of `problem-specifications` data.
- `.appends/`: repository-specific additions to Exercism's org-wide files.
- `.github/workflows/`: CI.
- [`CONTRIBUTING.md`](../../CONTRIBUTING.md): how to contribute, add exercises, and write generator templates.
- [`STYLE.md`](../../STYLE.md): the MoonScript style guide.

## Tooling

| Script | Purpose |
| --- | --- |
| `bin/add-practice-exercise` | scaffold a new practice exercise |
| `bin/generate-spec` | generate an exercise's test file from its template |
| `bin/verify-exercises` | test example solutions locally |
| `bin/verify-exercises-in-docker` | test example solutions with the test runner image |
| `bin/fetch-configlet`, `bin/fetch-configlet.ps1` | download `configlet` into `bin/` |

## Practice exercise layout

Practice exercises live in `exercises/practice/<slug>/`.
Read each exercise's `.meta/config.json` to confirm its configured filenames.
`<snake_slug>` is the slug with hyphens replaced by underscores.

- `<snake_slug>.moon`: student-facing stub; normally remains incomplete.
- `<snake_slug>_spec.moon`: `busted` tests delivered to students.
- `.busted`: `busted` configuration, identical in every exercise.
- `.meta/example.moon`: reference solution; must pass all tests.
- `.meta/generator.tmpl`: test-generation template, when present.
- `.meta/tests.toml`: canonical test selection and metadata, when the exercise has canonical data.
- `.meta/config.json`: exercise metadata and file mappings.
- `.docs/instructions.md`: student-facing instructions.
- `.docs/introduction.md`, `.docs/instructions.append.md`, `.docs/hints.md`: optional student-facing documentation.

An exercise may list extra files under `files.editor`.
For example, `markdown` shows students the Lua code (`markdown.lua`) that they translate.

## Slugs that differ from `problem-specifications`

An exercise entry in `config.json` may set `problem_specifications_slug`.
The `say-numbers` exercise uses the canonical data for `say`.
The older `say` exercise is deprecated but still in the repository.
