function Gen-Scoop {
    # get scoop info
    $apps = (Get-ChildItem ($env:SCOOP + '/apps')).Name
    $buckets = (Get-ChildItem ($env:SCOOP + '/buckets')).Name
    if ($env:SCOOP_GLOBAL) {
        $golobalApps = ((Get-ChildItem ($env:SCOOP_GLOBAL + '/apps')).Name)
    }

    $commandCache

    # add install scoop command
    $commandCache += '$env:SCOOP=' + "'$env:SCOOP'`r`n"
    $commandCache += "[environment]::setEnvironmentVariable('SCOOP','$env:SCOOP','User')`r`n"
    $commandCache += "iex (new-object net.webclient).downloadstring('https://get.scoop.sh')`r`n"

    # config env:global
    $commandCache += '$env:SCOOP_GLOBAL=' + "'$env:SCOOP_GLOBAL'`r`n"
    $commandCache += "[environment]::setEnvironmentVariable('SCOOP_GLOBAL','$env:SCOOP_GLOBAL','Machine')`r`n"

    # add buckets
    foreach ($bucket in $buckets) {
        $command = 'scoop bucket add ' + $bucket
        $commandCache += $command + "`r`n"
    }

    #install apps
    foreach ($app in $apps) {
        $command = 'scoop install ' + $app
        $commandCache += $command + "`r`n"
    }

    #install global apps
    foreach ($app in $golobalApps) {
        $command = 'scoop install -g ' + $app
        $commandCache += $command + "`r`n"
    }

    # TODO solve manifest

    $commandCache
}