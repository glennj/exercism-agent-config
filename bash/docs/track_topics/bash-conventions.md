# Bash conventions

- Target Bash, not POSIX `sh`; POSIX compatibility is not required.
- Follow `POLICIES.md`, including the Google Shell Style Guide, while matching the surrounding file's established style.
- Use `#!/usr/bin/env bash` where a shebang is needed.
- Quote expansions unless splitting or globbing is explicitly intended.
  Correctly handle whitespace, empty strings, and glob characters.
- Prefer clear Bash conditionals, arrays, functions, and builtins where appropriate.
  Use `local` for function-local variables.
- Ensure exercise programs produce exactly the output and exit status expected by their tests.
  Bats `run` collects both stdout and stderr in `$output`, so writing diagnostics to either stream can break `assert_output`, `refute_output`, and related assertions.
- When diagnostic output is needed while validating an exercise, write it to file descriptor 3 so Bats does not include it in `$output`:

  ```bash
  printf 'debug: value=%q\n' "$value" >&3
  ```

- In standalone track-maintenance scripts, such as those under `bin/` or `.github/scripts/`, write diagnostics to stderr instead:

  ```bash
  printf 'error: invalid exercise configuration\n' >&2
  ```

- Remove temporary diagnostic output before finishing unless the user explicitly asks to retain it.
- Avoid unnecessary dependencies and unrelated rewrites.
- Preserve LF line endings.
