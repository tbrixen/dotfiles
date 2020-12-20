Import-Module posh-git

function Invoke-GitCheckout { git checkout @args }
Set-Alias gcco Invoke-GitCheckout

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
function Git-Pull { git pull }
Set-Alias -Name ggl -Value Git-Pull
function Git-Push { git push }
Set-Alias -Name ggp -Value Git-Push
