"Loading custom PowerShell environment..."
$startTime = Get-Date
## LOAD External Files
### Functions
$CustomFunctions="C:\Users\ablajide\OneDrive - Microsoft\PowerShell\CustomFunctions.ps1"
$OSSFunctions="C:\Users\ablajide\OneDrive - Microsoft\PowerShell\OSSFunctions.ps1"
$DenoCompletion="C:\Users\ablajide\OneDrive - Microsoft\PowerShell\DenoCompletion.ps1"
## prompt (view)
$prompt="C:\Users\ablajide\OneDrive - Microsoft\PowerShell\view.ps1"

## Other View Option is oh-my-posh
# Ensure oh-my-posh is loaded, to install oh-my-posh, Install-Module -Name oh-my-posh
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


## https://gist.github.com/jchandra74/5b0c94385175c7a8d1cb39bc5157365e
# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-4184928\src\posh-git.psd1'
# Ensure posh-git is loaded, to Install posh-git Instal-Module -Name posh-git
Import-Module -Name posh-git

# Might Need this if you are using github as your remote git repository
# Start SshAgent if not already
# if (! (Get-Process | Where-Object { $_.Name -eq 'ssh-agent'})) {
#     Start-SshAgent
# }



## Calculate profile load time.
$endTime = Get-Date
$elapsedTime = ($endTime - $startTime).Milliseconds

$message = "undefined"

If ($elapsedTime -lt 1000) { $message = ($elapsedTime.ToString() + "ms") }
Else { $message = (($elapsedTime * 1000).ToString() + "s") }
Write-Warning "Custom profile load time: $($message)"
