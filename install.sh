#!/bin/bash
THIS_DIR=$(cd $(dirname "$0"); pwd)
INSTALL_DIR=~/
VIM_DIR="${INSTALL_DIR}.vim"

if [[ $(uname) != "Linux" ]]
then
  echo "Currently only for linux"
fi

MANAGED_FILES_FOR_SYMLINK=(\
  ~/.tmux.conf \
  ~/.vimrc
  )

MANAGED_FILES_FOR_COPY_PASTING=(\
  ~/.gitconfig
 )
  
function create_file_if_absent()
{
  echo "    [+] Creating absent file $1"
  FILE=$1
  touch "$1"
  return 0
}

function does_file_contains_text()
{
  FILE=$1
  TEXT=$2
  grep "$TEXT" "$FILE" 1>/dev/null
  return $?
}

function replace_text_and_banner()
{
  BANNER_START=$1
  BANNER_STOP=$2
  FILE=$3
  # Replaces /  with \/
  TEXT_TO_INSERT=$(echo "$4" | sed "s=/=\\\/=g" )
  perl -pi.bak -e "BEGIN{undef $/;} s/$BANNER_START.*$BANNER_STOP/$BANNER_START\n$TEXT_TO_INSERT\n$BANNER_STOP/smg" $FILE
  return 0
}

function insert_or_replace_into_file()
{
  COMMENT_CHAR="#"
  BANNER_START="$COMMENT_CHAR tbrixen dotfiles section start"
  BANNER_STOP="$COMMENT_CHAR tbrixen dotfiles section end"
  FILE=$1
  TEXT_TO_INSERT=$2

  create_file_if_absent "$FILE"
  
  if ! does_file_contains_text "$FILE" "$BANNER_START"; then
    echo $BANNER_START >> "$FILE"
    echo -e "$TEXT_TO_INSERT" >> "$FILE"
    echo $BANNER_STOP >> "$FILE"
  else
    replace_text_and_banner "$BANNER_START" "$BANNER_STOP" "$FILE" "$TEXT_TO_INSERT"
  fi

}

echo "[+] Copy/pasting into files"
for FULL_PATH in ${MANAGED_FILES_FOR_COPY_PASTING}; do
  FILE_NAME=${FULL_PATH##*/}
  echo "  [+] $FILE_NAME into $FULL_PATH"
  TEXT_TO_INSERT=$(<$FILE_NAME)
  if [[ "$FILE_NAME" == ".gitconfig" ]]; then
    TEXT_TO_INSERT="[include]\n    path = $THIS_DIR/$FILE_NAME"
  fi
  insert_or_replace_into_file "$INSTALL_DIR$FILE_NAME" "$TEXT_TO_INSERT"
done

echo "[+] Symlinking files" 
for FILE in ${MANAGED_FILES_FOR_SYMLINK[@]}; do
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


