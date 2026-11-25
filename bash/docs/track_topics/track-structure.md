# Track structure

How the Bash track repository is organized.
Read this before adding, moving, or editing track content.

## Repository hierarchy

- `exercises/practice/<slug>/`: practice exercises.
- `exercises/concept/<slug>/`: concept exercises.
- `concepts/<slug>/`: concept documentation.
- `config.json`: track-level configuration.
- `docs/`: track-level documentation, such as `SYLLABUS.md`, `TESTS.md`, and `MAINTAINING.md`.
- `bin/`: track tooling, such as test generation, validation, and linting scripts.
- `POLICIES.md`: track policies, including the style guide to follow.

## Practice exercise layout

Practice exercises live in `exercises/practice/<slug>/`.
Read each exercise's `.meta/config.json` to confirm its configured filenames.

- `<snake_slug>.sh`: student-facing stub; normally remains incomplete.
- `<snake_slug>.bats`: tests delivered to students.
- `.meta/example.sh`: reference solution; must pass all tests.
- `.meta/template.j2`: test-generation template, when present.
- `.meta/tests.toml`: canonical test selection and metadata.
- `.meta/config.json`: exercise metadata and file mappings.
- `.docs/`: student-facing instructions and documentation.
- `bats-extra.bash`: vendored Bats support/assertion library.
