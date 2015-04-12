#!/bin/sh

MASTER_ID=$1
if [ -z ${MASTER_ID} ]; then
  MASTER_ID='local'
fi

MOUNTPOINT="/ipns/${MASTER_ID}/docker-registry"

echo "Starting local docker registry mounted on IPFS:"
echo ${MOUNTPOINT}
echo

docker run -p 5000:5000 \
           -d -t \
           --name registry \
           -v /etc/docker-registry.yml:/docker-registry.yml \
           -v ${MOUNTPOINT}:${MOUNTPOINT} \
           -e DOCKER_REGISTRY_CONFIG=/docker-registry.yml \
           -e SETTINGS_FLAVOR=prod \
           -e STORAGE_PATH=${MOUNTPOINT} \
           registry
