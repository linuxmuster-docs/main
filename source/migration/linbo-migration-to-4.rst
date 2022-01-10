.. _migration-linbo-label:

==========================
Migration Linbo 2.4 zu 4.0
==========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_


Hinweise zu Linbo4
==================

In der linuxmuster v7.1 löst linbo4 das bisherige linbo 2.4 ab. Ab v7.1 gibt es nur noch ein Paket für linbo7, das nur noch linbo7 enthält.

Hast du auf die v7.1 umgestellt, musst du nun noch die bisherigen Images, die im Cloop-Format zur Verfügung standen für linbo 4 migrieren.

Linbo4 weist einige Besonderheiten auf:

* Für neue Images wird nur noch das Format qcow2 unterstützt. Der Name des Basis-Images muss daher in der übernommenen start.conf angepasst werden (z.B. image.qcow2).
* Die Bennenung der zusätzlichen Image-Dateien postsync, prestart and reg ändert sich, so dass diese nur noch ohne dem Image-Format angegeben werden (z.B. image.postsync, image.prestart and image.reg, früher: image.cloop.postsync etc.).
* qemu-img wird nun genutzt, um die Erstellung und Wiederherstellung der qcow2 Images durchzuführen.
* Es wird nur noch 64 Bit Client-Hardware unterstützt.
* linuxmuster.net <=6.2 wird nicht mehr unterstützt.
* Es gibt jetzt keine differentielle Images mehr. Differentielle Images werden voraussichtlich erst wieder ab Linbo v4.1 unterstützt.
* Bisherige Images im cloop Format bitte direkt in das neue qcow2 Format komvertieren - wie unten beschrieben.

Konvertiere die linbo 2.4 Images
================================

Hast Du auf v7.1 umgestellt, musst du jetzt noch deine bisherigen linbo 2.4 Images konvertieren, so dass diese mit linbo4 nutzbar sind.

1. Konvertiere deine Cloop-Images in das qcow2 Format mithilfe von linbo-cloop2qcow2. Wechsele dazu in das Linbo-verzeichnis und rufe den Befehl mit dem zu konvertierenden Image auf:

.. code::

   cd /srv/linbo 
   linbo-cloop2qcow2 ubu20.cloop

Das Cloop-Image wird dadurch in das qcow2-Format konvertiert und im Verzeichnis ``/srv/linbo/images/ubu20/`` als Datei ``ubu20.qcow`` abgelegt.

.. hint::

   Images von Windows-Systemen könnten nach der Konvertierung ggf. nicht so funktionieren wie vorgesehen - dies gilt insbesondere für UEFI-Systeme. In diesem Fall ist es notwendig, ein neues Image zu erstellen.

2. Ändere den Namen des Images in the start.conf der jeweiligen Hardwareklasse/Gruppe.
3. Starte die Dienste zur Image-Verteilung neu mit: ``systemctl restart linbo-torrent.service``.

.. important::

   Start alle Clients 2x, um sicherzustellen, dass Linbo v2 auf v4 aktualisiert wurde.


4. Zum Schluss starte das Skript ``linuxmuster-import-devices``. Dieses löscht die nun nicht mehr benötigten start.conf links.
5. Ab jetzt kannst du Images wieder wie gewohnt erstellen und verteilen.

Zusätzliche Hinweise
====================

1. Neu hochgeladene Images werden in einem Unterverzeichnis unterhalb von ``/srv/linbo/images`` abgelegt.
2. Backups von Images werden jetzt nach ``/srv/linbo/images/<imagename>/backups/<timestamp>`` verschoben.




