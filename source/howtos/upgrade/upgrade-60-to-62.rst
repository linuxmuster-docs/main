Upgrade von 6.0
===============

Ein schrittweises Upgrade 6.0 -> 6.1 -> 6.2 ist nicht nötig.  Neben
dem hier beschriebenen direkten Upgradepfad 6.0 (Codename ObenBleiben) auf  6.2 (Codename Babo62), ist auch eine
Aktualisierung mithilfe der Migration möglich.

Lesen der Release-Informationen
-------------------------------

Lesen Sie die Informationen zu :ref:`release-information-label`, speziell, welche :ref:`Fehler bekannt sind<knownbugs-label>`.


Dokumentation der eigenen Firewallregeln 
----------------------------------------

Im Zuge der Aktualisierung wird die interne und externe Firewall auf
IP-basierte Regeln umgestellt.  Daher ist es notwendig alle selbst
definierten und in IPFire eingetragenen Regeln vorab zu
dokumentieren. Diese müssen nach dem Upgrade neu in IPFire eingetragen
werden.

Screenshots erstellen
_____________________

Die Regeln / Einstellungen aus den folgenden IPFire-Bereichen müssen dokumentiert werden:

- Eingehende Firewallregeln

- Ausgehende Firewallregeln

- Eingehender Firewallzugang

- Ausgehender Firewallzugang

- Standardverhalten der Firewall

Zu diesen Bereichen sind sinnvollerweise Screenshots zu erstellen, um
so die Regeln erfassen.  Die eigenen Regeln ergeben sich im Vergleich
mit dem `Auslieferungszustand
<https://www.linuxmuster.net/wiki/dokumentation:techsheets:ipfire.defaultconfig>`_
des IPFire.  Nach dem Upgrade der Firewall müssen die eigenen Regeln
wieder eingepflegt werden.

Sperrliste löschen
__________________

Prüfen Sie, ob im IPFire auf der **Webproxy-Seite** noch MAC-Adressen
in der Sperrliste eingetragen sind.  Sind hier MAC-Adressen noch
eingetragen, müssen Sie diese löschen und diese Änderungen mit der
Schaltfläche **Speichern und Neustart** übernehmen.

Paketquellen anpassen
---------------------

Zum Upgrade auf linuxmuster.net 6.2 (Codename Babo62) muss das entsprechende Repositorium eingebunden werden. 

In der Datei ``/etc/apt/sources.list.d/linuxmuster-net.list`` sind folgende Paketquellen anzugeben:

.. code::

   deb http://pkg.linuxmuster.net/ babo/
   deb-src http://pkg.linuxmuster.net/ babo/
   deb http://pkg.linuxmuster.net/ babo62/
   deb-src http://pkg.linuxmuster.net/ babo62/


Bestehende Zeilen, die auf das precise-Repositorium verweisen, ebenso alte Quellendateien, die auf precise-Repositorien verweisen, sollten auskommentiert oder gelöscht bzw. verschoben werden.

.. code:: bash

    # deb http://pkg.linuxmuster.net/ precise/
    # deb-src http://pkg.linuxmuster.net/ precise/ 

.. attention:: Paketquellen überprüfen

   Stellen Sie sicher, dass keine weitere Datei im Verzeichnis ``/etc/apt/sources.list.d/`` oder die Datei ``/etc/apt/sources.list`` Repositorien von ``pkg.linuxmuster.net`` enthält.


Dist-upgrade durchführen
------------------------

Nachdem die Paketquellen in der genannten Datei für apt eingetragen wurden, können Sie nun die Paketquellen aktualisieren und die Pakete selbst aktualisieren.

Dazu sind auf der Eingabekonsole als Benutzer root folgende Befehle einzugeben:

.. code-block:: console

   # apt-get update
   # apt-get dist-upgrade
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

Nachdem das Distributions-Upgrade durchgelaufen ist, setzen Sie die externe Firewall mit dem Befehl 

.. code-block:: console

   # linuxmuster-ipfire --setup

einmal in den Auslieferungszustand zurück.  Starten Sie die Firewall
neu und warten Sie, bis diese vollständig neu gestartet ist.

Ab jetzt können Sie die vorher dokumentierten eigenen Regeln und
Portweiterleitungen wieder einpflegen und aktivieren.

Import der Workstations durchführen
-----------------------------------

Beim durchgeführten Upgrade wurde auch eine neue Version des Pakets
linuxmuster-linbo eingespielt. Diese neue Version von Linbo erfordert
es, dass zur Aktivierung zu Beginn ein einmaliger Import der
Workstations ausgeführt wird. Auf diese Weise werden die notwendigen
Konfigurationsdateien erstellt.  Führen Sie hierzu folgenden Befehl
aus:

.. code-block:: console

   # import_workstations

Das Skript prüft die angegebenen Eintragungen in der Datei ``/etc/linuxmuster/workstations``. Sind diese korrekt wird der Import ausgeführt. Wurde das Skript erfolgreich abgearbeitet, wird dies mit einem entsprechenden Hinweis quittiert.

Clients mit neuem Linbo booten
------------------------------

.. note:: Ab Linbo 2.3 ist es zwingend notwendig, im BIOS auch die Festplatte als Bootmedium einzustellen.

Um sicherzustellen, dass das neue LINBO-System auch lokal auf den
Clients installiert wird, erzwingt man eine Aktualisierung des Caches
und einen Reboot.

Folgender Befehl auf der Serverkonsole sorgt dafür, dass beim nächsten
Bootvorgang per PXE der Cache initialisiert wird (und rebootet wird):

.. code-block:: console

   # linbo-remote -p initcache,reboot [-i <hostname>|-g <group>|-r <room>]

Sollten sich in Ihrem Netzwerk neben den Clients, die via
PXE-Netwerk-Boot starten, auch solche befinden, die Linbo nur lokal
starten, schalten Sie die betreffenden Rechner ein und lassen Sie
diese mit LAN-Verbindung in die Linbo-Oberfläche booten.  Über die
Konfigurationseinstellung ``AutoInitCache = yes`` in der zugehörigen
``start.conf`` erzwingt man die Cache-Initialisierung auch bei diesen
Clients.

.. note:: Nach dem Upgrade sollten alle Clients wie gewohnt weiter
   funktionieren. Die Bildschirmausgabe beim Bootvorgang ist leicht
   verändert und vor dem Betriebssystemstart aus der Linbo-Oberfläche
   heraus wird nun immer ein Neustart initiiert (Der sogenannte
   *reboot-Workaround* wird nun immer verwendet.)

Fehlerbehebung mit einem USB-Stick
__________________________________

Wenn ein Arbeitsplatz mit der Fehlermeldung "Kernel panic" hängt oder
in Schleifen immer wieder rebootet, kann ein Neuanfang über einen
USB-Stick oder CD/DVD initiiert werden.

Laden Sie dazu die die Datei ``linbo.iso`` von ihrem Server herunter (z.B. über `<http://10.16.1.1/linbo.iso>`_)
und brennen Sie diese auf CD/DVD oder kopieren diese auf einen
USB-Stick, z.B. mit Hilfe des Befehls

.. code-block:: console

   # dd if=linbo.iso of=/dev/sdb

wobei ``/dev/sdb`` der Schnittstellenname ihres USB-Sticks sein muss.

Tausch- und Vorlagenordner umstellen
------------------------------------

Die Tausch- und Vorlagenordner der Klassen/Projekte und des aktuellen
Raums müssen ab linuxmuster.net 6.1 von den bisherigen
so genannten `bind-mounts` auf verlinkte `shares` umgestellt werden.

Homeverzeichnisse bereinigen
____________________________

Dazu ist es zunächst erforderlich die Verzeichnisse 

.. code:: bash

   __tauschen
   __vorlagen 

in jedem Benutzerverzeichnis zu entfernen. Dies kann man mit folgenden
Befehlen für alle Benutzer oder gezielt für einzelne Benutzer erledigt
werden:

.. code-block:: console

   # sophomorix-repair --repairhome
   # sophomorix-repair --repairhome -u user

.. attention:: 
   Es ist notwendig, dass die Benutzer nicht am System angemeldet sind, sonst können die in Benutzung 
   befindlichen Links nicht entfernt werden. 

Bind-mounts abschalten
______________________

Die Verwendung der bind-mounts auf dem Server sind händisch abzuschalten. Dies wurde so vorgesehen, damit ein Parallelbetrieb als Übergang genutzt werden kann. Dazu in den Dateien

.. code:: bash

    /etc/linuxmuster/samba/root-preexec.d/sophomorix-root-preexec
    /etc/linuxmuster/samba/root-postexec.d/sophomorix-root-postexec 

die Zeilen mit "sophomorix-bind" durch Voranstellen eines ``#`` auszukommentieren. 

.. code:: bash

   #!/bin/bash
   # sophomorix-bind --quick --login --host $HOSTNAME --user $USERNAME --homedir $HOMEDIR


Damit werden die bind-mounts bei der Benutzeran- bzw. abmeldung nicht mehr angelegt bzw. entfernt.

Da es möglich ist, dass zum Umstellungszeitpunkt Bind-mounts gesetzt waren, sollten diese entfernt werden mit:

.. code-block:: console

   # sophomorix-bind --cron

Dateirechte umstellen
_____________________

Mit dem Upgrade von 6.0 auf 6.1 müssen auch noch die
Dateirechte/Eigentümer von schon erstellten Verzeichnissen in den
Tauschordnern angepasst werden.  Dies geschieht durch Aufruf von:

.. code-block:: console

   # sophomorix-repair --permissions



