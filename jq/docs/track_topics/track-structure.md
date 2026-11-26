# Track structure

How the jq track repository is organized.
Read this before adding, moving, or editing track content.

## Repository hierarchy

- `exercises/practice/<slug>/`: practice exercises.
- `exercises/concept/<slug>/`: concept exercises.
- `exercises/shared/.docs/`: student-facing documentation shared by the exercises (`help.md`, `tests.md`, `debug.md`).
- `concepts/<slug>/`: concept documentation (`about.md`, `introduction.md`, `links.json`, `.meta/config.json`).
- [`config.json`](../../config.json): track-level configuration, including the default exercise filenames under `files` and the list of foregone exercises.
- `docs/`: track-level documentation, indexed by [`docs/config.json`](../config.json), plus the code snippets `SNIPPET.txt` and `SIGN_UP_SNIPPET.txt`.
- `bin/`: track tooling (see below).
- `lib/`: the master copies of the Bats helpers that every exercise carries, and some jq modules (`misc.jq`, `permutations.jq`).
  See [`lib/README.md`](../../lib/README.md).
- `.github/`: CI workflows, the pull request template, and `required-checks.yml`.
- `.appends/`: repository-specific additions to Exercism's org-wide files.
- [`README.md`](../../README.md): explains why the foregone exercises are not implemented.
- [`CONTRIBUTING.md`](../../CONTRIBUTING.md): how to create concepts, port practice exercises, and rate difficulty.
- [`.prettierignore`](../../.prettierignore): files excluded from Prettier, with usage notes.
- `.lycheeignore`: URL patterns excluded from the link check.

## Tooling

| Script | Purpose |
| --- | --- |
| `bin/add-exercise` | scaffold a new practice exercise |
| `bin/test-generator` | generate practice exercise test files from templates (Python) |
| `bin/validate_one_exercise` | test one exercise's reference solution |
| `bin/validate_exercises` | test every exercise's reference solution |
| `bin/pr` | CI helper: validate the exercises that own the files given as arguments |
| `bin/fetch-configlet`, `bin/fetch-configlet.ps1` | download `configlet` into `bin/` |

## Practice exercise layout

Practice exercises live in `exercises/practice/<slug>/`.
Read each exercise's `.meta/config.json` to confirm its configured filenames.
The filenames keep the hyphens of the slug.

- `<slug>.jq`: student-facing stub; normally remains incomplete.
- `test-<slug>.bats`: Bats tests delivered to students.
- `bats-extra.bash`: bundled copy of the `bats-support` and `bats-assert` libraries.
- `bats-jq.bash`: the track's `jq` wrapper and extra assertions.
- `.meta/example.jq`: reference solution; must pass all tests.
- `.meta/template.j2`: test-generation template, when present.
- `.meta/tests.toml`: canonical test selection and metadata.
- `.meta/config.json`: exercise metadata and file mappings.
- `.docs/instructions.md`: student-facing instructions.
- `.docs/introduction.md`, `.docs/instructions.append.md`: optional student-facing documentation.

The `eliuds-eggs` exercise is an exception to the naming rule: its files are `pop-count.jq` and `test-pop-count.bats`.

Deprecated exercises stay in the repository and are marked with `"status": "deprecated"` in `config.json`.

## Concept exercise layout

Concept exercises live in `exercises/concept/<slug>/`.

- `<slug>.jq`: student-facing stub.
- `test-<slug>.bats`: tests delivered to students.
- `bats-extra.bash`, `bats-jq.bash`: as in practice exercises.
- `.meta/exemplar.jq`: reference solution; must pass all tests.
- `.meta/design.md`: learning objectives, scope, and prerequisites.
- `.meta/config.json`: exercise metadata and file mappings.
- `.docs/instructions.md`, `.docs/hints.md`: student-facing instructions and hints.
- `.docs/introduction.md.tpl`: source of `.docs/introduction.md`, which pulls in concept introductions with `%{concept:<slug>}`.

An exercise may list extra files under `files.editor` in `.meta/config.json`, such as the JSON data file in `shopping`.
