===============
 Menü: LINBO
===============

.. image:: media/schulkonsole-linbo.png

Gruppenkonfiguration editieren
------------------------------

Klicken Sie auf einen Gruppennamen, um den Editor zu öffnen.

Beachten Sie, daß sich im Editor der Radio-Button zur Deaktivierung
des Autostarts am Seitenende befindet.

.. todo::

   Fehler in der Info-Beschreibung der Schulkonsole: pxelinux.cfg ist abgeschafft.

Beachten Sie außerdem, daß beim reboot-workaround in der
gruppenspezifischen Linbo-Startdatei unter "pxelinux.cfg/<gruppe>" der
Eintrag "DEFAULT reboot" aktiviert ist und der Rechner über PXE
startet.

.. todo::

   Hinweis auf ein eigenes Todo, oder längere Erklärung, was welcher Eintrag bedeutet.


Gruppenkonfiguration erstellen
------------------------------

Kopieren Sie hier die Konfiguration einer bestehenden Rechnergruppe
oder erstellen Sie eine neue Gruppenkonfiguration.

Beachten Sie, dass ab LINBO 1.1.0 IDE-Platten wie SATA-Platten
angesprochen werden. MMC steht für eine neue Art von günstigen
SSD-Speichern, wie sie bisher nur in Kameras Verwendung fanden.

Ist die neue Gruppenkonfiguration erstellt, können Sie im Untermenü
„Gruppenkonfiguration editieren“ gegebenenfalls weitere Anpassungen an
der neuen Konfiguration vornehmen.

GRUB-Startdatei
---------------

GRUB-Startdateien können hier editiert werden.

Imageverwaltung
---------------

Es können die bestehenden Abbilder umbenannt oder kopiert und
Informationen oder Beschreibungen zu den Abbilder angesehen werden.

Zum Umbennenen und Kopieren von Images, müssen Sie einen neuen
Dateinamen eingeben. Dateierweiterungen (.cloop/.rsync) können
weggelassen werden.

Wenn Sie die Maus auf die Symbole bewegen, werden Hilfetexte
angezeigt.

Registrypatch editieren
-----------------------

Klicken Sie auf den Namen einer Registrypatch-Datei, um sie zu
editieren.

Wollen Sie eine neue Registrypatch-Datei erstellen, wählen Sie
zunächst die Image-Datei aus dem oberen Dropdown-Menü. Im unteren
Dropdown-Menü wählen Sie die Registrypatch-Datei aus, die als Vorlage
für die neue Datei dienen soll.

Postsync-Datei editieren
------------------------

Hier können Sie die postsync-Dateien der Images bearbeiten.

Fernsteuerung
-------------

Beobachten Sie laufende Fernsteuerungsbefehle oder erstellen Sie neue Befehle.

