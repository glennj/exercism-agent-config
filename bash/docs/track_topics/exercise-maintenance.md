# Maintaining exercises

- Keep instructions, tests, example solutions, stubs, and metadata consistent.
- When tests change, ensure `.meta/example.sh` demonstrates the intended behavior and passes the complete test suite.
- Preserve the student-facing stub's intended level of guidance; do not turn it into another example solution.
- For exercises with `.meta/template.j2`, treat the `.bats` file as generated.
  Change the template or shared `bin/generator_macros.j2`, then regenerate rather than making generated edits that would be overwritten.
- Use canonical data from `problem-specifications` and `.meta/tests.toml`.
  Do not invent canonical UUIDs or silently omit canonical cases.
- Preserve the skip convention: the first skip directive is commented out and later tests have active directives.
  Validation uses `BATS_RUN_SKIPPED=true` to run all tests.
- Do not modify `bats-extra.bash` unless updating the vendored library is part of the task.

## Regenerating tests

Regenerate tests only for affected exercises when possible:

```bash
bin/generate_tests two-fer
```

The generator requires Python 3.11 or newer, Jinja2, and the cached problem-specifications repository.
Report missing prerequisites rather than claiming generation succeeded.

See [validation.md](validation.md) for checking the result.

For the monthly sync with `problem-specifications`, follow [../MAINTAINING.md](../MAINTAINING.md#syncing-with-problem-specifications).
