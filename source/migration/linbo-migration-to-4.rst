.. _migration-linbo-label:

==========================
Migration LINBO 2.4 zu 4.0
==========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_


Hinweise zu LINBO 4
===================

In der linuxmuster v7.1 löst LINBO 4 das bisherige LINBO 2.4 ab. Ab v7.1 gibt es nur noch ein Debian-Paket für LINBO (`linuxmuster-linbo7`) und eines für die grafische Oberfläche (`linuxmuster-linbo-gui7`), die nur noch LINBO 4 und die zugehörige grafische Oberfläche enthalten.

LINBO 4 weist einige Besonderheiten auf:

* Es wird nur noch das Format `qcow2` für Images unterstützt. Bisherige Images im cloop-Format müssen in das neue qcow2-Format konvertiert werden - wie unten beschrieben.
* Es gibt jetzt derzeit keine differentiellen Images mehr. Differentielle Images werden voraussichtlich erst wieder ab LINBO v4.1 unterstützt.
* Der Name des Basis-Images muss aufgrund des Formatwechsels in der übernommenen start.conf angepasst werden (z.B. `image.qcow2`).
* Die Benennung der zusätzlichen Image-Dateien ``.postsync``, ``.prestart`` and ``.reg`` ändern sich, so dass das Image-Format nicht mehr in den Dateinamen mit angegeben wird (z.B. `image.postsync` statt `image.cloop.postsync` oder `image.prestart` statt `image.cloop.prestart` usw.).
* `qemu-img` wird nun genutzt, um die Erstellung und Wiederherstellung der qcow2 Images durchzuführen.
* Es wird nur noch 64-Bit Client-Hardware unterstützt.
* Die Nutzung von LINBO 4 unter linuxmuster.net <=6.2 wird nicht unterstützt. 

Konvertieren der LINBO 2.4 Images
=================================

Hast du auf die v7.1 umgestellt, musst du jetzt noch deine bisherigen LINBO 2.4 Images konvertieren, so dass diese mit LINBO 4 nutzbar sind.

1. Konvertiere deine Cloop-Images in das qcow2 Format mithilfe von ``linbo-cloop2qcow2``. Wechsle dazu in das Linbo-Verzeichnis und rufe den Befehl mit dem zu konvertierenden Image auf:

.. code::

   cd /srv/linbo 
   linbo-cloop2qcow2 ubu22.cloop

Das Cloop-Image wird dadurch in das qcow2-Format konvertiert und im Verzeichnis ``/srv/linbo/images/ubu22/`` als Datei ``ubu22.qcow2`` abgelegt.

.. hint::

   Images von Windows-Systemen könnten nach der Konvertierung ggf. nicht so funktionieren wie vorgesehen - dies gilt insbesondere für UEFI-Systeme. In diesem Fall ist es notwendig, ein neues Image zu erstellen.

2. Ändere den Namen des Images in the start.conf der jeweiligen Hardwareklasse/Gruppe, z.B. ``BaseImage = ubu22.qcow2``
3. Starte die Dienste zur Image-Verteilung neu mit: ``systemctl restart linbo-torrent.service``.

.. important::

   Starte alle Clients zweimal, um sicherzustellen, dass LINBO von v2 auf v4 aktualisiert wurde.


4. Zum Schluss starte das Skript ``linuxmuster-import-devices``. Dieses löscht die nun nicht mehr benötigten start.conf-Links.
5. Ab jetzt kannst du Images wieder wie gewohnt erstellen und verteilen.

Zusätzliche Hinweise
====================

1. Neu hochgeladene Images werden in einem Unterverzeichnis unterhalb von ``/srv/linbo/images`` abgelegt.
2. Backups von Images werden jetzt nach ``/srv/linbo/images/<imagename>/backups/<timestamp>`` verschoben.




