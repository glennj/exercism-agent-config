# Validation

## Example solutions

After changing an exercise's tests, template, or example solution, run:

```bash
bin/verify-exercises two-fer
```

It needs `busted`, the `moonscript` LuaRocks module, `jq`, `perl`, and Bash 4 or newer (macOS's `/bin/bash` is too old).
Some exercises need more modules, such as `lua-tz`.

The script copies the exercise into a temporary directory, copies the example solution over the stub, changes every `pending` to `it`, and runs `busted`.
It validates the **example solution**, not student code.
The exercise directory is never modified, so uncommitted changes to it are safe.

It accepts one slug, or none to verify all exercises.
Options go before the slug: `-t` for TAP output and `-e` to stop at the first failing exercise.

Optional tests are skipped unless you ask for them:

```bash
BONUS_TESTS=true bin/verify-exercises custom-set
```

For broad changes, including changes to `lib/`, verify all exercises:

```bash
bin/verify-exercises
```

## Test runner image

To test with the production test runner (needs Docker and `jq`):

```bash
bin/verify-exercises-in-docker two-fer
```

This pulls the `exercism/moonscript-test-runner` image and runs it without network access.
Pass `-L` to use a locally built image.

## Generated tests

After changing a template or a helper in `lib/`, regenerate each affected exercise and check that the diff contains only the intended changes:

```bash
bin/generate-spec two-fer
git diff
```

See [exercise-maintenance.md](exercise-maintenance.md#regenerating-tests) for prerequisites.

## Configuration and metadata

For configuration, metadata, or documentation changes, run:

```bash
bin/configlet lint
```

To check the formatting of the track's `config.json` and each exercise's `.meta/config.json` (add `--update` to rewrite them):

```bash
bin/configlet fmt
```

Use `bin/fetch-configlet` only when `configlet` is needed and fetching it is acceptable.
Do not install global dependencies without approval.

## CI

`.github/required-checks.yml` lists the checks a pull request must pass.

- `configlet / configlet`: lints the track.
- `test`: runs `bin/verify-exercises` for each practice exercise with a changed `.moon` file.
- `i18n / completeness`: fails when English text changed by the PR has no translation yet.
- `Validate required checks`: confirms that the listed checks exist.

The `test` check does not exercise changes limited to other files, such as `lib/`, `.meta/generator.tmpl`, `.busted`, or `config.json`, so verify those locally.
All exercises are tested after a push to `main`.
