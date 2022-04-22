.. _migration-linbo-label:

==========================
Migration LINBO 2.4 zu 4.0
==========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_


Hinweise zu LINBO 4
===================

In der linuxmuster v7.1 löst LINBO 4 das bisherige LINBO 2.4 ab. Ab v7.1 gibt es nur noch ein Debian-Paket für LINBO (`linuxmuster-linbo7`) und eines für die grafische Oberfläche (`linuxmuster-linbo-gui7`), die nur noch LINBO 4 und eine grafische Oberfläche enthalten.

Hast du auf linuxmuster v7.1 umgestellt, ist es sinnvoll, die bisherigen LINBO 2.4 Cloop-Images zu konvertieren.

LINBO 4 weist einige Besonderheiten auf:

* neues Image-Format mit Abwärtskompatibilität zum alten Format für eine einfach Migration
* Änderungen an der Namensgebung und des Speicherortes der zum Image zugehörigen Dateien
* Es wird nur noch 64-Bit Client-Hardware unterstützt.
* LINBO 4 kann nicht mit linuxmuster v6.2 und kleiner verwendet werden.
* Es gibt derzeit *keine* differentiellen Images. Differentielle Images werden voraussichtlich erst wieder ab LINBO v4.1 unterstützt.


Neues Image-Format
------------------

Das neue Image-Format heißt `qcow2`. `qemu-img` wird nun genutzt, um die Erstellung und Wiederherstellung der `qcow2`-Images durchzuführen.

* Für neue Images wird nur noch das Format `qcow2` unterstützt. 
* Images im `cloop`-Format werden aber weiterhin an Clients ausgeliefert.
* Bisherige Images im `cloop`-Format können in das neue `qcow2`-Format einfach konvertiert werden.

Folgende Änderungen sollte man auch beachten:

* Der Name des Basis-Images muss aufgrund des Formatwechsels in der übernommenen start.conf angepasst werden (z.B. `image.qcow2` statt `image.cloop`).
* Die Benennung der zusätzlichen Image-Dateien ``*.postsync``, ``*.prestart`` and ``*.reg`` ändern sich, so dass das Image-Format nicht mehr in den Dateinamen mit angegeben wird (z.B. ``image.postsync`` statt ``image.cloop.postsync`` oder ``image.prestart`` statt ``image.cloop.prestart``).
* Der Ablageort der neuen Images und der zugehörigen zusätzlichen Dateien ist ``/srv/linbo/images/<imagename>/``. Diese Verzeichnisstruktur wird aber nicht in der start.conf angegeben.
* Backups von Images werden jetzt nach ``/srv/linbo/images/<imagename>/backups/<timestamp>`` verschoben.



Konvertieren der LINBO 2.4 Images
=================================

1. Konvertiere deine Cloop-Images in das qcow2 Format mithilfe von ``linbo-cloop2qcow2``. Wechsle dazu in das Linbo-Verzeichnis und rufe den Befehl mit dem zu konvertierenden Dateinamen auf:

.. code::

   cd /srv/linbo 
   linbo-cloop2qcow2 ubu22.cloop

Das Cloop-Image wird dadurch in das `qcow2`-Format konvertiert und im Verzeichnis ``/srv/linbo/images/ubu22/`` als Datei ``ubu22.qcow2`` abgelegt.

.. hint::

   Images von Windows-Systemen könnten nach der Konvertierung ggf. nicht so funktionieren wie vorgesehen - dies gilt insbesondere für UEFI-Systeme. In diesem Fall ist es notwendig, ein neues Image zu erstellen.

2. Ändere den Dateinamen des Images in the start.conf der jeweiligen Hardwareklasse/Gruppe. Das Ablageverzeichnis des Images wird dabei nicht genannt, obiges Beispiel: ``BaseImage = ubu22.qcow2``
3. Starte die Dienste zur Image-Verteilung neu mit: ``systemctl restart linbo-torrent.service``.

.. important::

   Starte alle Clients zweimal, um sicherzustellen, dass LINBO v2 auf v4 aktualisiert wurde.


4. Zum Schluss starte das Skript ``linuxmuster-import-devices``. Dieses löscht die nun nicht mehr benötigten start.conf-Links.
5. Ab jetzt kannst du Images wieder wie gewohnt erstellen und verteilen.



