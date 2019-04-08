function Gen-Profile {
    $commandCache = 'if(!(Test-Path $PROFILE)) {' + "`r`n" + '  New-Item $PROFILE' + "`r`n}`r`n" 
    $profileName = $PROFILE.Substring($PROFILE.LastIndexOf('\')+1)
    $commandCache += "cp .\config\$profileName "+ '$PROFILE'
    $commandCache
}

function Copy-OldProfile {
    $commandCache = 'Copy-Item $PROFILE $PROFILE' + '.SubString(0,$PROFILE.IndexOf(' + "'.ps1'))" + ".old.ps1"
    $commandCache
}