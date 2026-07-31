.. include:: /guided-inst.subst
.. _`what-is-new-label`:

===================
Was ist neu in 7.4?
===================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

Linuxmuster.net 7.4 ist das Release-Update der linuxmuster.net v7.3. Es erfolgt eine Aktualisierung der bisher eingesetzten Ubuntu LTS Version 24.04 auf die Ubuntu Server LTS Version 26.04. Die Kernpakete der linuxmuster.net Lösung erhalten alle ein Update und stellen viele Verbesserungen und neue Features bereit.


Neuerungen
----------

Version 7.4 ist eine umfangreiche Wartungs- und Refactoring-Version. Der gesamte Python-Code wurde auf die Debian Python Policy (PEP 517/518) umgestellt, kritische Sicherheitslücken wurden geschlossen und die OPNsense |reg| - Anbindung wurde auf die REST-API migriert. Daneben wurden zahlreiche Fehler behoben und Sicherheitsverbesserungen eingeführt.


**Neue Python-Paketstruktur (Debian Python Policy)**

Der gesamte Python-Code wurde in ein reguläres Python-Paket überführt und folgt nun der Debian Python Policy:

   - Neues Paket-Layout unter src/linuxmuster_base7/ mit den Untermodulen cli/ und setup/
   - Alle CLI-Werkzeuge sind jetzt reguläre Python-Module im Paket pyproject.toml (PEP 621) als zentrale Projektkonfiguration.
   - Die alten monolithischen Skripte unter sbin/ und lib/ wurden entfernt
   - Alle Skripte werden nun nach /usr/sbin/ statt /usr/bin/ installiert

**Sicherheitsfixes**

Mehrere kritische Sicherheitslücken wurden geschlossen:

  -  Shell-Injection in SSH-Funktionen beseitigt.
  -  Passwort-Leak in opnsense_reset.py behoben.
  -  Shell-Injection in catFiles() behoben.
  -  Alle verbleibenden os.popen()-, os.system()- und subProc()-Aufrufe wurden durch sicheres subprocess.run() ersetzt.

**OPNsense-Anbindung auf REST-API migriert**

import_subnets.py verwaltet statische Routen in der OPNsense-Firewall jetzt ausschließlich über die REST-API (HTTP/HTTPS) statt über SSH-Kommandos. Dadurch entfällt die Abhängigkeit von SSH-Zugangsdaten für diese Operation und die Anbindung ist robuster und besser zu warten.

**Verbesserter Ablauf bei linuxmuster-import-devices**

Vor dem eigentlichen ``sophomorix-device --sync`` wird jetzt zwingend ``sophomorix-device --dry-run`` ausgeführt. Nur wenn der dry-run fehlerfrei durchläuft, wird mit dem Sync fortgefahren. Schlägt der dry-run fehl, bricht das Skript mit einer Fehlermeldung ab.

**Setup-Verbesserungen**

    - Hostname-Änderungen werden bei der Samba-Provisionierung jetzt korrekt übernommen (bisher wurde ein geänderter Hostname ignoriert)
    - isc-dhcp-server6.service wird während des Setups deaktiviert, um Konflikte zu vermeiden.
    - Keytab-Erstellung wird übersprungen, wenn das Firewall-Setup deaktiviert ist (skipfw = True)
    - NTP wird nur dann deaktiviert, wenn es tatsächlich aktiv ist.
    - Versionsnummer in der Setup-Dialoganzeige korrigiert.

**LINBO - Neuerungen**

    - Komplette Überarbeitung des Build-Systems
    - Refaktorierung der Kernel-Bereitstellung
    - Ersatz von ctorrent durch aria2c
    - Aufräumen und Entfernen veralteter Komponenten
    - Natives Windows-Treiberprofil-Management
    - Weitere Fehlerbehebungen und Verbesserungen

Funktionalitäten
----------------

Skalierbarkeit
  * Mehrschulfähigkeit: Konsolidierung mehrerer Schulinstanzen möglich
  * Gruppenorientierte Abbildung der Schule und flexible, regelbasierte Steuerung
  * Moderne Bereitstellung zusätzlicher IT-Dienste der Schule innerhalb der Schullösung

Moderne Betriebssystembasis und Steuerung
  * Aktuelle Betriebssysteme für die Server (Ubuntu Server 26.04 LTS)
  * **Optionale** Firewall OPNsense |reg| ab v26.1
  * Verbesserung der Performance des Samba-Dateiservers durch automatische Verlagerung der Shares auf eine zweite VM, die nur den Dateiserver aufnimmt. Nutzung von DFS als Dateisystem.
  * Mit LINBO 7.4: aktuelle Linux-Kernels für aktuelle Hardware, differentielle Images, ntfs3 Kernel-Treiber, VNC-Server, mit neuem Namensschema zur einheitlichen Partitionierung
  * Webbasierte Steuerung der pädagogischen Funktionen mit einem **responsive design** (passt sich an alle Bildschirmgrößen und -auflösungen an).
  * WebUI mit vielen neuen administrativen Möglichkeiten wie die Verwaltung von Schulpersonal und Eltern
  * Bereitstellung von linuxmuster-tools, linuxmuster-api und linuxmuster-cli mit erweiterten Möglichkeiten zur Administration und Anbindung externer webbasierter Systeme
  * Benutzerverwaltung sophomorix mit verbesserter Quotierung für Nutzer sowie flexibleren Möglichkeiten zur Erstellung von Kennwörtern für Benutzer

Technische Neuerungen
---------------------

Installation
  * linuxmuster.net ist eine Drei-Serverlösung. Es wird der linuxmuster-Server (für AD/DC, LINBO, Benutzerverwaltung etc.) sowie der linuxmuster-Dateiserver benötigt. Zudem muss eine zusätzliche Firewall genutzt werden. Dies kann eine bereits bestehende eigene Firewall sein. Optional kann diese Firewall auch als OPNsense genutzt werden. Letztere wird beim Setup direkt eingebunden. 
  * Es können weitere Server / Docker-Instanzen angebunden werden.
  * Die Installation erwartet eine vorkonfigurierte Virtualisierungslösung (Proxmox - andere sind ebenfalls möglich).

Bedienung und Administration
  * Die WebUI als Verwaltungswerkzeug zur Administration und zur Steuerung von Unterricht weist viele zusätzliche Funktionen auf (z.B. Verwaltung von Eltern und VPN via Wireguard).
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
  * LINBO ist das zentrale Softwareverteilungssystem.
  * Weitere Neuerungen in LINBO sind u.a.:

    * Aktuelle Linux-Kernel und einem nativen NTFS-Kernel Treiber
    * Neues einheitliches Partitionsschema mit neuem Namensschema
    * Konsolidierung der Start-Parameter
    * VNC-Server auf den Clients für Remote-Zugriff
    * Inventarisierung der Clients mit hwinfo
    * Verbesserungen bei der Software-Verteilung mit Torrent
    




