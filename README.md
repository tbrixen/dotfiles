Dotfiles
========

Dotfiles uses [Dotbot][dotbot] for installation.

How to use
----------

    $ git clone http://github.com/tbrixen/dotfiles
    $ cd dotfiles
    $ ./install

The vim plugin YouCompleteMe is included. For this to work it must be compiled. This requires `python` and `cmake`. Install the plugin using

    $ vim/bundle/YouCompleteMe/install.py

Windows users see https://bitbucket.org/Alexander-Shukaev/vim-youcompleteme-for-windows.

The Tmux theme uses PowerLine patched fonts. For WSL in Windows Terminal install CascadiaMonoPL (https://github.com/microsoft/cascadia-code/releases) and set `"fontFace": "Cascadia Mono PL"` in options of Windows Terminal.

Making local customizations
---------------------------

* `.gitignore` : `~/.gitignore_local`
* `.bashrc` : `~/.bashrc_local_before` runs first
* `.bashrc` : `~/.bashrc_local_after` runs after
* `.zshrc` : `~/.zshrc_local_after` runs after

Updating submodules
-------------------

Updating the local submodules to the versions specified in this repository

    $ git submodule update --remote --merge

Updating submodules to the current version on their respective remotes

    $ git submodule update --remote --merge
    $ git submodule foreach --recursive 'git reset --hard'
    $ git status
    $ # Then, for each submodule with 'new commits', do a 'git add <submodule path>'

Removing a submodule
--------------------

To remove a submodule, use the `rm` command

    $ git rm /path/to/submodule

Add a plugin to Vim
----------------------

Add it as a sub-module, and reload vim

    $ cd vim/bundle/
    $ git submodule add https://url-to-clone

To check if it has been loaded, source the `vimrc`, run `:version` and check that it is in the list.

Vim and Tmux integration
------------------------

The Vim plugin [vim-tmux-navigation](https://github.com/christoomey/vim-tmux-navigator) together with the Tmux plugin [vim-tmux-navigation](https://github.com/christoomey/vim-tmux-navigator) provides seamless split/pane navigation using the following key-bindings

* `C-l`
* `C-k`
* `C-j`
* `C-h`

[dotbot]: https://github.com/anishathalye/dotbot
