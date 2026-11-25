#!/usr/bin/env bash
#
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

usage() {
    printf 'usage: %s <track> [track-repo-dir]\n' "${0##*/}" >&2
    exit 2
}

die() {
    printf 'error: %s\n' "$*" >&2
    exit 1
}

warn() {
    printf '%s\n' "$*" >&2
}

# Print the path of $1 relative to directory $2.
# Relative links survive moving the whole tracks/ directory.
relative_path() {
    python3 -c 'import os, sys; print(os.path.relpath(sys.argv[1], sys.argv[2]))' "$1" "$2"
}

# Add $1 to the exclude file $2 unless it is already listed.
add_to_exclude() {
    local name=$1 exclude_file=$2
    if ! grep -qxF -- "$name" "$exclude_file"; then
        printf '%s\n' "$name" >> "$exclude_file"
    fi
}

# Make $2 a symlink pointing at $1, replacing only an existing symlink.
# Returns 1 (and does nothing) if $2 is a real file or directory.
link_entry() {
    local link_target=$1 link_path=$2

    if [[ -L $link_path ]]; then
        # Already a symlink: repoint it only if it is wrong.
        if [[ $(readlink "$link_path") != "$link_target" ]]; then
            ln -sfn "$link_target" "$link_path"
        fi
    elif [[ -e $link_path ]]; then
        return 1
    else
        ln -s "$link_target" "$link_path"
    fi
}

main() {
    (( $# >= 1 && $# <= 2 )) || usage

    local here track src dest exclude
    here=$(cd "$(dirname "$0")" && pwd -P)
    track=${1%/}
    src=$here/$track
    dest=$(cd "${2:-$here/../$track}" && pwd -P)

    [[ -d $src ]]       || die "no such track config: $src"
    [[ -d $dest/.git ]] || die "not a git repo: $dest"

    exclude=$dest/.git/info/exclude
    mkdir -p "${exclude%/*}"
    touch "$exclude"

    # Match dotfiles; expand to nothing (not a literal "*") if the dir is empty.
    shopt -s dotglob nullglob

    local path name rel
    for path in "$src"/*; do
        name=${path##*/}
        rel=$(relative_path "$path" "$dest")

        if link_entry "$rel" "$dest/$name"; then
            add_to_exclude "$name" "$exclude"
            printf 'linked %s -> %s\n' "$name" "$rel"
        else
            warn "skip $name: exists and is not a symlink"
        fi
    done
}

main "$@"
