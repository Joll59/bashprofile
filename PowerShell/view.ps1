### My OWN version of Prompt. If you want to use this, comment out Set-Theme.

Function prompt {

    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path

    if ($curPath.ToLower().StartsWith($Home.ToLower()))

    {

        $curPath = "~" + $curPath.SubString($Home.Length)

    }



    $maxPathLength = 20

    if ($curPath.Length -gt $maxPathLength) {

        $curPath = '...' + $curPath.SubString($curPath.Length - $maxPathLength + 3)

    }


    $realLASTEXITCODE = $LASTEXITCODE

    # Write-Host

    # Reset color, which can be messed up by Enable-GitColors

    # $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    # if (Test-Administrator) {  # Use different username if elevated

    #     Write-Host "(Admin) " -NoNewline -ForegroundColor Red

    # }


    # Write-Host "$ENV:USERNAME" -NoNewline -ForegroundColor DarkYellow

    # Write-Host "$ENV:COMPUTERNAME" -NoNewline -ForegroundColor Magenta


    if ($null -ne $s) {  # color for PSSessions

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

# $global:GitPromptSettings.BeforeText = '['

# $global:GitPromptSettings.AfterText  = '] '