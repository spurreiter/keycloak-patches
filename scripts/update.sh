#!/usr/bin/env bash

set -x

cwd=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

. "$cwd/env"

echo $VERSION

cd "$cwd/.."

checkgitbranch(){
  local expBranch="release"
  local branch=$(git rev-parse --abbrev-ref HEAD)

  if [ $branch != $expBranch ]; then
    echo "not on $expBranch branch"
    exit 1
  fi
  # git reset --hard origin/main
}

download(){
  wget "https://github.com/keycloak/keycloak/archive/refs/tags/$VERSION.tar.gz"
}

update(){
  local KV="keycloak-$VERSION"
  tar -xzf "$VERSION.tar.gz"
}

checkgitbranch
download
update
