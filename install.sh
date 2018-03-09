#!/bin/bash
THIS_DIR=$(cd $(dirname "$0"); pwd)
INSTALL_DIR=~/

MANAGED_FILES=(\
  ~/.tmux.conf \
  )

for FILE in ${MANAGED_FILES[@]}; do
  STRIPPED_FILE_NAME=${FILE##*/}
  echo "Symlinking ${THIS_DIR}/${STRIPPED_FILE_NAME} to ${INSTALL_DIR}"
  ln -sf ${THIS_DIR}/${STRIPPED_FILE_NAME} ${INSTALL_DIR}
done
