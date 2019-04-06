function Gen-Modules {
    # get a list of installed modules
    $modules = Get-ChildItem((Split-Path $profile) + '/Modules')
    
    #add install module command
    $commandCache
    foreach ($module in $modules) {
        $command = 'Install-Module ' + $module
        $commandCache+=$command+"`r`n"
    }
    $commandCache
}