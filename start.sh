#!/bin/sh
export TMK_DIR='/tmk/keyboard/alps64'
export DOCKER_NAME='alps'

# Build the image from Dockerfile
docker build -t "${DOCKER_NAME}" .
#
# Run the script which makes all the firmware
docker run -it --rm --env TMK_DIR="$TMK_DIR" -v "$(pwd):/work" "${DOCKER_NAME}" "$TMK_DIR/make.sh"
