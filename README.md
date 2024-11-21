# clogs (PowerShell Skript)

Dieses PowerShell-Skript ermöglicht es, alte Log-Dateien (mit der Endung `.log`) aus einem angegebenen Verzeichnis zu archivieren und zu löschen. Es überprüft das Änderungsdatum der Log-Dateien und archiviert diejenigen, die älter sind als ein bestimmtes Alter (in Monaten). Archivierte Dateien werden in eine ZIP-Datei gespeichert, die im angegebenen Zielverzeichnis abgelegt wird. Zusätzlich bietet das Skript die Möglichkeit, die Originaldateien nach dem Archivieren zu löschen.

## Funktionen

- **Archivierung von Log-Dateien**: Archiviert alte `.log`-Dateien in eine ZIP-Datei.
- **Löschung von Log-Dateien**: Löscht die archivierten Log-Dateien aus dem Quellverzeichnis (optional).
- **Flexible Zielverzeichnisse**: Bestimmen Sie das Zielverzeichnis für archivierte Dateien oder verwenden Sie den Standardordner `Archive`.

## Voraussetzungen

- **PowerShell 5.1 oder höher**
- Administratorrechte sind erforderlich, um das Skript auszuführen.

## Verwendung

1. **Klonen Sie das Repository**:
    ```bash
    git clone https://github.com/pyvnoaim/clogs.git
    ```

2. **Skript ausführen**:
    Öffnen Sie PowerShell und navigieren Sie zum Verzeichnis, in dem das Skript gespeichert ist.

    Beispiel:
    ```bash
    cd C:\Pfad\Zu\clogs
    ```

3. **Befehl zum Ausführen des Skripts**:
    ```powershell
    .\clogs.ps1 -Path "C:\Logs" -Age 6 -DestinationPath "C:\Archiv"
    ```

    - `-Path` (Pfad): Das Verzeichnis, das die Log-Dateien enthält.
    - `-Age` (Alter): Die maximale Anzahl der Monate, die eine Log-Datei alt sein darf, um archiviert zu werden.
    - `-DestinationPath` (Zielpfad): Der Zielordner, in dem die archivierten Log-Dateien gespeichert werden (optional).

    **Hinweis:** Wenn der `-DestinationPath` nicht angegeben wird, wird ein Ordner namens `Archive` im angegebenen `-Path` erstellt.

## Skriptablauf

1. **Administrator-Überprüfung**: Das Skript prüft, ob es mit Administratorrechten ausgeführt wird.
2. **Verzeichnisüberprüfung**: Das Skript überprüft, ob das Quellverzeichnis existiert und ob das Zielverzeichnis vorhanden ist (es wird ggf. erstellt).
3. **Log-Dateien auflisten**: Alle `.log`-Dateien im angegebenen Verzeichnis und seinen Unterordnern werden aufgelistet.
4. **Archivierung und Löschung**: Alte Log-Dateien (älter als das angegebene Alter in Monaten) werden archiviert und können nach der Archivierung gelöscht werden.
5. **Fehlerbehandlung**: Falls ein Fehler auftritt, gibt das Skript eine detaillierte Fehlermeldung aus.

## Beispielausgabe

```powershell
[i] Path: C:\Logs
[i] Destination: C:\Archiv
[+] 50 log file(s) found - 3.22 GB
[!] 12 outdated log file(s) found - 250.33 MB

Archive outdated log file(s)? (y/N): y

[+] 12 log file(s) archived into 'Archived_Logs_2024-11-21.zip' - 250.33 MB
Delete the archived files from the source directory? (y/N): y
[+] 12 log file(s) deleted after archiving.
