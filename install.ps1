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

New-Symlink "$ENV:HOMEDRIVE$ENV:HOMEPATH\.bashrc" "$PSScriptRoot\bashrc" 

New-Symlink "$ENV:HOMEDRIVE$ENV:HOMEPATH\_vimrc" "$PSScriptRoot\vimrc"

New-Symlink "$ENV:HOMEDRIVE$ENV:HOMEPATH\vimfiles" "$PSScriptRoot\vim"

New-Symlink "$ENV:HOMEDRIVE$ENV:HOMEPATH\.vim" "$PSScriptRoot\vim"

New-Symlink "$ENV:HOMEDRIVE$ENV:HOMEPATH\.gitconfig" "$PSScriptRoot\gitconfig"

New-Symlink "$ENV:HOMEDRIVE$ENV:HOMEPATH\.dotfiles" "$PSScriptRoot\"

New-Symlink "$Profile" "$PSScriptRoot\Microsoft.PowerShell_profile.ps1"

Install-Module posh-git -Scope CurrentUser
Install-Module -Name PSFzf -RequiredVersion 2.1.0
Install-Module git-aliases -Scope CurrentUser -AllowClobber

echo "[+] Initializing dotbot and other git submodules"
cd $PSScriptRoot\
git submodule update --init --recursive

echo "[+] To install plugins for Vim, open Vim and run the following:"
echo "    :PlugInstall"
