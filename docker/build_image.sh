#!/bin/bash

DOCKERFILE_PATH="$(dirname $(realpath $0))/Dockerfile"
PROJ_ROOT="$(dirname ${DOCKERFILE_PATH})"

# echo "DOCKERFILE_PATH: ${DOCKERFILE_PATH}"
# echo "PROJ_ROOT: ${PROJ_ROOT}"

USERNAME=${USER}
USER_UID=$(id -u)
USER_GID=$(id -g)

docker build \
    --build-arg USERNAME=${USERNAME} \
    --build-arg USER_UID=${USER_UID} \
    --build-arg USER_GID=${USER_GID} \
    --tag kaist_ee478/simulator:2026 \
    --file ${DOCKERFILE_PATH} \
    ${PROJ_ROOT}