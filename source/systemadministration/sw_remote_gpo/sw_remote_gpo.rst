Softwareinstallation via GPO
============================

.. sectionauthor:: `@michael_kohls <https://ask.linuxmuster.net/u/michael_kohls>`_

Voraussetzung: Windows-PC mit installierten RSAT-Tools. Siehe: https://docs.linuxmuster.net/de/latest/systemadministration/gpo/gpo.html#installation-der-rsat-remote-server-administration-tools

Über GPOs können Sie drei Arten von Paketen installieren: Windows-Installationspakete mit der Dateiendung .MSI, Transformationsdateien mit der Dateiendung .MST und Patch-Dateien, die auf .MSP enden.

Software kann an Computer oder User verteilt werden. In diesem Beispiel erfolgt die Verteilung an die Computer in einem bestimmten Raum.

Melde dich an einem PC mit ``global-admin`` an und starte die ``Gruppenrichtlinienverwaltung``.

Klappe den Baum auf bis zum gewünschten Raum. 

    .. image:: media/01-gpmc.png
        :alt: Gruppenrichtlinienverwaltung
        :align: center
        
Mache einen Rechtsklick auf den gewünschten Raum und wähle ``Gruppenrichtlinienobjekt hier erstellen und verknüpfen``.
Im folgenden Fenster einen sinnvollen Namen vergeben (z.B. Software für Raum X) und mit ``OK`` bestätigen.

   .. image:: media/02-gpmc.png
        :alt: Gruppenrichtlinienverwaltung
        :align: center

Nun muss die neue GPO noch bearbeitet werden. Mache dazu einen Rrchtsklick darauf und wähle ``Bearbeiten``. Der Gruppenrichtlinienverwaltungs-Editor öffnet sich.
Gehe zu: ``Computerkonfiguration`` -> ``Richtlinien`` -> ``Softwareeinstellungen`` -> ``Softwareinstallation``

   .. image:: media/03-gpmc-edit.png
        :alt: Gruppenrichtlinienverwaltungs-Editor
        :align: center

Mache einen Rechtsklick auf ``Softwareinstallation`` und wähle ``Neu`` -> ``Paket``. Gibt den UNC-Pfad zum Paket ein. Wichtig: Das Paket muss an einer Stelle liegen, auf die der Ziel-Computer Zugriff hat! Darauf weißt der folgende Dialog auch nochmals hin.

Bei der Bereitstellungsmethode ``Zugewiesen`` auswählen und mit ``Okay`` bestätigen. 

Damit die neue GPO am Ziel-PC greift, muss dieser neu gestartet werden. 

bekannte Probleme:
------------------

 - Hibernate / Fastboot nicht deaktiviert
 - Netzwerk zu schnell -> LOKALE Richtlinie „auf Netzwerk warten“ setzen



