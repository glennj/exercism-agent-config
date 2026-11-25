# agent_config

Agent files (`AGENTS.md`, `.agents/`, ...) for the Exercism track repos I
contribute to. Kept here, not in the track repos, because maintainers are
split on LLM use.

Layout: one directory per track, mirroring where the files go in the track repo.

    bash/AGENTS.md          ->  ../bash/AGENTS.md
    bash/.agents/skills/... ->  ../bash/.agents

Each file is symlinked into the track repo and listed in that repo's
`.git/info/exclude`, so it never shows up in `git status` or a PR.

    ./link.sh <track>       # assumes the track repo is ../<track>

Re-running is safe. Real files already in the track repo are never overwritten.
