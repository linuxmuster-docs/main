Softwareinstallation via GPO
============================

.. sectionauthor:: `@michael_kohls <https://ask.linuxmuster.net/u/michael_kohls>`_

Voraussetzung: Windows-PC mit installierten RSAT-Tools. Siehe: https://docs.linuxmuster.net/de/latest/systemadministration/gpo/gpo.html#installation-der-rsat-remote-server-administration-tools

Über GPOs können drei Arten von Paketen installiert werden: Windows-Installationspakete mit der Dateiendung .MSI, Transformationsdateien mit der Dateiendung .MST und Patch-Dateien, die auf .MSP enden.

Software kann an Computer oder User verteilt werden. In diesem Beispiel erfolgt die Verteilung an die Computer in einem bestimmten Raum.

Zunächst sollte die Software auf einem UNC-Pfad abgelegt werden, von dem aus die Installation ausgeführt werden kann. Das Server-Share ``\\server\default-school\program`` ist ungeeignet. Besser: ``\\server\sysvol\domänenname\``. Hier einen Unterordner ``Software`` erstellen und die MSI-Pakete ablegen.

Neue GPO erzeugen
-----------------

Melde Dich an einem PC mit ``global-admin`` an und starte die ``Gruppenrichtlinienverwaltung``. Klappe den Baum auf bis zum gewünschten Raum. Mache einen Rechtsklick auf den gewünschten Raum und wähle ``Gruppenrichtlinienobjekt hier erstellen und verknüpfen``. Im folgenden Fenster einen sinnvollen Namen vergeben (z.B. Software für Raum X) und mit ``OK`` bestätigen.

    .. image:: media/01-gpmc.png
        :alt: Gruppenrichtlinienverwaltung
        :align: center
        
Nun muss die neue GPO noch bearbeitet werden. Mache dazu einen Rerchtsklick darauf und wähle ``Bearbeiten``.

   .. image:: media/02-gpmc.png
        :alt: Gruppenrichtlinienverwaltung
        :align: center


Der Gruppenrichtlinienverwaltungs-Editor öffnet sich. Gehe zu: ``Computerkonfiguration`` -> ``Richtlinien`` -> ``Softwareeinstellungen`` -> ``Softwareinstallation``

   .. image:: media/03-gpmc-edit.png
        :alt: Gruppenrichtlinienverwaltungs-Editor
        :align: center

Mache einen Rechtsklick auf ``Softwareinstallation`` und wähle ``Neu`` -> ``Paket``. Gibt den UNC-Pfad zum Paket ein. Wichtig: Das Paket muss an einer Stelle liegen, auf die der Ziel-Computer Zugriff hat! Darauf weißt der folgende Dialog auch nochmals hin.

Bei der Bereitstellungsmethode ``Zugewiesen`` auswählen und mit ``Okay`` bestätigen. 

Damit die neue GPO am Ziel-PC greift, muss dieser neu gestartet werden. 

bekannte Probleme:
------------------

1) Hibernate / Fastboot nicht deaktiviert

2) Die GPO wird nicht übernommen, weil die Verbindung zu schnell ist. In diesem Fall auf dem Ziel-PC mittels ``gpedit.msc`` die lokale GPO aktivieren: ``Computerkonfiguration\Administrative Vorlagen\System\Anmelden`` - ``Beim Neustarten des Computers und bei der Anmeldung immer auf das Netzwerk warten``.

Software erneut verteilen
-------------------------

Wurde die Software absichtlich oder unabsichtlich mit einem lokalen Administrator auf dem Ziel-PC gelöscht, muss das Paket neu verteilt werden. Dazu im Gruppenrichtlinienverwaltungs-Editor unter ``Computerkonfiguration`` -> ``Richtlinien`` -> ``Softwareeinstellungen`` -> ``Softwareinstallation`` einen Rechtsklick auf die Software machen und ``Alle Aufgaben -> Entfernen`` wählen. Anschließend das Paket wieder neu hinzufügen.

