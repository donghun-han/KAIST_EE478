#!/bin/bash

REPO_ROOT="$(dirname $(dirname $(realpath $0)))"
# echo $REPO_ROOT

# Display
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

DISPLAY_OPTIONS="--env DISPLAY=$DISPLAY \
                 --env XAUTHORITY=$XAUTH \
                 --env QT_X11_NO_MITSHM=1 \
                 --volume $XSOCK:$XSOCK:rw \
                 --volume $XAUTH:$XAUTH:rw"

GPU_OPTIONS="--gpus all \
             --runtime=nvidia \
             --env NVIDIA_DRIVER_CAPABILITIES=compute,utility,graphics,display"

# Mounting volume
MOUNT_OPTIONS="--volume $REPO_ROOT/catkin_ws:/home/$USER/catkin_ws"

docker run -it --rm --privileged \
    $DISPLAY_OPTIONS \
    $MOUNT_OPTIONS \
    $GPU_OPTIONS \
    --env TERM=xterm-256color \
    --network=host \
    --shm-size=4gb \
    --name ee478 \
    kaist_ee478/simulator:2026 \
    /bin/bash