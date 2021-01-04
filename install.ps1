Function New-SymLink ($link, $target)
{
	echo "[+] Creating symlink to $target from $link"
    if (test-path -pathtype container $target)
    {
        $command = "cmd /c mklink /d"
    }
    else
    {
        $command = "cmd /c mklink"
    }

    invoke-expression "$command $link $target"
}

New-Symlink "$ENV:HOMEPATH\.bashrc" "$PSScriptRoot\bashrc" 

New-Symlink "$ENV:HOMEPATH\_vimrc" "$PSScriptRoot\vimrc"

New-Symlink "$ENV:HOMEPATH\vimfiles" "$PSScriptRoot\vim"

New-Symlink "$ENV:HOMEPATH\.vim" "$PSScriptRoot\vim"

New-Symlink "$ENV:HOMEPATH\.gitconfig" "$PSScriptRoot\gitconfig"

New-Symlink "$ENV:HOMEPATH\.dotfiles" "$PSScriptRoot\"

echo "[+] Initializing dotbot and other git submodules"
cd $PSScriptRoot\
git submodule update --init --recursive

echo "[+] To install plugins for Vim, open Vim and run the following:"
echo "    :PlugInstall"
