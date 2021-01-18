Import-Module posh-git
Import-Module ~/.dotfiles/posh-extras/cd-extras/cd-extras/cd-extras.psd1

# Enable tab-completion as in Zsh with selection
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings: (PSFzf module)
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

# Inspiration https://hodgkins.io/ultimate-powershell-prompt-and-git-setup#powershell-profile 
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host

    if (Test-Administrator) {  # Use different username if elevated
        Write-Host "(Elevated) " -NoNewline -ForegroundColor White
    }

    Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Blue

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus

    Write-Host
    return "> "
}

# Displays a selectable grid of commands from the history
Function h+
{
    Get-Content (Get-PSReadlineOption).HistorySavePath |
      Out-GridView -Title "Command History - press CTRL to select multiple - Selected commands copied to clipboard" -OutputMode Multiple |
      ForEach-Object -Begin { [Text.StringBuilder]$sb = ""} -Process { $null = $sb.AppendLine($_.CommandLine) } -End { $sb.ToString() | clip }
}

function Read-Manifest {
  param([string]$jarfile)

  Add-Type -Assembly System.IO.Compression.FileSystem

  $jarfileAbsolute = (Resolve-Path $jarfile)

  #extract list entries for dir myzipdir/c/ into myzipdir.zip
  $zip = [IO.Compression.ZipFile]::OpenRead($jarfileAbsolute)
  $entries=$zip.Entries | where {$_.FullName -like 'META-INF/MANIFEST.MF'}

  #create dir for result of extraction
  $parent = [System.IO.Path]::GetTempPath()
  [string] $name = [System.Guid]::NewGuid()
  New-Item -ItemType Directory -Path (Join-Path $parent $name) | Out-Null

  $tempfolder = (Join-Path $parent $name)

  #extraction
  $entries | foreach {[IO.Compression.ZipFileExtensions]::ExtractToFile( $_, (Join-Path $tempfolder $_.Name)) }

  #free object
  $zip.Dispose()

  Get-Content $tempfolder\MANIFEST.MF
}

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

