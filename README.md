Dotfiles
========

Dotfiles uses [Dotbot][dotbot] for installation.

How to use
----------

    $ git clone http://github.com/tbrixen/dotfiles
    $ cd dotfiles
    $ ./install

Making local customizations
---------------------------

* `.gitignore` : `~/.gitignore_local`
* `.bashrc` : `~/.bashrc_local_before` runs first
* `.bashrc` : `~/.bashrc_local_after` runs after


[dotbot]: https://github.com/anishathalye/dotbot
