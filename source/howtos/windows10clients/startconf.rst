Konfiguration start.conf
========================



Schulkonsole
------------

Wechseln Sie auf den Reiter
LINBO. Klicken Sie auf der linken Seite auf
Gruppenkonfiguration editieren
und wählen anschließend die Gruppe (Hardwareklasse) die Sie editieren möchten.

|10000000000003FC0000030089B2BD2A_png|


Ändern Sie die Konfiguration nach Ihren Bedürfnissen und klicken Sie im Anschluss auf die Schaltfläche
Änderungen Speichern. Wichtig sind dabei die Einstellungen unter dem Punkt Systeme.

|1000000000000382000003C15DFFA156_png|


Server-Konsole
--------------

Geben Sie den Befehl
nano /var/linbo/start.conf.<gruppe>
ein.

|100000000000028800000188045E477F_png|

Ändern Sie die Konfiguration nach Ihren Bedürfnissen und verlassen danach den Editor speichernd.

|1000000000000295000002927824780F_png|


Beispiel start.conf
-------------------

Das ist eine Beispielkonfiguration für eine Partition 50GB für eine Windowsinstallation und eine Cachepartition 90GB.

.. code:: bash

    # LINBO start.conf

    # Windows 10 auf Partition 1 (NTFS)


    [LINBO]
    # globale Konfiguration

    Cache = /dev/sda2
    # lokale Cache Partition

    Server = 10.16.1.1
    # IP des Linbo-Servers, der das Linbo-Repository vorhält

    Group = vmpc
    # Achtung: Server und Group werden beim Workstationsimport automatisch gesetzt!

    RootTimeout = 600
    # automatischer Rootlogout nach 600 Sek.

    Autopartition = no
    # automatische Partitionsreparatur beim LINBO-Start

    AutoFormat = no
    # kein automatisches Formatieren aller Partitionen beim LINBO-Start

    AutoInitCache = no
    # kein automatisches Befüllen des Caches beim LINBO-Start

    DownloadType = torrent
    # Image-Download per Rsync

    BackgroundFontColor = white
    # Bildschirmschriftfarbe (default: white)

    ConsoleFontColorStdout = white
    # Konsolenschriftfarbe (default: white)

    ConsoleFontColorStderr = red
    # Konsolenschriftfarbe für Fehler-/Warnmeldungen (default: red)

    KernelOptions = acpi=noirq dhcpretry=5 irqpoll
    # LINBO-Kernel-Parameter (z. B. acpi=off), m. Leerz.
    Getrennt


    [Partition]
    # Start einer Partitionsdefinition, Windows 7 auf NTFS

    Dev = /dev/sda1
    # Device-Name der Partition (sda1 = erste Partition auf erster Platte)

    Size = 52428800
    # Partitionsgroesse in kB (Bsp.: 50GB)

    Id = 7
    # Partitionstyp (83 = Linux, 82 = swap, c = FAT32, 7 = NTFS, ...)

    FSType = ntfs
    # Dateisystem auf der Partition (NTFS)

    Bootable = yes
    # Bootable-Flag


    [Partition]
    # Start einer Partitionsdefinition, Ubuntu

    Dev = /dev/sda2
    # Device-Name der Partition (sda2 = zweite Partition auf erster Platte)

    Size =
    # Partitionsgroesse in kB (Bsp.: 90G)

    Id = 83
    # Partitionstyp (83 = Linux, 82 = swap, c = FAT32, 7 = NTFS, ...)

    FSType = ext4
    # Dateisystem auf der Partition (ext4)

    Bootable = no
    # Bootable-Flag


    [OS]
    # Beginn einer Betriebssystemdefinition

    Name = Windows 10
    # Name des Betriebssystems

    Version =
    # Version (optional, frei waehlbar)

    Description = Windows 1 Edu
    # Beschreibung

    IconName = winxp.png
    # Icon für die Startseite, muss unter /var/linbo/icons abgelegt sein

    Image =
    # kein differentielles Image definiert

    BaseImage = win10.cloop
    # Dateiname des Basisimages (Erweiterung .cloop)

    Boot = /dev/sda1
    # Partition, die Kernel & Initrd enthaelt

    Root = /dev/sda1
    # Rootpartition, in die das BS installiert ist

    Kernel = reboot
    # Relativer Pfad zum Kernel, bei Windows immer grub.exe

    Initrd =
    # Relativer Pfad zur Initrd, bei Windows immer leer

    Append =
    # bleibt bei Windows leer

    StartEnabled = yes
    # "Start"-Button deaktiviert

    SyncEnabled = yes
    # "Sync+Start"-Button anzeigen

    NewEnabled = yes
    # "Neu+Start"-Button anzeigen

    Hidden = yes
    # zeige OS-Reiter an

    Autostart = yes
    # automatischer synchronisierter Start dieses Betriebssystems: yes|no

    AutostartTimeout = 3
    # Timeout in Sekunden für Benutzerabbruch bei Autostart

    DefaultAction = start
    # DefaultAction bei Autostart: start|sync|new halt einer beispielhaften start.conf


.. |1000000000000295000002927824780F_png| image:: media/1000000000000295000002927824780F.png
    :width: 11.999cm
    :height: 11.944cm


.. |10000000000003FC0000030089B2BD2A_png| image:: media/10000000000003FC0000030089B2BD2A.png
    :width: 12.011cm
    :height: 9.042cm


.. |1000000000000382000003C15DFFA156_png| image:: media/1000000000000382000003C15DFFA156.png
    :width: 15.99cm
    :height: 17.112cm


.. |100000000000028800000188045E477F_png| image:: media/100000000000028800000188045E477F.png
    :width: 12.002cm
    :height: 7.261cm

