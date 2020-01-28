## Found in the OSS world
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

        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [ValidateRange(1, 9223372036854775807)]
        [long[]]$Id,

        [Parameter(Position = 1)]
        [ValidateRange(0, [Int16]::MaxValue)]
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
            $all = $all.where( { $_.commandline -match $pattern })
        }

        if ($Unique) {
            Write-Verbose "Selecting unique items"
            $all = $all | Select-Object -Unique
        }

        #write results to pipeline and add a new property
        $all | Add-Member -MemberType ScriptProperty -Name "Runtime" -value { $this.EndExecutionTime - $this.StartExecutionTime } -PassThru -force

    } # process

    End {
        Write-Verbose "Ending $($MyInvocation.Mycommand)"
    } # end

} # end function Get-MyHistory

# define an optional alias
Set-Alias -Name gmh -Value Get-MyHistory


### Sort one file into another with benchmarks
Function UniqSortFileToFile {
    <#
.DESCRIPTION
A way to sort large files of text grabbing unique entities, and writing to a new file with benchmarks printed out.

.NOTES
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

.PARAMETER OriginFile
Path to the file you want to sort.

.PARAMETER DestinationFile
Path to the destination file to write the sort to.
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        $OriginFile,

        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        [String] $DestinationFile
    )
    $hs = new-object System.Collections.Generic.HashSet[string]
    $sw = [System.Diagnostics.Stopwatch]::StartNew();
    $reader = [System.IO.File]::OpenText($OriginFile)
    try {
        while (($line = $reader.ReadLine()) -ne $null) {
            $t = $hs.Add($line)
        }
    }
    finally {
        $reader.Close()
    }
    $sw.Stop();
    Write-Output ("read-uniq took {0}" -f $sw.Elapsed);

    $sw = [System.Diagnostics.Stopwatch]::StartNew();
    $ls = new-object system.collections.generic.List[string] $hs;
    $ls.Sort();
    $sw.Stop();
    Write-Output ("sorting took {0}" -f $sw.Elapsed);

    $sw = [System.Diagnostics.Stopwatch]::StartNew();
    try {
        $f = New-Object System.IO.StreamWriter $DestinationFile;
        foreach ($s in $ls) {
            $f.WriteLine($s);
        }
    }
    finally {
        $f.Close();
    }
    $sw.Stop();
    Write-Output ("saving took {0}" -f $sw.Elapsed);
}

### Attained from Code Fosters Profile

### Shakes the git tree to find unsycned files/folders.
Function gittree () {
	param($path = (Get-Item -Path ".\" -Verbose).FullName)

    Write-Host "Processing for git branch status of subfolders in folder: $path"

    $items = @()

    Get-ChildItem -Path $path | Where-Object {$_.PSIsContainer } | Foreach-Object -Process {
        if (Test-Path -Path (Join-Path -Path $_.FullName -ChildPath '.git')) {
            Push-Location $_.FullName
            Write-Host "Processing $($_)...."
            git fetch
            $synced = ((git status -uno) -join ' ') -match 'up-to-date'
            $branch = git rev-parse --abbrev-ref HEAD
            $local_branches = (git branch) -join ','
            $remote_branches = (git branch -r) -join ','
            Pop-Location

            if (!$synced) {
                $branch += " [NOT SYNCED]"
            }
            Write-Host "$($_): $branch"

            $obj = New-Object System.Object
            $obj | Add-Member -type NoteProperty -name dir -value $_
            $obj | Add-Member -type NoteProperty -name branch -value $branch
            $obj | Add-Member -type NoteProperty -name local_branches -value $local_branches
            $obj | Add-Member -type NoteProperty -name remote_branches -value $remote_branches
            $items += $obj
        }
    }

    $items | Send-ToPSGridView -Passthru -Title "Git branch status of subfolders in path $path"
}
Set-Alias -Name gt -Value gittree


### Attained from Chris Duck

### Checking SSL Protocols
Function Test-SslProtocols {
    <#
.DESCRIPTION
Outputs the SSL protocols that the client is able to successfully use to connect to a server.

.NOTES

Copyright 2014 Chris Duck
http://blog.whatsupduck.net

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

.PARAMETER ComputerName
The name of the remote computer to connect to.

.PARAMETER Port
The remote port to connect to. The default is 443.

.EXAMPLE
Test-SslProtocols -ComputerName "www.google.com"

ComputerName       : www.google.com
Port               : 443
KeyLength          : 2048
SignatureAlgorithm : rsa-sha1
Ssl2               : False
Ssl3               : True
Tls                : True
Tls11              : True
Tls12              : True
#>
    param(
        [Parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        $ComputerName,

        [Parameter(ValueFromPipelineByPropertyName = $true)]
        [int]$Port = 443
    )
    begin {
        $ProtocolNames = [System.Security.Authentication.SslProtocols] | Get-Member -static -MemberType Property | Where-Object { $_.Name -notin @("Default", "None") } | ForEach-Object { $_.Name }
    }
    process {
        $ProtocolStatus = [Ordered]@{ }
        $ProtocolStatus.Add("ComputerName", $ComputerName)
        $ProtocolStatus.Add("Port", $Port)
        $ProtocolStatus.Add("KeyLength", $null)
        $ProtocolStatus.Add("SignatureAlgorithm", $null)

        $ProtocolNames | ForEach-Object {
            $ProtocolName = $_
            $Socket = New-Object System.Net.Sockets.Socket([System.Net.Sockets.SocketType]::Stream, [System.Net.Sockets.ProtocolType]::Tcp)
            $Socket.Connect($ComputerName, $Port)
            try {
                $NetStream = New-Object System.Net.Sockets.NetworkStream($Socket, $true)
                $SslStream = New-Object System.Net.Security.SslStream($NetStream, $true)
                $SslStream.AuthenticateAsClient($ComputerName, $null, $ProtocolName, $false )
                $RemoteCertificate = [System.Security.Cryptography.X509Certificates.X509Certificate2]$SslStream.RemoteCertificate
                $ProtocolStatus["KeyLength"] = $RemoteCertificate.PublicKey.Key.KeySize
                $ProtocolStatus["SignatureAlgorithm"] = $RemoteCertificate.PublicKey.Key.SignatureAlgorithm.Split("#")[1]
                $ProtocolStatus.Add($ProtocolName, $true)
            }
            catch {
                $ProtocolStatus.Add($ProtocolName, $false)
            }
            finally {
                $SslStream.Close()
            }
        }
        [PSCustomObject]$ProtocolStatus
    }
}

# Helper function to show Unicode character
Function U
{
param
    (
        [int] $Code
    )

    if ((0 -le $Code) -and ($Code -le 0xFFFF)) {
        return [char] $Code
    }

    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF)) {
        return [char]::ConvertFromUtf32($Code)
    }

    throw "Invalid character code $Code"
}


Function Send-ToPSGridView {
<#
.SYNOPSIS
requires -version 6.1
Send objects to Out-Gridview in Windows PowerShell
.DESCRIPTION
This command is intended as a workaround for PowerShell Core running on a Windows platform, presumably Windows 10. PowerShell Core does not support all of the .NET Framework which means some commands like Out-Gridview are not supported. However, on a Windows desktop you are most likely running Windows PowerShell side by side with PowerShell Core. This command is designed to take objects from a PowerShell expression and send it to an instance of Windows PowerShell running Out-Gridview. You can specify a title and pass objects back to your PowerShell Core session. Note that passed objects will be deserialized versions of the original objects.
.PARAMETER Title
Specify a Title for the Out-Gridview window
.PARAMETER Passthru
Pass selected objects from Out-Gridview back to your PowerShell Core session.
.EXAMPLE
PS C:\> get-childitem c:\scripts\*.ps1 | Send-ToPSGridview -title "My Scripts"
Press Enter to continue...:

Display all ps1 files in Out-Gridview. You must press Enter to continue.
.EXAMPLE
PS C:\>  get-service | where status -eq 'running' | Send-ToPSGridView -Passthru | Restart-service -PassThru
Press Enter to continue...:

Status   Name               DisplayName
------   ----               -----------
Running  BluetoothUserSe... Bluetooth User Support Service_17b710
Running  Audiosrv           Windows Audio

Get all running services and pipe to Out-Gridview where you can select services which will be restarted.
.EXAMPLE
PS C:\> $val = 1..10 | Send-ToPSGridView -Title "Select some numbers" -Passthru
Press Enter to continue...:
PS C:\> $val
4
8
6
PS C:\> $val | Measure-Object -sum

Count             : 3
Average           :
Sum               : 18
Maximum           :
Minimum           :
StandardDeviation :
Property          :

Send the numbers 1 to 10 to Out-Gridview where you can select a few. The results are saved to a variable in the PowerShell Core session where you can use them.
.INPUTS
System.Object
.OUTPUTS
None, Deserialized.System.Object[]
.NOTES
Learn more about PowerShell: http://jdhitsolutions.com/blog/essential-powershell-resources/
#>

    [cmdletbinding()]
    [alias("ogv")]
    [OutputType("None", "Deserialized.System.Object[]")]

    Param(
        [Parameter(Position = 0, ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [object[]]$InputObject,
        [ValidateNotNullOrEmpty()]
        [string]$Title = "Out-GridView",
        [switch]$Passthru
    )
    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        #validate running on a Windows platform`
        if ($PSVersionTable.Platform -ne 'Win32NT') {
            Throw "This command requires a Windows platform with a graphical operating system like Windows 10."
        }
        #initialize an array to hold pipelined objects
        $data = @()

        #save foreground color
        $fg = $host.ui.RawUI.ForegroundColor

    } #begin

    Process {
        Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Adding object"
        $data += $InputObject
    } #process

    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Creating a temporary xml file with the data"
        $tempFile = Join-Path -path $env:temp -ChildPath ogvTemp.xml
        $data | Export-Clixml -Path $tempFile

        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Starting up a PowerShell.exe instance"
        PowerShell.exe -nologo -noprofile -command {
            param([string]$Path, [string]$Title = "Out-Gridview", [bool]$Passthru)
            Import-Clixml -Path $path | Out-Gridview -title $Title -passthru:$Passthru
            #a pause is required because if you don't use -Passthru the command will automatically complete and close
            $host.ui.RawUI.ForegroundColor = "yellow"
            Pause
        } -args $tempFile, $Title, ($passthru -as [bool])

        if (Test-Path -Path $tempFile) {
            Write-Verbose "[$((Get-Date).TimeofDay) END    ] Removing $tempFile"
            Remove-Item -Path $tempFile
        }

        #restore foreground color
        $host.ui.RawUI.ForegroundColor = $fg
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

} #close Send-ToPSGridView
