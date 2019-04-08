# Usage: winapshot gen [options]
# Summary: Generate scripts
# Options:
#   -a, -all    Generate all scripts
#   -s, -scoop  Generate scoop script
#   -m, -module Generate module script
param (
    [switch]
    [alias("a")]
    $all,
    [switch]
    [alias("s")]
    $scoop,
    [switch]
    [alias("m")]
    $module
)
process {
    . "$psscriptroot\..\lib\Modules.ps1"
    . "$psscriptroot\..\lib\Scoop.ps1"
    . "$psscriptroot\..\lib\Profile.ps1"

    $SetAllFolderPath = "winapshot"
    $SetAllFilePath = ".\$SetAllFolderPath\Set-All.ps1"
    $SetAllConfigFolderPath = "$SetAllFolderPath\config"

    if (!(Test-Path $SetAllFolderPath)) {
        mkdir $SetAllFolderPath
    }

    if (!(Test-Path $SetAllFilePath)) {
        New-Item $SetAllFilePath
    }
    else {
        Clear-Content $SetAllFilePath
    }

    if ($all -or !($scoop -or $module)) {
        Gen-Modules >> $SetAllFilePath
        Gen-Scoop >> $SetAllFilePath
    }
    else {
        if ($scoop) {
            Gen-Scoop >> $SetAllFilePath
        }
        if ($module) {
            Gen-Modules >> $SetAllFilePath
        }
    }
    if (!(Test-Path $SetAllConfigFolderPath)) {
        mkdir $SetAllConfigFolderPath
    }
    if (Test-Path $PROFILE) {
        $ProfileCopyPath =$SetAllConfigFolderPath+".\$PROFILE.Substring($PROFILE.LastIndexOf('\')+1)"
        if(Test-Path $ProfileCopyPath) {
            Remove-Item $ProfileCopyPath
        }
        Copy-Item $PROFILE $SetAllConfigFolderPath
        Copy-OldProfile >> $SetAllFilePath
        Gen-Profile >> $SetAllFilePath
    }
}
