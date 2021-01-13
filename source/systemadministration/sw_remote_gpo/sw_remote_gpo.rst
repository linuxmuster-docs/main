Softwareinstallation via GPO
============================

.. sectionauthor:: `@michael_kohls <https://ask.linuxmuster.net/u/michael_kohls>`_

Voraussetzung: Windows-PC mit installierten RSAT-Tools. Siehe: https://docs.linuxmuster.net/de/latest/systemadministration/gpo/gpo.html#installation-der-rsat-remote-server-administration-tools

Über GPOs können Sie drei Arten von Paketen installieren: Windows-Installationspakete mit der Dateiendung .MSI, Transformationsdateien mit der Dateiendung .MST und Patch-Dateien, die auf .MSP enden.

Software kann an Computer oder User verteilt werden. In diesem Beispiel erfolgt die Verteilung an die Computer in einem bestimmten Raum.

Melde dich an einem PC mit ``global-admin`` an und starte die ``Gruppenrichtlinienverwaltung``.

Klappe den Baum auf bis zum gewünschten Raum:


