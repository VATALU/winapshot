# Useage: winapshot gen [options]
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
    . "..\lib\Gen-Modules.ps1"
    . "..\lib\Gen-Scoop.ps1"
    . "..\lib\Gen-Profile.ps1"

    if (!(Test-Path Set-All.ps1)) {
        New-Item Set-All.ps1
    }
    else {
        Clear-Content Set-All.ps1
    }
    if ($all -or !($scoop -or $module)) {
        Gen-Modules >> Set-All.ps1
        Gen-Scoop >> Set-All.ps1
    }
    else {
        if ($scoop) {
            Gen-Scoop >> Set-All.ps1
        }
        if ($module) {
            Gen-Modules >> Set-All.ps1
        }
    }

    if(Test-Path $PROFILE) {
        mkdir config
        cp $PROFILE .\config\
        Copy-OldProfile >> Set-All.ps1
        Gen-Profile >> Set-All.ps1
    }
}
