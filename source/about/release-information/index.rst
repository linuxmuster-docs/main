.. Installationsleitfaden documentation master file, created by
   sphinx-quickstart on Sat Nov  7 15:29:20 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
   
.. _release-information-label:

Was ist neu in 7.0?
===================

.. sectionauthor:: Dokuteam

Linuxmuster.net 7.0 ist in großen Teilen neu geschrieben worden. Es
gibt einen Upgrade-Pfad über eine Migration, da ein reguläres Update
des Basissystems aufgrund der zahlreichen Veränderungen unter der
Haube nicht sinnvoll ist.

Neue Funktionalitäten
---------------------

Verbesserte Skalierbarkeit
  * Mehrschulfähigkeit: Konsolidierung mehrerer Schulinstanzen auf einem
    Server möglich
  * Gruppenorientierte Abbildung der Schule und flexible, regelbasierte
    Steuerung
  * Moderne Bereitstellung zusätzlicher IT-Dienste der Schule innerhalb der
    Schullösung

Moderne Steuerung
  * Webbasierte Steuerung der pädagogischen Funktionen in responsive Design
  * Aktuelle Betriebssysteme der Server und der vorkonfiguierten,
    kostenlos bereitgestellten Linux-Arbeitsplätzen


Technische Neuerungen
---------------------
  
Vereinfachte Installation
  * Standardmäßig bleibt linuxmuster.net eine Zwei-Serverlösung aus
    Firewall und Server. Optional sind ein OPSI-Verwaltungsserver und
    ein Dockerhost vorkonfiguriert installierbar.
  * Die Installation erwartet eine vorkonfigurierte Umgebung, entweder
    in der jeweiligen Virtualisierungslösung oder über ein installiertes
    Ubuntu für den Server.

Bedienung und Administration
  * Das zentrale Verwaltungswerkzeug (Schulkonsole) wird
    ersetzt. SELMA (Digitale Schulnetz-Einstellungen für Lehrer
    Machbar Angezeigt) ist als moderne Oberfläche auch auf mobilen
    Geräten einsetzbar.
  * Die vollständige Bedienbarkeit auf der Konsole bleibt erhalten
  * Wegfall der PostGREs-Datenbank zugunsten einheitlicher Speicherung
    aller Daten in Samba 4 / Active Directory


Benutzerverwaltung
  * Automatische Erkennung der Kodierung der Benutzerdaten
  * Session-basierte Berechtigungen für die Unterrichtsteuerung

    * Gruppen können freiwählbar zusammengestellt werden
    * Benutzerbezogene statt rechnerbezogene Verwaltung

Netzwerkverwaltung
  * Frei definierbar IP-Bereiche
  * Standardmäßige Zugangskontrolle zum Internet über einen Proxyservice
    auf Single-Sign-On Basis 
  * OpnSense auf Basis von FreeBSD vorkonfiguriert ausgeliefert aber
    flexibel mit anderen Firewall-Produkten einsetzbar
      
Was erhalten bleibt
-------------------

* LINBO ist weiterhin das zentrale Softwareverteilungssystem. Die
  größte Modernisierung hat LINBO schon mit der Version 2.3.x in
  linuxmuster.net 6.2 erfahren.




  

.. _knownbugs-label:

Bekannte Probleme
-----------------

...

Release-Informationen früherer Versionen
----------------------------------------

* `Release-Information zur linuxmuster.net 6.2 <https://docs.linuxmuster.net/de/v6.2/release-information/index.html>`_
* `Release-Informationen zur linuxmuster.net 5.1, 6.0 und 6.1 <https://www.linuxmuster.net/wikiarchiv/dokumentation:handbuch:preparation:features>`_
