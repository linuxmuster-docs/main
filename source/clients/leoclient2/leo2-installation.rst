Installation von leoclient2
===========================

Software-Pakete installieren
----------------------------

Die leoclient-Pakete liegen auf dem linuxmuster.net-Paketserver https://deb.linuxmuster.net/, der im Linuxclient eventuell schon zur Einrichtung der Anmeldung am Server (Domänenanmeldung) eingetragen wurde. Dann ist der Schlüssel schon als linuxmuster.net.gpg vorhanden.

.. code-block:: console

   # cd /etc/apt/trusted.gpg.d
   # wget https://deb.linuxmuster.net/pub.gpg

In /etc/apt/sources.list eintragen:

.. code-block:: console

   deb https://deb.linuxmuster.net/ lmn71 main            (von Domänenanmeldung schon vorhanden)
   deb https://deb.linuxmuster.net/ lmn71-testing main    (leoclient2 aus testing!!!)

Installation der Pakete auf dem Linuxclient mit folgenden Befehlen:

.. code-block:: console

   # sudo apt update
   # sudo apt install leoclient2-leovirtstarter-client leoclient2-vm-printer
  
Virtualbox installieren/updaten
-------------------------------

Es wird empfohlen unter Ubuntu 22.04 die aktuelle Version von Virtualbox zu installieren.

.. code-block:: console

   # sudo apt update
   # sudo apt install virtualbox virtualbox-guest-additions-iso
  
Aktuelle Gasterweiterungen von VirtualBox installieren, falls nicht vorhanden beispielsweise mit (Versionsnummer anpassen)

.. code-block:: console

   # cd /tmp
   # wget https://download.virtualbox.org/virtualbox/6.1.38/Oracle_VM_VirtualBox_Extension_Pack-6.1.38.vbox-extpack

als linuxadmin anmelden
virtualbox starten
unter Datei → Einstellungen → Zusatzpakete: mit + hinzufügen und heruntergeladene Datei in /tmp auswählen → …


Benutzer-Rechte anpassen
------------------------

Lokale Benutzer
   
Auch lokale Benutzer am Linuxclient (z.B. ``linuxadmin``) müssen der
Gruppe ``vboxusers`` hinzugefügt werden. Für lokale Benutzer erfolgt
das mit

.. code-block:: console

   # sudo adduser linuxadmin vboxusers

Diese Änderung wird erst bei einer erneuten Anmeldung des Nutzers wirksam.

Domänenbenutzer

Anpassen der Datei /etc/group über ein Anmeldescript /etc/linuxmuster-linuxclient7/onLoginAsRoot.d/10_vboxusers-group.sh

.. code-block:: console
   
    #!/bin/bash 
    # mit diesem Script sollen zusätzliche Gruppenzugehörigkeiten
    # eingerichtet werden, da dies über PAM aktuell nicht funktioniert
    
    # Aktuellen Benutzer in Gruppe vboxusers und lpadmin in /etc/group eintragen
    # vboxusers:x:136:linuxadmin ersetzen mit vboxusers:x:136:linuxadmin,$USER
    # lpadmin:x:122:linuxadmin ersetzen mit lpadmin:x:122:linuxadmin,$USER
    # wenn vboxusers vorhanden und $USER dort nicht enthalten
    
    USER=`echo $USER | tr [:upper:] [:lower:]`
    
    if [ 'grep vboxusers /etc/group' != "" ];
    then
        if [ "`grep vboxusers /etc/group | grep $USER`" = "" ];
        then
            sed -i "s|vboxusers:x:136:linuxadmin|vboxusers:x:136:linuxadmin,$USER|g" /etc/group
        fi
    fi
    
    if [ 'grep lpadmin /etc/group' != "" ];
    then
        if [ "`grep lpadmin /etc/group | grep $USER`" = "" ];
        then
            sed -i "s|lpadmin:x:122:linuxadmin|lpadmin:x:122:linuxadmin,$USER|g" /etc/group
        fi
    fi

u.s.w. - Fortsetzung folgt ...



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

Konfiguration

Die Konfigurationsdatei liegt unter
``/etc/leoclient2/leoclient-vm-printer2.conf``.

Zur Fehlerbehebung werden Log-Dateien in
``/tmp/run-vm-printer2-spooler.log-USERNAME`` und
``/tmp/run-vm-printer2-splitter.log-USERNAME`` abgelegt. Dort sieht
man nach welcher Datei der Drucker-Splitter sucht

