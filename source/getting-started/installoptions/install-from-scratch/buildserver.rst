.. include:: /guided_inst.subst

Anlegen und Installieren des Servers
====================================

Starte den Server via Ubuntu 18.04.1 Server ISO-Image (USB-Stick oder CD-ROM).

Es erscheint das erste Installationsfenster mit der Abfrage zur gewünschten Sprache.

Wähle deine bevorzugte Sprache.

.. figure:: media/server11.png

Wähle das Tastaturlayout Deutsch.

.. hint:: Das Tastaturlayout wirkt sich während der Installation noch nicht aus! 

.. figure:: media/server12.png

In der Voreinstellung ist die Netzwerkkarte auf DHCP eingestellt. Das klappt natürlich nicht, da der DHCP-Service der Firewall deaktiviert wurde. Du musst also die Konfiguration von Hand einstellen.

Gehe dazu auf die Netzwerkkarte und wähle ``Edit IPv4``.

.. figure:: media/server13.png

Wähle ``Manual``.

.. figure:: media/server14.png

Gib die Netzwerkkonfiguration, wie im oberen Bild, ein.

.. hint:: Bedenke, dass das deutsche Tastaturlayout noch nicht aktiv ist. Den ``/``, den du für die Eingabe des Subnetzes brauchst, bekommst du mit der ``-``-Taste!

.. hint:: Falls Du dich für das Netz der linuxmuster.net V6.2 entschieden hast, konfigurierst du das Subnet 10.16.0.0/12, die Adresse 10.16.1.1, den Gateway 10.16.1.254 und den Name server 10.16.1.254. 

.. figure:: media/server15.png

Lass die Proxy-Adresszeile leer.

.. figure:: media/server16.png

Die Mirror-Adresse übernimmst du.

.. figure:: media/server17.png


.. figure:: media/server18.png


.. figure:: media/server19.png


.. figure:: media/server20.png

Nenne den Server ``server``. Der Benutzername und das Passwort sind frei wählbar. 

.. figure:: media/server21.png

Installiere OpenSSH **nicht**.

Wenn die Installation abgeschlossen ist und der Server neu gestartet ist, meldest du dich als linuxadmin (Passwort Muster!) an.

Automatische Updates abschalten
-------------------------------

Der frisch installierte Ubuntu-Server hat automatische Updates aktivieret. Das solltest du abschalten.

Werde mit ``sudo -i`` root und editiere beispielsweise mit nano die Datei ``/etc/apt/apt.conf.d/20auto-upgrades``:

``nano /etc/apt/apt.conf.d/20auto-upgrades``

Ersetze bei ``APT::Periodic::Unattended-Upgrade`` die ``"1";`` durch ``"0";``. Mit ``<Strg>+o`` speicherst du die Änderung ab. Und mit ``<Strg>+x`` verlässt du nano wieder.

Jetzt kannst du den Server mit ``apt-get update`` und anschließendem ``apt-get dist-upgrade`` updaten. 

Schlüssel importieren
---------------------

* Zunächst wirst du wieder root mit ``sudo -i``.
* Dann lädst du den key mit ``wget http://pkg.linuxmuster.net/archive.linuxmuster.net.key`` herunter.
* Jetzt fügst du den Schlüssel mit ``apt-key add archive.linuxmuster.net.key`` hinzu.

