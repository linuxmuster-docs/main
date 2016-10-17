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
   exit 0 

