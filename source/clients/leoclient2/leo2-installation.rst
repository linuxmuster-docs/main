Installation von leoclient2
===========================

Software-Pakete installieren
----------------------------

Die leoclient2-Pakete liegen auf dem linuxmuster.net-Paketserver https://deb.linuxmuster.net/, der im Linuxclient eventuell schon zur Einrichtung der Anmeldung am Server (Domänenanmeldung) eingetragen wurde. Dann ist der Schlüssel schon als linuxmuster.net.gpg vorhanden.

.. code-block:: console

   # cd /etc/apt/trusted.gpg.d
   # wget https://deb.linuxmuster.net/pub.gpg

In /etc/apt/sources.list Paketquellen eintragen:

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
  
Zugehöriges Erweiterungspaket von VirtualBox installieren.
Dazu mit dpkg die Versionsnummer von VirtualBox ausfindig machen und den Downloadlink entsprechend anpassen.

.. code-block:: console

   # dpkg -l | grep virtualbox
   ii  virtualbox                                    6.1.38-dfsg-3~ubuntu1.22.04.1         amd64        x86 virtualization solution - base binaries
   # cd /tmp
   # wget https://download.virtualbox.org/virtualbox/6.1.38/Oracle_VM_VirtualBox_Extension_Pack-6.1.38.vbox-extpack

als ``linuxadmin`` anmelden und virtualbox starten. 
Unter Datei -> Einstellungen -> Zusatzpakete: mit + hinzufügen und heruntergeladene Datei in /tmp auswählen und installieren.

Gruppenzugehörigkeiten anpassen
-------------------------------

**Lokale Benutzer**
   
Lokale Benutzer am Linuxclient (z.B. ``linuxadmin``) müssen der Gruppe ``vboxusers`` hinzugefügt werden. 
Für den lokalen Benutzer ``linuxadmin`` erfolgt das mit:

.. code-block:: console

   # sudo adduser linuxadmin vboxusers

Weitere lokale Benutzer können entsprechend hinzugefügt werden.
Diese Änderung wird erst bei einer erneuten Anmeldung des Nutzers wirksam.

**Domänenbenutzer**

Anpassen der Datei ``/etc/group`` über ein Anmeldescript ``/etc/linuxmuster-linuxclient7/onLoginAsRoot.d/10_vboxusers-group.sh`` .
Dabei wird den Gruppen ``vboxusers`` und ``lpadmin`` der sich anmeldende Benutzer ``$USER`` hinzugefügt.
Der Eintrag in ``lpadmin`` berechtigt zur Anpassung der Druckerkonfiguration (z.B. Standarddrucker), 
die Mitgliedschaft in ``vboxusers`` ermöglicht die umfangreiche Nutzung von Virtualbox. 
Die Anpassungen in der Datei ``/etc/group`` zeigen sofort Wirkung und nicht erst nach einer erneuten Anmeldung. 

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

Benutzerrechte erweitern mit sudo
---------------------------------
 
Einträge in ``/etc/sudoers.d/80-leoclient2`` sind vorzunehmen, um die notwendigen Rechte für das leovirtstarter2-Skript zu erweitern. Die lokalen Benutzer (linuxadmin, localuser) und Domänenbenutzer (%schools) erhalten sudo-Rechte ohne Passwortabfrage. Änderungen über ``# sudoedit /etc/sudoers.d/80-leoclient2``

.. code-block:: console

    # leoclient2 needs to make a VM of other users usable
    # option --set-permissions allows to do this
    # option --register-machine allows to do this
    %schools ALL=NOPASSWD: /usr/bin/leovirtstarter2 --set-permissions, /usr/bin/leovirtstarter2 --register-machine *
    linuxadmin ALL=NOPASSWD: /usr/bin/leovirtstarter2 --set-permissions, /usr/bin/leovirtstarter2 --register-machine *
    localuser ALL=NOPASSWD: /usr/bin/leovirtstarter2 --set-permissions, /usr/bin/leovirtstarter2 --register-machine *
   

Weitere sudo-Rechte setzen mit ``sudoedit /etc/sudoers.d/60-mkdir``, um notwendige Berechtigungen für das Snapshot-Verzeichnis ``/media/localdisk/cache`` zu erhalten (dazu später mehr).

.. code-block:: console

    # leoclient2 needs to make a directory /media/localdisk/cache
    %schools ALL=NOPASSWD: /bin/mkdir
    %schools ALL=NOPASSWD: /bin/chmod
    linuxadmin ALL=NOPASSWD: /bin/mkdir
    linuxadmin ALL=NOPASSWD: /bin/chmod
    localuser ALL=NOPASSWD: /bin/mkdir
    localuser ALL=NOPASSWD: /bin/chmod

Dateien unter /etc/sudoers.d müssen Rechte 440 haben:

.. code-block:: console

    # sudo chmod 440 /etc/sudoers.d/80-leoclient2
    # sudo chmod 440 /etc/sudoers.d/60-mkdir

Startskripte
------------

Damit alle Benutzer im Verzeichnis ``/media`` Schreibrechte erhalten, um verschiedene Links einrichten zu können, werden die Berechtigungen über das Skript ``/etc/linuxmuster-linuxclient7/onLoginAsRoot.d/03_media-rechte.sh`` angepasst.

.. code-block:: console

    #!/bin/bash
    
    chmod 777 /media

Für den leovirtstarter2 sollen die Snapshots vom Server in einem lokalen Verzeichnis gecacht werden. Dieses kann eine separate Partition (Datenpartition) sein und ist erreichbar über ``/media/localdisk``. Eine separate Partition ist hilfreich, denn dann wird der cache beim Synchronisieren des Betriebssystems nicht gelöscht. 

.. code-block:: console

    # sudo mkdir /media/localdisk
    bzw. passender Eintrag für ``/media/localdisk`` in ``/etc/fstab``.

Die notwendigen Schreibrechte werden in ``/etc/linuxmuster-linuxclient7/onLoginAsRoot.d/40_localdisk.sh`` eingerichtet.

.. code-block:: console

    #!/bin/bash 
    # Schreibrechte auf Datenpartition setzen
    sudo chmod 777 /media/localdisk

Hat ein anderer Benutzer einen Snapshot vom Server im lokalen Verzeichnis ``/media/localdisk/cache/`` gecacht, muss der Snapshot für andere Benutzer freigegeben werden. Dazu werden in ``/etc/linuxmuster-linuxclient7/onLoginAsRoot.d/50_leoclient2.sh`` die notwendigen Rechte gesetzt.
Außerdem werden die virtuellen Maschinen, die unter ``/virtual/leoclient2-vm/`` liegen, für alle Benutzer lesbar gemacht (Hintergrund: Bei der Nutzung einer VM durch einen Benutzer werden die Berechtigungen für andere entfernt.)

Es bietet sich an den Ort für die virtuellen Maschinen ``/virtual/leoclient2-vm`` in eine separate Partition unter ``/virtual`` zu legen, dann kann man die virtuellen Maschinen unabhängig vom Betriebsystem.

``/etc/linuxmuster-linuxclient7/onLoginAsRoot.d/50_leoclient2.sh``

.. code-block:: console

    #!/bin/bash 
    # Schreibrechte auf alle gecachten Snapshots
    chmod -R 777 /media/localdisk/cache/*
    # Zugriffsrechte auf alle VMs setzen beim Anmelden
    chmod -R 755 /virtual/leoclient2-vm/*

Links von früheren Benutzeranmeldungen müssen entfernen werden. Dazu das Skript ``/etc/linuxmuster-linuxclient7/onLoginAsRoot.d/01_links-entfernen.sh`` erstellen.

.. code-block:: console

    #!/bin/bash
    
    # Link von /home/$USER/media/ISO für Virtuelle Maschinen auf /virtual/server
    # muss vorher als root gelöscht werden
    rm /virtual/server
    
    # Link von /media/Tausch_auf_Server auf /home/$USER/Tausch_auf_Server
    # muss vorher als root gelöscht werden
    rm /media/Tausch_auf_Server
    
    # Link zu Schülerhomes Schueler_auf_Server in /media, wenn vorhanden (nur für Lehrkräfte)
    # muss vorher als root gelöscht werden
    rm /media/Schueler_auf_Server

Zum Säubern von Einträgen von anderen Benutzern ``/etc/linuxmuster-linuxclient7/onLoginAsRoot.d/02_leoclient2-log-heimat-entfernen.sh`` anlegen.

.. code-block:: console

    #!/bin/bash
    # leovirtstarter2-log-Dateien entfernen
    rm /tmp/leovirtstarter2*.log
    # Eintrag des bisher angemeldeten Benutzers entfernen
    rm /tmp/heimatverzeichnis


Scripte für Login im User-Kontext
---------------------------------

Für den einfachen Zugriff auf die Servershares werden verschiedene Links angelegt mit ``/etc/linuxmuster-linuxclient7/onLogin.d/10_links.sh``.


.. code-block:: console

    #!/bin/bash
    
    USER=`echo $USER | tr [:upper:] [:lower:]`
    
    # Link von Home_auf_Server in lokales Home, wenn noch nicht vorhanden
    if [ ! -L /home/$USER/Home_auf_Server ] && [ ! -f /home/$USER/Home_auf_Server ]; then
        ln -s "/home/$USER/media/$USER (H:)" "/home/$USER/Home_auf_Server"
    fi
    
    # Link von Tauschverzeichnissen in lokales Home
    # mit Unterverzeichnis "Tausch_auf_Server" für deutsche Bezeichnungen darunter
    # Verzeichnis Tausch_auf_Server mit Inhalten, wenn noch nicht vorhanden
    if [ ! -L /home/$USER/Tausch_auf_Server ] && [ ! -d /home/$USER/Tausch_auf_Server ]; then
        mkdir /home/$USER/Tausch_auf_Server
        ln -s "/home/$USER/media/Shares/projects" "/home/$USER/Tausch_auf_Server/Projekte"
        ln -s "/home/$USER/media/Shares/classes" "/home/$USER/Tausch_auf_Server/Klassen"
        ln -s "/home/$USER/media/Shares/school" "/home/$USER/Tausch_auf_Server/Schule"
        ln -s "/home/$USER/media/Shares/teachers" "/home/$USER/Tausch_auf_Server/Kollegium"
    fi
    # Link von /media/Tausch_auf_Server auf /home/$USER/Tausch_auf_Server
    # muss vorher als root gelöscht werden /etc/linuxmuster-linuxclient7/onLoginAsRoot.d/03_link-media-tausch.sh
    if [ -d /home/$USER/Tausch_auf_Server ]; then
        ln -s /home/$USER/Tausch_auf_Server /media/Tausch_auf_Server
    fi
    
    # Link zu Schülerhomes in lokales Home, wenn vorhanden (nur für Lehrkräfte)
    if [ ! -L /home/$USER/Schueler_auf_Server ] && [ ! -d /home/$USER/Schueler_auf_Server ] && [ -d /home/$USER/media/Students-Home ]; then
        ln -s "/home/$USER/media/Students-Home" "/home/$USER/Schueler_auf_Server"
    fi
    # Link zu Schülerhomes Schueler_auf_Server in /media, wenn vorhanden (nur für Lehrkräftte)
    # muss vorher als root gelöscht werden /etc/linuxmuster-linuxclient7/onLoginAsRoot.d/03_link-media-tausch.sh
    if [ -L /home/$USER/Schueler_auf_Server ]; then
        ln -s /home/$USER/Schueler_auf_Server /media/Schueler_auf_Server
    fi
    
    # Link für Virtuelle Maschinen auf /virtual/server
    # muss vorher als root gelöscht worden sein
    ln -s "/home/$USER/media/ISO" "/virtual/server"

Skript ``/etc/linuxmuster-linuxclient7/onLogin.d/50_leoclient2-printer.sh`` zum Starten der Druckskripte.
Damit werden pdf-Dateien, die in der VM erzeugt werden und unter ``Home_auf_Server`` abgelegt werden zum Standarddrucker übertragen.
Somit kann man aus der VM heraus ohne direkte Netzverbindung auf Netzwerkdrucker ausdrucken. 

.. code-block:: console

    #!/bin/bash
    
    # Die Scripte run-vm-printer2-spooler und run-vm-printer2-splitter
    # überprüfen ständig, ob der angemeldete Benutzer
    # (Eintrag in /tmp/heimatverzeichnis) noch mit dem Benutzer
    # übereinstimmt, der das Skript gestartet hat.
    # Ist dies nicht der Fall, wird das Skript beendet.
    
    USER=`echo $USER | tr [:upper:] [:lower:]`
    
    # Anlegen der Datei /tmp/heimatverzeichnis mit dem lokalen USER-home
    
    echo /home/$USER > /tmp/heimatverzeichnis
    chmod 777 /tmp/heimatverzeichnis
    
    # kurze Pause, damit eventuell noch laufende printer-Skripte
    # durch anderes /tmp/heimatverzeichnis beendet werden können
    sleep 5
    
    # Starten der Skripte für das Ausdrucken aus der VM
    run-vm-printer2-spooler &
    run-vm-printer2-splitter &

Eintrag in ``/etc/leoclient2/leoclient-vm-printer2.conf`` anpassen in welcher Datei das Ausdruck aus der VM abgelegt wird -> ``$print_file_user="ausdruck-winxp.pdf";``.
Damit wird die Datei ``ausdruck-winxp.pdf`` unter ``Home_auf_Server`` auf dem Standarddrucker des Ubuntu-Rechners ausgedruckt.

Sicherungen der Skripte löschen (mit "~" am Ende), die durch Änderungen entstehen. Diese würden sonst ebenso ausgeführt werden!!!

.. code-block:: console

    # sudo rm /etc/linuxmuster-linuxclient7/onLogin.d/*~
    # sudo rm /etc/linuxmuster-linuxclient7/onLoginAsRoot.d/*~

Rechte der oben neu erstellten Dateien unter ``/etc/linuxmuster-linuxclient7/onLogin.d/`` bzw. /etc/linuxmuster-linuxclient7/onLoginAsRoot.d/`` anpassen, die bei der Anmeldung ausgeführt werden sollen, damit diese ausgeführt werden können.

.. code-block:: console

    # chmod +x /etc/linuxmuster-linuxclient7/onLoginAsRoot.d/*
    # chmod +x /etc/linuxmuster-linuxclient7/onLogin.d/*

Abschließend muss man die Standard-VM in ``/etc/leoclient2/servers.conf`` eintragen (hier: "win7"), außerdem den Pfad zu den Snapshots für die VMs auf dem Server.
Die Snapshots mit der folgenden Einstellung liegen für die VM "win7" auf dem Server im Verzeichnis ``/virtual/server/leoclient2-vm/win7``. Lokal liegen die VMs unter ``/virtual/leoclient2-vm``.

.. code-block:: console
   
    # common configuration for the machines
    #
    # which machine is the default
    DEFAULT=win7-64
    # where is/are the mounted server dir for snapshots 
    SERVERDIR=/virtual/server/leoclient2-vm


Fehleranalyse
-------------

Zur Fehlerbehebung werden Log-Dateien in
``/tmp/run-vm-printer2-spooler.log-USERNAME`` und
``/tmp/run-vm-printer2-splitter.log-USERNAME`` abgelegt. 
Dort sieht man nach welcher Datei der Drucker-Splitter sucht.

Die log-Datei für den leovirtstarter2 liegt ebenfalls unter ``/tmp``.

