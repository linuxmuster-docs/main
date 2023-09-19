.. _`what-is-new-label`:

===================
Was ist neu in 7.2?
===================

.. sectionauthor:: `Das Dokuteam <https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_

Linuxmuster.net 7.2 ist das Release-Update der linuxmuster.net v7.1. Es erfolgt eine Aktualisierung der bisher eingesetzten Ubuntu LTS Version auf die derzeit aktuellste Ubuntu Server LTS Version. Die Kernpakete der linuxmuster.net Lösung erhalten alle ein Update und stellen viele Verbesserungen und neue Features bereit.

Neue Funktionalitäten
---------------------

Verbesserte Skalierbarkeit
  * Mehrschulfähigkeit: Konsolidierung mehrerer Schulinstanzen auf einem Server möglich
  * Gruppenorientierte Abbildung der Schule und flexible, regelbasierte Steuerung
  * Moderne Bereitstellung zusätzlicher IT-Dienste der Schule innerhalb der Schullösung

Moderne Steuerung
  * Webbasierte Steuerung der pädagogischen Funktionen mit einem sog. responsive design
  * Aktuelle Betriebssysteme der Server und der vorkonfigurierten, kostenlos bereitgestellten Linux-Arbeitsplätze
  * Mit LINBO 4: Neues User-Interface für die Steuerung an den Clients
  * WebUI mit vielen administrativen Möglichkeiten, die zuvor nur an der Server-Konsole zu erreichen waren.

Technische Neuerungen
---------------------

Vereinfachte Installation
  * Standardmäßig bleibt linuxmuster.net eine Zwei-Serverlösung aus Firewall und Server. Optional können weitere Server / Docker-Instanzen angebunden werden.
  * Die Installation erwartet eine vorkonfigurierte Virtualisierungslösung oder kann direkt auf zwei Hardware-Maschinen installiert werden.

Bedienung und Administration
  * Die WebUI als Verwaltungswerkzeug zur Administration und zur Steuerung von Unterricht weist viele zusätzliche Funktionen auf.
  * Die vollständige Bedienbarkeit auf der Konsole bleibt erhalten.

Benutzerverwaltung
  * Automatische Erkennung der Kodierung der Benutzerdaten, Sonderzeichen in Klarnamen
  * Klassen- und Projektmanagement bleibt erhalten
  * Zusätzlich Session-basierte Berechtigungen für die Unterrichtsteuerung

    * Gruppen können freiwählbar zusammengestellt werden
    * Benutzerbezogene statt rechnerbezogene Verwaltung

Netzwerkverwaltung
  * Frei definierbare IP-Bereiche
  * Standardmäßige Zugangskontrolle zum Internet über einen Proxyservice
    auf Single-Sign-On Basis - anselle eines transparenten Proxys

Selbstheilende Arbeitsstationen
  * LINBO ist weiterhin das zentrale Softwareverteilungssystem.
  * Es erfolgt ein Major Release Update auf LINBO 4.

    * Umstellung der Images-Abbilder auf das qcow2 Format
    * Neues User-Interface für die Steuerung an den Clients




