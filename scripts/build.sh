#!/usr/bin/env bash

# Download release zip file from https://github.com/keycloak/keycloak/tags
# copy this file to the root

set -x

cwd=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
lwd="$cwd/.."

. "$cwd/env"

echo $VERSION

mvnbuild(){
  cd "$lwd"
  mvn clean install
}

copy(){
  cd "$lwd"
  local deployments="$lwd/deployments"

  cd "$deployments"
  find . -name "*.jar" | xargs rm -f
  cd "$lwd"

  cp "$lwd/federation/ldap/target/keycloak-ldap-federation-${VERSION}.jar" \
    "$deployments"
  cp "$lwd/services/target/keycloak-services-${VERSION}.jar" \
    "$deployments"
}

dockerbuild(){
  cd "$lwd"
  (cat << EOS
FROM jboss/keycloak:$VERSION

COPY ./federation/ldap/target/keycloak-ldap-federation-${VERSION}.jar /opt/jboss/keycloak/modules/system/layers/keycloak/org/keycloak/keycloak-ldap-federation/main/keycloak-ldap-federation-${VERSION}.jar
COPY ./services/target/keycloak-services-${VERSION}.jar /opt/jboss/keycloak/modules/system/layers/keycloak/org/keycloak/keycloak-services/main/keycloak-services-${VERSION}.jar

ENTRYPOINT []

CMD ["/opt/jboss/tools/docker-entrypoint.sh", "-b", "0.0.0.0"]
EOS
  ) > Dockerfile

  docker build \
    -f Dockerfile \
    -t keycloak-ldap:${VERSION} \
    .
}

dockerrun(){
  docker run --rm -it \
  --name kc \
  -p 8080:8080 \
  -e KEYCLOAK_USER=admin \
  -e KEYCLOAK_PASSWORD=admin \
  -e KEYCLOAK_LOGLEVEL=DEBUG \
  -v ${cwd}/../deployments:/opt/jboss/keycloak/standalone/deployments \
  keycloak-ldap:$VERSION
}

case $1 in 
--run)
  dockerrun
  ;;
--docker)
  dockerbuild
  ;;
-h|--help)
  cat $0
  ;;
*)
  mvnbuild
  ;;
esac
