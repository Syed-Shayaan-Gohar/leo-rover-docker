#!/bin/bash
xhost +local:docker > /dev/null

if docker ps | grep -q "leo-rover-sim"; then
    docker exec -it leo-rover-sim bash
else
    docker run -it --rm \
        --name leo-rover-sim \
        --net=host \
        --gpus all \
        -e DISPLAY=$DISPLAY \
        -e NVIDIA_DRIVER_CAPABILITIES=all \
        -e __NV_PRIME_RENDER_OFFLOAD=1 \
        -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        leo-rover-sim
fi
