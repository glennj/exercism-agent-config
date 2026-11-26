# MoonScript conventions

- Follow [STYLE.md](../../STYLE.md) while matching the surrounding file's established style.
- Indent with two spaces.
- A solution is a module that returns a table of functions or a class.
  The test file `require`s it, so exported names must match what the tests use.
- Tests that expect a failure use `assert.has.errors` with a message.
  Raise exactly that message, for example `error 'empty stack'`; a partial match fails.
- Compare tables with `assert.are.same`, values (including objects with `__eq`) with `assert.are.equal`, and floating-point numbers with `assert.is.near`.
- Avoid unnecessary dependencies and unrelated rewrites.
  See [exercise-maintenance.md](exercise-maintenance.md#libraries) before using a module.
- Preserve LF line endings.

## Diagnostic output

`busted` does not capture output, so anything printed is mixed into the test report, including TAP output.
When debugging exercise code or tests, write diagnostics to stderr:

```moonscript
io.stderr\write "debug: value=#{value}\n"
```

To inspect a table:

```moonscript
import dump from require 'moonscript.util'
io.stderr\write dump(tbl), '\n'
```

Track tooling written in MoonScript, such as `bin/generate-spec`, also writes diagnostics to stderr.
In shell scripts under `bin/`, use `>&2`.

Remove temporary diagnostic output before finishing unless the user explicitly asks to retain it.
