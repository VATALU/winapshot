. "..\lib\Get-Command.ps1"
function Exec-Command($cmd, $arguments) {
    $cmdPath = Get-WinapshotCommandPath $cmd
    & $cmdPath @arguments
}