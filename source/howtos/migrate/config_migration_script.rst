Konfiguration des Migrationsskripts
===================================

In der Standardeinstellung wird das komplette Home-Verzeichnis ohne Ausnahme gesichert und wieder hergestellt.

Einstellungen bzgl. zusätzlich zu sichernden bzw. vom Backup auszuschließenden Dateien und Verzeichnissen trägt man in die Konfigurationsdateien **defaults.conf, include.conf und exclude.conf** unter 

.. code:: bash

    /etc/linuxmuster/migration 

ein. Diese Dateien werden beim Backup mitgesichert und beim Restore auf dem Zielsystem ausgewertet.
Eigene Dateien und Verzeichnisse einbeziehen

Soll zum Beispiel die Schulhomepage, die unter ``/var/www/homepage``  
abgelegt ist, ebenfalls gesichert und auf dem Zielsystem wieder hergestellt werden, so trägt man den Pfad einfach in ``etc/linuxmuster/migration/include.conf`` ein:

.. code:: bash

    #/var/www/index.html
    /var/www/homepage

Dabei ist zu beachten, dass pro Zeile nur ein Eintrag erlaubt ist. Außerdem müssen immer absolute Pfade angegeben werden. Wildcards sind erlaubt.

Dateien und Verzeichnisse ausschließen
--------------------------------------

Soll zum Beispiel das schulweite Tauschverzeichnis von der Migration ausgeschlossen werden, trägt man in die Konfigurationsdatei ``/etc/linuxmuster/migration/exclude.conf`` den entsprechenden Pfad ein:

.. code:: bash

    #*.mp3
    /home/share/school/*

Es können per Wildcard (*) bestimmte Dateimuster ausgeschlossen werden (z. Bsp. *.mp3).

Weitere Wiederherstellungsoptionen
----------------------------------

Über die Konfigurationsdatei **custom.conf** kann das Verhalten bei der Wiederherstellung gesteuert werden.

Soll über ein Netzwerk migriert werden, so ist ein Backup auf ein Netzwerkshare durchzuführen und hiervon das Restore auszuführen.

