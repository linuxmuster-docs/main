.. include:: ../../guided-inst.subst

.. _basis_server-label:

====================================
Anlegen und Installieren des Servers
====================================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

.. note:: 

   Bist Du zuvor der Anleitung "Proxmox vorbereiten" gefolgt, dann kannst Du fortfahren mit `Erster Start des Servers vom Installationsmedium`_.

.. hint::

   Willst Du in einer VM installieren, so must Du für die neue VM folgende Mindesteinstellungen angeben:
     
     - Template - Ubuntu Bionic Beaver 18.04, installation from ISO library, 
     - Boot-Mode - BIOS Boot / MBR, 
     - 2 vCPU, 
     - 3 GiB RAM, 
     - storage -> hdd1: 25 GiB -> hdd2: 100 GiB, 
     - 1 NIC mit Zuordnung zu vSwitch green.
   
   Achte darauf, dass vor dem Start der VM beide Festplatten der VM zugewiesen wurden.


   Bei der Einrichtung des Servers musst Du nur einen Server mit 2 HDDs haben und Ubuntu 18.04 auf der ersten HDD installieren. Die zweite HDD bleibt frei. Auf dieser 2. HDD richtest Du - wie nachstehend beschrieben -  ein LVM ein.

Erster Start des Servers vom Installationsmedium
================================================

Sprachauswahl
-------------

Starte den Server via Ubuntu 18.04 Server ISO-Image (USB-Stick oder CD-ROM). Es erscheint das erste Installationsfenster mit der Abfrage zur gewünschten Sprache.

.. figure:: media/basis_server_001.png

Wähle Deine bevorzugte Sprache.

Tastaturlayout
--------------

Danach wähle Dein Tastaturlayout.

.. figure:: media/basis_server_002.png

Wähle das Tastaturlayout Deutsch und bestätige dies mit ``Erledigt``.

.. tip:: Wenn Du Dir nicht sicher bist, vor welcher Tastatur Du gerade sitzt:

   Wähle nacheinander 
  
   ``Tastatur erkennen`` --> ``OK`` --> ``y`` --> ``Ja`` --> ``ö`` --> ``Nein`` --> ``OK``

   Da sollte zumindest für eine deutsche Tastatur das richtige Layout finden.
   Für andere einfach den Abfragen folgen

Netzwerk
--------

Konfiguriere danach Deine Netzwerkkarte.

.. figure:: media/basis_server_003.png

In der Voreinstellung ist die Netzwerkkarte auf DHCP eingestellt. Das klappt natürlich nicht, da der DHCP-Service der Firewall deaktiviert wurde. 
Du musst also die Konfiguration von Hand einstellen.

Gehe dazu auf die Netzwerkkarte und wähle ``Edit IPv4``.

.. figure:: media/basis_server_004.png

Wähle ``Manual`` aus.

.. figure:: media/basis_server_005.png

Gib die Netzwerkkonfiguration, wie im oberen Bild ein beziehungsweise |...|

.. hint:: |...| passe sie Deinen Bedürfnissen an und übernehme diese mit ``Speichern``. 

.. attention::

   Die Länge des ersten Teils der Domäne darf maximal 15 Zeichen betragen. Die Domäne "muster-gymnasium.de" überschreitet diese Grenze um ein Zeichen, da "muster-gymnasium" 16 Zeichen lang ist.
 
   Eine gute Wahl ist beispielsweise ``linuxmuster.lan``. Beim späteren Setup von linuxmuster.net wird diese ggf. für alle Server-Dienste angepasst.

.. figure:: media/basis_server_006.png

Mit ``Èrledigt`` geht es weiter.

.. figure:: media/basis_server_007.png

Lass die Proxy-Adresszeile leer. Auch diese Anfrage verlässt Du mit ``Erledigt``.

.. figure:: media/basis_server_008.png

Die Mirror-Adresse übernimmst Du ebenfalls mit ``Erledigt``.

.. figure:: media/basis_server_009_new-installer.png

Aktualisierung des Installers
-----------------------------

Bei der angebotene Aktualisierung wählst Du ``Ohne Akualisierung fortfahren``.

Speichermedien
--------------

Für die weitere Installation benötigst Du zwei unterschiedliche Speichermedien in Deinem Server.

Dabei ist es egal ob es sich dabei um |...| 

* |...| eine reale Festplatte mit zwei Partionen.
* |...| zwei reale Festplatten.
* |...| zwei virtuelle Festplatten handelt.

In dieser Anleitung beschreiben wir zunächst die Installation auf Basis unserer Mindestanforderungen, also |...|

* |...| 25G Speichermedium für das System und
* |...| 100G Speichermedium für Daten

Wobei anzumerken ist, dass die Installation des Speicherplatzes für das System ``/`` für alle Varianten identisch ist.

Speicher des Systems
^^^^^^^^^^^^^^^^^^^^

.. figure:: media/basis_server_010_custom-storage-layout.png

Wähle nun zur Einrichtung der Festplatten ``Custom Storage Layout`` aus, wie in obigen Bild dargestellt.

Es werden Dir dann die verfügbaren Geräte angezeigt. 

.. figure:: media/basis_server_011_custom-storage-layout-create-partition-table.png

Wähle die erste Festplatte bzw. die erste Partition aus, auf der Du das System des Servers unterbringen möchtest. Es wird ein Kontextmenü angezeigt, bei dem Du mit ``Add GPT Partition`` diese erstellen musst. 

.. figure:: media/basis_server_012_custom-storage-layout-create-partition-table2.png

Wähle den gesamten Festplattenplatz (einfach das Eingabefeld leer lassen) und formatiere diesen mit dem ext4-Dateiformat und weise diese dem Mount Point ``/`` zu.

.. figure:: media/basis_server_013_custom-storage-layout-create-partition-table3.png

Gehe auf ``Erstellen``.

Danach gelangst Du zu nachstehendem Bildschirm.

.. figure:: media/basis_server_014_custom-storage-layout-create-partition-table-lvm-hdb-5.png

Speicherplatz für das Testsystem
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Für das Setup werden noch weitere Partitionen benötigt. Dafür haben wir uns für folgende Größenvorgabe entschieden. 

.. hint:: Für kleine Schulen oder eine Test-Installation sollten diese Vorgaben passen. 
   
   ============== ========================== ================================= ==========
   LV Name        LV Pfad                    Mountpoint                        Größe
   ============== ========================== ================================= ==========
   var            /dev/sg_srv/var            /var                              10G
   linbo          /dev/sg_srv/linbo          /srv/linbo                        40G
   global         /dev/sg_srv/global         /srv/samba/global                 10G
   default-school /dev/sg_srv/default-school /srv/samba/schools/default-school 40G [#f1]_
   ============== ========================== ================================= ==========

.. [#f1] Sollte Deine Festplatte größer sein als die vorgeschlagene Mindestgröße so wird für diese Partition der maximal übrige freie Platz mit verwendet.

.. attention::

   Unser linuxmuster-setup nimmt Dir die nötigen vorbereitenden Aktionen ab. Du läßt also das `zweite Speichermedium unkonfiguriert`.

Zum Abschluss werden Dir die Partitionsierungseinstellungen gemäß Deiner Eingaben angezeigt.

.. figure:: media/basis_server_016_custom-storage-layout-create-partition-table-overview.png

Wenn Du es für Deine Installation nutzen willst, dann kannst Du die nächsten Punkte überspringen und mit `Speicherplatzkonfiguration übernehmen`_ weitermachen.

Speicherplatz nach Deinen Vorgaben (optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. tip::

  Alternativ kannst Du die zweite Platte mit anderen Größenangaben auch mit linuxmuster-prepare im Zuge des Setup ausführen. Möchtest Du dies so durchführen, kannst Du nachstehende Punkte überspringen.

Solltest Du Dich für eine andere Größeneinteilung oder für eine Einrichtung auf realen Festplatten entschieden haben, dann geht es hier für Dich weiter.

   ============== ========================== ================================= ==========
   LV Name        LV Pfad                    Mountpoint                        Größe
   ============== ========================== ================================= ==========
   var            /dev/sg_srv/var            /var                              20G
   linbo          /dev/sg_srv/linbo          /srv/linbo                        80G
   global         /dev/sg_srv/global         /srv/samba/global                 20G
   default-school /dev/sg_srv/default-school /srv/samba/schools/default-school 80G
   ============== ========================== ================================= ==========

Wir beschreiben hier exemplarisch das Vorgehen für die Größen aus der obigen Tabelle für die |...|

|...| `Einrichtung eines LVM auf der 2. HDD nach Deinen Vorgaben (optional)`_

|...| `Einrichtung ohne LVM auf HDD nach Deinen Vorgaben (optional)`_

Einrichtung eines LVM auf der 2. HDD nach Deinen Vorgaben (optional)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

.. figure:: media/basis_server_016_lvm_001.png

Wähle den Eintrag ``Datenträgergruppe (LVM) anlegen`` aus.

.. figure:: media/basis_server_016_lvm_002.png

Hier gibst Du einen Namen für die LVM Volume Group an (z.B. sg_srv) und wählst das Gerät aus wo es erstellt werden soll. ``Erstellen`` schließt dieses Fenster.

#####

Bei ``VERFÜGBARE GERÄTE`` gilt es nun in die angelegte "LVM volume group" die benötigten "Logical Volume" anzulegen.

.. figure:: media/basis_server_016_lvm_003.png

Bei ``VERFÜGBARE GERÄTE`` findest Du die von Dir zuvor angelegte "LVM volume group". Diese markierst Du , um dann ``Create Logical Volume`` auszuwählen.

.. figure:: media/basis_server_016_lvm_004.png

Die benötigten Daten entnimmst Du aus der obigen Tabelle.
Die Zuordnung ist folgende:

========== === ===============================
``Name``   --> LV Name
``Size``   --> Größe
``Mount``  --> Mountpoint
========== === ===============================

Bei ``Format`` wählst Du, wie in der Grafik gezeigt "ext4".

Wieder schließt Du diese Aktion mit ``[Èrstellen]`` ab.

#####

Die letzten zwei Schritte wiederholst Du für die anderen Positionen der Tabelle |...|

|...| linbo:

.. figure:: media/basis_server_016_lvm_005.png

.. figure:: media/basis_server_016_lvm_006.png

#####

|...| global:

.. figure:: media/basis_server_016_lvm_007.png

.. figure:: media/basis_server_016_lvm_008.png

#####

|...| default-school:

.. figure:: media/basis_server_016_lvm_009.png

.. figure:: media/basis_server_016_lvm_010.png

######

Zum Abschluss werden Dir die Partitionsierungseinstellungen gemäß Deiner Eingaben angezeigt.

.. figure:: media/basis_server_016_lvm_011.png

Wenn Du es für Deine Installation nutzen willst, dann kanst Du mit `Speicherplatzkonfiguration übernehmen`_ weitermachen.

Einrichtung ohne LVM auf HDD nach Deinen Vorgaben (optional)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ohne LVM sind die Mount Points ``/var``, ``/srv/linbo``, ``/srv/samba/global`` und ``/srv/samba/schools/default-school`` auf die HDD(s) beziehungsweise auf einzelne Partitionen zu legen.

Auf eine detaillierte Beschreibung verzichten wir hier. Wir gehen davon aus, dass Du weißt, wie Du es umsetzen musst, wenn Du es so einrichten willst. 

Die vorhergehende Beschreibung bietet Dir sicherlich genügende Hinweise, daher verlinken wir sie hier noch einmal für Dich. `Einrichtung eines LVM auf der 2. HDD nach Deinen Vorgaben (optional)`_ 

Speicherplatzkonfiguration übernehmen
-------------------------------------

Stimmen diese mit den gewünschten überein, so wähle ``Erledigt`` wie in dem zuletzt gesehen Bild aus.

Danach erhälst Du die Rückfrage, ob die Installation fortgesetzt werden soll und das die Daten auf der Festplatte dabei gelöscht werden.

.. figure:: media/basis_server_016_d.png

Bestätige dies mit ``Fortfahren``.

.. figure:: media/basis_server_017.png

Nenne den Server ``server``. Der Benutzername (linuxadmin) und das Passwort (Muster!) sind frei wählbar - wie in der Abb. dargestellt.

.. figure:: media/basis_server_018.png

Solltest Du eine Möglichkeit für einen Fernzugang zu dem Server wünschen, aktiviere ``OpenSSH-Server installieren``. 

.. attention:: Wenn Du dies machst, mache Dir auch Gedanken wie Du diesen Zugang absichern kannst.
   
   Wir empfehlen das PublicKey-Verfahren.
   https://wiki.ubuntuusers.de/SSH/#Publickey-Authentifizierung (externer Link)

.. figure:: media/basis_server_019.png

Installiere keine weiteren optionalen Pakete.

Bestätige den Start des Installationsvorganges mit ``Erledigt``.

Zum Abschluß der Installation wird automatisch versucht, Updates zu installieren |...|

.. figure:: media/basis_server_020.png

|...| und danach gilt es den Server neu zu starten.

.. hint::

   Bei einer VM achte vor dem Neustart darauf, dass Du die ISO-Datei / DVD ausgeworfen hast und die Boot-Reihenfolge so umgestellt hast, dass die VM direkt von HDD bootet.

Wann die Installation abgeschlossen ist, erkennst Du daran das die Anzeige am unteren Bildschirmrand von

.. figure:: media/basis_server_022.png

auf

.. figure:: media/basis_server_023.png

gewechselt ist.

.. figure:: media/basis_server_021.png

Den Neustart veranlasst Du mit ``Jetzt neustarten``, wenn es Dir angeboten wird.

.. tip::

   Folgendes Vorgehen bieten sich an, wenn der Server virtualisiert betrieben wird und der Hypervisor so schnell den Neustart einleitet, dass Du keine Chance hast, das Installationsmedium zu entfernen.

   Alternative zum ``Jetzt Neustarten`` gehe zum Punkt ``Hilfe`` oben rechts. Dort wählst Du den Menüpunkt ``Enter Shell`` aus, wo Du dann den Server gezielt mit ``init 0`` herunterfährst. Es folgt noch ein Hinweis, dass Du die Entfernung des Installationsmediums mit ``Enter`` bestätigen sollst. Im Anschluss daran fährt der Server herunter und Du kannst ihn von neuem starten.

Bei laufender und wie zuvor beschriebener Einrichtung der OPNsense |reg| sollte dies erfolgreich verlaufen.

######

Basis-Konfiguration des Servers
===============================

term.js für die Konsolen-Nutzung in Proxmox aktivieren
------------------------------------------------------

Nachdem Du Dich erneut als ``linuxadmin`` beziehungsweise mit dem von Dir angelegten Nutzer an der ``noVNC`` Konsole angemeldet hast, gib diese zwei Zeilen Code nacheinander ein:

.. code::

   sudo systemctl enable serial-getty@ttyS0.service

.. code::

   sudo systemctl start serial-getty@ttyS0.service

Fahre nun die virtuelle Maschine (VM) herunter und starte sie erneut.

Wähle jedoch oben rechts ``>_ Console -> xterm.js``.
Es öffnet sich das Terminal-Fenster der VM und es erscheint folgender Hinweis:

.. figure:: media/basis_server_023c.png

Nach einem ``Enter`` wirst Du zur Eingabe Deines Passwortes aufgefordert.

Nach erfolgter Anmeldung mit Deinem Account kannst Du die ab jetzt folgenden Codezeilen einfach zwischen der Anleitung und dem Server mittels ``Copy-and-paste`` übertragen. Abhängig von dem Betriebssystem Deines Administration-PCs klappt vielleicht auch ``Drag-and-drop``. Einfach mal testen.

.. code::

   stty cols 120 rows 60

.. note:: Der Befehl sorgt dafür, dass die Zeilenumbrüche hoffentlich zu Deiner Konsolen-Anzeige passen. Ansonsten musst Du die Angaben für die Zeichen (cols) und Zeilen (rows) anpassen.    

Quota-Einstellungen überprüfen
------------------------------

.. hint::

   Nachstehende Schritte musst Du nur durchführen, wenn Du **nicht** mit den default-Einstellungen installierst. Überspringe diesen Punkt und gehe zu: `Bezeichnung des Speichermediums für das LVM ermitteln`_


.. code:: 

   nano /etc/fstab

Mit diesem Aufruf öffnest Du die Datei ``/etc/fstab`` mit dem Editor nano auf, damit Du die Ersetzung von ``defaults`` durchführen kannst. Das ist der Ersetzungstext:

.. code::

   user_xattr,acl,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0,barrier=1

Vor Deiner Ersetzung:

.. code::
 
   /dev/vg0/var              /var ext4 defaults 0 1
   /dev/vg0/linbo            /srv/linbo ext4 defaults 0 1
   /dev/vg0/global           /srv/samba/global ext4 defaults 0 1
   /dev/vg0/default-school   /srv/samba/schools/default-school ext4 defaults 0 1

Nach der Änderung:
 
 .. code::
 
   /dev/vg0/var              /var ext4 defaults 0 1
   /dev/vg0/linbo            /srv/linbo ext4 defaults 0 1
   /dev/vg0/global           /srv/samba/global ext4 user_xattr,acl,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0,barrier=1 0 1
   /dev/vg0/default-school   /srv/samba/schools/default-school ext4 user_xattr,acl,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0,barrier=1 0 1
 
Speichere die Einstellung mit ``Strg+w`` und verlasse den Editor mit ``Strg+x``. 
 
Lade die Eintragungen aus der Datei ``/etc/fstab`` neu mit ``mount -a``. Ggf. erkennst Du auch noch Fehler, die sich aufgrund von Tippfehlern in der Datei /etc/fstab ergeben. Behebe diese zuerst, bevor Du fortfährst.
 
.. _lsblk-command:

Bezeichnung des Speichermediums für das LVM ermitteln
-----------------------------------------------------

Betrifft Dich nur, wenn Du die default-Einstellungen verwendest.

.. code::

   lsblk

Aus dessen Ausgabe kannst Du Namen für die weitere Verwendung ermitteln. Hier wäre er beispielhaft ``/dev/sdb/``

.. figure:: media/basis_server_024.png

.. note:: Notiere Dir HDD- und Partition-Bezeichnungen für die spätere Verwendung.

Automatische Updates abschalten
-------------------------------

Der frisch installierte Ubuntu-Server hat automatische Updates aktiviert. Das solltest Du abschalten, denn nur so kannst Du sichern sein, dass Updates nicht während der Unterrichtszeit in Deiner Einrichtung durchgeführt werden und zu eventuellen Problemen im Schulalltag führen.

Werde mit |...| 

.. code::

  sudo -i

|...| zum Nutzer ``root`` und editiere, beispielsweise mit nano, die Datei |...|

.. code::

  nano /etc/apt/apt.conf.d/20auto-upgrades

Ersetze bei ``APT::Periodic::Unattended-Upgrade`` die ``"1";`` durch ``"0";``.
Mit ``<Strg>+o`` und anschließendem ``Enter`` speicherst Du die Änderung ab. Und mit ``<Strg>+x`` verlässt Du nano wieder.

Jetzt kannst Du den Server updaten, mit |...|

.. code:: 

   apt update && apt dist-upgrade
   
Nachdem Dir neue Pakete zur Anzeige gebracht wurden, startest Du den Upgrade-Prozess mit ``j``.

.. attention::

   Durch das Deaktivieren der automatischen Updates liegt jetzt natürlich die Verantwortung des zeitnahen Einspielen von Updates bei Dir bzw. der Person, die für die Administration verantwortlich zeichnet!

Test der Verbindung zur Firewall
--------------------------------

Es folgt ein letzter Test, um sicherzustellen, dass die SSH-Verbindung zwischen dem Server und der Firewall funktioniert. Diese ist für das weitere Vorgehen entscheidend.

Nach dem erneuten Einloggen rufst Du folgende Zeile an der Konsole des Servers auf: 

.. code::

   ssh root@10.0.0.254

Da es die erste Kontaktaufnahme zwischen dem Server und der Firewall ist,

.. figure:: media/basis_server_025.png

ist es notwendig, dass Du den Key akzeptierst.

Anschließend sollte der Log-in nach der Eingabe des Passwortes ``Muster!`` erfolgreich sein.

.. figure:: media/basis_server_026.png

Mit ``0) Logout`` beendest Du die Verbindung.

Weiter geht es jetzt mit :ref:`lmn_pre_install-label`
