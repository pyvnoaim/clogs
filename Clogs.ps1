param(
    [Parameter(Mandatory)]
    [ArgumentCompleter({
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
        Get-ChildItem -Path . -Directory -Recurse | Where-Object { $_.FullName -like "$wordToComplete*" } | ForEach-Object { $_.FullName }
    })]
    [string]$Path,

    [Parameter()]
    [ArgumentCompleter({
        param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
        Get-ChildItem -Path . -Directory -Recurse | Where-Object { $_.FullName -like "$wordToComplete*" } | ForEach-Object { $_.FullName }
    })]
    [string]$DestinationPath,

    [Parameter(Mandatory)]
    [int]$Age
)

# Falls kein Zielpfad angegeben wurde, Standardzielordner erstellen
if (-not $DestinationPath) {
    $DestinationPath = Join-Path -Path $Path -ChildPath "Archive"
}

Write-Host

# Prüfen, ob das Skript als Administrator ausgeführt wird
$user = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-Not ($user.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
    Write-Warning "This script needs to be executed as an administrator."
    Write-Host
    exit
}

# Prüfen, ob das Quellverzeichnis existiert
if (-Not (Test-Path $Path -PathType Container)) {
    Write-Warning "'$Path' doesn't exist."
    Write-Host
    exit
}

# Zielordner erstellen, falls er nicht existiert
if (-Not (Test-Path $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory | Out-Null
}

# Überprüfen, ob das Alter eine gültige Zahl ist
if ($Age -lt 0) {
    Write-Warning "The age must be a positive integer."
    exit
}

# Log-Dateien auflisten
$log_files = Get-ChildItem -Path $Path -Filter "*.log" -File -Recurse
$log_files_count = $log_files.Count
$total_size_mb = [math]::round(($log_files | Measure-Object -Property Length -Sum).Sum / 1MB, 2)
$months_ago = (Get-Date).AddMonths(-$Age)
$old_logs = $log_files | Where-Object { $_.LastWriteTime -lt $months_ago }
$old_logs_count = $old_logs.Count
$deleted_size_mb = [math]::round(($old_logs | Measure-Object -Property Length -Sum).Sum / 1MB, 2)

# Kulturell unabhängige Formatierung von Zahlen
$formatted_total_size_gb = "{0:N2}" -f ($total_size_mb / 1024) -replace ',', '.'
$formatted_total_size_mb = "{0:N2}" -f $total_size_mb -replace ',', '.'

# Ausgabe der Log-Informationen
Write-Host -ForegroundColor Cyan ("[i] Path: $Path")
Write-Host -ForegroundColor Cyan ("[i] Destination: $DestinationPath")

if ($total_size_mb -gt 1024) {
    Write-Host -ForegroundColor Green ("[+] $log_files_count log file(s) found - $formatted_total_size_gb GB")
} else {
    Write-Host -ForegroundColor Green ("[+] $log_files_count log file(s) found - $formatted_total_size_mb MB")
}

# Prüfen, ob veraltete Logdateien vorhanden sind
if ($old_logs_count -eq 0) {
    Write-Host -ForegroundColor Green "[+] 0 outdated log file(s) found"
    Write-Host
    exit
} else {
    Write-Host -ForegroundColor Red ("[!] $old_logs_count outdated log file(s) found - {0:N2} MB" -f $deleted_size_mb)
    Write-Host
}

# Benutzeraufforderung zur Archivierung der veralteten Logdateien
$confirm = Read-Host "Archive outdated log file(s)? (y/N)" 
if ($confirm -ne "y") {
    Write-Warning "Archiving canceled by the user."
    Write-Host
    exit
}

# ZIP-Datei mit Datum im Namen erstellen
$zip_name = "Archived_Logs_{0:yyyy-MM-dd}.zip" -f (Get-Date)
$zip_path = Join-Path -Path $DestinationPath -ChildPath $zip_name

try {
    # Logs archivieren
    $old_logs_paths = $old_logs | ForEach-Object { $_.FullName }
    Compress-Archive -Path $old_logs_paths -DestinationPath $zip_path -Force

    # Prüfen, ob die ZIP-Datei erfolgreich erstellt wurde
    if (Test-Path $zip_path) {
        Write-Host -ForegroundColor Green ("[+] $old_logs_count log file(s) archived into '$zip_name' - {0:N2} MB" -f $deleted_size_mb)
        Write-Host
        
        # Option zur Löschung der Dateien
        $delete_confirm = Read-Host "Delete the archived files from the source directory? (y/N)"
        if ($delete_confirm -eq "y") {
            foreach ($old_log in $old_logs) {
                Remove-Item $old_log.FullName -Force
            }
            Write-Host -ForegroundColor Green ("[+] $old_logs_count log file(s) deleted after archiving.")
        } else {
            Write-Warning "Archived files were not deleted."
        }
    } else {
        Write-Warning "Archiving failed. Log files were not deleted."
    }
} catch {
    Write-Warning "An error occurred during archiving: $_"
    Write-Warning "Log files were not deleted."
}

Write-Host
