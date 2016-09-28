Upgrade von 6.1
===============

Um linuxmuster.net 6.1 (Codename Babo) auf linuxmuster.net 6.2 (Codename babo62) zu aktualisieren, sind nachstehend aufgeführte Schritte auszuführen.

Paketquellen anpassen
---------------------

Zum Upgrade auf linuxmuster.net 6.2 (Codename Babo62) muss das entsprechende neue **babo62**-Repositorium eingebunden werden. 

In der Datei ``/etc/apt/sources.list.d/linuxmuster-net.list`` sind folgende Paketquellen anzugeben:

.. code::

   deb http://pkg.linuxmuster.net/ babo/
   deb-src http://pkg.linuxmuster.net/ babo/
   deb http://pkg.linuxmuster.net/ babo62/
   deb-src http://pkg.linuxmuster.net/ babo62/

.. attention:: Paketquellen überprüfen

   Stellen Sie sicher, dass keine weitere Datei im Verzeichnis ``/etc/apt/sources.list.d/`` oder die Datei ``/etc/apt/sources.list`` Repositorien von ``pkg.linuxmuster.net`` enthält.

Dist-upgrade durchführen
------------------------

Nachdem die Paketquellen in der genannten Datei für apt eingetragen wurden, können Sie nun die Paketquellen aktualisieren und die Pakete selbst aktualisieren.

Dazu sind auf der Eingabekonsole als Benutzer root folgende Befehle einzugeben:

.. code-block:: console

   # apt-get update
   # apt-get dist-upgrade

Das Paketsystem fragt bei einigen Paketen nach, ob bei **geänderten Konfigurationsdateien die aktuelle Konfiguration beibehalten** werden sollen, oder ob die neuen angewendet werden sollen.

.. attention:: Aktuelle Konfiguration beibehalten

    Wählen Sie immer aus, dass die aktuelle Konfiguration beibehalten werden soll. Dies entspricht auch 
    der Voreinstellung, die Sie mit ENTER bestätigen können.

Import der Workstations durchführen
-----------------------------------

Beim durchgeführten Upgrade wurde auch eine neue Version des Pakets linuxmuster-linbo eingespielt. Diese neue Version von Linbo erfordert es, dass zur Aktivierung zu Beginn ein einmaliger Import der Workstations ausgeführt wird. Auf diese Weise werden die notwendigen Konfigurationsdateien erstellt.

Führen Sie hierzu folgenden Befehl aus:

.. code-block:: console

   # import_workstations

Das Skript prüft die angegebenen Eintragungen in der Datei ``/etc/linuxmuster/workstations``. Sind diese korrekt wird der Import ausgeführt. Wurde das Skript erfolgreich abgearbeitet, wird dies mit einem entsprechenden Hinweis quittiert.

Clients mit neuem Linbo booten
------------------------------

Um sicherzustellen, dass das neue LINBO-System auch lokal auf den
Clients installiert wird, erzwingt man eine Aktualisierung des Caches
und einen Reboot.

Folgender Befehl auf der Serverkonsole sorgt dafür, dass beim nächsten
Bootvorgang (egal ob per PXE oder von Festplatte) der Cache
initialisiert wird (und rebootet wird):

.. code-block:: console

   # linbo-remote -p initcache,reboot [-i <hostname>|-g <group>|-r <room>]


..
   2. **Alternativ: Wake-on-Lan**: Sind die Client für Wake-on-Lan konfiguriert, so kann der gesamte 
      Vorgang mit nur einem Befehl umgesetzt werden:

      .. code:: bash

	 linbo-remote -w0 -p initcache,reboot [-i <hostname>|-g <group>|-r <room>]

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
   *reboot-Workaround* wird nun immer verwendet.).

Fehlerbehebung mit einem USB-Stick
__________________________________

Wenn ein Arbeitsplatz mit der Fehlermeldung "Kernel panic" hängt oder
in Schleifen immer wieder rebootet, kann ein Neuanfang über einen
USB-Stick oder CD/DVD initiiert werden.

Laden Sie dazu die die Datei ``linbo.iso`` von ihrem Server herunter
und brennen Sie diese auf CD/DVD oder kopieren diese auf einen
USB-Stick, z.B. mit Hilfe des Befehls

.. code-block:: console

   # dd if=linbo.iso of=/dev/sdb

wobei ``/dev/sdb`` der Schnittstellenname ihres USB-Sticks sein muss.
