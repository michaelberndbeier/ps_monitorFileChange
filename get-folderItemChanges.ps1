param(
    $pathToMonitor
)

$fileSystemWatcher = New-Object System.IO.FileSystemWatcher
$fileSystemWatcher.IncludeSubdirectories = $true
$fileSystemWatcher.Path = $pathToMonitor
$fileSystemWatcher.EnableRaisingEvents = $true

$fileWatcherAction =
{
    $changeDate = $(get-date)
    $fullPath = $event.SourceEventArgs.FullPath
    $changeType = $event.SourceEventArgs.ChangeType
    $fileHash = get-filehash $fullPath | select-object -ExpandProperty Hash
    echo "$fullPath;$changeType;$changeDate;$fileHash"
}

Register-ObjectEvent $fileSystemWatcher 'Created' -Action $fileWatcherAction
