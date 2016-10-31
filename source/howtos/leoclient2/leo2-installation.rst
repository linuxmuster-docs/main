Installation von leoclient2
===========================

Software-Pakete installieren
----------------------------

Die leoclient-Pakete liegen auf dem linuxmuster.net-Paketserver, der im Linuxclient schon zur Einrichtung der Anmeldung am Server eingetragen wurde.
 
Die Pakete werden installiert mit root-Rechten auf dem Linuxclient mit folgenden Befehlen:

.. code-block:: console

   # apt-get update
   # apt-get install libglib-perl libgtk2-perl
   # apt-get install leoclient2-leovirtstarter-client leoclient2-vm-printer linuxmuster-client-sudoers

Damit wird ggf. auch das Paket virtualbox-x.y auf dem Linuxclient installiert.

.. todo:: Mit dem aktuellen Default-cloop Linuxclient nachprüfen, ob virtualbox und welches installiert ist und wie man ein aktuelleres installieren kann.
	  
Eine aktuelle Version kann man mit Hilfe der Anleitung z.B. unter
https://www.virtualbox.org/wiki/Linux_Downloads installieren. Für die
Schule kann die PUEL-Version installiert werden, die beispielsweise
USB2 unterstützt (statt USB1.1).


Benutzer-Rechte anpassen
------------------------

Um für die Domänenbenutzer alle Optionen von VirtualBox freizugeben, müssen diese Mitglied der Gruppe ``vboxusers`` sein. Hierzu ergänzt man in der Datei ``/etc/security/group.conf`` in der Zeile ``*;*;*;Al0000-2400;dialout...`` den Eintrag ``vboxusers``. Diese Zeile könnte dann wie folgt aussehen:

.. code-block:: console
   
   *;*;*;Al0000-2400;dialout,cdrom,floppy,audio,dip,video,plugdev,scanner,vboxusers

Auch lokale Benutzer am Linuxclient (z.B. ``linuxuser``) müssen  der Gruppe ``vboxusers`` hinzugefügt werden. Für lokale Benutzer erfolgt das mit

.. code-block:: console

   # sudo adduser linuxuser vboxusers

Diese Änderung ist erst bei einer erneuten Anmeldung des Nutzers wirksam.

.. todo:: Nachprüfen ob folgendes stimmt:
	  
Hinweis: Diese Rechte-Anpassungen sind im Standard-Linuxclient schon eingepflegt.

Rechte an den lokalen virtuellen Maschinen
------------------------------------------

Bei der Anmeldung eines Benutzers werden die Rechte an den lokalen virtuellen Maschinen so gesetzt, dass der Benutzer die Maschine starten, Logs anlegen und den aktiven Snapshot verändern kann. Dazu muss nachfolgendes Script ``015-leoclient2`` unter ``/etc/linuxmuster-client/post-mount.d/`` abgelegt sein.

.. code-block:: bash 
   :caption: /etc/linuxmuster-client/post-mount.d/015-leoclient2

   #!/bin/bash
   #
   #  Script /etc/linuxmuster-client/post-mount.d/015-leoclient2
   #  Setzt die Rechte für die lokalen VMs auf den aktuellen USER
   #

   # this script is supposed to be run only once after mount of HOME_auf_Server
   #[ -z "$HOMEDIRMOUNT" ] && return 0

   $LOGGING && msg2log post-mount "015-leoclient2 Environment settings are: USER=$USER VOLUME=$VOLUME MNPT=$MNTPT OPTIONS=$OPTIONS SERVER=$SERVER NUMUID=$NUMUID NUMPRIGID=$NUMPRIGID FULLNAME=$FULLNAME HOMEDIR=$HOMEDIR LOGINSHELL=$LOGINSHELL"
   
   etcpfad="/etc/leoclient2/machines"
   for file in "$etcpfad"/*.conf ; do
      vmpfad=`cat $file`
      vmname=$(basename "$vmpfad")
      chmod ugo+rwt $vmpfad 
      chown -R $USER "$vmpfad/Logs" 
      chown -R $USER "$vmpfad/Snapshots" 
      chown $USER "$vmpfad"/VBoxSVC.log* 
      chown $USER "$vmpfad/$vmname.vbox" 
      chown $USER "$vmpfad/$vmname.vbox-prev" 
   done  


Drucker-Spooler aktivieren
--------------------------

Um aus der virtuellen Maschine heraus drucken zu können, müssen ein
Drucker-Spooler und ein -Splitter bei Anmeldung am Linuxclient
gestartet werden.

Mit Hilfe der linuxmuster-client-extras Skripte gelingt dies wie folgt:

.. code-block:: console

   # linuxmuster-client-extras-setup --type login --on /usr/bin/run-vm-printer2-splitter --order 060
   # linuxmuster-client-extras-setup --type login --on /usr/bin/run-vm-printer2-spooler --order 070

Die Konfigurationsdatei dazu liegt unter
``/etc/leoclient2/leoclient-vm-printer2.conf``, zur Fehlerbehebung
werden Log-Dateien in ``/tmp/run-vm-printer2-spooler.log-USERNAME``
und ``/tmp/run-vm-printer2-splitter.log-USERNAME`` abgelegt.
