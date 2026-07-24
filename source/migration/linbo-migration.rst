.. include:: /guided-inst.subst
.. _migration-linbo-label:

==========================
Migration LINBO 4.3 zu 7.4
==========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

In der linuxmuster v7.4 löst LINBO v7.4 das bisherige LINBO v4.3 ab, das mit linuxmuster.net v7.3 ausfeliefert wurde.

.. attention::

   Voraussetzung für das Upgrade zu linuxmuster.net v7.4 und LINBO v7.4 ist, dass Du Dein System bereits auf linuxmuster.net v7.3 und LINBO v4.3 aktualisiert und alle Pakete aktualisiert hast.

Ist dies der Fall, wird LINBO im Zuge des Upgrades mit

.. code::

   linuxmuster-release-upgrade

ebenfalls aktualisiert.


Neuerungen von LINBO v7.4
-------------------------

LINBO 7.4 weist u.a. folgende Neuerungen auf:

* Es sind verschiedene Kernel Versionen verfügbar (6.1.*, 6.12.* & 6.16.*).
* Es wird als Image-Format ``qcow2`` gentutzt.
* Es werden differentielle Images unterstützt.
* ``linbo_cmd`` wurde vollständig neu refaktorisiert.
* Es wurde ein neuer NTFS3-Kernel-Treiber eingebunden, der die Synchronisation für NTFS-Partitionen unterstützt.

qcow2-Format
------------

Das Image-Format heißt `qcow2`. `qemu-img` wird genutzt, um die Erstellung und Wiederherstellung der `qcow2`-Images durchzuführen.

Folgendes sollte beachtet werden:

* Der Name des Basis-Images muss in der start.conf z.B. `image.qcow2` lauten.
* Die Benennung der zusätzlichen Image-Dateien ``*.postsync``, ``*.prestart`` and ``*.reg`` ändern sich, so dass das Image-Format nicht mehr in den Dateinamen mit angegeben wird (z.B. ``image.postsync`` oder ``image.prestart``).
* Der Ablageort der neuen Images und der zugehörigen zusätzlichen Dateien ist ``/srv/linbo/images/<imagename>/``. Diese Verzeichnisstruktur wird aber nicht in der start.conf angegeben.
* Backups von Images werden jetzt nach ``/srv/linbo/images/<imagename>/backups/<timestamp>`` verschoben.


**Widerspenstige LINBO-Clients**


Möchtest Du bestehende LINBO-Clients zu LINBO 7 migrieren und hast dabei Probleme, obwohl Du - wie zuvor beschrieben - den Befehl ``linuxmuster-import-devices`` ausgeführt hast, solltest Du nachstehend bechriebene Schritte ausführen.

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

    
