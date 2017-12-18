Konfiguration und Anwendung
===========================

Da die Skripte der Migration eines Systems zur Anwendung kommen, ist die Konfiguration und Anwendung identisch mit einer Migration. Ausnahme ist, dass im Falle einer Wiederherstellung üblicherweise derselbe Rechner mit derselben linuxmuster.net Version das Migrationsziel darstellt. 

Zur Umsetzung der Backuplösung folgen Sie bitte dem `Howto_Migration` Schritt für Schritt

Automatisierung
---------------
Ein regelmäßiges Backup per kann per `cronjob` eingerichtet werden. 
Erstellen und editieren Sie die Datei ``/etc/cron.d/backupservice``

.. code:: bash
    
    #cron.d/backupservice
    #
    # Jeden Tag um 1 Uhr nachts ein migrations-backup
    0 1 * * *   root       linuxmuster-migration-backup -d /srv/backup/server 

Pseudo-Vollbackups
``````````````````
Mit Hilfe des Werkzeuges `rsnapshot` kann eine Versionierung des Backupziels erfolgen.
Dazu installieren Sie zunächst rsnapshot:

.. code:: bash

     apt-get install rsnapshot

Haben Sie mit den Migrationstools bereits ein Backup auf das Ziel ``/srv/backup/server`` gesichert, dann können Sie dieses nun mit einer Versionverwaltung ergänzen.

Ziel des Migrationsbackups: ``/srv/backup/server``
Versionen dieser Backups (Pseudo-Vollbackups): ``/srv/backup/rsnapshot``

Um hierfür eine Versionierung einzurichten find folgende Einträge in ``/etc/rsnapshot.conf`` vorzunehmen:

.. code:: bash

    snapshot_root»  /srv/backup/rsnapshot/$
    retain» »       daily»  15$
    retain» »       monthly»        12$
    ###############################$
    ###·BACKUP·POINTS·/·SCRIPTS·###$
    ###############################$
    backup» /srv/backup/server/»     server/$


Dabei gilt:

Die Zeichen » stehen für TABs und $ für das Ende der Zeile. Dies ist so besonders hervorgehoben, weil das Programm rsnapshot bei zusätzlichen Leerzeichen, z.B. am Ende der Zeile nicht richtig funktioniert. 
Ebenso müssen alle Verzeichnisse mit einem / enden. Der Eiontrag `retain daily 15` sorgt dafür, dass 15 Backups vom Typ „daily“ behalten werden, dagegen 12 vom Typ „monthly“ behalten. 

Wann diese Backups erfolgen, ist selbst festzulegen, indem rsnapshot von cron aus mit dem richtigen Argument gestartet wird.

Eine beispielhafte Konfiguration für cron in ``/etc/cron.d/backupservice`` wäre:

.. code:: bash

    # Jeden Tag um 3.42 Uhr ein Pseudo-Vollbackup erstellen
    42 3 * * *   root        /usr/bin/rsnapshot daily > /tmp/backupdaily.$$.log 2>&1
     
    # Alle zwei wochen am 1. und 15. des Monats  um 5.42 Uhr noch ein Backup
    42 5 1 * *      root    /usr/bin/rsnapshot monthly > /tmp/backupmonthly.$$.log 2>&1
    42 5 15 * *     root    /usr/bin/rsnapshot monthly > /tmp/backupmonthly.$$.log 2>&1

Diese Einstellung hat zur Folge, dass die täglichen Backups der letzten 15 Tage und die zweiwöchentlichen Backups der letzten 6 Monate behalten werden.

Das Verzeichnis der Pseudo-Vollbackups sollte dann nach einiger Zeit folgende Struktur haben:

.. code:: bash

     	ls -lt /srv/backup/rsnapshot/
     	insgesamt 64
	drwxr-xr-x 6 root root 4096 Okt  5 04:41 daily.0
	drwxr-xr-x 6 root root 4096 Okt  4 04:41 daily.1
	drwxr-xr-x 6 root root 4096 Okt  3 04:42 daily.2
	drwxr-xr-x 6 root root 4096 Okt  2 04:34 daily.3
	drwxr-xr-x 6 root root 4096 Okt  1 04:42 daily.4
	drwxr-xr-x 6 root root 4096 Okt  1 06:33 monthly.0
	drwxr-xr-x 6 root root 4096 Sep 30 04:39 daily.5
	drwxr-xr-x 6 root root 4096 Sep 29 04:41 daily.6
	drwxr-xr-x 6 root root 4096 Sep 28 04:55 daily.7
	#...
	drwxr-xr-x 6 root root 4096 Sep 22 04:44 daily.13
	drwxr-xr-x 6 root root 4096 Sep 21 04:38 daily.14





