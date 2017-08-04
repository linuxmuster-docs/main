Installation von leoclient2
===========================

Software-Pakete installieren
----------------------------

Die leoclient-Pakete liegen auf dem linuxmuster.net-Paketserver, der im Linuxclient schon zur Einrichtung der Anmeldung am Server eingetragen wurde.

.. todo:: link um Quellen einzutragen statt folgendes ...


.. code-block:: console

   # wget http://pkg.linuxmuster.net/linuxmuster.net.key -O - | sudo apt-key add -

In /etc/apt/sources.list eintragen:

.. code-block:: console

   deb http://pkg.linuxmuster.net/ xenial/ 
 
Installation der Pakete auf dem Linuxclient mit folgenden Befehlen:

.. code-block:: console

   # sudo apt-get update
   # sudo apt-get install leoclient2-leovirtstarter-client leoclient2-vm-printer
   
Virtualbox installieren/updaten
-------------------------------

Es wird empfohlen eine aktuelle Version von Virtualbox zu installieren
(5.1.22 im Mai 2017).
	  
Für die Schule kann die PUEL-Version (aktuelles VirtualBox mit
ExtensionPack) installiert werden, die beispielsweise USB2 unterstützt
(statt USB1.1).

Die Anleitung zur Installation findet sich unter
https://www.virtualbox.org/wiki/Linux_Downloads im Bereich
''Debian-based Linux distributions''.

In Kürze das Vorgehen für Ubuntu 16.04/xenial:

1. apt-get install dkms

2. Virtualbox Schlüssel laden, Quellen eintagen, apt-get update

3. apt-get install virtualbox-5.1

4. Extension-Pack im Browser downloaden, installieren im Virtualbox-gui


Benutzer-Rechte anpassen
------------------------

Hinweis: Diese Rechte-Anpassungen sind im Standard-Linuxclient schon eingepflegt.

Domänenbenutzer

Um für die Domänenbenutzer alle Optionen von VirtualBox freizugeben,
müssen diese Mitglied der Gruppe ``vboxusers`` sein. Hierzu ergänzt
man in der Datei ``/etc/security/group.conf`` in der Zeile
``*;*;*;Al0000-2400;dialout...`` den Eintrag ``vboxusers``. Diese
Zeile könnte dann wie folgt aussehen:

.. code-block:: console
   
   *;*;*;Al0000-2400;dialout,cdrom,floppy,audio,dip,video,plugdev,scanner,vboxusers

Lokale Benutzer
   
Auch lokale Benutzer am Linuxclient (z.B. ``linuxadmin``) müssen der
Gruppe ``vboxusers`` hinzugefügt werden. Für lokale Benutzer erfolgt
das mit

.. code-block:: console

   # sudo adduser linuxadmin vboxusers

Diese Änderung wird erst bei einer erneuten Anmeldung des Nutzers wirksam.

Rechte an den lokalen virtuellen Maschinen
------------------------------------------

Mit der im Paket ``leoclient2-leovirtstarter-client`` befindlichen
Datei ``/etc/sudoers.d/80-leoclient2`` wird der Eigentümer der lokalen
virtuellen Maschine vor ihrem Start auf den angemeldeten Benutzer
gesetzt. Somit kann die Maschine gestartet, Logs angelegt und der
aktiven Snapshot verändern werden.

Drucker-Spooler beim login aktivieren
-------------------------------------

Um aus der virtuellen Maschine heraus drucken zu können, müssen ein
Drucker-Splitter und ein Drucker-Spooler bei Anmeldung am Linuxclient
gestartet werden. Der Drucker-Splitter fängt ankommende Druckdateien
ab, bevor sie überschrieben werden. Der Drucker-Spooler druckt sie
aus.

Auf dem Standard-Linux-Client gelingt dies mit Hilfe der
``linuxmuster-client-extras`` Skripte wie folgt:

.. code-block:: console

   # sudo linuxmuster-client-extras-setup --type login --on /usr/bin/run-vm-printer2-splitter
   # sudo linuxmuster-client-extras-setup --type login --on /usr/bin/run-vm-printer2-spooler
   
Überprüft werden kann das mit

.. code-block:: console

   # sudo linuxmuster-client-extras-setup --type login -i

Ohne den Standard-Linux-Client kann man mit folgenden Befehlen einen
ähnlichen Effekt erzielen:

.. code-block:: console

   # sudo install -oroot -groot --mode=0644 /usr/share/leovirtstarter2/desktop/leoclient2-splitter.desktop  /etc/xdg/autostart
   # sudo install -oroot -groot --mode=0644 /usr/share/leovirtstarter2/desktop/leoclient2-spooler.desktop  /etc/xdg/autostart

Konfiguration

Die Konfigurationsdatei liegt unter
``/etc/leoclient2/leoclient-vm-printer2.conf``.

Zur Fehlerbehebung werden Log-Dateien in
``/tmp/run-vm-printer2-spooler.log-USERNAME`` und
``/tmp/run-vm-printer2-splitter.log-USERNAME`` abgelegt. Dort sieht
man nach welcher Datei der Drucker-Splitter sucht

