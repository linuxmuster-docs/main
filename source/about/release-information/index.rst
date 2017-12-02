.. Installationsleitfaden documentation master file, created by
   sphinx-quickstart on Sat Nov  7 15:29:20 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. _release-information-label:

Was ist neu in 7.0?
===================

.. sectionauthor:: Hans Wurst <fleischsalat@linuxmuster.net>


Linuxmuster.net 7.0 ist in großen Teilen neu geschrieben worden. Es
gibt einen Upgrade-Pfad über eine Migration, da ein Update des
Basissystems aufgrund der zahlreichen Veränderungen unter der Haube
nicht sinnvoll ist.

Die Highlights sind ein Mehrschulbetrieb, eine neue Firewall, eine
optionale Mailserverlösung, ... ohne die bekannten Vorzüge wie LINBO,
Opsi, usw. zu verlieren.

Lesen Sie im Detail die Neuerungen in den einzelnen Teilfeldern und bekannten Probleme.

Installation
------------

* Docker-Container für Mailserver und weitere externe Services


Systemadministration
--------------------

Linbo
+++++

Die größte Modernisierung hat LINBO schon mit der Version 2.3.x in
linuxmuster.net 6.2 erfahren. Dennoch gibt es einige Neuigkeiten, die
nur die linuxmuster.net 7.0 betreffen.

...

Firewall
++++++++

* OpnSense auf Basis von FreeBSD
* Squid-Proxy ermöglicht Benutzerbezogene Authentifizierung, z.B. für Internetzugang, Wifizugang, etc.

...

Benutzerverwaltung
------------------

* Session-basierte Berechtigungen für die Unterrichtsteuerung:
* Freiwählbare Gruppen, Speichern als Session, Klassen hinzufügen
* Raumsteuerung nicht mehr so einfach (nur inkl. User)

.. _knownbugs-label:

Bekannte Probleme
-----------------

...

Release-Informationen früherer Versionen
----------------------------------------

* `Release-Information zur linuxmuster.net 6.2 <https://docs.linuxmuster.net/de/v6.2/release-information/index.html>`_
* `Release-Informationen zur linuxmuster.net 5.1, 6.0 und 6.1 <https://www.linuxmuster.net/wiki/dokumentation:handbuch:preparation:features>`_
