#!/bin/sh
set -ex

INPUT_BRANCH=${INPUT_BRANCH:-master}
INPUT_FORCE=${INPUT_FORCE:-false}
_FORCE_OPTION=''
REPOSITORY=${INPUT_REPOSITORY:-$GITHUB_REPOSITORY}
REMOTE_REPO="$REMOTE_URL"

# Setup SSH
eval "$(ssh-agent -s)" >/dev/null
echo "$SSH_KEY" >> ~/.ssh_key
ssh-add ~/.ssh_key
chmod 400 ~/.ssh_key

if ${INPUT_FORCE}; then
    _FORCE_OPTION='--force'
fi

ls -ahl
# Make sure correct key is used
GIT_SSH_COMMAND='ssh -i ~/.ssh_key'
git push "${REMOTE_REPO}" HEAD:${INPUT_BRANCH} --follow-tags $_FORCE_OPTION;

# Clean up key
rm ~/.ssh_key
