Function Test-Administrator {
    # checks to see if an administrator is logging and will identify the account as such in Terminal windows.

    $user = [Security.Principal.WindowsIdentity]::GetCurrent();

    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

}

## Helper Function to kill all Node processes.
Function Stop-AllNodeJS {
    taskkill /f /im node.exe
}

# Helper function to change directory to my development workspace
# Change c:\ws to your usual workspace and everytime you type
# in cws from PowerShell it will take you directly there.
Function cws { Set-Location "C:\Code" }

Function Show-Shellprofile {
<#
.SYNOPSIS
open shell profile in vscode insiders edition, Maybe i can set a default IDE when i get a chance.
#>
    # Opens current shellprofile in vscode insiders editor, I Should generalize this to open in default code editor.
    return code-insiders.cmd $PROFILE.CurrentUserCurrentHost
# return code-insiders.cmd $PROFILE
}

Function Get-LastCommandExecTime {
<#
.SYNOPSIS
Shows time of execution and completion of last command ran in powershell.
#>
    $command = Get-History -Count 1
    $command.EndExecutionTime - $command.StartExecutionTime
}

Function Show-NetworkProcess {
<#
.SYNOPSIS
searches network processes matching entered PID or roughly mathcing IP.
.EXAMPLE
PS C:\>CheckNetworkProcess 15234
PS C:\>CheckNetworkProcess 67809 | measure
#>
[CmdletBinding()]
    param(
        [parameter(Mandatory = $True, ValueFromPipeline = $True)] [int] $PIDorIP
    )
    NETSTAT.exe -a -n -o | Where-Object { $_ -like "*$PIDorIP*" }
}


Function Add-FolderToPath {
<#
.SYNOPSIS
Add a folder to current machines PATH variable for all users.
.DESCRIPTION
The Add-FolderToPath function allows user to add a particular folder to their machines path env variables for all users to use and access, it has a sister function Remove-FolderFromPath, which does
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
        $NewPath = $OldPath + ';' + $Folder
        [System.Environment]::SetEnvironmentVariable("path", $NewPath, 'Machine')
        # Show our results back to the world
        Return $NewPath
    }
}

Function Remove-FolderFromPath {
<#
.SYNOPSIS
Remove a folder to current machines PATH variable for all users.
.DESCRIPTION
The Remove-FolderFromPath function allows user to remove a particular folder from their machines path env variables for all users, it has a sister function Add-FolderToPath, which does
the inverse.
.EXAMPLE
PS C:\>Remove-FolderFromPath 'FolderToRemove'
#>
    [Cmdletbinding()]
    param
    (
        [parameter(Mandatory = $True, ValueFromPipeline = $True, Position = 0)] [String] $RemoveFolder
    )
    Write-Verbose "Removing folder ""$RemoveFolder"" from SYSTEM path"
    # * Get the current search path from the environment keys in the registry.
    # * [System.Environment]::GetEnvironmentVariable can also be utilized directly with $env.
    $path = [System.Environment]::GetEnvironmentVariable('PATH','Machine')

    # See if the Folder you want to remove is in the path.
    If ($path | Select-String -SimpleMatch $RemoveFolder) {
        Write-Verbose "Found ""$RemoveFolder"" in System Path"
        Write-Verbose "NOW removing"
        # Set the New Path
        $path = ($path.Split(';') | Where-Object { $_ -ne $RemoveFolder }) -join ';'
        [System.Environment]::SetEnvironmentVariable("path", $path, 'Machine')
        # Show our results back to the world
        Write-Verbose "Restart PowerShell for New PATH to take effect"
        Return $path
    }
    else {
        Write-Warning "Folder ""$RemoveFolder"" is NOT FOUND in the path"
    }
}
