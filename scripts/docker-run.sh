#!/usr/bin/env bash

cwd=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

. "$cwd/env"

echo $VERSION

# -v ${cwd}/my-realm.json:/tmp/my-realm.json \
# -e KEYCLOAK_IMPORT=/tmp/my-realm.json \

docker run --rm -it \
  --name kc \
  -p 8080:8080 \
  -e KEYCLOAK_USER=admin \
  -e KEYCLOAK_PASSWORD=admin \
  -e KEYCLOAK_LOGLEVEL=DEBUG \
  -v ${cwd}/../federation/ldap/target/keycloak-ldap-federation-${VERSION}.jar:/opt/jboss/keycloak/modules/system/layers/keycloak/org/keycloak/keycloak-ldap-federation/main/keycloak-ldap-federation-${VERSION}.jar \
  -v ${cwd}/../deployments:/opt/jboss/keycloak/standalone/deployments \
  jboss/keycloak:$VERSION
