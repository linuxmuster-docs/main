.. include:: /guided-inst.subst
.. _migration-linbo-label:

==========================
Migration LINBO 2.4 zu 4.3
==========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_


Vorgehen
========

In der linuxmuster v7.3 löst LINBO 4.3 das bisherige LINBO 4.2 ab. 

**Fall A**:

Solltest Du noch v7.0/v7.1 einsetzen, musst Du 

  1. zunächst auf v7.2 aktualisieren und 
  2. die in der Doku zur v7.2 beschriebenen Schritte zur Konvertierung der bisherigen LINBO 2.4 Cloop-Images durchlaufen. Diese sind nachstehend nochmals dargestellt.


**Fall B:**

Nutzt Du bereits linuxmuster v7.2 mit LINBO v4.2, dann entspricht die Migration dem beschriebenen Upgrade.

Neuerungen von LINBO v4.3
-------------------------

LINBO 4.3 weist u.a. folgende Neuerungen auf:

* Änderungen der Namensgebung und des Speicherortes der zum Image zugehörigen Dateien
* Vereinheitlichte Partitionsbezeichnungen unabhängig von dem verwendeten Festplattentyp
* Es wird nur noch 64-Bit Client-Hardware unterstützt.
* Während des Linbo-Bootvorganges werden automatisch Torrent-Seeder-Prozesse für alle im Cache liegenden Images gestartet.
* verbesertes Hardware-Logging der Clients mit hwinfo
* Möglichkeit während des LINBO-Startvorgangs einen VNCSERVER mit starten zu lassen, um sich von einem PC via Server auf den LINBO-Client zu schalten.
* Es kann vom Server als LINBO-Client eine ISO-Live-System gebootet werden.
* Erweiterte LINBO-Client Shell
* WLAN-Unterstützung
* Unterstützung eigener Boot-Skripte
* Vereinfachung des Syntax für LINBO-start.conf-Dateien: Optionen Server | SystemType | Version | Image | Boot | Hidden entfallen.
* Einbindung des aktuellsten Linux-Kernels (z.B. > 6.14.*) - alternativ kann auch ein LTS-Kernel (6.12.*), ein legacy Kernel (6.1.*) oder ein eigener Kernel eingebunden werden.

Image-Format
------------

Das Image-Format heißt seit LINBO v4.2 `qcow2`. `qemu-img` wird genutzt, um die Erstellung und Wiederherstellung der `qcow2`-Images durchzuführen.

* Für neue Images wird nur noch das Format `qcow2` unterstützt. 
* Bisherige Images im `cloop`-Format können in das neue `qcow2`-Format einfach konvertiert werden.

Folgende Änderungen sollten beachtet werden:

* Der Name des Basis-Images muss aufgrund des Formatwechsels in der übernommenen start.conf angepasst werden (z.B. `image.qcow2` statt `image.cloop`).
* Die Benennung der zusätzlichen Image-Dateien ``*.postsync``, ``*.prestart`` and ``*.reg`` ändern sich, so dass das Image-Format nicht mehr in den Dateinamen mit angegeben wird (z.B. ``image.postsync`` statt ``image.cloop.postsync`` oder ``image.prestart`` statt ``image.cloop.prestart``).
* Der Ablageort der neuen Images und der zugehörigen zusätzlichen Dateien ist ``/srv/linbo/images/<imagename>/``. Diese Verzeichnisstruktur wird aber nicht in der start.conf angegeben.
* Backups von Images werden jetzt nach ``/srv/linbo/images/<imagename>/backups/<timestamp>`` verschoben.

Konvertieren der LINBO 2.4 Images
---------------------------------

1. Konvertiere Deine Cloop-Images in das qcow2 Format mithilfe von ``linbo-cloop2qcow2``. Wechsle dazu in das Linbo-Verzeichnis und rufe den Befehl mit dem zu konvertierenden Dateinamen auf:

.. code::

   cd /srv/linbo 
   linbo-cloop2qcow2 ubu22.cloop

Das Cloop-Image wird dadurch in das `qcow2`-Format konvertiert und im Verzeichnis ``/srv/linbo/images/ubu22/`` als Datei ``ubu22.qcow2`` abgelegt.

.. hint::

   Images von Windows-Systemen könnten nach der Konvertierung ggf. nicht so funktionieren wie vorgesehen - dies gilt insbesondere für UEFI-Systeme. In diesem Fall ist es notwendig, ein neues Image zu erstellen.

2. Ändere den Dateinamen des Images in der start.conf der jeweiligen Hardwareklasse/Gruppe. Das Ablageverzeichnis des Images wird dabei nicht genannt, obiges Beispiel: ``BaseImage = ubu22.qcow2``
3. Starte die Dienste zur Image-Verteilung neu mit: ``systemctl restart linbo-torrent.service``.

.. important::

   Starte alle Clients zweimal, um sicherzustellen, dass LINBO v2 auf v4 aktualisiert wurde.


4. Zum Schluss starte das Skript ``linuxmuster-import-devices``. Dieses löscht die nun nicht mehr benötigten start.conf-Links.
5. Ab jetzt kannst Du Images wieder wie gewohnt erstellen und verteilen.

Widerspenstige LINBO-Clients
============================

Möchtest Du bestehende LINBO-Clients zu LINBO 4 migrieren und hast dabei Probleme, obwohl Du - wie zuvor beschrieben - den Befehl ``linuxmuster-import-devices`` ausgeführt hast, solltest Du nachstehend bechriebene Schritte ausführen. 

Wichtig ist, dass vor dem Upgrade alle Clients das aktuelle LINBO im Cache haben. Falls es nach dem Upgrade beim Booten von LINBO trotzdem zu Fehlern kommt, kannst Du so vorgehen:

1. Auf dem Server temporär den LINBO-Netboot erzwingen:
    
.. code::

   # cd /srv/linbo/boot/grub/
   # cp grub.cfg grub.cfg.bak
   # cp /usr/share/linuxmuster/linbo/templates/grub.cfg.forced_netboot grub.cfg
   
2. Clients per PXE booten.
3. Prüfe, ob die Clients wirklich via PXE Network Boot starten, damit hierdurch die Clients auf die letzte LINBO-Version aktualisiert werden.
4. Nehme die Änderungen nun wieder zurück.

.. code::

   # cd /srv/linbo/boot/grub/
   # cp grub.cfg.bak grub.cfg
   
5. Starte die Clients erneut.

    
