.. _howto-user-management:

=======================================
Benutzer verwalten mit der Schulkonsole
=======================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

In dieser Dokumentation erhalten Sie einen Überblick über den ``workflow`` zur Benutzerveraltung 
in der aktuellen linuxmuster.net. Neben den Möglichkeiten zur Konfiguration der Benutzereinstellungen,
über das Einlesen der Benutzer via CSV-Datei und die Änderung einzelner Nutzer werden die wichtigsten 
Tätigkeiten zur Benutzerverwaltung erläutert.

Die Benutzerverwaltung in der aktuellen linuxmuster.net Version erfolgt grundsätzlich grafisch 
unterstützt mithilfe eines Browsers der sog. ``Schulkonsole``. In der Schulkonsole (WebUI) werden 
grundlegende Einstellungen vorgenommen, die für die Benutzerveraltung relevant sind, wie z.B. die 
Mindestanzahl an Zeichen für Nach- und Vorname. Zudem werden hier die Benutzerlisten gepflegt, 
geprüft sowie Benutzer angelegt, versetzt und gelöscht. Die Passwörter und der Plattenplatz (Quotas) 
werden hier für alle Benutzer, Klassen und Gruppen verwaltet. 

Grundsätzlich nimmt der Benutzer ``global-admin`` die Einstellungen für die Benutzerverwaltung vor.
Benutzer mit Lehrer-Rechten können danach Passwörter für Schüler und Schülerinnen sowie Projekte verwalten.

.. toctree::
   :maxdepth: 2
   :caption: Inhalt

   commonworkflow
   managewebui
   sophomorix4

