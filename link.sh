#!/usr/bin/env bash
# Symlink a track's agent files into its repo and hide them from git.
#
# usage: link.sh <track> [track-repo-dir]
#   <track>          directory in this repo holding that track's agent files
#   track-repo-dir   defaults to ../<track>
#
# Every top-level entry in <track>/ (dotfiles included) is symlinked into the
# track repo, and its name is added to the repo's .git/info/exclude.
# Safe to re-run. Never overwrites a real file or directory.

set -euo pipefail

(( $# >= 1 && $# <= 2 )) || { sed -n '2,10p' "$0" | sed 's/^# \?//'; exit 2; }

here=$(cd "$(dirname "$0")" && pwd -P)
track=${1%/}
src=$here/$track
dest=$(cd "${2:-$here/../$track}" && pwd -P)

[[ -d $src ]]      || { echo "no such track config: $src" >&2; exit 1; }
[[ -d $dest/.git ]] || { echo "not a git repo: $dest" >&2; exit 1; }

exclude=$dest/.git/info/exclude
mkdir -p "$dest/.git/info"
touch "$exclude"

shopt -s dotglob nullglob
for path in "$src"/*; do
    name=${path##*/}
    target=$dest/$name
    # relative link so it survives moving the whole tracks/ directory
    rel=$(python3 -c 'import os,sys; print(os.path.relpath(*sys.argv[1:3]))' "$path" "$dest")

    if [[ -L $target ]]; then
        [[ $(readlink "$target") == "$rel" ]] || ln -sfn "$rel" "$target"
    elif [[ -e $target ]]; then
        echo "skip $name: exists and is not a symlink" >&2
        continue
    else
        ln -s "$rel" "$target"
    fi

    grep -qxF "$name" "$exclude" || echo "$name" >> "$exclude"
    echo "linked $name -> $rel"
done
