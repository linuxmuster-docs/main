.. _howto-user-management:

=======================================
Benutzer verwalten mit der Schulkonsole
=======================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

In dieser Dokumentation erhalten Sie einen Überblick über den ``workflow`` zur Benutzerverwaltung 
in der aktuellen linuxmuster.net. Neben den Möglichkeiten zur Konfiguration der Benutzereinstellungen,
über das Einlesen der Benutzer via CSV-Datei und die Änderung einzelner Nutzer werden die wichtigsten 
Tätigkeiten zur Benutzerverwaltung erläutert.

Die Benutzerverwaltung in der aktuellen linuxmuster.net Version erfolgt auf dem Server mithilfe von sophomorix4.
Sophomorix stellt eine Vielzahl an Befehlen und einen speziellen Workflow bereit, arbeitet aber vollständig
konsolenorientiert. Es können somit alle Befehle zur Benutzerveraltun auch auf der CLI am Server 
direkt abgesetzt werden. Siehe hierzu die Hinweise im letzten Unterkapitel dieses Abschnitts.

Um eine grafisch unterstützte, einfache und bequeme Möglichkeit zur Benutzerverwaltung bereitzustellen, verfügt 
linuxmuster.net über die sog. ``Schulkonsole``, einem grafischen Hilfsmittel, das im Browser aufgerufen wird. 
Die Schulkonsole führt die Vielzahl an pädagogischen Funktionen und Funktionen zur Verwaltung und 
zum Betrieb des Schulungsnetzs unter einer einfach zu nutzenden, grafischen Oberfläche zusammen.

In der Schulkonsole (WebUI) werden grundlegende Einstellungen vorgenommen, die für die Benutzerverwaltung 
relevant sind, wie z.B. die Mindestanzahl an Zeichen für Nach- und Vorname. Zudem werden hier die Benutzerlisten gepflegt, 
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

