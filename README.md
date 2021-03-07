# keycloak-patches

includes patches for 

## verify email write back to ldap server 

...


## wildcard subdomains

...


## build the patches 

checkout your docker version 

```sh
git tag
# get 12.0.4
git checkout v12.0.4
```

build

```sh
./scripts/build.sh 
````

run it with the corresponding docker container

```sh
./scripts/docker-run.sh
````

(optional) extract patches 

```sh
git diff-tree --no-commit-id --name-only -r <commit>
```

# license

Apache 2.0

# links

- https://github.com/keycloak/keycloak/tags

