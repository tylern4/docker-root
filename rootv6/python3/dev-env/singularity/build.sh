#!/usr/bin/env bash
BLUE="\033[34m"
DEF="\033[0m"
MAG="\033[35m"
RED="\033[31m"
GREEN="\033[32m"

IM_PATH="."
NAME="dev-env"

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -p|--path)
    IM_PATH="$2"
    shift # past argument
    ;;
    -n|--name)
    NAME="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

#Create singularity image name
IMAGE=${IM_PATH}/${NAME}.img

#If there is an image remove it
if [ -f "${IMAGE}" ]; then
    echo -e $RED"deleting image"$DEF
    sudo rm -rf ${IMAGE}
fi

#Create image and build software inside it
sudo singularity create --size 2800 ${IMAGE}
sudo singularity bootstrap ${IMAGE} dev-env.def
