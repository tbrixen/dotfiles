Import-Module posh-git
Import-Module ~/.dotfiles/posh-extras/cd-extras/cd-extras/cd-extras.psd1
Import-Module git-aliases -DisableNameChecking

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

function Vimwiki-Goto { vim -c "VimwikiIndex" -c "VimwikiGoto $args" }
Set-Alias -Name ww -Value Vimwiki-Goto

