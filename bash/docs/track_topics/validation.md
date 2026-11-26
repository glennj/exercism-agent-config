# Validation

After changing an exercise's tests, template, or example solution, run:

```bash
bin/validate_one_exercise exercises/practice/two-fer
```

This script copies the example solution, tests, `bats-extra.bash`, and any configured editor files into a temporary directory, then runs all Bats tests there against the example.
The temporary directory is removed on exit.
It validates the **example solution**, not student code.
The exercise directory, including the student-facing stub, is never modified, so uncommitted changes to it are safe.

Pass `-D` to run the tests inside the `exercism/bash-test-runner` Docker image instead of locally:

```bash
bin/validate_one_exercise -D exercises/practice/two-fer
```

It fails unless the test runner reports `pass`.

For broad exercise changes, validate all exercises:

```bash
bin/validate_exercises
```

Run ShellCheck over active exercise shell files with:

```bash
bin/lint
```

For configuration or metadata changes, also run:

```bash
bin/configlet lint
```

Use `bin/fetch-configlet` only when configlet is needed and fetching it is acceptable.
Do not install global dependencies without approval.

## CI

[`.github/required-checks.yml`](../../.github/required-checks.yml) lists the checks a pull request must pass.

- `configlet / configlet`: lints the track.
- `i18n / completeness`: fails when English text changed by the PR has no translation.
- `Check / Check exercises`: checks the order of exercises by difficulty and name.
- `ci`: validates each exercise that has an added, modified, or renamed `.sh`, `.bash`, or `.bats` file.
- `Validate required checks`: when a PR changes a workflow or the list itself, confirms that the listed checks ran.

The `ci` check does not test changes limited to other files, such as templates, JSON files, or `config.json`, so verify those locally.

The [`shellcheck`](../../.github/workflows/shellcheck.yml) workflow also runs on pull requests, but it is not a required check.
It ignores some files that the workflow lists, and it is not limited to active exercises as `bin/lint` is.

All exercises are validated after a push to `main` by [`ci.yml`](../../.github/workflows/ci.yml).

A [workflow](../../.github/workflows/no-important-files-changed.yml) runs a check when a pull request that touches exercise files outside the `.docs/`, `.meta/`, `.approaches/`, and `.articles/` directories is opened.
Changes to exercise tests or other important files can make the website re-run students' solutions.

When a maintainer adds the `ready-to-translate` label to a pull request, [`i18n-queue.yml`](../../.github/workflows/i18n-queue.yml) requests a translation of its English text.
