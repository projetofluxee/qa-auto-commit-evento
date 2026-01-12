$path = "C:\qa-auto-commit-evento\Scripts"
$filter = "*.script"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $path
$watcher.Filter = $filter
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent $watcher Created -Action {
    Start-Sleep -Seconds 2

    Set-Location "C:\qa-auto-commit-evento"

    git add Scripts
    git commit -m "Novo script adicionado automaticamente"
    git push origin main
}
