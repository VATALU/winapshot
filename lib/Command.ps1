function Get-WinapshotCommandFiles {
    Get-ChildItem("$psscriptroot/../libexec") | Where-Object { $_.name -match 'winapshot-.*?\.ps1$' }
}

function Get-WinapshotCommands {
    Get-WinapshotCommandFiles | ForEach-Object { Get-WinapshotCommandName $_ }
}

function Get-WinapshotCommandName($fileName) {
    $fileName.name | Select-String 'winapshot-(.*?)\.ps1$' | ForEach-Object { $_.matches[0].groups[1].value }
}

function Get-WinapshotCommandPath($cmd) {
    $cmdPath = "$psscriptroot/../libexec/winapshot-$cmd.ps1"
    $cmdPath
}

function Exec-Command($cmd, $arguments) {
    $cmdPath = Get-WinapshotCommandPath $cmd
    & $cmdPath @arguments
}