## https://gist.github.com/jchandra74/5b0c94385175c7a8d1cb39bc5157365e
## Most of below is Inspired by what is found at the link above, if not mostly directly copied from it.

"Loading custom PowerShell environment..."
# start bench marking profile loading time. Naive? probably.
$startTime = Get-Date
## LOAD External Files
### Functions
$CustomFunctions=Join-Path $PSScriptRoot  "CustomFunctions.ps1"
$OSSFunctions=Join-Path $PSScriptRoot  "OSSFunctions.ps1"
### A view/ prompt
$prompt=Join-Path $PSScriptRoot  "view.ps1"
## You need Deno installed, to you run deno completions.
$DenoCompletion=Join-Path $PSScriptRoot  "DenoCompletion.ps1"
## this logic should be ran for each of the import steps. WIP*
if (Test-Path($DenoCompletion)) {
    Import-Module "$DenoCompletion"
}
# loop over this array and run the Test-Path logic and import if the file is found at path
$FilesToImport= [$CustomFunctions,$OSSFunctions,$prompt,$DenoCompletion]

# Other view option is to use oh-my-posh comment out the $prompt above.
# Ensure oh-my-posh is loaded, to install oh-my-posh: Install-Module -Name oh-my-posh
# Import-Module -Name oh-my-posh

# Default the prompt to darkblood oh-my-posh theme
## https://github.com/JanDeDobbeleer/oh-my-posh#themes
# Set-Theme darkblood

Import-Module $CustomFunctions
Import-Module $OSSFunctions
Import-Module $DenoCompletion
Import-Module $prompt



## Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# https://github.com/joonro/Get-ChildItemColor
# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-4184928\src\posh-git.psd1'
# Ensure posh-git is loaded, to Install posh-git Install-Module -Name posh-git
Import-Module -Name posh-git

# Might Need this if you are using github as your remote git repository
# Start SshAgent if not already
if (! (Get-Process | Where-Object { $_.Name -eq 'ssh-agent'})) {
    Start-SshAgent
}



## Calculate profile load time.
$endTime = Get-Date
$elapsedTime = ($endTime - $startTime).Milliseconds

$message = "undefined"

If ($elapsedTime -lt 1000) { $message = ($elapsedTime.ToString() + "ms") }
Else { $message = (($elapsedTime * 1000).ToString() + "s") }
Write-Warning "Custom profile load time: $($message)"
