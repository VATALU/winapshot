param($cmd)

. "../lib/Command.ps1"

$commands = Get-WinapshotCommands

if ($commands -contains $cmd) {
    Exec-Command $cmd $args
}
elseif (@($null, '--help', '/?') -contains $cmd -or $args[0] -contains '-h') {
    Exec-Command 'help' $args
}
else {
    "winapshot: '$cmd' isn't a scoop command. See 'winapshot help'."
    exit 1
}