# Enable tab-completion as in Zsh with selection
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

function GoAdmin { start-process powershell -verb runAs }

Import-Module ~/.dotfiles/posh-extras/cd-extras/cd-extras/cd-extras.psd1

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