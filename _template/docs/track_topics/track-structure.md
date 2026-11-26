# Track structure

How the {{language}} track repository is organized.
Read this before adding, moving, or editing track content.

## Repository hierarchy

- `exercises/practice/<slug>/`: practice exercises.
- `exercises/concept/<slug>/`: concept exercises.
- `concepts/<slug>/`: concept documentation.
- `config.json`: track-level configuration.
- `docs/`: track-level documentation.
- `bin/`: track tooling.
- TODO: list other notable directories and files, such as the style guide.

## Practice exercise layout

Practice exercises live in `exercises/practice/<slug>/`.
Read each exercise's `.meta/config.json` to confirm its configured filenames.

- TODO: student-facing stub filename; normally remains incomplete.
- TODO: test filename.
- TODO: reference solution filename; must pass all tests.
- TODO: test-generation template, if the track uses one.
- `.meta/tests.toml`: canonical test selection and metadata.
- `.meta/config.json`: exercise metadata and file mappings.
- `.docs/`: student-facing instructions and documentation.
