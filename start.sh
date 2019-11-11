#!/bin/sh
set -ex

INPUT_BRANCH=${INPUT_BRANCH:-master}
INPUT_FORCE=${INPUT_FORCE:-false}
_FORCE_OPTION=''
REPOSITORY=${INPUT_REPOSITORY:-$GITHUB_REPOSITORY}
REMOTE_REPO="$REMOTE_URL"

if [ -n "${SSH_KEY:-}" ] || [ -n "${SSH_KEY_VAR:-}" ]; then
    eval "$(ssh-agent -s)" >/dev/null
    mkfifo -m 600 ~/.ssh_key.fifo && printf -- "${SSH_KEY}\n" >~/.ssh_key.fifo | ssh-add ~/.ssh_key.fifo && rm ~/.ssh_key.fifo
fi

if ${INPUT_FORCE}; then
    _FORCE_OPTION='--force'
fi

ls -ahl

git push "${REMOTE_REPO}" HEAD:${INPUT_BRANCH} --follow-tags $_FORCE_OPTION;
