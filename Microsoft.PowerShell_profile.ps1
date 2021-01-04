Import-Module posh-git

$profilePath = Split-Path $Profile
$profileBefore = "$profilePath\Microsoft.PowerShell_profile_before.ps1"
if (test-path -Path $profileBefore)
{
    . $profileBefore
}
. $ENV:HOMEDRIVE$ENV:HOMEPATH\.dotfiles\powershell.ps1

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

function New-BashStyleAlias([string]$name, [string]$command)
{
    $sb = [scriptblock]::Create($command)
    New-Item "Function:\global:$name" -Value $sb | Out-Null
}

New-BashStyleAlias dco        'docker-compose          @args'
New-BashStyleAlias dcb        'docker-compose build    @args'
New-BashStyleAlias dce        'docker-compose exec     @args'
New-BashStyleAlias dcps       'docker-compose ps       @args'
New-BashStyleAlias dcrestart  'docker-compose restart  @args'
New-BashStyleAlias dcrm       'docker-compose rm       @args'
New-BashStyleAlias dcr        'docker-compose run $c   @args'
New-BashStyleAlias dcstop     'docker-compose stop     @args'
New-BashStyleAlias dcup       'docker-compose up       @args'
New-BashStyleAlias dcupd      'docker-compose up -d    @args'
New-BashStyleAlias dcdn       'docker-compose down $c  @args'
New-BashStyleAlias dcl        'docker-compose logs     @args'
New-BashStyleAlias dclf       'docker-compose logs -f  @args'
New-BashStyleAlias dcpull     'docker-compose pull     @args'
New-BashStyleAlias dcstart    'docker-compose start    @args'

$profileAfter = "$profilePath\Microsoft.PowerShell_profile_after.ps1"
if (test-path -Path $profileAfter)
{
    . $profileAfter
}

