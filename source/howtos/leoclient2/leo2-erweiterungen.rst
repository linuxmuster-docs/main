Weitere Informationen zu leoclient2
===================================

Speicherort der virtuellen Maschinen
------------------------------------

Lokale Virtuelle Maschinen auf einer zusätzlichen Partition ablegen
```````````````````````````````````````````````````````````````````

Standardmäßig werden die Dateien einer lokalen VM unter ``/var/virtual/`` abgelegt. Dieses Verzeichnis liegt im normalen Dateisystem des Linuxclients. Um diesen Speicherort auf eine extra Partition auszulagern, kann man eine zusätzliche Partition der Festplatte nach ``/var/virtual`` per fstab mounten. Eine Partition dynamisch unter ``/media`` dafür zu verwenden ist ungeeignet, da sich deren Namen und Zugriffsberechtigung je nach User ändern kann.

Damit erfolgt die Synchronisation der Installation des Linuxclients deutlich schneller. Außerdem kann man die virtuellen Maschinen über das Synchronisieren der zugehörigwn Partition unabhängig von der Linuxinstallation zurücksetzen. 

Beispiel: Es existiert eine Partition ``/dev/sda3`` (wie z.B. bei der start.conf zum default-cloop), die mit ext4 formatiert ist. Zunächst das Verzeichnis ``/var/virtual/`` leeren bzw. den Inhalt wegsichern. Dann die Datei ``/etc/fstab`` als root editieren und letzte Zeile ergänzen:

.. code: bash

  #  /etc/fstab: static file system information.
  #
  /dev/sda3   /var/virtual    ext4   defaults  0  0

Danach als root folgendes auf der Konsole ausführen, um die Partition zu mounten und das ganze dann noch mit ``df`` zu überprüfen:

``# mount -a``
``# df -h``

Nun ggf. die weggesicherten Dateien aus wieder nach ``/var/virtual/`` zurückspielen und von beiden Partitionen ein Image erstellen.


Frage: Wann muss welche Partition geimaged werden?
``````````````````````````````````````````````````

Nach dem Anlegen einer neuen VM müssen beide Partitionen geimaged werden da beim Anlegen einer neuen VM diese unter ``/etc/leoclient2/machines`` registiert wird.
Nach dem Verändern einer VM muss nur die zusätzliche VM-Partition geimaged werden.


Virtuelle Maschinen auf dem Server
``````````````````````````````````

Wird ein vom Server gemountetes share für die Basisimages und die Snapshots einer remote-VM benutzt, so ist in der Datei ``/etc/leoclient2/servers.conf`` die Variable ``SERVERDIR`` zu setzen. Mehrere SERVERDIR sind (in Zukunft, todo) möglich.
Nach der Installation enthält die Variable ``SERVERDIR`` den voreingestellten Pfad ``SERVERDIR=/media/leoclient2-vm``. Dieses Verzeichnis wird bei der Installation des leoclient2 angelegt. 
Alternativ kann dieser Pfad auch auf ein anderes, existierendes Verzeichnis abgeändert werden, in dem sich die Remote-virtuellen Maschinen befinden.
Welche Quellen mit dem Verzeichnis verbunden sind, kann wiederum in der Datei ``/etc/fstab`` eingerichtet werden.


Remote virtuelle Maschine erzeugen
``````````````````````````````````

Eine lokale VM wird zur remoten VM, indem
- ihr Datenverzeichnis auf den Server kopiert wird, z.B. das Verzeichnis ``/var/virtual/winxp`` kopieren in das Netzlaufwerk auf dem Server ``/media/leoclient2-vm``:
  
  ``# cp -R /var/virtual/winxp /media/leoclient2-vm``
  
- ggf. die Variable ``SERVERDIR`` angepasst wird, falls ein anderes Share verwendet

Prinzipiell kann die VM danach lokal gelöscht werden. Dann wird die VM vor dem Starten vom Server nach lokal synchronisiert/kopiert. Da dabei beträchtliche Datenmengen übertragen werden, sollte man das nur bei kleinen, wenig genutzen VM's machen (z.B. einem Linux-Mysql-Server o.ä.).


VM Windows XP – Tipps und Tricks
--------------------------------

Zur Installation in VirtulBox ein CD-Rom-Lauftwerk hinzufügen und dann darin die Installations-iso einlegen, die NTFS-Schellformatierung genügt.
Netzlaufwerke verbinden

Zunächst die Gasterweiterungen installieren, mit Hilfe der Menüleiste des VBox-Fensters bei „Geräte“. Dadurch wird auch die Maus nicht mehr gefangen und das Fenster der VM ist beliebig skalierbar.

Share zu Home_auf_Server einrichten:

-    Windows Explorer → Menü Extras → Netzlaufwerk verbinden
-    einen Laufwerksbuchstabe auswählen (z.B. H:) und Ordner angeben: \\vboxsrv\home
-    ggf. Verknüpfung auf Desktop ziehen und umbenennen

Share zu Tauschordnern und USB-Sticks einrichten:

-    Windows Explorer → Menü Extras → Netzlaufwerk verbinden
-    einen Laufwerksbuchstabe und Orner angeben: \\vboxsrv\media
-    ggf. Verknüpfungen auf Desktop ziehen und umbenennen


VM Windows 7 – Tipps und Tricks
-------------------------------

Bei der Installation bricht die 64bit Version ab, wenn nur 1 GB RAM da ist.

Netzlaufwerke

Share zu Home_auf_Server einrichten:
-    Windows Explorer → Rechte Maustaste auf Netzwerk → Netzlaufwerk verbinden
-    Laufwerksbuchstabe und Pfad nennen: \\vboxsrv\home
-    Verknüpfung auf Desktop ziehen und umbenennen

Share auf USB-Sticks einrichten:
-    Windows Explorer → Rechte Maustaste auf Netzwerk → Netzlaufwerk verbinden
-    Laufwerksbuchstabe und Pfad nennen: \\vboxsrv\media
-    Verknüpfung auf Desktop ziehen und umbenennen

Drucker einrichten
-    Sieh FreePDF-Webseite: http://freepdfxp.de/download_de.html
-    ghosscript Installieren
-    Free-PDF Installieren (Version 4.08 bei mir ging 4.14 NICHT(Eigener Drucker anlegen bei 32bit Windows 7)
-    FreePDF Config starten → admin Config starten
-    Profile neu : Profil ausdrucken anlegen
-    Button: Für das aktuelle Profil einen eigenen Drucker anlegen
-    Profil ausdrucken bearbeiten: FreePDF Dialog

     -   Als festen Dateinamen speichern
     -   H:\ausdruck.pdf (anpassen, entsprechend /etc/leoclient2/leoclient-vm-printer2.conf)
     -   Speichern

-    Den Drucker FreePDF als Standard Drucker anlegen


VM schrumpfen – Tipps und Tricks
--------------------------------

Die virtuellen dynamischen Festplattendateien werden im Laufe des Betriebes immer größer, nie kleiner, auch wenn man Dateien löscht. Zum Verkleinern muss man vierschrittig vorgehen:

-    Alles überflüssige in der VM löschen
-    Unbenutzte Festplattenbereiche in der VM nullen
-    Mit dem Tool VBoxManage die .vdi-Festplattendatei schrinken
-    Die geschrinkte Festplattendatei als neuen base-Snapshot setzen

Windows XP schrinken

Vorgehensweise (am Beispiel einer virtuellen Maschine mit Namen „winxp“):

-    Die leoclient-VM booten und ``sdelete`` und ``CCleaner`` in der VM installieren:
     -   download → ``sdelete`` (Microsoft-Tool), kopieren nach ``C:\Windows``
     -   download → ``CCleaner`` von heise.de
-    Auslagerungsdatei abschalten, reboot der VM und dann die versteckte Datei ``C:\pagefile.sys`` löschen
-    CCleaner ausführen und alles wesentliche löschen lassen
-    Ggf. Defragmentieren von c: (Auswirkung unklar)
-    In der Windows Eingabeaufforderung ausführen: ``sdelete.exe -z c:`` (dauert etwas)
-    Auslagerungsdatei wieder anschalten, Herunterfahren der VM
-    Als linuxadmin im Terminal ausführen und den Anweisungen folgen:

    ``# sudo leoclient2-base-snapshot-renew``

-    Der aktuelle Snapshot ``../Snapshots/{...}.vdi`` wird dadurch zur Basisfestplatte ``winxp.vdi`` „gemerged“ und ist danach wieder sehr kein.
-    Als linuxadmin im Terminal ausführen um die Basisfestplatte zu schrinken:

    ``# sudo VBoxManage modifyhd --compact /var/virtual/winxp/winxp.vdi``

-    Nun Basis nochmals neu erstellen, um die geschrinkte Festplatte zu zippen und nach ``.../snapshot-store/`` zu kopieren:

    ``# sudo leoclient2-base-snapshot-renew``

Linux-VM schrinken

Zuerst alles Überflüssige in der laufenden VM löschen, u.a. auch der apt-Cache. Die anschließend beste Vorgehensweise ist das Einbinden der .vdi-Festplatte in ein anderes System, z.B. in ein live-Linux-System, um das „Nullen“ durchzuführen:

    das Tool „zerofree“ nullt die unbenutzten Festplatteninhalte
    auch Swap-Partition nullen per dd-Befehl

Schließlich die 3 Punkte wie oben bei WinXP durchführen.
-    Als linuxadmin im Terminal ausführen und den Anweisungen folgen:

    ``# sudo leoclient2-base-snapshot-renew``

-    Der aktuelle Snapshot ``../Snapshots/{...}.vdi`` wird dadurch zur Basisfestplatte ``winxp.vdi`` „gemerged“ und ist danach wieder sehr kein.
-    Als linuxadmin im Terminal ausführen um die Basisfestplatte zu schrinken:

    ``# sudo VBoxManage modifyhd --compact /var/virtual/winxp/winxp.vdi``

-    Nun Basis nochmals neu erstellen, um die geschrinkte Festplatte zu zippen und nach ``.../snapshot-store/`` zu kopieren:

    ``# sudo leoclient2-base-snapshot-renew``

Das Tool VBoxManage kann nur .vdi-Datein schrinken. Dateien vom Typ .vmdk müssen zuerst in .vdi-Datein umgewandelt werden und danach ge-shrinked werden:

``# VBoxManage clonehd disk1.vmdk disk1.vdi --format vdi``

``# VBoxManage modifyhd --compact disk1.vdi``


Netzwerkeinstellungen einer VM
------------------------------

Die Netzwerkkonfiguration der VM erfolgt durch eine Datei ``network.conf``, die zusätzlich im Verzeichnis der VM angelegt werden muss. Fehlt diese Datei oder treten Fehler bei der Konfiguration auf, werden beim Snapshot-Start des leovirtstarters2 immer alle Netzwerkkarten deaktiviert.

Möchte man eine Netzwerkkarte aktivieren, so muss im Maschinenverzeichnis der VM eine Datei <MASCHINENPFAD>/network.conf angelegt werden, die 5 Einträge in einer Zeile, durch Strichpunkt getrennt, enthält. Diese Konfiguration gilt dann für alle lokalen Snapshots dieser VM.
-    hostname (Name des Linux-Clients auf dem VirtualBox installiert ist)
-    vm-nic (1-4)
-    mode (none|null|nat|bridged|intnet|hostonly|generic|natnetwork)
-    macaddress
-    devicename (eth0,eth1,…) oder (auto-unused-nic|auto-used-nic)

Z.B. ``/var/virtual/winxp/network.conf``
  
.. code:: bash

    # Beispiel einer NAT-Netzwerkkarte
    r100-pclehrer;1;nat;080011223344;auto-used-nic

Folgendes typische Netzwereinstellungen können bisher (Version 0.5.4-1, Juli 2015) umgesetzt werden:
-    nat - NAT auf die NIC des pädagogischen Netzes (VM kann ins Internet)
-    bridged + auto-used-nic - Bridge auf die Karte ins pädagogische Netz
-    bridged + auto-unused-nic - Bridge auf eine zweite Karte (nicht ins pädagogische Netz verbunden -> unused)

Mit Hilfe des ``hostname`` kann man z.B. auf verschiedenen Clients verschiedene MAC-Adressen in der VM für den Bridged-Modus verwenden.

Es gibt insgesamt 4 Möglichkeiten eine ``network.conf`` -Datei abzulegen: zweimal lokal und zweimal im ``SERVERDIR``. Für die Priorität der Möglichkeiten gilt folgende Reihenfolge:

-    Ist auf dem Server speziell für einen Snapshot der VM eine eigene Datei ``<SERVERDIR>/<MACHINENAME>/snapshot-store/<SNAPSHOT>/network.conf`` vorhanden, so wird diese benutzt.
-    Danach wird die Datei auf dem Server für die VM ``<SERVERDIR>/<MACHINENAME>/network.conf`` ausgewertet (falls vorhanden).
-    Anschließend wird die lokale Datei für den Snapshot der VM ``<lokaler Maschinenpfad>/network.conf`` ausgewertet (falls vorhanden).
-    Abschließend wird die lokale Datei für die VM ``<lokaler Maschinenpfad>/snapshot-store/<SNAPSHOT>/network.conf`` ausgewertet (fals vorhanden).
-    Ist keine Datei ``network.conf`` vorhanden, werden alle Netzwerkkarten für die VM deaktiviert.


Berechtigungen zum Starten einer VM bzw. eines Snapshots
--------------------------------------------------------

An welchen Rechnern (Hosts) welcher User eine VM starten darf wird in ``/PFAD/MASCHINENNAME/image.conf`` konfiguriert.

Es werden USER, GROUP, HOST, ROOM gelistet, die Zugriff erhalten sollen (Positivliste). Wenn nichts konfiguriert wird, haben alle User von allen Hosts Zugriff.
Es gibt 2 Arten des Zugriffs:

USER-LEVEL Zugriff:
Zeile mit user=user1,user2 für den Zugriff eines Users
Zeile mit group=group1,group2 für den Zugriff eines in der primären/sekundären Gruppe group1,group2 befindlichen Users (z.B. teachers)

HOST-LEVEL Zugriff:
Zeile mit host=host1,host2 für den Zugriff eines Hosts
Zeile mit room=raum1,raum2 für den Zugriff eines in der primären Gruppe raum1,raum2 befindlichen Hosts

Um eine Maschine starten zu können, müssen BEIDE Level erfüllt sein (logische UND-Verknüpfung): Der User muss auf die VM zugreifen dürfen UND der Host muss die VM starten dürfen.
Die Dateirechte der VM- bzw. Snapshot-Verzeichnisse müssen so eingestellt sein (z.B. Zugriff für alle), das die Konfigurierten USER, GROUP, HOST, ROOM Zugriff auf die VM/den Snapshot besitzen.

Beispieldatei image.conf

.. code:: bash

  # Berechtigugen eine VM zu starten. 
  group=teachers
  host=
  room=lehrerzimmer

Hinweis: Die Berechtigung für einen einzelnen Snapshot wird nur dann korrekt ausgewertet, wenn beim HOST-LEVEL beide Optionen host und room auftauchen. Fehlt z.B. die „room“-Option ist jeder Raum und damit auch jeder Host zugelassen!

Stand Version 0.5.4-1 Juli 2015: Die Gruppen- und User-Beschränkung auf VM-Ebene wird z.Z. nicht korrekt ausgelesen → 'group' und 'user' damit ohne Funktion


Leoclient-1-VM's umziehen nach Leoclient2
-----------------------------------------

Umzug einer bestehenden virtuellen Maschine (VM) unter ``leoclient`` Version 1 auf ``leoclient2``. 
(Hinweis: Es kann grundsätzlich jede VM mit genau einem Snapshot integriert werden.)

Zunächst erzeugt man eine neue virtuelle Maschine nach Anleitung mit ``leoclient2-init`` (mit root-Rechten).
Die Größe der Festplatte sollte der Größe der Festplatte der vorhandenen Maschine entsprechen.
Der hier verwendete Name ``win-umzug`` kann natürlich angepasst werden.

Auf die Installation des Betriebssystems kann verzichtet und VirtualBox kann sofort wieder geschlossen werden.

Dann benötigt man die virtuelle Festplatte und den Standardsnapshot der alten VM und kopiert die virtuelle Festplatte (vdi-Datei) in das Verzeichnis der neuen VM unter ``leoclient2`` (hier nach ``/var/virtual/win-umzug``) auf die Festplatten-Datei (hier: ``win-umzug.vdi``).
Außerdem kopiert man den Snapshot in das Unterverzeichnis ``Snapshot`` unter Verwendung des bestehenden Dateinamens der Snapshot-Datei der neuen virtuellen Maschine (bestehende Datei ersetzen).

Anschließend startet man den ``leovirtstarter2`` mit normalen Benutzerrechten über die Konsole mit ``$ leovirtstarter2`` und wählt die neue erstellte Maschine aus. Die VM wird wie vorgefunden gestartet.

Da die Zuordnung in den Konfigurationsdateien noch nicht stimmt, bricht das Starten mit einer Fehlermeldung ab.

Den Hinweis aus der Fehlermeldung nimmt man zur Korrektur der Konfigurationsdatei für die neue VM (hier: ``/var/virtual/win-umzug/win-umzug.vbox``).
Dabei muss man in diesem Beispiel die Einträge ``{764a4d59-464c-45ea-bd58-ee5ba35c1f09}`` durch ``{a9fbe850-cb0d-45d1-a08b-619fc3457410}`` ersetzen (vgl. Fehlermeldung).
Die entsprechenden Abschnitte für HardDisks und StorageController könnten dann wie folgt aussehen:

.. code:: bash

    (...)
    <HardDisks>
      <HardDisk uuid="{a9fbe850-cb0d-45d1-a08b-619fc3457410}" location="win-umzug.vdi" format="VDI" type="Normal">
        <HardDisk uuid="{4852257a-b9b9-4a69-8b75-84555b24064d}" location="Snapshots/{4852257a-b9b9-4a69-8b75-84555b24064d}.vdi" format="VDI"/>
      </HardDisk>
    (...)
    <StorageControllers>
      <StorageController name="win-umzug" type="PIIX4" PortCount="2" useHostIOCache="true" Bootable="true">
        <AttachedDevice type="HardDisk" port="0" device="0">
          <Image uuid="{a9fbe850-cb0d-45d1-a08b-619fc3457410}"/>
        </AttachedDevice>
      </StorageController>
    </StorageControllers>
    (...)
    

Die Datei ``VirtualBox.xml`` muss nicht angepasst werden.

Anschließend sollte die neue-alte VM über den ``leovirtstarter2`` gestartet werden können.


Alte Dateien von leoclient (Version 1) entfernen
------------------------------------------------

Software-Pakete entfernen
`````````````````````````

Die Pakete des alten Leoclient müssen von Hand entfernt werden:

``# apt-get purge leoclient-leovirtstarter-client leoclient-leovirtstarter-common``
``# apt-get purge leoclient-leovirtstarter-server leoclient-tools leoclient-virtualbox leoclient-vm-printer``

Evtl. alte Daten von leoclient (Version 1) entfernen:

``# rm -rf /etc/leoclient``


Rechte korrigieren
``````````````````

Der leovirtstarter2 benötigt sudo-Rechte zur Starten der virtuellen Maschinen.
Dies wird mit dem folgenden Paket eingerichtet:

``# apt-get install linuxmuster-client-sudoers``

Eventuell muss auch die sudoers-Datei editiert werden. Dort sollten keine Einträge zu ``linuxmuster`` mehr vorhanden sein (ggf. löschen), da diese nach ``/etc/sudoers.d/10-linuxmuster-client-sudoers`` ausgelagert sind. 
Kommando zum Starten des Editors für die sudoers-Datei:

``# visudo``

z.B.: Inhalt der Datei:

``#``
``# This File MUST be edited with the 'visudo' command as root.``
``#``
``...``
``...``
``%sudo   ALL=(ALL:ALL) ALL``
``# see sudoers(5) for more Information on "#include" directives.``
``#includedir /etc/sudoers.d``


Hintergrundinformationen
------------------------

Virtuelle Maschine erzeugen
```````````````````````````

Beim Anlegen einer virtuellen Maschine mit ``leoclient2-init`` wird der Pfad zur Maschine in ``/etc/leoclient2/machines/MASCHINENNAME.conf`` gespeichert.

Nach Beenden von Virtualbox werden folgende Aktionen vom Script ausgeführt:
- Ein Snapshot wird erzeugt (in ``/PFAD/MASCHINENNAME/Snapshot/``) und dieser als Standard-Snapshot nach ``PFAD/MASCHINENNAME/snapshot-store/standard/`` gesichert.
- Außerdem werden die Konfigurationsdateien (compreg.dat, VirtualBox.xml, xpti.dat und MASCHINENNAME.vbox) gesichert nach ``/PFAD/MASCHINENNAME/defaults/``.
- Abschließend werden alle Dateirechte für den Einsatz gesetzt (z.B. ``/PFAD/MASCHINENNAME/MASCHINENNAME.vdi`` nur lesbar, da diese Datei nicht verändert werden darf)

Jede VM ist vollständig in ihrem Maschinenverzeichnis gespeichert.


Serverbasierte VM kopieren, lokaler cache
`````````````````````````````````````````

Die auf dem Server liegenden gezippten Basisimages und Snapshots werden (falls lokal nicht vorhanden oder verändert) beim Start in den lokalen cache kopiert und dann lokal an die Stelle entpackt, wo sie genutzt werden. Der Cache hat eine maximale Größe, die in ``SERVERDIR/caches.conf`` definiert wird. Es empfielt sich dafür ein lokales Datenlaufwerk zu verwenden. Falls das nicht vorhanden ist, ein Verzeichnis auf der Partition mit den virtuellen Maschinen.


Virtuelle Maschine starten
``````````````````````````

VirtualBox startet mit der Umgebungsvariablen ``VBOX_USER_HOME`` (``$ export VBOX_USER_HOME=/PFAD/MASCHINENNAME``) und mit der Einstellung für den Standardort für die VM für Virtualbox (``$ VBoxManage setproperty machinefolder /PFAD/MASCHINENNAME``).
Mit diesen Anpassungen und anschließendem Starten von Virtualbox (``$ VirtualBox``) kann eine VM auch von Hand gestartet werden.

Damit ``leovirtstarter2`` eine lokale Maschine findet, muss in ``/etc/leoclient2/machines/MASCHINENNAME.conf`` ihr Pfad eingetragen sein. (leoclient2-init erzeugt diese Datei automatisch). Der Standard-Pfad für die lokalen VM ist dabei ``/var/virtual/`` .

Außer den lokal vorhandenen Maschinen wird auch in allen in ``SERVERDIR`` konfigurierten Pfaden nach Maschinen gesucht. (Der Pfad MUSS NICHT remote liegen, allerdings geht ``leovirtstarter2`` davon aus und holt diese Maschinen in gezippter Form (Netzwerk-Bandbreitenschonend) zu den lokalen Maschinen und startet Sie dort). 
Der Standard-Pfad für die remote VM ist dabei ``/media/leoclient2-vm`` .

Auflisten kann man alle sichtbaren VM's mit:
``$ leovirtstarter2 -i``
``$ leovirtstarter2 --info``

Wird mit dem ``leovirtstarter2`` ein Snapshot einer VM zum Starten ausgewählt, wird folgendes abgearbeitet:
- Kopieren der Standard-Konfigurationsdateien aus ``/PFAD/MASCHINENNAME/defaults/`` nach ``/PFAD/MASCHINENNAME/`` 
- Anpassen folgender Angaben:

  - Shared Folder verbinden ins Heimatverzeichnis des angemeldeten Benutzers
  - Netzwerkeinstellungen (verschiedene Möglichkeiten stehen zur Verfügung)

- Starten der Maschine

Gibt es die Maschine auch Remote, können zusätzlich folgende Dinge erfolgen:
- Snapshots wird gegebenenfalls vom Server in den lokalen Cache kopiert.
- Reparatur des Basisimages, falls notwendig
- Update der lokalen VM durch die Remote-VM, falls verschieden.
- Der Snapshot wird aus dem Cache bzw. aus ``/PFAD/MASCHINENNAME/snapshot-store/default/`` nach ``/PFAD/MASCHINENNAME/Snapshots/{…}.vdi`` entzippt


VM direkt starten
`````````````````

Nachfolgendes Script startet direkt ohne Dialog eine VM. Das Script ermittelt den aktuellen Snapshot-Namen ``{…}.vdi`` aus der VBox-XML-Datei der VM. Dann wird der gezippte-Snapshot verwendet. Starten, „wie vorgefunden“ klappt nicht, wenn sich die VM im einem „gespeicherten Zustand“ befindet.
Script unter ``/usr/bin`` ablegen und ausführbar machen. Die Rechteanpassung erfolgt mit Hilfe des ``leovirtstarter2``. Eine Datei ``network.conf`` wird von dem Script nicht ausgewertet. Bei den Berechtigugen wird nur der Snapshot und die primäre Gruppe des Users überprüft
Aufruf z.B.:

``# leoclient2-directstart -m winxp -r 1024 -s standard``

.. code:: bash

  /usr/bin/leoclient2-directstart
  
    #! /bin/bash
    #
    #  /usr/bin/leoclient2-directstart -m <VM> -s <Snapshot> -r <RAM>
    #
    #  m: Name der lokalen VM
    #  s: Name des lokalen Snapshots, ohne wird "wie vorgefunden" verwendet
    #  r: RAM in MB
    #
    #  Version 3 - September 2015
     
    etcdir="/etc/leoclient2/machines"
    OPTIND=1
     
    vm=""
    S_NAME=""
    MACHINENAME=""
    MACHINEPATH=""
    RAM="1024"
     
    while getopts "m:s:r:" opt; do
        case "$opt" in
        m)  vm=$OPTARG
            ;;
        s)  S_NAME=$OPTARG
            ;;
        r)  RAM=$OPTARG
            ;;
        esac
    done
     
    shift $((OPTIND-1))
    [ "$1" = "--" ] && shift
     
    for file in "$etcdir"/*.conf; do
      pfad=`cat $file`
      b=$(basename "$pfad")
      if [ "$b" = "$vm" ] ; then
        MACHINENAME=$b
        MACHINEPATH=$pfad
      fi
    done
     
    if [ "$MACHINENAME" = "" ] ; then
      echo "ERROR: Die Virtuelle Maschine $vm wurde nicht gefunden!"
      exit 1
    fi
     
    sudo /usr/bin/leovirtstarter2 --set-permissions
     
    if [ "$S_NAME" != "" ] ; then
      SNAPSHOTPATH="$MACHINEPATH/snapshot-store/$S_NAME"
      if [ -d "$SNAPSHOTPATH" ]; then
        # Name des aktuellen Snapshots aus der VBox-XML-Dstei ermitteln
        XMLPATH="$MACHINEPATH/defaults/$MACHINENAME.vbox"
        SNAPSHOTNAME=`sed -n 's|.*location="Snapshots\/\([^"]*\).*|\1|p' $XMLPATH`
        # echo $SNAPSHOTNAME
        if [ -f "$SNAPSHOTPATH/$SNAPSHOTNAME.zip" ]; then
          rm -Rf "$MACHINEPATH/Snapshots"/*
          unzip "$SNAPSHOTPATH/$SNAPSHOTNAME.zip" -d "$MACHINEPATH/Snapshots"
          cp -f "$MACHINEPATH/defaults/$MACHINENAME.vbox" "$MACHINEPATH"
          echo "zip"
        elif [ -f "$SNAPSHOTPATH/$SNAPSHOTNAME.ZIP" ]; then
          rm -Rf "$MACHINEPATH/Snapshots"/*
          unzip "$SNAPSHOTPATH/$SNAPSHOTNAME.ZIP" -d "$MACHINEPATH/Snapshots"
          cp -f "$MACHINEPATH/defaults/$MACHINENAME.vbox" "$MACHINEPATH"
        else
          echo "ERROR: Snapshot $S_NAME wurde nicht gefunden!"
          exit 1
        fi
      fi
    fi
     
    # Berechtigungen des Snapshots Ueberpruefen
     
    if [ -f "$SNAPSHOTPATH/image.conf" ]; then
      auser=1
      ahost=1
      buser=0
      bhost=0
      HOST=$(hostname)
      ROOM=`groups $HOST | gawk -F" " '{ print $3 }'`
      GROUP=`groups $USER | gawk -F" " '{ print $3 }'`
      # echo  "---$USER---$GROUP---$HOST---$ROOM---"
      IFS="="
      while read -r name value
      do
        liste=${value//\"/}
        # echo "Inhalt von $name ist $liste"
        if [ "$name" == "user" ]; then
          auser=0
          IFS=","
          for u in $liste
            do
              if [ "$USER" == "$u" ]; then
                buser=1
                echo "Berechtigung user gefunden: $u"
              fi
            done
        fi
        if [ "$name" == "group" ]; then
          auser=0
          IFS=","
          for u in $liste
            do
              if [ "$GROUP" == "$u" ]; then
                buser=1
                echo "Berechtigung group gefunden: $u"
              fi
            done
        fi
        if [ "$name" == "host" ]; then
          ahost=0
          IFS=","
          for u in $liste
            do
              if [ "$HOST" == "$u" ]; then
                bhost=1
                echo "Berechtigung host gefunden: $u"
              fi
            done
        fi
        if [ "$name" == "room" ]; then
          ahost=0
          IFS=","
          for u in $liste
            do
              if [ "$ROOM" == "$u" ]; then
                bhost=1
                echo "Berechtigung room gefunden: $u"
              fi
            done
        fi
        IFS="="
      done < "$SNAPSHOTPATH/image.conf"
     
      if [ $auser = 0 ] && [ $buser = 0 ]; then
        echo "User/Group hat keine Berechtigung -> ABBRUCH"
        exit 1
      fi
     
      if [ $ahost = 0 ] && [ $bhost = 0 ]; then
        echo "Host/Room hat keine Berechtigung -> ABBRUCH"
        exit 1
      fi
    fi
     
    export VBOX_USER_HOME=$MACHINEPATH
     
    /usr/bin/VBoxManage sharedfolder remove "$vm" --name home 
    /usr/bin/VBoxManage sharedfolder add "$vm" --name home --hostpath "$HOME/Home_auf_Server"
    /usr/bin/VBoxManage modifyvm "$vm" --memory "$RAM"
    /usr/bin/VBoxManage startvm "$vm" --type gui
     
    exit 0

Zum bequemen Starten kann man einen Desktop-Starter anlegen, z.B. für die VM „winxp“ mit 1024 MB RAM und „standard“-Snapshot:

.. code:: bash

  leoclient2-directstart.desktop

    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=VirtualBox Direktstart
    Comment=Starting Snapshots of VirtualBox
    Comment[de]=Starten von VirtualBox Snapshots
    Exec=/usr/bin/leoclient2-directstart -m winxp -r 1024 -s standard
    Icon=leovirtstarter2
    Categories=Graphics;Engineering;
    Categories=Emulator;System;Application;
    Terminal=false

Hinweis: Nach Anlegen dieser Datei muss diese ausführbar gesetzt werden.


Datenstruktur einer VM
``````````````````````

Virtualbox-Dateien
In der obersten Verzeichnisebene im Verzeichnis der VM verwaltet VirtualBox die aktuell verwendete Maschine:
- Die Basisdatei ist ``MASCHINENNAME.vdi``, sie enthält den Basis-Zustand der Festplatte und ist meist mehrere GB groß
- Konfigurationsdateien
- Logdateien
- usw. ...
- Im Unterverzeichnis ``Snapshots`` verwaltet VirtualBox den aktuell verwendeten Snapshot {*}.vdi.

leoclient2-Dateien
- ``MASCHINENNAME.conf`` beinhaltet den Pfad in dem die VM erstellt wurde. Dorthin wird sie im Fall einer remoten Maschine auch wieder entpackt (funktioniert nur in diesem Pfad)
- ``network.conf`` ist optional. Konfiguriert die Netzwerkkarten der Virtuellen Maschine (falls keine network.conf speziell für den Snapshot exisiert)
- ``image.conf`` ist optional.
- Das Unterverzeichnis ``snapshot-store`` enthält in Unterverzeichnissen weitere Snapshots. (Bei einer lokalen VM ist meist nur das Verzeichnis standard vorhanden):
- ``{*}.vdi`` ist die Snapshot-Datei. 
- ``{*}.vdi.zip`` ist die gezippte Snapshot-Datei (nur etwa 1/3 so groß wie ``{*}.vdi)`` .
- ``filesize.vdi`` ist eine Textdatei und enthält die Größe von ``{*}.vdi`` .
- ``filesize.vdi.zipped`` ist eine Textdatei und enthält die Größe von ``{*}.vdi.zip`` .
- ``network.conf`` ist optional. Konfiguriert die Netzwerkkarten für diesen Snapshot.
- Das Unterverzeichnis ``defaults`` enthält ein Backup der Konfigurationsdateien. Vor dem Start der Maschine kann mit diesen Dateien die Maschine zurückgesetzt werden (Kopieren auf eine Verzeichnisebene höher).


Übersicht der Scripte/Befehle zum leoclient2
````````````````````````````````````````````

- leoclient2-init 		legt eine neue lokale VM an

- leovirtstarter2 		startet das grafische Auswahlfenster und anschließend die VM
  mit Optionen
  --info 	listet alle VMs auf der Konsole auf
  --vbox 	startet das grafische Auswahlfenster und VirtualBox ohne die VM zu starten
  -h 	        Hilfe anzeigen
  --local-snapshots 	nur lokale Snapshots listen
  --ignore-virtualbox 	startet den leovirtstarter auch wenn gerade VirtualBox ausgeführt wird
  --serverdir <abs path> 	verwendet anderen Pfad statt SERVERDIR zu den remote VMs

- leoclient2-base-snapshot-renew 		Erstellt eine neue Basisfestplatte mit dem aktuellen Snapshot der zur bisherigen Basisfestplatte ge-„merged“ wird. Der „Aktuelle Zustand“ wird somit gesichert/festgeschrieben.

- leoclient2-vm-move 		Importiert eine VM (z.B. vom externen Speichermedium) oder verschiebt ein VM

- VBoxManage 	mit vielen Optionen 	Konsolen-Tool zum Bearbeiten von VMs 


Entwicklungsdokumentation des leoclient2
````````````````````````````````````````

siehe http://www.linuxmuster.net/wiki/entwicklung:linuxclient:leoclient2


Fehlersuche - Fehlerbehebung
````````````````````````````

Log-Datei
'''''''''
Am Client findet man unter ``/tmp/leovirtstarter2.log`` die aktuelle log-Datei des ``leovirtstarters2`` zur Fehlersuche.

Endlosschleife bei ``leoclient2-base-snapshot-renew``
'''''''''''''''''''''''''''''''''''''''''''''''''''''
Problem: Das Script ``leoclient2-base-snapshot-renew`` läuft in eine Endlosschleife, wenn im Verzeichnis ``<lokaler Maschinenpfad>/Snapshots/`` eine verweiste Snapshot-Datei übrig bleibt.
Lösung: Die verweiste Snapshot-Datei manuell löschen, dann ``leoclient2-base-snapshot-renew`` nochmals ausführen.

Snapshot passt nicht zur Basisfestplatte
''''''''''''''''''''''''''''''''''''''''
Nach einem ``leoclient2-base-snapshot-renew`` werden bisherige Snapshots unbrauchbar und sollten auch nicht mehr verwendet werden. Der Snapshotname wird dabei auch geändert. In der Datei ``<Maschinennamen>.vbox`` wird der aktuell gültige ``Snapshotnamen {…}.vdi`` aufgeführt.
Problem: Unter ``<Maschinenpfad>/Snapshots`` liegt ein alter Snapshot, der Name passt nicht. VirtualBox startet deshalb nicht.
Lösung: Den Snapshot in ``<Maschinenpfad>/Snapshots`` manuell löschen und dann einen Snapshot mit dem aktuellen Namen aus ``<Maschinenpfad>/snapshot-store/standard/`` in das Verzeichnis ``<Maschinenpfad>/Snapshots`` kopieren.

``network.conf`` für lokalen Snapshot bereitstellen
'''''''''''''''''''''''''''''''''''''''''''''''''''
Problem: Aktuell wertet der ``leovirtstarter2`` eine ``network.conf`` im Verzeichnis des lokalen Snapshots nicht aus. (leoclient2-Version: 0.5.4-1)
Lösung: Wenn man jedoch eine ``network.conf`` im remote-Pfad des Snapshots ablegt, wird diese ausgewertet. Weitere Dateien müssen im remote-Pfad nicht vorhanden sein. Der remote-Pfad muss nicht zwingend remote liegen!
Z.B. mit den voreingestellten Standard-Pfaden des Snapshots „physik“:

    lokaler Snapshot-Pfad: ``/var/virtual/winxp1/snapshot-store/physik/...``
    ergibt ``network.conf``-Pfad: ``/media/leoclient2-vm/winxp1/snapshot-store/physik/network.conf``

``leovirtstarter2`` zeigt/startet "wie vorgefunden" nicht
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Problem: Im Auswahlmenü wird „wie vorgefunden“ nicht angezeigt oder kann nicht gestartet werden.
Ursache 1: Die VM wurde nicht ausgeschaltet sondern befindet sich in einem gespeicherten Zustand. Im Verzeichnis ``.../Snapshots`` befindet sich eine ``*.sav``-Datei.
Lösung 1: Den „Standard“-Snapshot starten oder die Maschine direkt mit VirtualBox starten und dann herunterfahren.
Ursache 2: Im Verzeichnis ``Maschinenpfad>/Snapshots/`` befinden sich überflüssige Dateien.
Lösung 2: Alle Dateien löschen bis auf den aktuellen Snapshot: ``{...}.vdi``. Der Name/die UUID des aktuellen Snapshots kann man (falls unklar) aus der ``<Maschinenname>.vbox``-Datei ermitteln.

