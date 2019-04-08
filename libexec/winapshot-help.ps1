# Usage: winapshot help <command>
# Summary: Show help for a command
param($cmd)

. "$psscriptroot\..\lib\Command.ps1"
. "$psscriptroot\..\lib\Help.ps1"

function print_help($cmd) {
    $file = Get-Content (Get-WinapshotCommandPath $cmd) -raw
    $usage = Get-Usage $file
    $help = Get-Help $file

    if ($usage) { Write-Host "$usage`n" }
    if ($help) { Write-Host $help }
}

function print_summaries {
    $commands = @{ }

    Get-WinapshotCommandFiles | ForEach-Object {
        $command = Get-WinapshotCommandName $_
        $summary = Get-Summary (Get-Content (Get-WinapshotCommandPath $command) -raw)
        if (!($summary)) { $summary = '' }
        $commands.add("$command ", $summary) # add padding
    }

    $commands.getenumerator() | Sort-Object name | Format-Table -hidetablehead -autosize -wrap
}

$commands = Get-WinapshotCommands

if (!($cmd)) {
    "Usage: winapshot <command> [<args>]

Some useful commands are:"
    print_summaries
    "Type 'winapshot help <command>' to get help for a specific command."
}
elseif ($commands -contains $cmd) {
    print_help $cmd
}
else {
    "winapshot help: no such command '$cmd'"; exit 1
}

exit 0
