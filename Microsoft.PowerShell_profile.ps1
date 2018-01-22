
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function shellprofile {
    return code $profile.CurrentUserCurrentHost
}


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

Import-Module -Name posh-git
# 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'
$global:GitPromptSettings.BeforeText = '['
$global:GitPromptSettings.AfterText  = '] '