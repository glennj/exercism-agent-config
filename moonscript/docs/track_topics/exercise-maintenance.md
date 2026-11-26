# Maintaining exercises

- Keep instructions, tests, example solutions, stubs, and metadata consistent.
- When tests change, ensure `.meta/example.moon` demonstrates the intended behavior and passes the complete test suite.
- A stub provides every function, class, constructor, and method that the tests use, and each raises an error until implemented.
  `hello-world` (returns the wrong greeting) and `react` (comments only) are deliberate exceptions.
- Preserve the stub's intended level of guidance; do not turn it into another example solution.
- Use canonical data from `problem-specifications` and `.meta/tests.toml`.
  Do not invent canonical UUIDs or silently omit canonical cases.
  Mark a case the track does not implement with `include = false`.

## Test conventions

- The first test uses `it` and every later test uses `pending`.
- A template gets the right command from `test_cmd(is_first)`.
  With nested case groups, "first" must mean first in the whole file; see `complex-numbers` for a template that tracks this.
- Optional tests go inside `if os.getenv('BONUS_TESTS') == 'true'`, after the canonical tests.
  Keep the `-- The next tests are optional.` comment above that block, because the test runner relies on it.

## Test generators

If an exercise has `.meta/generator.tmpl`, treat its `_spec.moon` file as generated.
Change the template (or a helper in `lib/`), then regenerate rather than making edits that would be overwritten.
Without a template, edit the test file directly.

Template syntax and helpers are described in [CONTRIBUTING.md](../../CONTRIBUTING.md#the-test-generator-template).
Code inside template tags is Lua, not MoonScript.

## Regenerating tests

```bash
bin/generate-spec two-fer
```

The generator needs `moon` on your `PATH` and these LuaRocks modules: `moonscript`, `dkjson`, `penlight`, and `etlua`.
It overwrites the exercise's test file and also prints it.

It reads `canonical-data/<problem-specifications-slug>.json`, and downloads that file with `curl` only when it is missing.
A cached copy is never refreshed, so delete it first to pick up upstream changes.

Report missing prerequisites rather than claiming generation succeeded.
Review the diff, then see [validation.md](validation.md) for checking the result.

## Syncing with problem-specifications

Check one exercise for upstream changes (omit `--exercise` to check them all):

```bash
bin/configlet sync --exercise two-fer --docs --metadata --tests
```

Add `--update` to apply the changes.
After updating tests, delete the cached canonical data, regenerate, and verify.

`configlet sync` overwrites `.docs/instructions.md` and `.docs/introduction.md`, so do not edit them by hand.
Put track-specific text in `.docs/instructions.append.md`, following the headings used in the existing files.

## Adding an exercise

Follow [CONTRIBUTING.md](../../CONTRIBUTING.md#creating-a-new-practice-exercise), starting with:

```bash
bin/add-practice-exercise two-fer
```

Replace `two-fer` with the new slug.
The script needs `jq`, `curl`, and network access, and it re-sorts the practice exercises in `config.json` by difficulty and name.

## Libraries

The libraries the test runner offers students are listed in [../TESTS.md](../TESTS.md) and `exercises/shared/.docs/tests.md`; keep the two in step.
CI installs only `busted`, `moonscript`, `lua-tz`, and their dependencies.
An example solution that needs another module also needs that module added to `.github/workflows/pr.yml` and `test.yml`.

## Changes that re-run student solutions

Changing an exercise's tests can make the website re-run published solutions.
Before merging such a change, read [avoiding unnecessary test runs](https://exercism.org/docs/building/tracks#h-avoiding-triggering-unnecessary-test-runs).
