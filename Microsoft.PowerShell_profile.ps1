Import-Module posh-git
Import-Module ~/.dotfiles/posh-extras/cd-extras/cd-extras/cd-extras.psd1
Import-Module git-aliases -DisableNameChecking
Import-Module z

# Enable tab-completion as in Zsh with selection
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings: (PSFzf module)
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function sudo {
   Start-Process powershell.exe -Verb Runas
}

function sudo-command {
   Start-Process powershell.exe -Verb Runas -ArgumentList "-NoExit -Command $args"
}

function sudo-file {
   Start-Process powershell.exe -Verb Runas -ArgumentList "-NoExit -File $args"
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

function Show-Notication {
  param(
    $message,
    $title = "Script Completed!")

  [reflection.assembly]::loadwithpartialname("System.Windows.Forms")
  [reflection.assembly]::loadwithpartialname("System.Drawing")
  $notify = new-object system.windows.forms.notifyicon
  $notify.icon = [System.Drawing.SystemIcons]::Information
  $notify.visible = $true
  $notify.showballoontip(10000, $title, $message, [system.windows.forms.tooltipicon]::None)
}

# Tab-completion for ~/.ssh/config and ~/.ssh/known_hosts
# Stolen from https://github.com/michaeloyer/windows-setup/blob/master/Setup/PowershellProfile/ModulesToInstall/ProfileImport/TabCompletion.ps1
function Get-TabCompleteContext($wordToComplete, $commandAst) {
  if ($commandAst -notmatch ' ') {
    return ''
  }

  $subCommands = ($commandAst -split ' ', 2)[1].Trim() -replace '\s+', ' ' `
    -replace '(\B|\s)\-.*(?=\s\-)', ""

  $context = ($subCommands -replace ([Regex]::Escape($wordToComplete) + "$"), '').Trim() `
    -replace '\s+' + [Regex]::Escape($wordToComplete) + "$", ''

  return $context 
}

Register-ArgumentCompleter -Native -CommandName 'ssh' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $context = Get-TabCompleteContext $wordToComplete $commandAst

  switch ($context) {
    '-i' {
      Get-ChildItem ~/.ssh | 
      Select -ExpandProperty FullName |
      ForEach-Object { "$wordToComplete $_".TrimStart() }
    }
    '' {
      $ssh_hosts = 
      Get-Content ~/.ssh/config -ErrorAction Ignore |
      Select-String ^Host -Raw |
      ForEach-Object { $_ -split '\s+' | Where-Object { -not [string]::IsNullOrEmpty($_) } | Select-Object -Skip 1 } |
      Sort-Object -Property @{Expression={[ipaddress]::TryParse($_, [ref]$null) }}, @{Expression={$_}}

      $known_hosts =
      Get-Content ~/.ssh/known_hosts -ErrorAction Ignore |
      ForEach-Object { $_ -split '\s' | Select-Object -First 1 } |
      ForEach-Object { $_ -split ',' } |
      ForEach-Object { $_ -replace '^\[' -replace '\]:\d+$' } |
      Sort-Object -Property @{Expression={[ipaddress]::TryParse($_, [ref]$null) }}, @{Expression={$_}}

      ($ssh_hosts + $known_hosts) |
      Select-Object -Unique |
      Where-Object { $_ -like "$wordToComplete*" }
    }
  }
}

# docker-compose Set-Alias
# From https://gist.github.com/pokev25/0efa6747128b1738a3d5c71fc3b2d117
function DockerComposeUp {
    docker-compose up $args
}
function DockeComposeBuild {
    docker-compose build
}
function DockeComposeExec {
    docker-compose exec $args
}
function DockeComposePs {
    docker-compose ps $args
}
function DockeComposeRestart {
    docker-compose restart
}
function DockeComposeRm {
    docker-compose rm $args
}
function DockeComposeRun {
    docker-compose run $args
}
function DockeComposeStop {
    docker-compose stop $args
}
function DockeComposeUpd {
    docker-compose up -d
}
function DockeComposeDown {
    docker-compose down
}
function DockeComposeLogs {
    docker-compose logs
}
function DockeComposeLogsf {
    docker-compose logs -f
}
function DockeComposePull {
    docker-compose pull
}
function DockeComposeStart {
    docker-compose start
}
Set-Alias dco docker-compose
Set-Alias dcb DockeComposeBuild
Set-Alias dce DockeComposeExec
Set-Alias dcps DockeComposePs
Set-Alias dcrestart DockeComposeRestart
Set-Alias dcrm DockeComposeRm
Set-Alias dcr DockeComposeRun
Set-Alias dcstop DockeComposeStop
Set-Alias dcup DockerComposeUp
Set-Alias dcupd DockeComposeUpd
Set-Alias dcdn DockeComposeDown
Set-Alias dcl DockeComposeLogs
Set-Alias dclf DockeComposeLogsf
Set-Alias dcpull DockeComposePull
Set-Alias dcstart DockeComposeStart

