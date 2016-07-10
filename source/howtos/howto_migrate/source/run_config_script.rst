Migrationsskript ausführen
==========================

Die Sicherung der Migrationsdaten wird über das Shell-Skript **linuxmuster-migration-backup** realisiert.

Die Optionen des Skripts könenn mit folgendem Befehl kontrolliert werdne: 

.. code:: bash

    server ~>  linuxmuster-migration-backup -h
    
    Usage: linuxmuster-migration-backup <options>
    
    Options:
    
    -c <config dir>  Path to config directory (optional).
                     Default is /etc/linuxmuster/migration.
    -d <target dir>  Path to target directory (must exist, mandatory).
    -h               Show this help.

.. attention::

    Das Zielverzeichnis für die Sicherung muss mit dem Parameter -d zwingend angegeben werden. 
    Das Verzeichnis muss existieren und kann auf einem NFS-Share liegen, das jedoch gemountet 
    sein muss. 

.. attention::

    Für die Sicherung auf eine lokal angeschlossene Platte ist ein Linux-Dateisystem des Typs 
    ext2, ext3, reiserfs oder xfs Voraussetzung.
    

Die Sicherung kann problemlos auch remote in einer SSH-Konsole gestartet werden.
Die Ausgaben des Skripts werden in die Datei ``/var/log/linuxmuster/migration-backup.log`` geschrieben. Nach Abschluss des Backups wird die Logdatei in das Backupverzeichnis kopiert.

Beispiel:

.. code:: bash

     linuxmuster-migration-backup -d /media/backup/migration

Dieser Befehl würde nun mithilfe des Mikrationsskripts eine Sicherung in das Verzeichnis ``/media/backup/migration`` durchführen. Die lokale Festplatte oder das NFS-Share (mit Schreibrechten) müssen hierin gemountet worden sein, damit der Befehl erfolgreich durchläuft.


