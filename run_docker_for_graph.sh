# https://blog.yadutaf.fr/2017/09/10/running-a-graphical-app-in-a-docker-container-on-a-remote-server/
# Prepare target env
CONTAINER_DISPLAY="10"
CONTAINER_HOSTNAME=`hostname`

# Create a directory for the socket
mkdir -p display/socket
touch display/Xauthority

# Get the DISPLAY slot
DISPLAY_NUMBER=$(echo $DISPLAY | cut -d: -f2| cut -d. -f1 )

# Extract current authentication cookie
AUTH_COOKIE=$(xauth list | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " | awk '{print $3}')

# Create the new X Authority file
xauth -f display/Xauthority add ${CONTAINER_HOSTNAME}/unix:${CONTAINER_DISPLAY} MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}

# Proxy with the :0 DISPLAY
socat TCP4:localhost:60${DISPLAY_NUMBER} UNIX-LISTEN:display/socket/X${CONTAINER_DISPLAY} &

# Launch the container
docker run -dit --rm \
  -e DISPLAY=:${CONTAINER_DISPLAY} \
  -v ${PWD}/display/socket:/tmp/.X11-unix \
  -v ${PWD}/display/Xauthority:/root/.Xauthority \
  -v /mnt/docker/data/:/mnt/data \
  --hostname ${CONTAINER_HOSTNAME} \
  tf:v1.0 /bin/bash

<<B
docker run -dit --rm \
  --net=host \
  -e DISPLAY=:10.0 \
  -e DISPLAY=:${CONTAINER_DISPLAY} \
  -v ${PWD}/display/socket:/tmp/.X11-unix \
  -v ${PWD}/display/Xauthority:/root/.Xauthority \
  -v /mnt/docker/data/:/mnt/data \
  --hostname ${CONTAINER_HOSTNAME} \
  tf:v1.0 /bin/bash
B


