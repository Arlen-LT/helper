#!/bin/bash -xe

GIT_REPO_URL=${1%.git*}
GIT_REPO_NO_PROTOCOL=${GIT_REPO_URL#*://*.*/}
GIT_OWNER_NAME=${GIT_REPO_NO_PROTOCOL%%/*}
GIT_REPO_NAME=${GIT_REPO_NO_PROTOCOL##*/}

GITHUB_LATEST_RELEASE_URL=${GIT_REPO_URL}/releases/latest
GITLAB_LATEST_RELEASE_URL=${GIT_REPO_URL}/-/releases/permalink/latest

GITHUB_LATEST_RELEASE_API_URL=https://api.github.com/repos/${GIT_OWNER_NAME}/${GIT_REPO_NAME}/releases/latest
GIT_LATEST_RELEASE_TAG=$(curl -sL ${GITHUB_LATEST_RELEASE_API_URL} \
    | python3 -c "import sys, json; print(json.load(sys.stdin)['tag_name'])")
GITHUB_TAGS_API_URL=https://api.github.com/repos/${GIT_OWNER_NAME}/${GIT_REPO_NAME}/git/tags/${GIT_LATEST_RELEASE_TAG}

curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer <YOUR-TOKEN>"\
  -H "X-GitHub-Api-Version: 2022-11-28" \
  ${GITHUB_TAGS_API_URL}
