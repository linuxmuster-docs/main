.. _`what-is-new-label`:

===================
Was ist neu in 7.1?
===================

.. sectionauthor:: `Das Dokuteam <https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_

Linuxmuster.net 7.1 ist das Release-Update der linuxmuster.net v7.0. Es erfolgt auf Basis der bislang eingesetzten Ubuntu LTS Version ein Update der Kernpakete der linuxmuster.net Lösung, die neue Features bereitstellt.

Neue Funktionalitäten
---------------------

.. todo::
   
   to be rewritten

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
    Firewall und Server. Optional können weitere Server / Docker-Instanzen angebunden werden.
  * Die Installation erwartet eine vorkonfigurierte Virtualisierungslösung oder kann auf direkt auf zwei Hardware-Maschinen installiert werden.

Bedienung und Administration
  * Die WebUI als Verwaltungswerkzeug zur Administration und zur Steuerung von Unterricht weist viele zusätzliche Funktionen auf.
  * Die vollständige Bedienbarkeit auf der Konsole bleibt erhalten

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

Selbstheilende Arbeitsstationen
  * LINBO ist weiterhin das zentrale Softwareverteilungssystem.
  * Es erfolgt ein Major Release Update auf LINBO 4.

    * Umstellung der Images-Abbilder auf das qcow2 Format
    * Neues User-Interface für die Steuerung an den Clients 

Hinweise
--------

.. hint::

   * Release-Informationen werden im Forum im Thread `Neue Pakete für lmn7.1 <https://ask.linuxmuster.net/t/linuxmuster-net-7-1-testing/8265/7>`_ veröffentlicht.


