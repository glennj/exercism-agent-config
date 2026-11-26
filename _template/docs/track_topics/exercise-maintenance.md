# Maintaining exercises

- Keep instructions, tests, example solutions, stubs, and metadata consistent.
- When tests change, ensure the reference solution demonstrates the intended behavior and passes the complete test suite.
- Preserve the stub's intended level of guidance; do not turn it into another example solution.
- Use canonical data from `problem-specifications` and `.meta/tests.toml`.
  Do not invent canonical UUIDs or silently omit canonical cases.

## Test conventions

TODO: how tests are skipped, and any other rules test files must follow.

## Regenerating tests

TODO: the generator command, its prerequisites, and which files are generated.

Report missing prerequisites rather than claiming generation succeeded.
See [validation.md](validation.md) for checking the result.
