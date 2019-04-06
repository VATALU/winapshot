param($cmd)

. "../lib/Get-Command.ps1"
. "../lib/Exec-Command.ps1"

$commands = Get-WinapshotCommands

if($commands -contains $cmd) {
    Exec-Command $cmd $args
} else {
    "winapshot: '$cmd' isn't a scoop command. See 'winapshot help'."
    exit 1
}