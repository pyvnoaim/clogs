# Changelog

## [1.0.0] - 2024-11-21
- Erste stabile Veröffentlichung.
- Hinzugefügte Benutzerbestätigungen und Statusmeldungen.

## [1.0.1] - 2024-11-21
- Die Datei `changelog.md` wurde hinzugefügt.

## [1.1.0] - 2024-11-22
- **Tab-Autovervollständigung**:
  - `ArgumentCompleter` für die Parameter `-Path` und `-DestinationPath` implementiert.
  - Bei der Autovervollständigung werden nur Ordner angezeigt, um die Eingabe zu erleichtern.
- **Standardverhalten für den Zielpfad**:
  - Ein Ordner namens `Archive` wird automatisch im Quellverzeichnis erstellt, falls kein `-DestinationPath` angegeben wird.
- **Verbesserte Benutzererfahrung**:
  - Verbesserte Fehlerbehandlung mit detaillierten Warnungen und Meldungen für verschiedene Szenarien (z. B. fehlende Pfade, ungültige Eingaben).
  - Überarbeitete Ausgabe der Log-Dateistatistiken mit einheitlicher Formatierung (MB und GB).
- **Code-Refactoring**:
  - Code übersichtlicher und besser lesbar gestaltet.
