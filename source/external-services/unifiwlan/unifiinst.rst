Die Installation
================

Hardwareanforderungen
---------------------

- 3 GB RAM
- Eine Netzwerkkarte im Schulnetz (VLAN 16)
- 10 GB Festplatte (bei mir im Schulbetrieb sind 3,3 GB vom 40 GB belegt).


Die Grundinstallation
---------------------

Bevor die Installation begonnen werden kann, muss ein Ubuntu-Server 16.04 64-Bit auf dem späteren Unifi-Kontroller installiert werden.

Schritt für Schritt
-------------------

Starte vom Installationsmedium und wähle die Sprache.

.. figure:: media/u01.png
   :alt: Sprachenauswahl

Wähle `Ubuntu Server installieren`.

Bestätige die Installation in der gewählten Sprache.

Ist der Rechner bereits in `/etc/linuxmuster/sophomorix/default-school/devices.csv`, so ist der Rechnername bereits in der Eingabemaske eingetragen.

.. figure:: media/u02.png
   :alt: Rechnername

Wähle einen Benutzer, seinen Benutzernamen und das Passwort.

Verschlüssle Deinen persönlichen Ordner **nicht**!

.. figure:: media/u03.png
   :alt: Home verschlüsseln

Wähle `vollständige Festplatte verwenden` und bestätige die Partitionierung.

.. figure:: media/u04.png
   :alt: Vollständige Festplatte

Es ist zu empfehlen, `keine automatischen Aktualisierungen` zu wählen, da Du dann nicht von unerwarteten Aktualisierungen überrascht wirst.

.. figure:: media/u05.png
   :alt: Keine Updates

An Software gibt es nichts Besonderes zu wählen.

.. figure:: media/u06.png
   :alt: Softwareauswahl

Beende die Installation und starte den Rechner neu.

Die Installation der Unifi-Pakete
---------------------------------

Der Rechner muss upgedatet, die Paketquellen müssen ergänzt und das Unifi-Paket installiert werden.

Schritt für Schritt
-------------------

Die englische Anleitung von Unifi findest Du `hier <https://help.ubnt.com/hc/en-us/articles/220066768-UniFi-How-to-Install-Update-via-APT-on-Debian-or-Ubuntu>`_.

Melde dich an.

öffne eine root-shell mit `sudo -i`

Update den Rechner mit

::

  apt-get update
  apt-get dist-upgrade

Editiere die Datei `/etc/apt/sources.list` und füge die folgende Zeile hinzu:


::

  deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti

Füge den GPG-key hinzu:

::

  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 06E85760C0A52C50

Nochmal updaten, unifi installieren und neu starten:

::

  sudo apt-get update
  sudo apt-get install unifi
  reboot


