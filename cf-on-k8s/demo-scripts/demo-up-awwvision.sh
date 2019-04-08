#!/usr/bin/env bash

set -x

mvn package -DskipTests && cf push -p target/awwvision-spring-0.0.1-SNAPSHOT.jar awwvision --no-start
cf create-service google-storage standard awwvision-storage
cf bind-service awwvision awwvision-storage -c '{"role":"storage.objectAdmin"}'
cf create-service google-ml-apis default ml
cf bind-service awwvision ml  -c '{"role":"ml.viewer"}'
cf start awwvision

