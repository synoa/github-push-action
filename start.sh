#!/bin/sh
set -ex

BRANCH=${INPUT_BRANCH:-master}
GIT_ARGS=${INPUT_GIT_ARGS:-""}

git push "${REMOTE_URL}" HEAD:${BRANCH} $GIT_ARGS;