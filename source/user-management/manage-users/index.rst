.. Installationsleitfaden documentation master file, created by
   sphinx-quickstart on Sat Nov  7 15:29:20 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. _howto-user-management:

Benutzer verwalten mit der Schulkonsole
=======================================

Dieses Dokument gibt Schritt-für-Schritt-Anleitungen für die
wichtigsten Tätigkeiten, die der Netzwerkbetreuer im Hinblick auf die
Benutzer mit der *Schulkonsole* durchführt.

In der Schulkonsole werden grundlegende Einstellungen vorgenommen, die
Benutzerlisten gepflegt und geprüft sowie Benutzer angelegt, versetzt
und gelöscht, außerdem die Passwörter und der Plattenplatz (Quotas)
für alle Benutzer und Gruppen verwaltet. Nur Passwörter von
Schülern/innen sowie Projekte können auch von Personen mit normalen
Lehrer-Rechten verwaltet werden.

Benutzergruppen in der linuxmuster.net
======================================

Wenn man auf Dienste und Dateien des Servers zugreifen möchte, muss
man sich mit einem Benutzernamen (Loginname) und einem Kennwort
(Passwort) am Server anmelden (authentifizieren). Dabei sollen nicht
alle Benutzer am System auf die gleichen Dateien und Drucker zugreifen
oder an Dateien die selben Rechte haben können.

Es ist üblich, Benutzer, die gleiche Rechte haben sollen, zu
Benutzergruppen zusammenzufassen. In der *linuxmuster.net* gibt es,
angepasst auf Schulbedürfnisse, die folgenden Hauptbenutzergruppen:

<Klassengruppe> (z.B. 10a, 5a, usw):
 Schüler-Benutzer mit (halb)privatem Datenbereich. Es dürfen keinerlei
 Systemdateien modifiziert werden.

teachers:
 Lehrer-Benutzer mit privatem Datenbereich. Es dürfen keine
 Systemdateien modifiziert werden.  Zusätzlich hat der Lehrer Zugriff
 auf alle Klassentauschverzeichnisse und lesenden Zugriff auf die
 Schüler-Homeverzeichnisse. Alle Lehrer können über die Schulkonsole
 pädagogisch notwendige Aufgaben auf dem Server ausführen
 (z. B. Dateien austeilen, Internetzugang abschalten)

domadmins:
 Dürfen alle für den reinen Schulbetrieb wichtigen Aufgaben am Server
 durchführen, vor allem der Benutzer ``administrator`` wird dafür
 verwendet.

root:
 Darf ohne Einschränkung alle Aufgaben am Server
 durchführen. (u.a. alle Dateien, auch Passwortdateien,
 einsehen/verändern/löschen)


.. toctree::
   :maxdepth: 2
   :caption: Inhalt

   configuration
   manage
   weiteres

