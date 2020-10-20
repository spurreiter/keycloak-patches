#!/usr/bin/env

set -x

cwd=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

. "$cwd/env"

echo $VERSION

cd "$cwd/.."

gitmain(){
  local branch=$(git rev-parse --abbrev-ref HEAD)

  if [ $branch != "main" ]; then
    echo "not on main branch"
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

#gitmain
download
update
