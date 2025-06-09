#!/bin/bash
workspace=${WORKSPACE}
if [ $workspace == 'all' ]; then
  for filename in src/${DEPLOY_TARGET}/*.yml; do
    name=`basename ${filename}`
    if [ $name != 'index.yml' ]; then
      WORKSPACE=${name/.yml/} ansible-playbook -i 'localhost,' ansible/main.yml
    fi
  done
else
  ansible-playbook -i 'localhost,' ansible/main.yml
fi