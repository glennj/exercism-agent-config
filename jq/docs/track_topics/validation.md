# Validation

Run these commands from the repository root.

## Example solutions

After changing an exercise's tests, template, or reference solution, run:

```bash
bin/validate_one_exercise exercises/practice/two-fer
```

Concept exercises work the same way:

```bash
bin/validate_one_exercise exercises/concept/shopping
```

The script needs:

- `jq` and `bats`.
- Bash 4 or newer first on your `PATH` (macOS's `/bin/bash` is too old).
- GNU `grep` with `-P` support, as `ggrep` or `grep`, for practice exercises other than `hello-world`.

It checks the skip lines, copies the tests, Bats helpers, and editor files into a temporary directory, copies the reference solution there under the stub's name, and runs all the tests.
It validates the **reference solution**, not the stub.
The exercise directory is never modified, so uncommitted changes to it are safe.
Give it the exercise's path rather than `.`, because it takes the exercise name from the argument.

The Bats helpers come from the exercise directory, so after changing `lib/`, [copy the helpers](exercise-maintenance.md#bats-helper-files) before validating.

For broad changes, validate all exercises, including deprecated ones:

```bash
bin/validate_exercises
```

It stops at the first failing exercise.

## Test runner image

To test with the production test runner (needs Docker):

```bash
bin/validate_one_exercise -D exercises/practice/two-fer
```

The `-D` option goes before the path.
The script pulls the `exercism/jq-test-runner` image, which needs network access, runs it without network access, and prints `results.json`.
It fails unless the reported status is `pass`.

## Generated tests

After changing a template or `bin/test-generator`, [regenerate](exercise-maintenance.md#regenerating-tests) each affected exercise, check that the diff contains only the intended changes, and validate it:

```bash
bin/test-generator --no-pull two-fer
git diff
bin/validate_one_exercise exercises/practice/two-fer
```

## Configuration and metadata

For configuration, metadata, or documentation changes, run:

```bash
bin/configlet lint
```

To check the formatting of the exercise `.meta/config.json` files (add `--update` to rewrite them):

```bash
bin/configlet fmt
```

After changing a concept introduction or an `introduction.md.tpl`, check that the generated introductions are current:

```bash
bin/configlet generate
```

After changing the practice exercise list, check that it is ordered by difficulty, then name (prints `true`):

```bash
jq '.exercises.practice | . == sort_by(.difficulty, (.name | ascii_downcase))' config.json
```

Use `bin/fetch-configlet` only when `configlet` is needed and fetching it is acceptable.
It downloads the latest release into `bin/`, replacing any copy there.
Do not install global dependencies without approval.

## Shell scripts

Lint the track's shell scripts with ShellCheck:

```bash
shellcheck bin/add-exercise bin/fetch-configlet bin/pr bin/validate_exercises bin/validate_one_exercise lib/bats-jq.bash
```

## Markdown

The track uses [Prettier](../../CONTRIBUTING.md#prettier) to format Markdown, but CI does not check it.
See [`.prettierignore`](../../.prettierignore) for installation, usage, and a known problem with Exercism admonition blocks.

## CI

[`.github/required-checks.yml`](../../.github/required-checks.yml) lists the checks a pull request must pass.

- `configlet / configlet`: lints the track.
- `i18n / completeness`: fails when English text changed by the PR has no translation.
- `Check / Check exercises`: checks the order of exercises by difficulty and name.
- `Run shellcheck on scripts`: runs ShellCheck, ignoring `bats-extra.bash`.
- `pr`: validates each exercise that has an added, modified, or renamed `.jq`, `.bats`, or `.bash` file.
- `Validate required checks`: when a PR changes a workflow or the list itself, confirms that the listed checks ran.

The `pr` check does not test changes limited to other files, such as templates, JSON data files, or `config.json`, nor changes in `lib/`, so verify those locally.
All exercises are validated after a push to `main` by [`ci.yml`](../../.github/workflows/ci.yml).

The [pull request template](../../.github/pull_request_template.md) has a checklist for documentation changes.
