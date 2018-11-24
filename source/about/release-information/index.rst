.. Installationsleitfaden documentation master file, created by
   sphinx-quickstart on Sat Nov  7 15:29:20 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. _release-information-label:

Was ist neu in 7.0?
===================

.. sectionauthor:: T. Küchel

Linuxmuster.net 7.0 ist in großen Teilen neu geschrieben worden. Es
gibt einen Upgrade-Pfad über eine Migration, da ein reguläres Update
des Basissystems aufgrund der zahlreichen Veränderungen unter der
Haube nicht sinnvoll ist.

Installation
------------

* Standardmäßig werden zur Zwei-Serverlösung mit Firewall und Server
  ein OPSI-Verwaltungsserver und ein Dockerhost integriert
  installiert.
* Die Installation erwartet eine vorkonfigurierte Umgebung, entweder
  in der jeweiligen Virtualisierungslösung oder über ein installiertes
  Ubuntu für den Server.


SELMA
-----

Das zentrale Verwaltungswerkzeug wird ersetzt. SELMA
(Schulnetz-Einstellungen für Lehrer Machbar Angezeigt) ist als moderne
Oberfläche auch auf mobilen Geräten einsetzbar.


LINBO
-----

LINBO ist weiterhin das zentrale Softwareverteilungssystem. Die größte
Modernisierung hat LINBO schon mit der Version 2.3.x in
linuxmuster.net 6.2 erfahren.

Firewall
--------

* OpnSense auf Basis von FreeBSD
* Standardmäßige Zugangskontrolle zum Internet über einen Proxyservice
  auf Single-Sign-On Basis


Benutzerverwaltung
------------------

* Session-basierte Berechtigungen für die Unterrichtsteuerung:
  * Gruppen können freiwählbar zusammengestellt werden
* Automatische Erkennung der Kodierung der Benutzerdaten

.. _knownbugs-label:

Bekannte Probleme
-----------------

...

Release-Informationen früherer Versionen
----------------------------------------

* `Release-Information zur linuxmuster.net 6.2 <https://docs.linuxmuster.net/de/v6.2/release-information/index.html>`_
* `Release-Informationen zur linuxmuster.net 5.1, 6.0 und 6.1 <https://www.linuxmuster.net/wikiarchiv/dokumentation:handbuch:preparation:features>`_
