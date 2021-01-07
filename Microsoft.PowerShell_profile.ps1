Import-Module posh-git

function Invoke-GitCheckout { git checkout @args }
Set-Alias gcco Invoke-GitCheckout

$GitPromptSettings.DefaultPromptSuffix = '`n' + "$('>' * ($nestedPromptLevel + 1)) "

# From https://stackoverflow.com/a/58844032/513325
function ggco
{
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({
            param($pCmd, $pParam, $pWord, $pAst, $pFakes)

            $branchList = (git branch --format='%(refname:short)')

            if ([string]::IsNullOrWhiteSpace($pWord)) {
                return $branchList;
            }

            $branchList | Select-String "$pWord"
        })]
        [string] $branch
    )

    git checkout $branch;
}

function Git-Status { git status $args }
Set-Alias -Name ggst -Value Git-Status
function Git-Add-Updated { git add --update $args }
Set-Alias -Name ggau -Value Git-Add-Updated
function Git-Commit { git commit -v $args }
Set-Alias -Name ggc -Value Git-Commit
function Git-Commit-Ammend { git commit -v --amend $args }
Set-Alias -Name ggc! -Value Git-Commit-Ammend
function Git-Fetch { git fetch }
Set-Alias -Name ggf -Value Git-Fetch
function Git-Pull { git pull }
Set-Alias -Name ggl -Value Git-Pull
function Git-Push { git push }
Set-Alias -Name ggp -Value Git-Push
function Git-Branch { git branch }
Set-Alias -Name ggb -Value Git-Branch
function Git-Branch-Remote { git branch --remote }
Set-Alias -Name ggbr -Value Git-Branch-Remote
function Git-Diff { git diff }
Set-Alias -Name ggd -Value Git-Diff
function Git-Diff-Cached { git diff --cached }
Set-Alias -Name ggdca -Value Git-Diff-Cached
function Get-Log-Oneline-Decorate-Graph { git log --oneline --decorate --graph }
Set-Alias -Name gglog -Value Get-Log-Oneline-Decorate-Graph

