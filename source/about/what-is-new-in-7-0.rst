.. _`what-is-new-label`:

===================
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
  * OPNsense® auf Basis von FreeBSD vorkonfiguriert ausgeliefert aber
    flexibel durch andere Firewall-Produkte zu ersetzen, die die Regeln im 
    Active Directory des Servers auslesen kann.
 
Selbstheilende Arbeitsstationen
  * LINBO ist weiterhin das zentrale Softwareverteilungssystem. Die
    größte Modernisierung hat LINBO schon mit der Version 2.3.x in
    linuxmuster.net 6.2 erfahren.

Was es so nicht mehr gibt
-------------------------

- Die Unterrichtssteuerung fällt weg, momentan muss man keinen
  Unterricht starten oder beenden. Stattdessen befinden sich die
  aktuellen Schüler in einem Unterrichtskurs, dessen Zugriff auf
  Internet, WLAN und Drucker gesteuert wird.

- Druckerquotierung (pykota)

- Interner E-Mail-Versand (möglich, aber noch nicht dokumentiert)

- OpenVPN Zugänge für Lehrer und Schüler (eventuell Ersatz durch wireguard, noch nicht abschließend entschieden und von daher auch noch nicht dokumentiert.)


