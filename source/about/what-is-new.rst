.. |_| unicode:: U+202F
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. _`what-is-new-label`:

===================
Was ist neu in 7.3?
===================

.. sectionauthor:: `Das Dokuteam <https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_

Linuxmuster.net 7.3 ist das Release-Update der linuxmuster.net v7.2. Es erfolgt eine Aktualisierung der bisher eingesetzten Ubuntu LTS Version auf die Ubuntu Server LTS Version 24.04. Die Kernpakete der linuxmuster.net Lösung erhalten alle ein Update und stellen viele Verbesserungen und neue Features bereit.

Neue Funktionalitäten
---------------------

Verbesserte Skalierbarkeit
  * Mehrschulfähigkeit: Konsolidierung mehrerer Schulinstanzen auf einem Server möglich
  * Gruppenorientierte Abbildung der Schule und flexible, regelbasierte Steuerung
  * Moderne Bereitstellung zusätzlicher IT-Dienste der Schule innerhalb der Schullösung

Moderne Betriebssystembasis und Steuerung
  * Aktuelle Betriebssysteme für die Server (Ubuntu Server 24.04 LTS) 
  * **Optionale** Firewall OPNsense |reg| ab v25.1
  * Verbesserung der Performance des Samba-Dateiservers durch automatische Verlagerung der Shares auf eine zweite VM, die nur den Dateiserver aufnimmt. Nutzung von DFS als Dateisystem.
  * Mit LINBO > 4.2: aktuellste Linux-Kernels für aktuelle Hardware, differentielle Images, ntfs3 Kernel-Treiber, VNC-Server, mit neuem Namensschema zur einheitlichen Partitionierung
  * Webbasierte Steuerung der pädagogischen Funktionen mit einem **responsive design** (passt sich an alle Bildschirmgrößen und -auflösungen an).
  * WebUI mit vielen neuen administrativen Möglichkeiten wie die Verwaltung von Schulpersonal und Eltern
  * Bereitstellung von linuxmuster - tools, linuxmuster - api und linuxmuster - cli mit erweiterten Möglichkeiten zur Administration und Anbindung externer webbasierter Systeme
  * Benutzerverwaltung sophomorix mit verbesserter Quotierung für Nutzer und Kennworterstellung

Technische Neuerungen
---------------------

Installation
  * linuxmuster.net ist nun eine Drei-Serverlösung. Es wird der linuxmuster-Server (AD/DC, LINBO etc.) sowie der linuxmuster-Dateiserver benötigt. Zudem muss eine zusätzliche Firewall genutzt werden. Dies kann eine bereits bestehende eigene Firewall sein. Optional kann diese Firewall auch als OPNsense genutzt werden. Letztere wird beim Setup miteingebunden. 
  * Es können weitere Server / Docker-Instanzen angebunden werden.
  * Die Installation erwartet eine vorkonfigurierte Virtualisierungslösung (Proxmox - andere sind ebenfalls möglich).

Bedienung und Administration
  * Die WebUI als Verwaltungswerkzeug zur Administration und zur Steuerung von Unterricht weist viele zusätzliche Funktionen auf.
  * Die vollständige Bedienbarkeit auf der Konsole bleibt erhalten.

Benutzerverwaltung
  * Automatische Erkennung der Kodierung der Benutzerdaten, Sonderzeichen in Klarnamen
  * Klassen- und Projektmanagement bleibt erhalten
  * Zusätzliche sitzungsbasierende Berechtigungen für die Unterrichtsteuerung:

    * Gruppen können frei zusammengestellt werden
    * Benutzerbezogene statt rechnerbezogene Verwaltung

Netzwerkverwaltung
  * Frei definierbare IP-Bereiche
  * Standardmäßige Zugangskontrolle zum Internet über einen Proxyservice
    auf Single-Sign-On Basis - anstelle eines transparenten Proxy

Selbstheilende Arbeitsstationen
  * LINBO ist weiterhin das zentrale Softwareverteilungssystem.
  * Weitere Neuerungen in LINBO sind u.a.:

    * Aktuelle Linux-Kernel ab 6.12.* und einem nativen NTFS-Kernel Treiber
    * Neues einheitliches Partitionsschema mit neuem Namenschemata
    * Konsolidierung der Start-Parameter
    * VNC-Server auf den Clients für Remote-Zugriff
    * Inventarisierung der Clients mit hwinfo
    




