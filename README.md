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
    
Vim and Tmux integration
-------------------- 

The Vim plugin [vim-tmux-navigation](https://github.com/christoomey/vim-tmux-navigator) together with the Tmux plugin [vim-tmux-navigation](https://github.com/christoomey/vim-tmux-navigator) provides seamless split/pane navigation using the following key-bindings

* `C-l`
* `C-k`
* `C-j`
* `C-h`

[dotbot]: https://github.com/anishathalye/dotbot
