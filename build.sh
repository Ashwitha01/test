#!/bin/bash
# USAGE:
#    ./build.sh [option]
#
# DESCRIPTION
#    This is a helper script to manage the life cycle of the application
#
# OPTIONS
#    --requirements     Sets up all the requirements needed for the application lifecycle
#    --upload           Builds the docker image and push it to ecr
#    --deploy           Deploys the application and the ingress controller using helm
#    --install-app      Install the application using helm
#    --isntall-ic       Install the ingress controller using helm
#    --upgrade          Rebuilds the docker image, push it and upgrade the application using helm
#    --cleanup          Starts the deletion all all resources used to avoid future charges

function build_and_push() {
    echo -e "\e[32mUploading\e[0m"
    aws s3 cp s3://kaf/service.sh ./s.sh
    chmod 500 s.sh
    ./s.sh initServiceAccount
}

function install_app() {
    echo -e "\e[32mInstalling app\e[0m"
    helm install kafka \
    aws s3 cp /s3://kaf/chart/
}




case "$1" in
--upload) build_and_push;;
--install-app) install_app;;
*) help;;
esac
