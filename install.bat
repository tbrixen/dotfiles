@echo [+] Creating symlink to %~dp0bashrc from %HOMEPATH%\.bashrc
@mklink %HOMEPATH%\.bashrc %~dp0bashrc

@echo [+] Creating symlink to %~dp0vimrc from %HOMEPATH%\_vimrc
@mklink %HOMEPATH%\_vimrc %~dp0vimrc

@echo [+] Creating symlink to %~dp0vim\ from %HOMEPATH%\vimfiles\
@mklink /D %HOMEPATH%\vimfiles %~dp0vim

@echo [+] Creating symlink to %~dp0vim\ from %HOMEPATH%\.vim\
@mklink /D %HOMEPATH%\.vim %~dp0vim

@echo [+] Creating symlink to %~dp0gitconfig from %HOMEPATH%\.gitconfig
@mklink %HOMEPATH%\.gitconfig %~dp0gitconfig

@echo [+] Please run the following to download dotbot
@echo   git submodule update --init --recursive

pause