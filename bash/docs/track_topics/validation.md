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
