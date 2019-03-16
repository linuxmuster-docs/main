===============================
 Migration auf linuxmuster 7.0
===============================

Es wird eine Migration der Benutzerinformationen (Namen, Passwort,
Projekte), Computerinformationen (``workstations``), der Benutzerdaten
(``/home``), Tausch- und Projektverzeichnisse und der Geräte-Abbilder
(``/var/linbo``) unterstützt.

Nicht migriert werden Beschreibungen von Projekten, Quota-Tabellen und
Rollen, die Geräte bekommen. Diese müssen von Hand angepasst werden.

Voraussetzungen
===============

Es muss als Quellsystem linuxmuster.net in der Version 6.2 installiert
sein. Es ist sehr wahrscheinlich, dass auch ab Version 6.1 und 6.0
eine Migration funktioniert. Dies wurde nicht offiziell
getestet. (Stand: Dez. 2018)

Wer eine alte paedML Linux (zwischen Version 4.0.6 und 5.1.0) besitzt,
für den kann der `Upgradepfad
<http://docs.linuxmuster.net/de/v62/systemadministration/migration/index.html>`_
über eine Migration zu einer linuxmuster.net 6.2 eine Option sein.

- Die Migration wird in die Standard-Schulinstanz `default-school` vorgenommen.
- Das Zielsystem darf außer den standardmäßig angelegten Benutzern des
  Setups keine zusätzlichen Benutzer, Gruppen oder Projekte haben.
  
Vorgehen
--------

1. Zunächst installiert man auf dem Quellsystem (Version 6.x) das
   Paket `sophomorix-dump` und exportiert die Daten  (ca. 15MByte).
    
2. Danach importiert man diese Daten auf einem Zielsystem (Version
   7.x) und rekonstruiert dort Benutzer, Passwörter, Projekte und
   Geräte, etc.
 
Export der Daten unter linuxmuster.net 6.x
==========================================

Der Server 6.x muss sich in einem synchronisierten Zustand befinden,
d.h. der Befehl auf der Konsole ``sophomorix-check`` darf keine
hinzuzufügenden oder zu verändernden Benutzer anzeigen.
Dafür führt man folgende Schritte als `root` nacheinander aus:

.. code-block:: console

   # sophomorix-check
   ...
   # sophomorix-add
   ...
   # sophomorix-move
   ...
   # sophomorix-kill
   ...

Jetzt sollte ein ``sophomorix-check`` keine Benutzer mehr verändern
wollen.

sophomorix-dump installieren
----------------------------

Installiere jetzt ``sophomorix-dump`` aus dem babo-Repository oder
lade das entsprechende Debian-Paket von der Webseite herunter

.. code-block:: console

   server ~ # apt-get update
   server ~ # apt-get install sophomorix-dump
   ...
   sophomorix-dump (3.63.2-1) wird eingerichtet ...

Alternativ kannst du (z.B. wenn du das babo-Repository nicht
einbinden kannst) unter http://pkg.linuxmuster.net/babo/ die
neueste Version `sophomorix-dump_u.v.w-z_all.deb` herausfinden,
herunterladen und installieren:

.. code-block:: console

   server ~ # wget http://pkg.linuxmuster.net/babo/sophomorix-dump_3.63.2-1_all.deb
   server ~ # dpkg -i sophomorix-dump_3.63.2-1_all.deb
   ...
   sophomorix-dump (3.63.2-1) wird eingerichtet ...

Daten exportieren
-----------------

Führe das Skript ``sophomorix-dump`` aus

.. code-block:: console

   server ~ # sophomorix-dump
   ...
       * Dump OK: /root/sophomorix-dump/data/etc/linuxmuster/subnets
   ########### End: Results of dump ##########
   WARNINGs in Results of dump are OK:
   
     /etc/sophomorix/virusscan/sophomorix-virusscan-excludes.conf
     /etc/sophomorix/virusscan/sophomorix-virusscan.conf
     /var/lib/sophomorix/virusscan/penalty.db
       are only needed, if you had configured sophomorix for scanning viruses

Die Zusammenfassung zeigt Fehler und Warnungen an. Warnungen und der folgende Fehler:
``ERROR dumping: /root/sophomorix-dump/data/etc/sophomorix/user/mail/*`` können ignoriert werden.

Die exportierten Daten (bis zu 15MByte) liegen jetzt in
``/root/sophomorix-dump``. Kopiere dieses Verzeichnis auf den Server
mit Version 7.x. Um die exportierten Daten wieder zu löschen, führe ``sophomorix-dump --clean`` aus.


Import der Daten unter linuxmuster.net 7.x
==========================================

Installiere die ``sophomorix-vampire``-Skripte über

.. code-block:: console

   server ~ # apt update
   server ~ # apt install sophomorix-vampire
   ...

Das Skript ``sophomorix-vampire -h`` zeigt Optionen und Schritte an,
die im folgenden durchgeführt werden. Beispielhaft führt das Skript
``sophomorix-vampire-example`` alle Schritte für eine typische Schule
durch.

1. Analyse der exportierten Daten
---------------------------------

Die folgende Analyse zeigt

.. code-block:: console

   server ~ # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --analyze

``ERROR``:
  z.B. fehlende Dateien (``/etc/sophomorix/user/mail/*`` wird dagegen
  nicht in jeder Installation verwendet)

``INFO``:
  z.B. Gruppen, die während der Migration umbenannt werden

``WARNING``:
  z.B. Warnungen, welche Dateien überschrieben werden

2. Migration der Klassen
------------------------

Alle Klassen werden vor den Benutzern migriert, inklusive eventueller
Umbenennungen der Klassennamen wie in der Analyse angezeigt. Dafür
erstellt man zunächst das Klassenskript und führt es danach aus

.. code-block:: console

   server ~ # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --create-class-script
   server ~ # /root/sophomorix-vampire/sophomorix-vampire-classes.sh

Jetzt können die neu erstellten Klassen überprüft werden, beispielsweise

.. code-block:: console

   server ~ # sophomorix-class -i
   server ~ # sophomorix-class -i --class teachers

3. Migration der Benutzer
-------------------------

Zunächst muss die Passwortlängen und -komplexitätsüberprüfung von
Samba 4 so eingestellt werden, dass bisherige einfache Passwörter
erlaubt sind.

.. code-block:: console

   server ~ # samba-tool domain passwordsettings set --complexity=off
   server ~ # samba-tool domain passwordsettings set --min-pwd-length=1

Jetzt wird aus den exportierten Daten eine Datei ``sophomorix.add``
erzeugt, die an die richtige Stelle im System kopiert werden muss, um
danach die Benutzer regulär aufzunehmen.

.. code-block:: console

   server ~ # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --create-add-file
   server ~ # cp /root/sophomorix-vampire/sophomorix.add /var/lib/sophomorix/check-result/sophomorix.add

Folgender Schritt informiert vorab mit ``ERRORS`` und ``WARNINGS``
über mögliche Fehlermeldungen bei der geplanten Aufnahme. Diese Fehler
sollten manuell in der Datei
``/var/lib/sophomorix/check-result/sophomorix.add`` korrigiert werden.

.. code-block:: console

   server ~ # sophomorix-add -i
   ...
   WARNING:
   ERROR:
   ...

Die Aufnahme der Benutzer wird ca. 1 Sekunde Zeit pro Benutzer in
Anspruch nehmen, Zeit einen Tee zu trinken.

.. code-block:: console

   server ~ # sophomorix-add 
   ...

Die Aufnahme

- nimmt die Benutzer mit ihren Erstpasswörtern auf, dies kann mit

  .. code-block:: console

     server ~ # sophomorix-passwd --test-firstpassword
     ...

  getestet werden, was hier zu 100% funktionieren sollte. Im nächsten
  Schritt folgt der Import der aktuellen Passworthashes.

- gibt den Benutzern keinerlei Rechte für SELMA.

:fixme: Werden weiter unten jetzt Rechte gesetzt oder nicht?

4. Passworthashes importieren
-----------------------------

Die mit Hash codierten Passwörter werde mit folgendem Befehl
importiert und sollte keine Fehler erzeugen

.. code-block:: console

   server ~ # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --import-user-password-hashes
   ...
   0 ERRORS:

Jetzt müssen die standardmäßig komplexen Passwörter wieder aktiviert werden

.. code-block:: console

   server ~ # samba-tool domain passwordsettings set --complexity=default
   server ~ # samba-tool domain passwordsettings set --min-pwd-length=default

Tests
~~~~~

:fixme: bisherigen? oder den neuen?
	
Abhängig von den bisherigen Passwortregeln werden nicht mehr alle
Erstpasswörter nach den neuen Regeln funktionieren

.. code-block:: console

   server ~ # sophomorix-passwd --test-firstpassword

Zeige einen oder mehrere Benutzer an

.. code-block:: console

   server ~ # sophomorix-user -i
   server ~ # sophomorix-user -i --user name
   server ~ # sophomorix-user -i --user na*

5. Create script to add administrators to classes and run it
------------------------------------------------------------

.. code-block:: console

   # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --create-class-adminadd-script
   # /root/sophomorix-vampire/sophomorix-vampire-classes-adminadd.sh

6. Create project script and run it
-----------------------------------

This step will create all projects.

.. code-block:: console

   # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --create-project-script
   # /root/sophomorix-vampire/sophomorix-vampire-projects.sh

Tests
~~~~~

Show one project or more:

.. code-block:: console

   # sophomorix-project -i
   # sophomorix-project -i -p <name>/<p_name>
   # sophomorix-project -i -p <p_na*>

7. Copy configuration files into new server
-------------------------------------------

This will modify some files.

You must run the script TWICE! (Guess its a bug)

.. code-block:: console

   # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --restore-config-files

You should then edit school.conf to to your liking (This is not automatically updated!)

8. Do a sophomorix run to update utf8, webui-permissions and maybe more
-----------------------------------------------------------------------

.. code-block:: console

   # sophomorix-check

Verify that there are no users to be added:

.. code-block:: console

   # sophomorix-add -i

Update user names to utf8, set sophomorixWebuiPermissionsCalculated, ... maybe more

.. code-block:: console

   # sophomorix-update

Delete overdue users (according to your settings in school.conf)

.. code-block:: console

   # sophomorix-kill

Tests
~~~~~

Check if special chars are imported into AD (if you have special chars in students.csv and teachers.csv):

.. code-block:: console

   # sophomorix-user -i -u <user_with_umlaut>

9. Add the workstations
-----------------------

.. code-block:: console

   # linuxmuster-import-devices --dry-run
   # linuxmuster-import-devices

Tests
~~~~~

Test if workstations are there:

.. code-block:: console

   # sophomorix-device -d firewall -i
   # sophomorix-device -r no-pxe -i (rooms Bug: zeigt auch hardwareclass)

Test if dns works:

.. code-block:: console

   # sophomorix-device --dns-test

10. Run some tests with users and groups
----------------------------------------

.. code-block:: console

   # sophomorix-vampire --datadir /path/to/dir/sophomorix-dump --verify-uid

11. Syncing user data with rsync
--------------------------------

Mount the old server home somewhere (for example to /mnt), so you can see:

.. code-block:: console

   /mnt/home/share
   /mnt/home/students
   /mnt/home/teachers

and specify your mount directory as: --path-oldserver /mnt

Do some tests for a single student, teacher, class, project:

.. code-block:: console

   # sophomorix-vampire --rsync-student-home <student> --path-oldserver /mnt
   # sophomorix-vampire --rsync-teacher-home <teacher> --path-oldserver /mnt
   # sophomorix-vampire --rsync-class-share <class> --path-oldserver /mnt
   # sophomorix-vampire --rsync-project-share <project> --path-oldserver /mnt

Sync all data of students, teachers, classe, projects:

.. code-block:: console

   # sophomorix-vampire --rsync-all-student-homes --path-oldserver /mnt
   # sophomorix-vampire --rsync-all-teacher-homes --path-oldserver /mnt
   # sophomorix-vampire --rsync-all-class-shares --path-oldserver /mnt
   # sophomorix-vampire --rsync-all-project-shares --path-oldserver /mnt

12. Linbo :
-----------

Sync linbo data:

.. code-block:: console

   # sophomorix-vampire --rsync-linbo --path-oldserver /mnt

Reinstall linbo to update stuff:

.. code-block:: console

   # apt-get --reinstall install linuxmuster-linbo7 linuxmuster-linbo-common7

13. What else to do by hand
---------------------------

- add descriptions to projects
- change role of devices
- set quota

Open Questions
==============

- should we move quota also (sum up the + values and apply it to the school?)
- Is there any need to import the dumped data in a certain school?

