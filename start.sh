#!/bin/sh
set -e

INPUT_BRANCH=${INPUT_BRANCH:-master}
INPUT_FORCE=${INPUT_FORCE:-false}
INPUT_DIRECTORY=${INPUT_DIRECTORY:-'.'}
_FORCE_OPTION=''
REPOSITORY=${INPUT_REPOSITORY:-$GITHUB_REPOSITORY}
INPUT_REMOTE_REPO="$INPUT_REMOTE_URL"

if [ -n "${SSH_KEY:-}" ] || [ -n "${SSH_KEY_VAR:-}" ]; then
    eval "$(ssh-agent -s)" >/dev/null
    mkfifo -m 600 ~/.ssh_key.fifo && printf -- "${!SSH_KEY_VAR:-"$SSH_KEY"}\n" >~/.ssh_key.fifo | ssh-add ~/.ssh_key.fifo && rm ~/.ssh_key.fifo
fi

if ${INPUT_FORCE}; then
    _FORCE_OPTION='--force'
fi

cd ${INPUT_DIRECTORY}

git push "${INPUT_REMOTE_REPO}" HEAD:${INPUT_BRANCH} --follow-tags $_FORCE_OPTION;
