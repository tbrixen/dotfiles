@echo [+] Creating symlink to %~dp0.vimrc from %HOMEPATH%\_vimrc
mklink %HOMEPATH%\_vimrc %~dp0.vimrc
@echo [+] Please open vim and run :PluginInstall
@echo [+] Please put the following into your .gitconfig
@echo [include]
@echo     path = %~dp0.gitconfig
