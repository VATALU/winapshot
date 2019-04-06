# get scoop info
$apps = (Get-ChildItem ($env:SCOOP + '/apps')).Name
$buckets = (Get-ChildItem ($env:SCOOP + '/buckets')).Name
if ($env:SCOOP_GLOBAL) {
    $golobalApps = ((Get-ChildItem ($env:SCOOP_GLOBAL + '/apps')).Name)
}

# add install scoop command
'$env:SCOOP=' + "'" + $env:SCOOP + "'" >> .\Set-All.ps1
"[environment]::setEnvironmentVariable('SCOOP'," + "'" + $env:SCOOP + "'" + ",'User')" >> .\Set-All.ps1
"iex (new-object net.webclient).downloadstring('https://get.scoop.sh')" >> .\Set-All.ps1

# config env:global
'$env:SCOOP_GLOBAL=' + "'" + $env:SCOOP_GLOBAL + "'" >> .\Set-All.ps1
"[environment]::setEnvironmentVariable('SCOOP_GLOBAL'," + "'" + $env:SCOOP_GLOBAL + "'" + ",'Machine')" >> .\Set-All.ps1

# add buckets
foreach ($bucket in $buckets) {
    $command = 'scoop bucket add ' + $bucket
    $command >> .\Set-All.ps1
}

#install apps
foreach ($app in $apps) {
    $command = 'scoop install ' + $app
    $command >> .\Set-All.ps1
}

#install global apps
foreach ($app in $golobalApps) {
    $command = 'scoop install -g ' + $app
    $command >> .\Set-All.ps1
}

# TODO solve manifest




