@echo [+] Creating symlink to %~dp0vimrc from %HOMEPATH%\_vimrc
@mklink %HOMEPATH%\_vimrc %~dp0vimrc

@echo [+] Creating symlink to %~dp0vimfile\ from %HOMEPATH%\.vim\
@mklink /D %HOMEPATH%\vimfiles %~dp0vim

@echo [+] Creating symlink to %~dp0gitconfig from %HOMEPATH%\.gitconfig
@mklink %HOMEPATH%\.gitconfig %~dp0gitconfig

@echo [+] Please run the following to download dotbot and vim plugins
@echo   git submodule update --init --recursive

pause