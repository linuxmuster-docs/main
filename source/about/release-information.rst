.. Installationsleitfaden documentation master file, created by
   sphinx-quickstart on Sat Nov  7 15:29:20 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
   
.. _release-information-label:

Was ist neu in 7.0?
===================

.. sectionauthor:: `Das Dokuteam <https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_

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
  * Aktuelle Betriebssysteme der Server und der vorkonfigurierten,
    kostenlos bereitgestellten Linux-Arbeitsplätze


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
    ersetzt und ist durch eine moderne Oberfläche auch auf mobilen
    Geräten einsetzbar.
  * Die vollständige Bedienbarkeit auf der Konsole bleibt erhalten
  * Wegfall der PostGREs-Datenbank zugunsten einheitlicher Speicherung
    aller Daten in Samba 4 / Active Directory

Benutzerverwaltung
  * Automatische Erkennung der Kodierung der Benutzerdaten, Sonderzeichen in Klarnamen
  * Klassen- und Projektmanagement bleibt erhalten
  * Zusätzlich Session-basierte Berechtigungen für die Unterrichtsteuerung
    * Gruppen können freiwählbar zusammengestellt werden
    * Benutzerbezogene statt rechnerbezogene Verwaltung

Netzwerkverwaltung
  * Frei definierbare IP-Bereiche
  * Standardmäßige Zugangskontrolle zum Internet über einen Proxyservice
    auf Single-Sign-On Basis statt des überwiegend obsoleten transparenten Proxys
  * Inhaltliche Filterung fällt weg, da technologisch überholt (Belwue-DNS/OpenDNS 
    weiterhin möglich, solange dies technologisch noch Sinn ergibt.)
  * OpnSense auf Basis von FreeBSD vorkonfiguriert ausgeliefert aber
    flexibel durch andere Firewall-Produkte zu ersetzen, die die Regeln im 
    Active Directory des Servers auslesen kann.
      
Was erhalten bleibt
-------------------

* LINBO ist weiterhin das zentrale Softwareverteilungssystem. Die
  größte Modernisierung hat LINBO schon mit der Version 2.3.x in
  linuxmuster.net 6.2 erfahren.

Was es so nicht mehr gibt
-------------------------

- Die Unterrichtssteuerung fällt weg, momentan muss man keinen
  Unterricht starten oder beenden. Stattdessen befinden sich die
  aktuellen Schüler in einem Unterrichtskurs, dessen Zugriff auf
  Internet, WLAN und Drucker gesteuert wird.

- Internet E-Mail-Versand (möglich, aber noch nicht dokumentiert)

- OpenVPN Zugänge für Lehrer und Schüler (eventuell Ersatz durch wireguard, noch nicht abschließend entschieden und von daher auch noch nicht dokumentiert.)

- Druckerquotierung (pykota)


Release-Informationen früherer Versionen
----------------------------------------

* `Release-Information zur linuxmuster.net 6.2 <https://docs.linuxmuster.net/de/v6/release-information/index.html>`_
* `Release-Informationen zur linuxmuster.net 5.1, 6.0 und 6.1 <https://www.linuxmuster.net/wikiarchiv/dokumentation:handbuch:preparation:features>`_

Gefundene und behobene Probleme
-------------------------------

Manche Aktualisierungen erfordern einen manuellen Eingriff, hier werden diese aufgelistet und auf die nötigen Schritte verwiesen:

* LINBO auf v7.0.72: Bearbeite nach dem Update die Datei ``/etc/samba/smb.conf`` und ergänze im Abschnitt `[global]` die Zeilen, so dass folgende Zeilen dabei sind:

.. code:: console

   ...
   rpc_server:spoolss = external
   rpc_daemon:spoolssd = fork
   spoolss:architecture = Windows x64
   printing = cups
   printcap name = cups
   ...
