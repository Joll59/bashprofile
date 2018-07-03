
# checks to see if an administrator is logging and will identify the account as such in Terminal windows.
# function Test-Administrator {

#     $user = [Security.Principal.WindowsIdentity]::GetCurrent();

#     (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

# }


# Opens current shellprofile in vscode insiders editor, I Should generalize this to open in default code editor.
Function shellprofile {
    return code-insiders.cmd $profile.CurrentUserCurrentHost
# return code-insiders.cmd $PROFILE
}


Function Add-FolderToPath() {
<#
.SYNOPSIS
Add a folder to current machines PATH variable for all users.
.DESCRIPTION
The Add-FolderToPath function allows user to add a particular folder to their machines path envariable for all users to use and access, it has a sister function Remove-FolderFromPath, which does
the inverse.
.EXAMPLE
PS C:\>Add-FolderToPath 'FolderToAdd'
#>
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $True, ValueFromPipeline = $True)] [ValidateScript( {Test-Path -Path $_ -PathType Container})] [String] $Folder
    )
    Write-Verbose "Adding folder ""$Folder"" to SYSTEM path"
    # Get the current search path from the environment keys in the registry.
    $OldPath = [System.Environment]::GetEnvironmentVariable("path",'Machine')
    # See if the new Folder is already in the path.
    If ($OldPath | Select-String -SimpleMatch $Folder) {
        Write-Warning "Folder ""$Folder"" is already in the path"
    }
    else {
        # Set the New Path
        $NewPath = $OldPath + ’;’ + $Folder
        [System.Environment]::SetEnvironmentVariable("path", $NewPath, ’Machine’)
        # Show our results back to the world
        Return $NewPath
    }
}

Function Remove-FolderFromPath() {
<#
.SYNOPSIS
Remove a folder to current machines PATH variable for all users.
.DESCRIPTION
The Remove-FolderFromPath function allows user to remove a particular folder from their machines path envariable for all users, it has a sister function Add-FolderToPath, which does
the inverse.
.EXAMPLE
PS C:\>Remove-FolderFromPath 'FolderToAdd'
#>
    [Cmdletbinding()]
    param
    (
        [parameter(Mandatory = $True, ValueFromPipeline = $True, Position = 0)] [String] $RemoveFolder
    )
    Write-Verbose "Removing folder ""$RemoveFolder"" from SYSTEM path"
    # Get the current search path from the environment keys in the registry.
    $path = [System.Environment]::GetEnvironmentVariable('PATH','Machine')

    # See if the Folder you want to remove is in the path.
    If ($path | Select-String -SimpleMatch $RemoveFolder) {
        Write-Verbose "Found ""$RemoveFolder"" in System Path"
        Write-Verbose "NOW removing"
        # Set the New Path
        $path = ($path.Split(';') | Where-Object { $_ -ne $RemoveFolder }) -join ';'
        [System.Environment]::SetEnvironmentVariable("path", $path, ’Machine’)
        # Show our results back to the world
        Write-Verbose "Restart PowerShell for New PATH to take effect"
        Return $path
    }
    else {
        Write-Warning "Folder ""$RemoveFolder"" is NOT FOUND in the path"
    }
}


### My OWN version of Profile. If you want to use this, comment out  Set-Theme Line(Last line of File).

function prompt {

    # $origLastExitCode = $LASTEXITCODE

    # Write-VcsStatus

    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path

    if ($curPath.ToLower().StartsWith($Home.ToLower()))

    {

        $curPath = "~" + $curPath.SubString($Home.Length)

    }



    $maxPathLength = 20

    if ($curPath.Length -gt $maxPathLength) {

        $curPath = '...' + $curPath.SubString($curPath.Length - $maxPathLength + 3)

    }

    # Write-Host $curPath -NoNewline -ForegroundColor Green

    # $LASTEXITCODE = $origLastExitCode

    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host

    # Reset color, which can be messed up by Enable-GitColors

    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    # if (Test-Administrator) {  # Use different username if elevated

    #     Write-Host "(Admin) " -NoNewline -ForegroundColor Red

    # }


    # Write-Host "$ENV:USERNAME" -NoNewline -ForegroundColor DarkYellow

    # Write-Host "$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Magenta


    if ($s -ne $null) {  # color for PSSessions

        Write-Host "(`$s: " -NoNewline -ForegroundColor DarkMagenta

        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow

        Write-Host ") " -NoNewline -ForegroundColor DarkMagenta

    }

    # [regex]::Unescape("\u1F419")

    Write-Host "$([char]0x2654) " -NoNewline -ForegroundColor Red

    Write-Host $curPath -NoNewline -ForegroundColor DarkYellow

    # Write-Host $($(Get-Location) -replace ($env:USERPROFILE).Replace('\','\\'), "~") -NoNewline -ForegroundColor Blue

    Write-Host ": " -NoNewline -ForegroundColor DarkMagenta

    # Write-Host (Get-Date -Format G) -NoNewline -ForegroundColor DarkMagenta

    # Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $global:LASTEXITCODE = $realLASTEXITCODE

    Write-VcsStatus

    Write-Host "$([char]0x21F6)" -NoNewline -ForegroundColor Green


    return " "

}

# Import-Module -Name posh-git

# Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-4184928\src\posh-git.psd1'

# $global:GitPromptSettings.BeforeText = '['

# $global:GitPromptSettings.AfterText  = '] '


## found online.
Function Get-MyHistory {
<#
.SYNOPSIS
Gets a list of the commands entered during the current session.

.DESCRIPTION
The Get-MyHistory cmdlet gets session history, that is, the list of commands entered during the current session. This is a modified version of Get-History. In addition to the parameters of the original command, this version allows you to select only unique history entries as well as filter by a regular expression pattern.
Windows PowerShell automatically maintains a history of each session. The number of entries in the session history is determined by the value of the $MaximumHistoryCount preference variable. Beginning in Windows PowerShell 3.0, the default value is 4096.
You can save the session history in XML or CSV format. By default, history files are saved in the home directory, but you can save the file in any location.

For more information about the history features in Windows PowerShell, see about_History (http://go.microsoft.com/fwlink/?LinkID=113233).

.PARAMETER Count
Displays the specified number of the most recent history entries. By, default, Get-MyHistory gets all entries in the session history. If you use both the Count and Id parameters in a command, the display ends with the command that is specified by the Id parameter.

In Windows PowerShell 2.0, by default, Get-MyHistory gets the 32 most recent entries.

.PARAMETER Id
Specifies the ID number of an entry in the session history. Get-MyHistory gets only the specified entry. If you use both the Id and Count parameters in a command, Get-MyHistory gets the most recent entries ending with the entry specified by the Id parameter.

.PARAMETER Pattern
A regular expression pattern to match something in the commandline.

.PARAMETER Unique
Only display command history items with a unique command.
.EXAMPLE
PS C:\>Get-MyHistory -unique
This command gets the unique entries in the session history. The default display shows each command and its ID, which indicates the order of execution as well as the command's start and stop time.

.EXAMPLE
PS C:\>Get-MyHistory -pattern "service"
This command gets entries in the command history that include "service".

.NOTES
The session history is a list of the commands entered during the session. The session history represents the order of execution, the status, and the start and end times of the command. As you enter each command, Windows PowerShell adds it to the history so that you can reuse it. For more information about the command history, see about_History (http://go.microsoft.com/fwlink/?LinkID=113233).

Beginning in Windows PowerShell 3.0, the default value of the $MaximumHistoryCount preference variable is 4096. In Windows PowerShell 2.0, the default value is 64. For more information about the $MaximumHistoryCount variable, see about_Preference_Variables (http://go.microsoft.com/fwlink/?LinkID=113248).

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************

.INPUTS
Int64

.OUTPUTS
Microsoft.PowerShell.Commands.HistoryInfo
.LINK
Add-History
Clear-History
Invoke-History
.LINK
about_History
#>
[CmdletBinding()]
Param(

    [Parameter(Position=0, ValueFromPipeline=$true)]
    [ValidateRange(1, 9223372036854775807)]
    [long[]]$Id,

    [Parameter(Position=1)]
    [ValidateRange(0, 32767)]
    [int]$Count,

    #parameters that I added
    [switch]$Unique,
    [regex]$Pattern
)

Begin {
    #insert verbose messages to provide debugging and tracing information
    Write-Verbose "Starting $($MyInvocation.Mycommand)"
    Write-Verbose "Using parameter set $($PSCmdlet.ParameterSetName)"
    Write-Verbose ($PSBoundParameters | out-string)

    #remove Unique and Pattern parameters if used since they are not part of Get-History
    if ($Unique) {
        $PSBoundParameters.Remove("Unique") | Out-Null
    }
    if ($Pattern) {
        $PSBoundParameters.Remove("Pattern") | Out-Null
    }
} #begin

Process {

    #splat bound parameters to Get-History
    $all = Get-History @PSBoundParameters

    if ($Pattern) {
        #use v4 Where method for performance purposes
        Write-Verbose "Searching for commandlines matching $pattern"
        $all = $all.where({$_.commandline -match $pattern})
    }

    if ($Unique) {
        Write-Verbose "Selecting unique items"
        $all = $all | Select-Object -Unique
    }

    #write results to pipeline and add a new property
    $all | Add-Member -MemberType ScriptProperty -Name "Runtime" -value {$this.EndExecutionTime - $this.StartExecutionTime} -PassThru -force

} # process

End {
    Write-Verbose "Ending $($MyInvocation.Mycommand)"
} # end

} # end function Get-MyHistory

# define an optional alias
Set-Alias -Name gmh -Value Get-MyHistory

### New Additions
## https://gist.github.com/jchandra74/5b0c94385175c7a8d1cb39bc5157365e
# Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Helper function to change directory to my development workspace
# Change c:\ws to your usual workspace and everytime you type
# in cws from PowerShell it will take you directly there.
Function cws { Set-Location C:\Users\ablajide\Code\ }

# Helper function to show Unicode character
Function U
{
    param
    (
        [int] $Code
    )

    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }

    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }

    throw "Invalid character code $Code"
}

# Ensure posh-git is loaded, to Install posh-git Instal-Module -Name posh-git
Import-Module -Name posh-git

# Might Need this if you are using github as your remote git repository
# Start SshAgent if not already
# if (! (ps | ? { $_.Name -eq 'ssh-agent'})) {
#     Start-SshAgent
# }

# Ensure oh-my-posh is loaded, to install oh-my-posh, Install-Module -Name oh-my-posh
# Import-Module -Name oh-my-posh

# Default the prompt to agnoster oh-my-posh theme
## https://github.com/JanDeDobbeleer/oh-my-posh#themes
# Set-Theme darkblood


### New Addition ends.