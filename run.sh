#!/bin/bash

./setup.sh

target="development"
workspace="all"
volume="$HOME/.events-platform-iac/config"
while getopts 'e::w::v::' flag; do
  case "${flag}" in
    e) target="${OPTARG}" ;;
    w) workspace="${OPTARG}" ;;
    v) volume="${OPTARG}" ;;
    *) printf "unsupported flag '${flag}'" ;;
  esac
done

docker build . -t events-platform-iac-iac
docker run -e DEPLOY_TARGET="${target}" -e WORKSPACE="${workspace}" -v ${volume}:/iac-config.yml \
    -a stdout -a stderr events-platform-iac-iac ./entrypoint.sh