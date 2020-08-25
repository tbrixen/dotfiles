# Dotfiles

These are my dotfiles. There are many more like them but these are mine. 

They are a mix of Windows, macOS and Linux dotfiles. I’ve tried to make them work on these platforms.


## Installation

For Linux/MacOS

    $ git clone http://github.com/tbrixen/dotfiles
    $ cd dotfiles
    $ ./install

The install script is a [Dotbot][dotbot] script and I’ve tried to configure it to be idempotent.

For Windows I’ve included an experimental installation script `install.bat`.

The dotfiles should work (more or less) out of the box, but to fully utilize all plugins we need to compile and/or install some dependencies.

**YouCompleteMe** (Vim plugin):
The vim plugin YouCompleteMe is included. For this to work it must be compiled. This requires `python` and `cmake`. Install the plugin using

    $ vim/bundle/YouCompleteMe/install.py

Windows users see https://bitbucket.org/Alexander-Shukaev/vim-youcompleteme-for-windows.

**One-dark** (Tmux theme):
This theme needs Powerline patched fonts.

* For WSL in Windows Terminal install CascadiaMonoPL (https://github.com/microsoft/cascadia-code/releases) and set `"fontFace": "Cascadia Mono PL"` in options of Windows Terminal.
* For Mac users with Iterm2: User a PowerLine patched font. E.g. from https://github.com/powerline/fonts. I currently use Inconsolata-dz.

**Tmux fingers** (Tmux plugin): requires `gawk`.

**Extrakto** (Tmux plugin): requires `fzf`.

**markdown-preview.nvim** (Vim plugin): 
Requires `npm` and `yarn`

    $ npm install -g yarn
    $ cd vim/bundle/markdown-preview.nvim
    $ yarn install

## Making local customizations

* `.gitignore` : `~/.gitignore_local`
* `.bashrc` : `~/.bashrc_local_before` runs first
* `.bashrc` : `~/.bashrc_local_after` runs after
* `.zshrc` : `~/.zshrc_local_after` runs after


## Vim and Tmux integration

The Vim plugin [vim-tmux-navigation](https://github.com/christoomey/vim-tmux-navigator) together with the Tmux plugin [vim-tmux-navigation](https://github.com/christoomey/vim-tmux-navigator) provides seamless split/pane navigation using the following key-bindings

* `C-l`
* `C-k`
* `C-j`
* `C-h`


## Notes for maintaining this repository

**Update submodules**

Updating the local submodules to the versions specified in this repository

    $ git submodule update --remote --merge

Updating submodules to the current version on their respective remotes

    $ git submodule update --remote --merge
    $ git submodule foreach --recursive 'git reset --hard'
    $ git status
    $ # Then, for each submodule with 'new commits', do a 'git add <submodule path>'

**Remove a submodule**

To remove a submodule, use the `rm` command

    $ git rm /path/to/submodule

**Add a plugin to Vim**

To increase portability, use https instead of ssh 

Add it as a sub-module, and reload vim

    $ cd vim/bundle/
    $ git submodule add https://url-to-clone

To check if it has been loaded, source the `vimrc`, run `:scriptnames` and check that it is in the list


[dotbot]: https://github.com/anishathalye/dotbot
