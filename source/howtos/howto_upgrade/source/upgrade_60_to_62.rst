Upgrade linuxmuster.net 6.0 auf 6.2 
===================================

Eine direkte Aktualisierung von linuxmuster.net 6.0 (Codename OpbenBleiben) auf linuxmuster.net 6.2 (Codename babo62) ist derzeit nicht vorgesehen bzw. getestet.

.. attention:: !! Bitte Update schrittweise ausführen !!

   Da das direkte Update von 6.0 -> 6.2 noch nicht abschliessend getestet wurde, bitte nur schrittweise 
   von 6.0 -> 6.1 und 6.1 -> 6.2 aktualisieren.

Prinzipiell bleibt bei einem direkten Upgrade von 6.0 -> 6.2 das Vorgehen wie bei einem Upgrade von 6.0 -> 6.1 und 6.1 -> 6.2 anzuwenden. 

Ein Aktualisierung auf die neueste Version wäre auch mithilfe der Migration recht einfach möglich. Dieses Verfashren wird in einem eigenen Howto beschrieben.

Dokumentation der eigenen Firewallregeln 
----------------------------------------

Um linuxmuster.net 6.0 (Codename ObenBleiben) auf linuxmuster.net 6.2 (Codename Babo) zu aktualisieren, ist es erforderlich, die externe Firewall **IPFIRE** auf sog. IP-basierte Reglen umzustellen. Das beschriebe Upgrade erledigt dies. Allerdings sind die selbst definierten und in IPFire eingetragenen Regeln vorab zu dokumentieren, da diese nach dem Upgrade neu in IPFire eingetragen werden müssen.

Screenshots erstellen
---------------------

Die derzeit im IPFire eingetragenen Regeln müssen alle doumentiert werden. Dazu müssen die Regeln / Einstellungen aus den folgenden IPFire-Bereichen erfasst werden:

- Eingehende Firewallregeln

- Ausgehende Firewallregeln

- Eingehender Firewallzugang

- Ausgehender Firewallzugang

- Standardverhalten der Firewall

Zu diesen Bereichen sind sinnvollerweise Screenshots zu erstellen, um so die Regeln erfassen. Diese werden später nach dem Upgrade der Firewall benötigt, um die eigenen Regeln wieder einpflegen zu können.

Als Referenz dient zudem nachstehende Dokumentation des Auslieferungszustands des IPFire.

Auslieferungszustand des IPFire
-------------------------------

.. todo::
    Aktuelle Screenshots des Auslieferungszustands erstellen und anstelle des Textes einfügen.

Webproxy
````````

- Netze GRÜN und BLAU sind transparent aktiviert.
- Cachemanager ist aktiviert.
- URL-Filter ist nicht aktiviert.
- Die Netze GRÜN und BLAU sind als erlaubte Subnetze eingetragen.

DHCP-Server
```````````

- Für Netz BLAU aktiviert.
- IP-Range 172.16.[16xn].1 bis 172.16.[16xn].200 ist vorkonfiguriert.

OpenVPN
```````

- Ist auf ROT und BLAU aktiviert.
- Ein selbstsigniertes Zertifikat ist erstellt.
- OpenVPN ist als Dienst mit der Netzadresse `172.16.18.0/2255.255.255.0` mit dem Protokoll UDP und 
  dem Port 1194 aktiviert. Diese Daten werden auch für alle weiteren Firewallregeln benötigt.
  In den erweiterten Serveroptionen ist Redirect-Gateway `def1` aktivert. Soll bei einer Remote-
  Verbindung der Internet-Zugriff lokal erfolgen, so muss die Option deaktiviert werden.

Zeitserver
``````````

Unter `Dienste|Zeitserver` sind folgende Optionen aktiviert

- Uhrzeit von einem Netzwerk Zeitserver ermitteln.
- Uhrzeit dem lokalen Netzwerk zur Verfügung stellen.
- Erzwinge das Setzen der Systemzeit im Bootvorgang.

Firewall
--------

Firewallregeln
``````````````

Wenn man eine Portweiterleitung aus dem Internet benötigt z.B. HTTP/80 oder HTTPS/443, so muss dazu AUSSCHLIESSLICH die Regel unter [Firewallregeln] durch setzen des Häkchens aktiviert werden, sofern das Häkchen noch nicht gesetzt ist.

Es sind acht Firewallregeln vordefiniert (im Menü unter Firewall|Firewallregeln):

Eingehend (Portforwarding):
```````````````````````````

- Eingehender TCP-Port 2222 wird auf Port 22 der Server-IP weitergeleitet (SSH), aktiv.
- Eingehender TCP-Port 25 wird auf Port 25 der Server-IP weitergeleitet (SMTP), nicht aktiv.
- Eingehender TCP-Port 443 wird auf Port 443 der Server-IP weitergeleitet (HTTPS), nicht aktiv.
- Eingehender TCP-Port 636 wird auf Port 636 der Server-IP weitergeleitet (LDAPS), nicht aktiv.

Ausgehend:
``````````

- Server darf auf allen Ports raus, aktiv.
- Rechnergruppe allowedhosts darf auf Ports raus, die in der Dienstgruppe allowedports definiert 
  sind, aktiv (wird für Internetsperre genutzt).
- Netzwerkgruppe allowednetworks darf auf Ports raus, die in der Dienstgruppe allowedports 
  definiert sind, aktiv (wird für Internetsperre genutzt, wenn bei aktiviertem Subnetting für 
  Subnetze Internetzugriff zugelassen wurde).

Firewallregeln
--------------

.. image:: media/upgrade_60_to_61/fw_rules.png
   :alt: Firewallregeln
   :align: center

Eingehender Firewallzugang
--------------------------

Hier sind nur die Regeln einzutragen, die dazu führen, dass man vom Internet auf den IPFire selbst zugreifen kann - also sollte hier außer dem Port 1194 GARNICHTS stehen.
Alles andere wäre ein Sicherheitsrisiko 
**Hinweis:** Administration des IPFire von zu Hause aus über einen OpenVPN-Tunnel oder über eine Portweiterleitung per ssh möglich. 

.. image:: media/upgrade_60_to_61/fw_rules_incoming_access.png
   :alt: Eingehender Firewallzugang
   :align: center

Werden Regeln nicht benötigt, so können diese einfach deaktiviert werden. In obiger Abbildung ist z.B. sowohl für den Zugriff via UDP als auch via TCP auf Port 1194 eine Regel eingetragen. Sollte nur UDP verwendet werden, so könnte diese für TCP gelöscht oder deaktiviert werden.


Ausgehender Firewallzugang
--------------------------

Firewallgruppen
```````````````

Unter

- Hosts
- Netzwerk-/Hostgruppen
- Dienstgruppen

sind drei Firewallgruppen vordefiniert (im Menü unter Firewall|Firewallgruppen). 

.. image:: media/upgrade_60_to_61/fw_rules_groups.png
   :alt: Firewallgruppen
   :align: center

Zu den Konfigurationsseiten der Firewallgruppen gelangt man über die entsprechende Schaltfläche.

Hosts
`````

Hier sind alle Hosts des Systems mit ihrer MAC-Adresse eingetragen. Der Workstationsimport auf dem Server aktualisiert diese Liste. Eigene Einträge sind hier nicht vorgesehen.

Hostgruppen
```````````

Die Hostgruppe allowedhosts ist vordefiniert und wird vom System verwaltet. Die Internetsperre trägt die IP-Adresse freigeschalteter Hosts in diese Gruppe ein. Eigene Hostgruppen können hinzugefügt und selbst verwaltet werden. Die allowedhosts-Gruppe sollte nicht geändert werden, da sie bei jeder Änderung der Internetsperre neu geschrieben wird.
Dienstgruppen

Es ist eine Dienstgruppe allowedports vordefiniert, die für die Internetsperre genutzt wird. Sie enthält zusätzliche Ports (Port 80 wird vom Webproxy verwaltet), die für freigeschaltete Hosts (Hostgruppe allowedhosts und ggf. Netzwerkgruppe allowednetworks) geöffnet sind. 

.. image:: media/upgrade_60_to_61/fw_rules_services.png
   :alt: Dienstgruppen
   :align: center

Im Auslieferungszustand sind die Ports für die Dienste SSH, HTTPS, FTP und FTPS für freigeschaltete Hosts zugelassen. Falls weitere Ports zugelassen werden sollen, müssen sie in dieser Gruppe ergänzt werden.

Netzwerkgruppen bei aktiviertem Subnetting
``````````````````````````````````````````

Bei aktiviertem Subnetting werden automatisch alle definierten Subnetze unter **Firewall|Firewallgruppen|Netzwerke** aufgelistet. 

Beispiel: 

.. image:: media/upgrade_60_to_61/fw_rules_groups_net.png
   :alt: Netzwerke
   :align: center

Subnetze, für die in der Datei /etc/linuxmuster/subnets auf dem Server Internetzugriff freigeschaltet wurde, werden automatisch in die Netzwerkgruppe allowednetworks eingetragen. Subnetze in dieser Gruppe erhalten Internetzugriff über den Webproxy und zusätzlich über die Ports, die in der Dienstgruppe allowedports definiert sind. 

Beispiel: 

.. image:: media/upgrade_60_to_61/fw_rules_allowed_networks.png
   :alt: Zugelassene Netzwerke
   :align: center

Standardverhalten der Firewall
``````````````````````````````

Das Standardverhalten der Firewall ist im Auslieferungszustand so eingestellt, dass ausgehende und eingehende Verbindungen blockiert werden, wenn keine entsprechenden Allow-Regeln definiert sind (im Menü unter **Firewall|Firewalloptionen**). 

.. image:: media/upgrade_60_to_61/fw_rules_standards.png
   :alt: Standardverhalten der Firewall
   :align: center

Es wird dringend empfohlen diese Einstellungen zum Standardverhalten beizubehalten.

Paketquellen anpassen
---------------------

Zum Upgrade auf linuxmuster.net 6.2 (Codename Babo62) muss das entsprechende Repositorium eingebunden werden. 

Dies sollte in einer Datei erfolgen:

.. code:: bash

    /etc/apt/sources.list.d/linuxmuster.net.list

In dieser Datei sind folgende Paketquellen anzugeben:

.. code:: bash

    deb http://pkg.linuxmuster.net/ babo62/
    deb-src http://pkg.linuxmuster.net/ babo62/

Bestehende Zeilen, die auf das precise-Repositorium verweisen, ebenso alte Quellendateien, die auf precise-Repositorien verweisen, sollten auskommentiert oder gelöscht bzw. verschoben werden.

.. code:: bash

    deb http://pkg.linuxmuster.net/ precise/
    deb-src http://pkg.linuxmuster.net/ precise/ 

.. attention:: Paketquellen überprüfen

   Stellen Sie sicher, dass keine weitere Datei im Verzeichnis ``/etc/apt/sources.list.d/`` oder die Datei ``/etc/apt/sources.list`` Repositorien von ``pkg.linuxmuster.net`` enthält.

Dist-Upgarde durchführen
------------------------

Nachdem die Paketquellen in einer Datei für Apt eingetragen wurden, prüfen Sie vor dem weiteren Upgrade, ob im IPFire auf der **Webproxy-Seite noch MAC-Adressen in der Sperrliste** eingetragen sind.
Sind hier MAC-Adressen noch eingetragen mpssen Sie diese löschen und diese Änderungen mit der Schaltfläche **Speichern und Neustart** übernehmen.

Danach können nun die Paketquellen aktualisiert und die Pakete selbst aktualisiert werden.

Dazu sind auf der Eingabekonsole als Benutzer root folgende Befehle einzugeben:

.. code:: bash

    apt-get update
    apt-get dist-upgrade

    Paketaktualisierung (Upgrade) wird berechnet...Fertig
    Die folgenden Pakete werden ENTFERNT:
       tftpd-hpa
    Die folgenden NEUEN Pakete werden installiert:
      atftpd ipcalc
    Die folgenden Pakete werden aktualisiert (Upgrade):
      linuxmuster-base linuxmuster-ipfire linuxmuster-linbo linuxmuster-migration
      sophomorix-base sophomorix-doc-html sophomorix-pgldap sophomorix2

Sollte die Paketaktualisierung verletzte Abhängigkeiten für tftpd-hpa melden, so installieren Sie zunächst gezielt atftpd oder installieren Sie das deinstallierte linuxmuster-linbo nach dem upgrade neu.

.. attention:: Aktuelle Konfiguration beibehalten

    Wählen Sie immer aus, dass die aktuelle Konfiguration beibehalten werden soll. Dies entspricht auch 
    der Voreinstellung, die Sie mit ENTER bestätigen können.

Externe Firewall umstellen
--------------------------

Im Zuge der Aktualisierung wird die interne und externe Firewall auf IP-basierte Regeln umgestellt. Damit dies sicher und erfolgreich abgeschlossen werden kann, ist hier nochmal ein weiterer Eingriff nötig. Nachdem das Distributions-Upgrade durchgelaufen ist, setzen Sie die externe Firewall mit dem Befehl 

.. code:: bash

    linuxmuster-ipfire --setup

einmal in den Auslieferungszustand zurück.

Starten Sie die Firewall neu und warten Sie, bis diese vollständig neu gestartet ist.

Beachten Sie, dass Sie eigene Regeln und Portweiterleitungen danach wieder einpflegen und aktivieren müssen.

Import der Workstationsdurchführen
----------------------------------

Beim durchgeführten Upgrade wurde auch eine neue Version des Pakets linuxmuster-linbo eingespielt. Diese neue Version von Linbo erfordert es, dass zur Aktivierung zu Beginn ein einmaliger Import der Workstations ausgeführt wird.

Führen Sie hierzu folgenden Befehl aus:

.. code:: bash

    import_workstations

Das Skript prüft die angegebenen Eintragungen in der Datei ``/etc/linuxmuster/workstations``. Sind diese korrekt wird der Import ausgeführt. Wurde das Skript erfolgreich abgearbeitet, wird dies mit einem entsprechenden Hinweis quittiert.

Clients mit lokalem Linbo-Boot aktualisieren
--------------------------------------------

Sollten sich in Ihrem Netzwerk neben den Clients, die via PXE-Netwerk-Boot starten, auch solche befinden, die Linbo nur lokal starten, müssen Sie nachstehende Schritte ausführen, um für diese Clients das lokale Linbo zu aktualisieren.

1. Schalten Sie die betreffenden Rechner ein und lassen Sie sie mit LAN-Verbindung in die Linbo-
   Oberfläche booten.

2. Schicken Sie dann auf der Serverkonsole den linbo-remote-Befehl zur Cache-Initialisierung ab:

.. code:: bash

    linbo-remote -c initcache,reboot -g <rechnergruppe>

3. Nach dem Neustart steht das nun aktualisierte Linbo lokal auf den Clients zur Verfügung.

Tausch- und Vorlagenordner umstellen
------------------------------------

Die Tausch- und Vorlagenordner der Klassen/Projekte und des aktuellen Raums müssen ab linuxmuster.net 6.1 von den bisherigen sog. `bind-mounts` auf verlinkte `shares` umgestellt werden. 

Homeverzeichnisse bereinigen
----------------------------

Dazu ist es zunächst erforderlich die Verzeichnisse 

.. code:: bash

   __tauschen
   __vorlagen 

in jedem Benutzerverzeichnis zu entfernen. 

Dies kann man mit folgenden Befehlen für alle Benutzer oder gezielt für einzelne Benutzer erledigt werden: 

.. code:: bash

   sophomorix-repair --repairhome
   sophomorix-repair --repairhome -u user

.. attention:: Achtung

   Es ist notwendig, dass die Benutzer nicht am System angemeldet sind, sonst können die in Benutzung 
   befindlichen Links nicht entfernt werden. 

Bind-mounts abschalten
----------------------

Die Verwendung der bind-mounts auf dem Server sind händisch abzuschalten. Dies wurde so vorgesehen, damit ein Parallelbetrieb als Übergang genutzt werden kann. 

Dazu in den Dateien

.. code:: bash

    /etc/linuxmuster/samba/root-preexec.d/sophomorix-root-preexec
    /etc/linuxmuster/samba/root-postexec.d/sophomorix-root-postexec 

die Einträge **sophomorix-bind** durch voranstellen eines **#** auskommentieren. 

Damit werden die bind-mounts bei der Benutzeran- bzw. abmeldung nicht mehr angelegt bzw. entfernt.

Da es möglich ist, dass zum Umstellungszeitpunkt Bind-mounts gesetzt waren, sollten diese entfernt werde mit:

.. code:: bash

    sophomorix-bind --cron

Dateirechte umstellen
---------------------

Mit dem Upgrade von 6.0 auf 6.1 müssen auch noch die Dateirechte/Eigentümer von schon erstellten Verzeichnissen in den Tauschordnern angepasst werden.

Dies geschieht durch Aufruf von: 

.. code:: bash

    sophomorix-repair --permissions


