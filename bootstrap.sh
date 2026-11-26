#!/usr/bin/env bash
#
# Create a new track's topic docs from the templates in _template/.
#
# usage: bootstrap.sh <track>
#   <track>   track slug; creates <track>/docs/track_topics/
#
# The language name comes from ../<track>/config.json when that repo exists,
# otherwise the slug is used. The docs are skeletons: a prompt asking an agent
# to fill them in is printed to stdout (everything else goes to stderr), so:
#   bootstrap.sh <track> | pbcopy
# Safe to re-run. Never overwrites an existing file.

set -euo pipefail

usage() {
    printf 'usage: %s <track>\n' "${0##*/}" >&2
    exit 2
}

die() {
    printf 'error: %s\n' "$*" >&2
    exit 1
}

warn() {
    printf '%s\n' "$*" >&2
}

# Print template file $1 with its {{...}} placeholders filled in.
# Uses the variables of the calling function.
render() {
    local content
    content=$(< "$1")
    content=${content//'{{track}}'/"$track"}
    content=${content//'{{language}}'/"$language"}
    content=${content//'{{config}}'/"$here"}
    content=${content//'{{repo}}'/"$repo"}
    printf '%s\n' "$content"
}

main() {
    (( $# == 1 )) || usage

    local here track templates dest repo language template name
    here=$(cd "$(dirname "$0")" && pwd -P)
    track=${1%/}
    [[ $track =~ ^[a-z0-9][a-z0-9-]*$ ]] || die "invalid track slug: $1"

    templates=$here/_template/docs/track_topics
    dest=$here/$track/docs/track_topics
    [[ -d $templates ]] || die "no templates: $templates"

    repo=${here%/*}/$track
    if ! language=$(jq -er .language "$repo/config.json" 2>/dev/null); then
        language=$track
        warn "cannot read language from $repo/config.json: using \"$language\""
    fi

    mkdir -p "$dest"

    for template in "$templates"/*.md; do
        name=${template##*/}
        name=${name/#language-/$track-}

        if [[ -e $dest/$name ]]; then
            warn "skip $name: already exists"
            continue
        fi

        render "$template" > "$dest/$name"
        warn "created $track/docs/track_topics/$name"
    done

    warn $'\nPrompt to populate the docs:\n'
    render "$here/_template/populate-prompt.md"
}

main "$@"
