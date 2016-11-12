Features der Backuplösung
=========================

Ab der Version 6.1 sind die sog. Migrationsskripte ``linuxmuster-migration-backup``und ``linuxmuster-backup-restore`` zu verwenden, um den Server sowie die Firewall zu sichern und wiederherzustellen.

Diese Lösung bietet:

- einfache Konfiguration der einzubindenden oder auszuschließenden Verzeichnisse
- automatische Sicherung der aktuellen Firewalleinstellungen
- kurzzeitiges Herunterfahren sensitiver Dienste (z.B. Datenbanken) zum Schutz der Datenintegrität
- ab der zweiten Sicherung werden nur noch die Änderungen gesichert (Rsync-Funktionalität)
- „Disaster-Recovery“ ist durch die rasche Neuinstallation gegeben
- äußerst einfaches Wiederherstellen einzelner Dateien durch den Administrator

Es fehlt:


- Sicherung der Virtualisierungsumgebung
- eine Versionverwaltung des Backups

.. hint::
    Es gibt nur ein Backup

Erweiterungen
-------------

Es wird als linuxmuster-addon eine weitere Disaster-Recovery Lösung ``Mondo-Rescue`` 
als Paket ``linuxmuster-addon`` zur Verfügung gestellt.

.. hint::
    Für Mondo-Rescue finden Sie in der Dokumentation ebenfalls ein Howto.
