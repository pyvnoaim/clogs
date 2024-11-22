# clogs (PowerShell Skript)

Dieses PowerShell-Skript ermöglicht es, alte Log-Dateien (mit der Endung `.log`) aus einem angegebenen Verzeichnis zu archivieren und zu löschen. Es überprüft das Änderungsdatum der Log-Dateien und archiviert diejenigen, die älter sind als ein bestimmtes Alter (in Monaten). Archivierte Dateien werden in eine ZIP-Datei gespeichert, die im angegebenen Zielverzeichnis abgelegt wird. Zusätzlich bietet das Skript die Möglichkeit, die Originaldateien nach dem Archivieren zu löschen.

## Funktionen

- **Tab-Autovervollständigung**: Beim Eingeben der Parameter `-Path` und `-DestinationPath` zeigt das Skript nur Ordner an, um die Eingabe zu erleichtern.
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
    .\clogs.ps1 -Path "C:\Logs" -DestinationPath "C:\Archiv" -Age 6 
    ```

    - `-Path` (Pfad): Das Verzeichnis, das die Log-Dateien enthält. **Tab-Autovervollständigung ist verfügbar** und zeigt nur Ordner an.
    - `-DestinationPath` (Zielpfad): Der Zielordner, in dem die archivierten Log-Dateien gespeichert werden (optional). **Auch hier wird Tab-Autovervollständigung unterstützt**.
    - `-Age` (Alter): Die Anzahl der Monate, die eine Log-Datei alt sein soll, um archiviert zu werden.

    **Hinweis:** Wenn der `-DestinationPath` nicht angegeben wird, wird ein Ordner namens `Archive` im angegebenen `-Path` erstellt.

## Skriptablauf

1. **Tab-Autovervollständigung**: Beim Eingeben von `-Path` und `-DestinationPath` zeigt das Skript nur Ordner zur Auswahl an.
2. **Administrator-Überprüfung**: Das Skript prüft, ob es mit Administratorrechten ausgeführt wird.
3. **Verzeichnisüberprüfung**: Das Skript überprüft, ob das Quellverzeichnis existiert und ob das Zielverzeichnis vorhanden ist (es wird ggf. erstellt).
4. **Log-Dateien auflisten**: Alle `.log`-Dateien im angegebenen Verzeichnis und seinen Unterordnern werden aufgelistet.
5. **Archivierung und Löschung**: Alte Log-Dateien (älter als das angegebene Alter in Monaten) werden archiviert und können nach der Archivierung gelöscht werden.
6. **Fehlerbehandlung**: Falls ein Fehler auftritt, gibt das Skript eine detaillierte Fehlermeldung aus.

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
```

## Wichtige Änderungen

- **Verbesserte Benutzerfreundlichkeit**:
  - Tab-Autovervollständigung für `-Path` und `-DestinationPath`, wodurch nur Ordner vorgeschlagen werden.
- **Standardverhalten für das Zielverzeichnis**:
  - Wenn `-DestinationPath` nicht angegeben wird, erstellt das Skript automatisch einen Ordner namens `Archive` im Quellverzeichnis.
- **Detailliertere Fehlerbehandlung**:
  - Alle Fehler werden klar ausgegeben, um die Ursachen schneller nachvollziehen zu können.
