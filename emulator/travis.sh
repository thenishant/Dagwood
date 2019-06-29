#!/bin/bash
# Bash version should >= 4 to be able to run this script.

if [[ ! -z "$ANDROID_VERSION" ]]; then
  echo "Log in to docker hub"
  docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
  echo "[Version: $ANDROID_VERSION] BUILD DOCKER IMAGES AND PUSH THOSE TO DOCKER HUB"
  bash CI.sh all ${ANDROID_VERSION} ${TRAVIS_TAG}
  echo "Log out of docker hub"
  docker logout
fi