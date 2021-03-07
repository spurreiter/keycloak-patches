# keycloak-patches

includes patches for 

## verify email write back to ldap server 

See [KEYCLOAK-16327](https://issues.redhat.com/browse/KEYCLOAK-16327)

A possible solution [KEYCLOAK-16464](https://issues.redhat.com/browse/KEYCLOAK-16464) should land in v13.0.0.

## wildcard subdomains

See [KEYCLOAK-13675](https://issues.redhat.com/browse/KEYCLOAK-13675)

Currently it is only possible to allow several wildcard pathnames for a given domain as redirect urls for a given client.

In a setup where multiple subdomains shall be allowed per client, each domain with its subdomain needs to be configured individually which is cumbersome (multi-tenancy using subdomains).

To ease configuration it would be great if the wildcard pattern is allowed for subdomains as well.

E.g. instead of multiple domains

- https://one.host.com/*
- https://two.host.com/*
- ...
- https://ninety.host.com/*

just one line would be required

- https://*.host.com/*

For security reasons the matching should be restricted to one domain label for a subdomain.

- ok https://sub.host.com
- fails https://sub.sub.host.com

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

