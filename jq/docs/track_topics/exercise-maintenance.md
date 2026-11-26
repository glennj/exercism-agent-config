# Maintaining exercises

- Keep instructions, tests, example solutions, stubs, and metadata consistent.
- When tests change, ensure the reference solution (`.meta/example.jq`, or `.meta/exemplar.jq` for a concept exercise) demonstrates the intended behavior and passes the complete test suite.
- Preserve the stub's intended level of guidance; do not turn it into another example solution.
- Use canonical data from `problem-specifications` and `.meta/tests.toml`.
  Do not invent canonical UUIDs or silently omit canonical cases.
  Mark a case the track does not implement with `include = false`.

## Student-facing documentation

`configlet sync` manages the `.docs/instructions.md` and `.docs/introduction.md` files of practice exercises that come from `problem-specifications`, so do not edit them by hand.
Put jq-specific text in `.docs/instructions.append.md`.
The existing append files start with a placeholder level-1 heading, followed by level-2 headings.
If a test passes unusual options to `jq`, explain them there, as `minesweeper` and `nth-prime` do.

A concept exercise's `.docs/introduction.md` is generated from `.docs/introduction.md.tpl`.
Edit the concept's `introduction.md` or the template, then regenerate:

```bash
bin/configlet generate --update
```

The command asks for confirmation before writing.

## Test conventions

- A test file starts by running `load bats-extra` and `load bats-jq`.
- Tests refer to files by relative path, so run them from the directory that contains them.
- In a practice exercise, every test has this line, and only the first test's copy is commented out:

  ```bash
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  ```

  `bin/validate_one_exercise` requires exactly one commented copy in every practice exercise except `hello-world`.
- Concept exercise tests have no skip lines.
  They name the instructions task they check with a `## task N` comment.
- Besides the `bats-assert` functions, [`bats-jq.bash`](../../lib/bats-jq.bash) provides `assert_objects_equal`, `assert_float`, and `assert_key_value`.
  Use `assert_objects_equal` when the order of object keys must not matter.

## Bats helper files

Every exercise has its own copy of `lib/bats-extra.bash` and `lib/bats-jq.bash`.
Do not edit one exercise's copy.
To change a helper, edit it in `lib/`, then copy it to all exercises with the loop in [`lib/README.md`](../../lib/README.md), run from the repository root.

## Test generator

If a practice exercise has `.meta/template.j2`, treat its test file as generated.
Change the template, then regenerate rather than making edits that would be overwritten.
Without a template, as in concept exercises and the deprecated `beer-song`, edit the test file directly.

Templates use Jinja2 and are rendered by [`bin/test-generator`](../../bin/test-generator), which defines the data and filters available to them:

- `header`: the shebang, a timestamp comment, and the `load` lines.
- `solution`: the exercise's solution filename.
- `cases`: the canonical cases listed in `.meta/tests.toml`, without those marked `include = false` or replaced by an included case that reimplements them.
- Each case also has `descriptions` (group names plus the case description), `expect_error`, and, for error cases, `expect_error_msg`.
- Filters: `quote` (shell quoting), `tojson`, `filter_keys`, and `format_list`.

A template can only include files from its own `.meta/` directory.
It must write the skip line itself, commented out when `loop.first` is true.
Copy the pattern from a similar exercise, such as `two-fer` for plain output or `forth` for grouped cases and errors.
Prefer the `quote` filter to hand-written single quotes, which break on text containing an apostrophe.

## Regenerating tests

```bash
bin/test-generator --no-pull two-fer
```

Run it from the repository root.
It needs:

- Python 3.11 or newer.
- The Jinja2 package.
- A copy of `problem-specifications` in `exercism/configlet/problem-specifications` under `$XDG_CACHE_HOME`, or under `~/.cache` when that variable is unset.
  The script exits without it, even for `--help`.

Without `--no-pull`, the script first runs `git pull` in that cached repository, which needs network access.
It accepts any number of slugs, and with none it regenerates every practice exercise that has a template.
It rewrites a test file only when something besides the timestamp line changes.

Report missing prerequisites rather than claiming generation succeeded.
Review the diff, then see [validation.md](validation.md) for checking the result.

## Syncing with problem-specifications

Check one exercise for upstream changes (omit `--exercise` to check them all):

```bash
bin/configlet sync --exercise two-fer --docs --metadata --tests
```

Add `--update` to apply the changes.
Without `--offline`, `configlet` also updates its cached copy of `problem-specifications`, which needs network access.
After `.meta/tests.toml` changes, regenerate the tests, update the example solution if needed, and validate.

A [scheduled workflow](../../.github/workflows/run-configlet-sync.yml) syncs documentation, but not tests, each month.

## Adding a practice exercise

Follow [CONTRIBUTING.md](../../CONTRIBUTING.md#how-to-port-an-exercise).
First check that the exercise is not listed as foregone in `config.json`.
Then, from the repository root, run:

```bash
bin/add-exercise queen-attack
```

Replace `queen-attack` with the new slug.
The script needs `jq` and network access, downloads the latest `configlet`, asks for your GitHub username, and adds the exercise.

Then finish the exercise:

- Write `.meta/template.j2`, `.meta/example.jq`, and the stub, and generate the tests.
- Check that `files.invalidator` in `.meta/config.json` names `bats-extra.bash` and `bats-jq.bash`.
- Set the difficulty in `config.json` using the [track's ratings](../../CONTRIBUTING.md#difficulty-ratings).
- Keep the practice exercises in `config.json` ordered by difficulty, then name.

## Adding a concept or concept exercise

Follow the checklist in [CONTRIBUTING.md](../../CONTRIBUTING.md#creating-concepts).

## Changes that re-run student solutions

Changing an exercise's tests or other important files can make the website re-run students' solutions.
The files listed under `files.invalidator` in `.meta/config.json`, normally the Bats helpers, count too.
A [workflow](../../.github/workflows/no-important-files-changed.yml) runs a check when a pull request that touches exercise files outside the `.docs/`, `.meta/`, `.approaches/`, and `.articles/` directories is opened.
