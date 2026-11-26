# jq conventions

- The track has no separate style guide, so match the surrounding file's established style.
- Indent with two spaces, as the online editor does.
- Target jq 1.8.
  The test runner [uses that version](../TESTS.md), and CI installs 1.8.0.
  Many package managers ship older releases; see [../INSTALLATION.md](../INSTALLATION.md).
- Avoid unnecessary dependencies and unrelated rewrites.
- Preserve LF line endings.

## Solution shapes

Read the exercise's test file to learn how a solution is run.

- Most practice exercises are a program run with `jq -f <slug>.jq`, reading a JSON object on standard input.
- Others define functions in the solution file, which the tests load with `include` or `import`, as in `rna-transcription`, `collatz-conjecture`, and many concept exercises.
  Function names and arities must match what the tests call.
- Tests usually use `-r` for raw string output or `-c` for compact JSON output.
- Some use other options, such as `-s -R` in `flower-field` and `minesweeper`, or `-n --argjson` in `nth-prime`.

Solutions are self-contained.
The validation script copies only the reference solution, the tests, the Bats helpers, and the configured editor files, so a solution cannot depend on any other file, including the modules in `lib/`.

## Errors

When a practice test expects a failure with an exact message, raise it with `halt_error`:

```jq
"empty stack" | halt_error
```

This writes the string to stderr as is and exits with a non-zero status.
`error("empty stack")` adds a `jq: error` prefix to the message, so an exact comparison fails.
The `the-farm` concept exercise teaches `error` and `try-catch`, and its tests match messages partially.

## Stubs

- A practice stub that is a whole program contains `"Remove this line and implement your solution" | halt_error`.
- A practice stub with functions gives each one the body `"Implement this function" | halt_error;`.
- `hello-world` is a deliberate exception: it outputs the wrong greeting.
- Concept exercise stubs guide the student with task comments and placeholder values.
- A stub may start with comments that point to relevant parts of the jq manual, as `two-fer` does.

## Diagnostic output

Use `debug` to inspect data without changing it:

```jq
. | debug | debug("length: \(length)")
```

`debug` writes to stderr.
The `jq` wrapper in `bats-jq.bash` moves lines that start with `["DEBUG:",` to file descriptor 3, so Bats shows them without adding them to `$output`.

Do not use the `stderr` builtin to debug code under test.
Its output is not redirected, so it ends up in `$output` and breaks assertions.

In a `.bats` file, write diagnostics to file descriptor 3:

```bash
echo "# value: $value" >&3
```

In track scripts under `bin/`, write diagnostics to stderr.

For student-facing debugging advice, see [../DEBUGGING.md](../DEBUGGING.md).
Remove temporary diagnostic output before finishing unless the user explicitly asks to retain it.
