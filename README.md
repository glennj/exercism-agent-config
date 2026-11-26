# agent_config

Agent files (`AGENTS.md`, `.agents/`, ...) for the Exercism track repos I contribute to.
Kept here, not in the track repos, because maintainers are split on LLM use.

Layout: files shared by every track live in `_common/`; each track has a directory mirroring where its own files go in the track repo.

    _common/AGENTS.md         ->  ../bash/AGENTS.md
    _common/LLM_GUIDELINES.md ->  ../bash/LLM_GUIDELINES.md
    bash/.agents/skills/...   ->  ../bash/.agents
    bash/docs/track_topics    ->  ../bash/docs/track_topics

Each file is symlinked into the track repo and listed in that repo's `.git/info/exclude`, so it never shows up in `git status` or a PR.

    ./bootstrap.sh <track>  # new track: create <track>/docs/track_topics
    ./link.sh <track>       # assumes the track repo is ../<track>

`bootstrap.sh` copies the skeletons in `_template/` and prints a prompt asking an agent to fill in their `TODO`s (`./bootstrap.sh <track> | pbcopy`).

`AGENTS.md` holds only rules general to every track.
Track-specific facts live in `<track>/docs/track_topics/`, symlinked into the track repo's `docs/` (`link.sh` merges into directories that already exist there).
See `LLM_GUIDELINES.md` (in each track's repo root) for what goes where.

Re-running is safe.
Real files already in the track repo are never overwritten.
