Restore - Wiederherstellung
===========================


Wiederherstellung auf Dateiebene
--------------------------------

Wurde das Backup in der Verzeichnis ``/srv/backup/server`` mit dem Befehl 


.. code:: 

   linuxmuster-migration-backup -d /srv/backup/server

ausgeführt, dann finden sich Dateien unterhalb des Verzeichnisses ``filesystem`` also
unter ``srv/backup/server/filesystem``.

Als Benutzer `root` können Sie die Daten sogar bis auf Dateiebene wiederherstellen.

Um einzelne Daten wiederherzustellen, geben Sie Quelle und Ziel für den Kopierbefehl an:

.. code:: 
    
    cp -a /srv/backup/server/filesystem/home/teachers/loescher/wichtigedaten.txt /home/teachers/loescher/

Der Befehl kopiert die Datei ``wichtigedaten.txt`` 
aus dem Sicherungsverzeichnis ``/srv/backup/server/filesystem/home/teachers/loescher`` 
in das Verzeichnis ``/home/teachers/loescher/`` auf dem neuen Wiederherstellungsziel.

Um alle Daten wiederherzustellen, geben Sie an:

.. code:: 
    
    cp -aR /srv/backup/server/filesystem/* /

Dieser Befehl kopiert alle Dateien und Verzeichnisse aus dem Sicherungsverzeichnis in das Root-Verzeichnis des Wiederherstellungsziels.

Gesamtrestore des Systems
-------------------------

Auf dem neuen System werden alle gesicherten Daten mithilfe des Shell-Skript ``linuxmuster-migration-restore`` 
wiederhergestellt

.. code:: bash

	server ~ # linuxmuster-migration-restore -h
	
	Usage: linuxmuster-migration-restore <options>
	
	Options:
	
	-c <config dir>     Path to directory with config files (optional).
        	            Per default we look in source dir for them.
	-d <source dir>     Path to source directory (mandatory,
        	            where the restore files live).
	-i <password>       Firewall root password (optional). If not given you
	                    will be asked for it.
 	-t <temp dir>       Path to directory where the restore files are
        	            temporarily stored in case the source dir is on a
                	    nfs share (optional, must exist).
	-h                  Show this help.

Das Quellverzeichnis mit den Migrationsdaten muss mit dem Parameter -d zwingend angegeben werden.
Mit der Option -i kann das Root-Passwort der Firewall übergeben werden. Gibt man es nicht auf der Kommandozeile an, wird danach gefragt. Liegt das Quellverzeichnis auf einem NFS-Share, kann mit der Option -t ein lokales Verzeichnis angegeben werden, in das die Migrationsdaten aus dem Quellverzeichnis kopiert werden. Das ist notwendig, da während des Restores das Netzwerk neu gestartet wird und damit die Verbindung zum Share verloren ginge. Gibt man kein lokales Verzeichnis an, sucht das Skript nach genügend freiem Platz im Wurzelverzeichnis, dann unter ``/var/tmp`` und ``/home``. Die Verarbeitung wird abgebrochen, falls nicht genügend Speicherplatz gefunden wird. Im anderen Fall wird ein temporäres Verzeichnis migration.tmp angelegt, das nach Abschluss der Verarbeitung wieder gelöscht wird.

Die Ausgaben des Skripts werden in die Datei ``/var/log/linuxmuster/migration-restore.log`` geloggt.
Die Remote-Ausführung des Restore-Skripts per SSH-Konsole ist nicht zu empfehlen, da wie schon erwähnt das Netzwerk neu gestartet wird. Ist der Zugriff nur per SSH möglich, muss das Skript in einer `Screen-Session` gestartet werden, damit es komplett durchlaufen kann.

Abschließend muss der Server neu gestartet werden.






