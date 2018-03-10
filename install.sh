#!/bin/bash
THIS_DIR=$(cd $(dirname "$0"); pwd)
INSTALL_DIR=~/
VIM_DIR="${INSTALL_DIR}.vim"

if [[ $(uname) != "Linux" ]]
then
  echo "Currently only for linux"
fi

MANAGED_FILES=(\
  ~/.tmux.conf \
  ~/.vimrc
  )

echo "[+] Symlinking files" 
for FILE in ${MANAGED_FILES[@]}; do
  STRIPPED_FILE_NAME=${FILE##*/}
  echo "Symlinking ${THIS_DIR}/${STRIPPED_FILE_NAME} to ${INSTALL_DIR}${STRIPPED_FILE_NAME}"
  ln -sf ${THIS_DIR}/${STRIPPED_FILE_NAME} ${INSTALL_DIR}
done

if [[ ! -d ${VIM_DIR} ]]
then
  echo "[+] Installing vundle" 
  git clone https://github.com/VundleVim/Vundle.vim.git "$VIM_DIR/bundle/Vundle.vim"
  echo "[+] Installing vim plugins"
  vim +PluginInstall +qall
  echo "[+] Compiling YouCompleteMe vim plugin"
  sudo apt-get install build-essential cmake
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py
fi

