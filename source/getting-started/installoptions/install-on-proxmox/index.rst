.. include:: /guided-inst.subst

.. _install-on-proxmox-label:

============================
 Virtualisierung mit Proxmox
============================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@maurice <https://ask.linuxmuster.net/u/Maurice>`_

Proxmox ist eine OpenSource-Virtualisierungsplattform. Diese kombiniert KVM- und Container-basierte Virtualisierung und verwaltet virtuelle Maschinen, Container, Storage, virtuelle Netzwerke und Hochverfügbarkeits-Cluster übersichtlich über die zentrale Managmentkonsole.

Das web-basierte Verwaltungs-Interface läuft direkt auf dem Server. Zudem kann die Virtualisierungsumgebung via SSH administriert werden.

Proxmox VE eignet sich für den virtuellen Betrieb von linuxmuster.net besonders, da dieser Hypervisor dem OpenSource-Konzept entspricht. Der Einsatz wird auf jeglicher Markenhardware unterstützt und es gibt zahlreiche professionelle 3rd-Party Software für Backup-Lösungen und andere Features. „NoName-Hardware“ kann hiermit ebenfalls meist verwendet werden.

Diese Anleitung beinhaltet Angaben zu den notwendigen Systemanforderungen und Festplattenkonfigurationen, der Proxmoxinstallation und -integration sowie der anschließenden Hypervisorinstallation und -integration von Proxmox.

Zusätzlich sind Beschreibungen enthalten, wie du von uns bereitgestellte Vorlagen für virtuelle Maschinen der linuxmuster-Komponenten importieren kannst.

Systemvoraussetzungen
=====================

In der unten aufgeführten Tabelle findest du die Systemvoraussetzungen zum Betrieb der von uns bereitgestellten virtuellen Maschinen. Die Systemanforderungen für die Installation von Proxmox selbst finden sich im Web unter https://www.proxmox.com/de/proxmox-ve/systemanforderungen. 

Die Werte sind die voreingestellten Werte der VMs beim Import und bilden gleichzeitig die Mindestvoraussetzungen. Für die Installation mit Proxmox und linuxmuster v7 wird der 
`IP-Bereich 10.0.0.0/16` genutzt.

============ ============= ================ =====
VM           IP            HDD              RAM 
============ ============= ================ =====
OPNsense     10.0.0.254/16 10 GiB           4 GiB
Server       10.0.0.1/16   25 GiB u 100 GiB 4 GiB
OPSI         10.0.0.2/16   100 GiB          2 GiB
Docker-VM    10.0.0.3/16   100 GiB          2 GiB
Proxmox-Host 10.0.0.10/16  100 GiB          4 GiB
============ ============= ================ =====

Die Festplattengröße sowie der genutzte RAM der jeweiligen VMs kann nach deren Import
später einfach an die Bedürfnisse der Schule angepasst werden. 

Bevor du dieses Kapitel durcharbeitest, lese bitte zuerst die Abschnitte
  + :ref:`what-is-linuxmuster.net-label`,
  + (:ref:`what-is-new-label`),
  +  :ref:`install-overview-label` und
  +  :ref:`prerequisites-label`.

Für den Betrieb des Hypervisors selbst (Proxmox VE) sollten ca. 2 bis 6 GB Arbeitsspeicher eingeplant werden. Um nach Anleitung installieren zu können, sollte der Server mit mindestens 2 Netzwerkkarten bestückt sein. Durch VLANs kann der Betrieb aber auch bereits mit nur einer NIC erfolgen, bsp. 10 Gbit-Karte an einem Core-VLAN-Switch (L3).

Für die Basis dieser Installationsanleitung werden auf dem verfügbaren Speicherplatz des Proxmox-Servers zwei Festplatten eingerichtet. Eine mit 120 GB (SSD) Speichergröße für die Hypervisorinstallation selbst und eine zweite mit dem restlich verfügbaren Speicherplatz (hier 1 TiB - HDD als zweite Festplatte) als Speicher für die virtuellen Maschinen. Eine Aufteilung auf zwei Disks wird empfohlen, wenn vor allem viel Speicher für Bakup-, Schuldaten usw. benötigt wird. Eine einzelne Disk kann aber je nach Anforderung für die linuxmuster-Umgebung ebenfalls ausreichend sein.

Der Proxmox-Host sollte gemäß o.g. Minimalanforderungen folgende Merkmale aufweisen - sofern alle VMs eingesetzt werden:

  * RAM gesamt: mind. 16 GiB (besser: 32 GiB)
  * Erste HDD: mind 100 GiB für Proxmox selbst
  * Zweite HDD: für die VMs mit mind. 500 GB Kapazität (besser: 1 TiB oder 2 TiB)
  * Zwei Netzwerkkarten
  * Der Internetzugang des Proxmox-Hosts sollte zunächst gewährleistet sein, d.h. dieser wird z.B. an einen (DSL-)Router angeschlossen, der den Internet-Zugang sicherstellt. Sobald spalles eingerichtet ist, bekommt der Proxmox-Host eine IP-Adresse im Schulnetz und die Firewall OPNSense stellt den Internet-Zugang für alle VMs und den Proxmox-Host bereit.

.. hint:: 

   Virtualisierungs-Hosts sollten grundsätzlich niemals im gleichen Netz wie andere Geräte sein, damit dieser nicht von diesen angegriffen werden kann. In dieser Dokumentation wird zur Vereinfachung der Fall dokumentiert, dass der Proxmox-Host zu Beginn im externen Netz mit Internet-Zugriff und nach Abschluss der Installation im internen Schulnetz mit Internet-Zugriff via OPNSense- Firewall befindet. 

Bereitstellen des Proxmox-Hosts
===============================

.. hint:: 

   Der Proxmox-Host bildet das Grundgerüst für die Firewall *OPNsense* und
   den Schulserver *server*. Die Virtualisierungsfunktionen der CPU sollten 
   zuvor im BIOS aktiviert worden sein.

Die folgende Anleitung beschreibt die *einfachste* Implementierung ohne Dinge wie VLANs, Teaming oder RAID. Diese Themen 
werden in zusätzlichen Anleitungen betrachtet.

* :ref:`Anleitung Netzwerksegmentierung <subnetting-basics-label>` 

Die Download-Quellen für den Proxmox-Host selbst finden sich hier:

https://www.proxmox.com/de/downloads/category/iso-images-pve/

Dort findet sich das ISO-Image zur Installation von Proxmox (derzeit basiert unsere Beschreibung auf der Proxmox-Version 6.2).

Lade dir dort dieses Image herunter und erstelle dir einen bootfähigen USB-Stick zur weiteren Installation.

Erstellen eines USB-Sticks zur Installation des Proxmox-Host
------------------------------------------------------------

Nachdem du die ISO-Datei für Proxmox heruntergeladen hast, wechselst Du in das Download-Verzeichnis. Danach ermittel Du den korrekten Buchstaben für den USB-Stick unter Linux. X ist durch den korrekten Buchstaben zu ersetzen und dann ist nachstehender Befehl als Benutzer *root* oder mit einem *sudo* vorangestellt einzugeben:

.. code-block:: console
 
   dd if=proxmox-ve_6.2-1.iso of=/dev/sdX bs=1M status=progress conv=fdatasync
   
Verkabelungshinweise
--------------------

Es ist für linuxmuster.net ein internes Netz (grün) und ein externes Netz (rot) am Proxmox-Host zu unterscheiden. 
Sind zwei Netzwerkkarten im Proxmox-Host vorhanden, so ist die erste Netzwerkkarte (z.B. eth0, eno1 oder enp7s0), die zu 
Beginn eine IP aus dem bestehenden lokalen Netz (z.B. via DSL-Router) erhalten soll, mit dem Switch zu verbinden, der an den (DSL-)Router angeschlossen ist.

Die zweite Netzwerkkarte (z.B. eth1 oder enp7s1) ist dann an einen eigenen Switch anzuschliessen, ebenso wie alle Clients, die im internen Netz eingesetzt werden. 

Um zu Beginn den Proxmox-Host zu administrieren, ist ein Laptop mit dem Switch zu verbinden, der an den lokalen (DSL-)Router angeschlossen ist. Der Laptop erhält ebenfalls eine IP aus dem lokalen (DSL-)Netz und kann sich dann auf die zu Beginn eingerichtete IP-Adresse des Proxmox-Host auf die grafische Verwaltungsoberfläche verbinden. 

Installieren von Proxmox
========================

Basis-Installation
------------------

Vom USB-Stick booten, danach erscheint folgender Bildschirm:

.. figure:: media/install-on-proxmox_01_boot-menu.png
   :align: center
   :alt: Schritt 1 

Wähle `Install Proxmox VE` und starte die Installation mit `ENTER`.

.. figure:: media/install-on-proxmox_02_eula.png
   :align: center
   :alt: Schritt 2

Bestätige das `End-User Agreement` mit `Enter`.

.. figure:: media/install-on-proxmox_03_target-harddisk.png
   :align: center
   :alt: Schritt 3

Wähle die gewünschte Festplatte auf dem Server zur Installation aus. Hast du mehrere einzelne Festplatten im Server verbaut und kein RAID-Verbund definiert, so kannst du an dieser Stelle mithilfe der Schaltfläche `Optionen` weitere Einstellungen aufrufen. Hier kannst du z.B. mehrere Festplatten angeben, die in einem sog. ZFS-Pool definiert werden sollen. Dies ist für das Erstellen von sog. Snapshots von Vorteil. Soll aber an dieser Stelle nicht vertieft werden. 
(siehe hierzu u.a.: https://pve.proxmox.com/pve-docs/pve-admin-guide.html)

Nun bei den Location- and Time-Settings `Next` wählen:

.. figure:: media/install-on-proxmox_04_location-and-time-zone.png
   :align: center
   :alt: Schritt 4

Lege ein Kennwort für den Administrator des Proxmox-Host und eine E-Mail
Adresse fest. Klicke auf `Weiter`.

.. figure:: media/install-on-proxmox_05_admin-passord.png
   :align: center
   :alt: Schritt 5

Lege die IP-Adresse des Proxmox-Host im internen Netz fest. Solltest Du intern z.B. auf dem (DSL-)Router einen
DHCP-Server laufen haben, dann erhälst Du hier bereits eine vorausgefüllte Konfigurationsseite. Passe diese Werte nun den 
gewünschten Werten an. Der Hostname des Proxmox-Host ist hier in gewünschter Form - hier `hv01.linuxmuster.lan` -
anzugeben.

.. hint::

   Diese muss zu diesem Zeitpunkt der Installation diejenige Adresse sein, die ebenfalls Zugriff auf das Internet hat.
   In einem lokalen Netz mit DSL-Router wäre dies eine IP-Adresse aus dem internen Netz, die der Router für die internen Clients 
   verteilt - also z.B. 192.168.199.20/24. DNS- und Gateway-Adressen entsprechen der Router-IP.

Hier wurde die interne IP-Adresse `192.168.199.20/24` festgelegt.

.. figure:: media/install-on-proxmox_06_network-configuration.png
   :align: center
   :alt: Schritt 6

Überprüfe auf der Übersichtsseite, dass alle Angaben korrekt sind und fahre anschließend fort.

.. figure:: media/install-on-proxmox_07_install-summary.png
   :align: center
   :alt: Schritt 7

Warte den Abschluss der Installation ab.

.. figure:: media/install-on-proxmox_08_install-success.png
   :align: center
   :alt: Schritt 8

Nach erfolgreicher Installation lasse Proxmox über `Reboot` neustarten.


Proxmox Einrichtung
-------------------

Nach dem Neustart von Proxmox kannst du dich über einen PC, welcher sich im selben Netz befindet, über das
graphische Webinterface auf https://192.168.199.20:8006 mit `root` als `User name` und dem vorher gesetzten Passwort 
über Login anmelden:

.. figure:: media/install-on-proxmox_09_proxmox-login.png
   :align: center
   :alt: Schritt 9

Im Fenster `No valid subscription` `OK` wählen oder Fenster schließen:

.. figure:: media/install-on-proxmox_10_no-valid-subscription.png
   :align: center
   :alt: Schritt 10

Updates ermöglichen
-------------------

Um Proxmox Updates installieren zu können, müssen in der Shell des Nodes hv01 folgende Änderungen an den Repositories vorgenommen werden. Dafür den Node im Datacenter auswählen und eine Shell öffnen.

.. figure:: media/install-on-proxmox_11_open-shell.png
   :align: center
   :alt: Schritt 11

Folgende Befehle müssen der Reihe nach ausgeführt werden:

.. code::

   sed -i -e 's/^/#/' /etc/apt/sources.list.d/pve-enterprise.list
   echo deb http://download.proxmox.com/debian buster pve-no-subscription" >> /etc/apt/sources.list.d/pve-no-subscription.list


.. hint:

   Falls du die beiden Befehl via copy & paste übernimmst, prüfe, ob in der Eingabekonsole die Hochkommata erhalten bleiben.

.. code::

   apt update
   apt upgrade -y

Die Konsole kann nach dem erfolgreichen Update geschlossen werden.
   
Netzwerkbrücken einrichten
--------------------------

Für eine funktionierende Umgebung müssen zwei Netzwerkschnittstellen auf dem Hypervisor eingerichtet sein. 

Eine für das interne Netz (green, 10.0.0.0/16) und eine für das externe Netz (red, externes Netz, Internetzugriff). 

Nach der Erstinstallation von Proxmox wurde bislang nur eine sogenannte Bridge (vmbr0) eingerichtet. Diese ist mit der ersten Netzwerkschnittstelle des Proxmox-Hosts verbunden. Über deren Ethernet-Kabel der (DSL)-Router angeschlossen ist. Verlief der vorherige Befehl zur Aktualisierung von Proxmox erfolgreich, so weist du, dass diese bereits funktioniert und für die weitere Nutzung für das externe Netz (red) genutzt werden kann.  

Daher muss nun die zweite Schnittstelle eingerichtet werden, um später mit den noch zu importierenden VMs arbeiten zu können.

Für die internen virtuellen Netze ist also eine zweite Bridge zu erstellen, die an die zweite Netzwerkkarte direkt gebunden wird. Dieser wird allerdings keine IP-Adresse zugeordnet. 

Ausgangspunkt: `Host hv01` -> `Network`

Die bisherige Netzwerkkonfiguration stellt sich wie folgt dar:

.. figure:: media/install-on-proxmox_12_network.png
   :align: center
   :alt: Schritt 12

Für die folgende Überprüfung öffnet du nochmals die Konsole auf dem Hypervisor hv01 (wie oben beschrieben) und lässt dir den Inhalt der Konfigurationdatei mittels `cat /etc/network/interfaces` anzeigen. Dort finden sich bisher folgende Eintragungen:

.. code::

  auto lo
  iface lo inet loopback

  iface eno1 inet manual

  auto vmbr0
  iface vmbr0 inet static
        address 192.168.199.20
        netmask 255.255.255.0
        gateway 192.168.199.1
        bridge_ports eno1
        bridge_stp off
        bridge_fd 0

  iface eno2 inet manual

Nun erstellst Du die zweite Bridge:

Dazu wähle das Menü `Datacenter` -> `hv01`-> `Network`-> `Create` -> `Linux Bridge`

.. figure:: media/install-on-proxmox_13_network-add-bridge.png
   :align: center
   :alt: Schritt 13

Darauf öffent sich ein neues Fenster. Dort sind folgende Einträge nötig: 

============ ======
Feld         Inhalt
============ ======
Bridge ports eno2
Comment      green
============ ======

Mit `Create` wird die Brücke erstellen.

.. figure:: media/install-on-proxmox_14_create-linux-bridge.png
   :align: center
   :alt: Schritt 14

.. Bild muss ausgetauscht werden.

Anschließend Proxmox über den Button `Reboot` oben rechts neu starten, um die neuen Networking-Konfigurationen zu laden - Node hv01 muss dafür im Menü `Datacenter` links ausgewählt sein:

.. figure:: media/install-on-proxmox_14-01_reboot.png
   :align: center
   :alt: Schritt 14-1

Die Netzwerkkonfiguration des Proxmox-Host kannst du mit ``cat /etc/network/interfaces`` wie oben gezeigt in der Konsole überprüfen.
Die Datei sollte nachstehende Eintragungen aufweisen. Die angezeigte IP für die Bridge `vmbr0` muss der entsprechen, die bei Installation eingetragenen wurde.

.. code::

  auto lo
  iface lo inet loopback

  iface eno1 inet manual

  iface eno2 inet manual

  auto vmbr0
  iface vmbr0 inet static
        address 192.168.199.20/24
        gateway 192.168.199.1
        bridge-ports eno1
        bridge-stp off
        bridge-fd 0
  #red  

  auto vmbr1
  iface vmbr1 inet manual
        bridge-ports eno2
        bridge-stp off
        bridge-fd 0
  #green

Der Firewall müssen dann später beide Interfaces zugeordnet werden.

(Optional) Festplatten anpassen
-------------------------------

Zweiten Datenträger als Speicher einbinden
++++++++++++++++++++++++++++++++++++++++++

In diesem Schritt wird die zweite Festplatte in Proxmox eingebunden, um diese als Storage für die virtuellen Maschinen zu nutzen.

.. note::

   Die folgenden Schritte nur dann ausführen, wenn nicht auf einem einzigen Volume eingerichtet werden soll!

local-lvm(hv01)-Partition entfernen und Speicher freigeben
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Während der Proxmox-Installation wurden die Storages „local“ und „local-lvm“ automatisch auf der ersten Festplatte erstellt. Da anfangs für die Linuxmuster-Maschinen eine zweite Festplatte als „Storage“ eingerichtet wurde, wird „local-lvm“ nicht benötigt. Deshalb wird nun „local-lvm“ entfernt und „local“ durch den freigewordenen Speicher vergrößert, so dass auf der ersten 
Festplatte der gesamte Speicher dem Hypervisor zur Verfügung steht:

1. auf hv01 oben rechts Shell anklicken:

.. figure:: media/install-on-proxmox_11_open-shell.png
   :align: center
   :alt: Shell aufrufen

2. ``lsblk`` eingeben und mit der Enter-Taste bestätigen; folgende Ausgabe sollte erscheinen:

.. figure:: media/install-on-proxmox_14-02_console-lsblk-default.png
   :align: center
   :alt: Schritt 14-2

Es ist zu sehen, dass die Festplatten sda (931.5G) und sdb (111.8G) vorhanden sind. Die erste Festplatte sda ist eine HDD mit 1TB Kapazität und soll nun für die VMs genutzt werden. Die zweite Fstplatte ist eine SSD auf der Proxmox selbst installiert wurde. Von dieser zweiten Platte startet dieses System automatisch Proxmox. Zudem findet sich auf `sdb3` ein sog. `LVM`. Bei der Erstinstallation wurde hier automatisch ein Bereich für die VMs eingerichtet.

Dieser Bereich wird im Folgenden nun gelöscht und der frei werdende PLatz auf `sdb` wird vollständig dem Proxmox-Host zugeordnet. Danach wird die Festplatte `sda` als LVM für die VM eingerichtet.

3. Vorhandene local-lvm entfernen:

.. code::

   lvremove /dev/pve/data

.. figure:: media/install-on-proxmox_14-03-01_console-lvremote-question.png
   :align: center
   :alt: Schritt 14-3-1

Bestätige die Nachfrage mit ``y``

.. figure:: media/install-on-proxmox_14-03-02_console-lvremote-success.png
   :align: center
   :alt: Schritt 14-3-2

4. Speicherbereich von local erweitern:

.. code::

   lvresize -l +100%FREE /dev/pve/root

.. figure:: media/install-on-proxmox_14-04_console-lvresiz-success.png
   :align: center
   :alt: Schritt 14-4

5. Filesystem anpassen:

.. code::

   resize2fs /dev/mapper/pve-root

.. figure:: media/install-on-proxmox_14-05_console-resize2fs.png
   :align: center
   :alt: Schritt 14-5

6. über ``lsblk`` sollte nun zu sehen sein, dass pve-data-Partitionen entfernt wurden:

.. figure:: media/install-on-proxmox_14-06_console-lsblk-ready.png
   :align: center
   :alt: Schritt 14-6

Es ist zu erkennen, dass auf `/dev/sdb3` nur noch `pve-swap` und `pve-root` vorhanden sind. 

7. Auf der Weboberfläche von Proxmox ist der local-lvm Eintrag noch über `Datacenter → Storage local-lvm (hv01)` mit dem `Remove`-Button graphisch zu entfernen:

.. figure:: media/install-on-proxmox_14-07-01_storage-default.png
   :align: center
   :alt: Schritt 14-7-1

Danach findest Du noch folgenden Speicher:

.. figure:: media/install-on-proxmox_14-07-02_storage-after-remove.png
   :align: center
   :alt: Schritt 14-7-2

Die SSD `/dev/sdb` steht nun ganz für den Proxmox-Host selbst zur Verfügung.

Zweiten Datenträger vorbereiten
+++++++++++++++++++++++++++++++

Die erste Festplatte heißt hier sda und ersetzt die pve-data-Partition, die im vorigen Schritt entfernt wurde. Um diese für Proxmox vorzubereiten, stellt man über Konsolenbefehle einige Konfigurationen ein. Falls die Shell noch nicht geöffnet ist, wie oben beschrieben, öffnen und folgende Befehle eingeben:

.. hint::

  Für folgende Schritte: Die Bezeichnungen vg-xxx & lv-xxx Namen solltest du an deine Festplattengrößen 
  entsprechend anpassen, die folgenden Grafiken dienen zur Orientierung: `vg-hdd-1000` eignet sich 
  beispielsweise für ein Volume aus einer HDD mit 1 TiB Kapazität.

1. Datenträger vorher partitionieren z.B mit ``fdisk /dev/sda → , g → n → w`` (über lsblk den richtigen Datenträgernamen herausfinden; in diesem Fall sda)

.. figure:: media/install-on-proxmox_14-08_console-fdisk.png
   :align: center
   :alt: Schritt 14-8

2. Jetzt eine neue Partition auf der Festplatte anlegen - ``pvcreate /dev/sd<xy>1``

Beispiel: 

.. code::

   pvcreate /dev/sda1

und anschließend mit ``y`` bestätigen:

.. figure:: media/install-on-proxmox_14-09_console-pvcreate.png
   :align: center
   :alt: Schritt 14-9

3. Nun wird eine virtuelle Gruppe auf der ersten Partition der zweiten Festplatte eingerichtet: ``vgcreate vg-<disk>-<size> /dev/sd<xy>1``

Beispiel:

.. code::

   vgcreate vg-hdd-1000 /dev/sda1

.. figure:: media/install-on-proxmox_14-10_console-vgcreate.png
   :align: center
   :alt: Schritt 14-10

4. mit ``lvcreate -l 99%VG -n lv-<disk>-<size> vg-<disk>-<size>`` nun das logical volume erstellen. Hier ist die virtuelle Festplatte eine HDD mit 1 TiB Speicher, weshalb die Namen im Befehl so angepasst werden: 

Beispiel: 

.. code:: 

   lvcreate -l 99%VG -n lv-hdd-1000 vg-hdd-1000

.. figure:: media/install-on-proxmox_14-11_console-lvcreate.png
   :align: center
   :alt: Schritt 14-11

5. ``lvconvert --type thin-pool vg-<disk>-<size>/lv-<disk>-<size>`` konvertiert den Speicherbereich der erstellten virtual group als „thin-pool“:

Beispiel: 

.. code:: 

   lvconvert --type thin-pool vg-hdd-1000/lv-hdd-1000

.. figure:: media/install-on-proxmox_14-12_console-lvconvert.png
   :align: center
   :alt: Schritt 14-12

Datenträger graphisch als Storage in Proxmox anbinden
+++++++++++++++++++++++++++++++++++++++++++++++++++++

1. Im Menü `Datacenter > Storage > Add` wählt man „LVM-Thin“ aus. Im ID-Feld wird der Name des virtuellen Datenträgers angegeben. In diesem Fall ist es eine HDD mit 1 TiB Speicherkapazität, weshalb die Bezeichnung vd-hdd-1000 gewählt wird. Unter Volume Group die erstellte virtuelle Gruppe auswählen, welche hier vg-hdd-1000 ist:

.. figure:: media/install-on-proxmox_15-01_add-lvm-thin.png
   :align: center
   :alt: Schritt 15-1

2. Nun sollte im linken Menü der zweite Storage zu sehen sein, auf welchem die Maschinen für Linuxmuster installiert werden können:

.. figure:: media/install-on-proxmox_15-02_storage-ready.png
   :align: center
   :alt: Schritt 15-2


Importieren der Virtuellen Maschinen
====================================

Nachdem du den Host für die virtuellen Maschinen fertiggestellt hast, müssen diese nun importiert werden.

Unter Proxmox ist ein Import einer VM, die zuvor unter Proxmox als Backup gesichert wurde, der bevorzugte Weg.

VM Templates herunterladen
--------------------------

Fertige VM-Snapshots für Proxmox stellt linuxmuster.net auf dem eigenen Download-Server bereit. https://download.linuxmuster.net/proxmox/v7/latest/

Für eine linuxmuster.net v7 Umgebung werden die Server-VM und als Firewall die OPNSense-VM benötigt. Optional sind zusätzlich eine OPSI-VM und eine Docker-VM für deine linuxmuster.net-Umgebung verfügbar. 

Um die Maschinen importieren zu können, müsssen diese zuerst auf den Hypervisor geladen werden. Die VMs können über die Shell von Proxmox mit dem wget-Befehl direkt heruntergeladen werden. 

Für die VMs wären folgende Befehle anzugeben: 

=========== ===================================================================================================
VM          Download-Befehl                                                                                   
=========== ===================================================================================================
opnsense-VM wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-200-2020_11_22-21_52_36.vma.lzo
server-VM   wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-201-2020_11_22-21_42_16.vma.lzo
opsi-VM     wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-202-2020_11_22-21_35_56.vma.lzo
docker-VM   wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-203-2020_11_22-21_31_19.vma.lzo
=========== ===================================================================================================

Nach dem Herunterladen der Backup-Dateien sollten sich diese mittels ``ls -lh`` in der Proxmox-Shell anzeigen lassen.

.. figure:: media/install-on-proxmox_16_console-ls-downloaded-lzo.png
   :align: center
   :alt: Schritt 16

Die Besonderheiten zu den Archiv-Namen der VMs sind in nachstehendem Hinweis erläutert.

.. hint::

   Sollte ein Proxmox-Host mit der Verion 6.2 zum Einsatz kommen, sind die einzelnen Sicherungen der VMs
   nach folgendem Muster aufgebaut:

   vzdump-qemu-xxx-yyyy_mm_dd-hh_mi_ss.vma.lzo

   xxx –> ID

   yyyy –> Jahr

   mm –> Tag

   hh –> Stunde

   mi –> Minute

   ss –> Sekunde

   Der Befehl qmrestore erwartet ab Proxmox 6.2 einen solchen Archivnamen.

VM Templates importieren
------------------------

Liegen die VMs auf Proxmox, können die Abbilder als neue virtuelle Maschinen in der Shell über das `qmrestore-Tool` eingefügt werden. Für jede zu importierende Maschine ist der nachstehende Befehl anzupassen und auszuführen. Dabei sollte man sich im selben Verzeichnis befinden, in welchem die Abbilder liegen oder im Befehl den Pfad zur Datei angeben.

Der Befehl sollte mit dem Prinzip ``qmrestore <vmname.vma.lzo> <VM-ID> --storage <storage-name> -unique 1`` angewendet werden.

Dabei gilt:

*  Festvorgegeben:

   `<vmname.vma.lzo>` entspricht einem der Dateinamen in der obigen Tabelle im Abschnitt "VM Templates herunterladen".

*  Anzupassen an deine Umgebung:

   Mit `<VM-ID>` gibst du der VM eine ID, in unserer Beschreibung beispielsweise "200", "201", "202" und "203". (Dieser Vorgabe musst du nicht folgen, kannst sie also nach eigenen Vorgaben wählen.)

   `<storage-name>` ist der Name des Volumes, welchen du zuvor bei "Datenträger graphisch als Storage in Proxmox anbinden" vergeben hast. Hier in der Anleitung "vd-hdd-1000".

*  Weiterer Parameter:

   `-unique 1` generiert eine andere MAC-Addresse, als im Template exportiert.

Übersicht der Import-Befehle
----------------------------

=========== ===== =============================================================================================
VM          VM-ID Import-Befehl                                                                             
=========== ===== =============================================================================================
opnsense-VM 200   ``qmrestore vzdump-qemu-200-2020_11_22-21_52_36.vma.lzo 200 --storage vd-hdd-1000 -unique 1`` 
server-VM   201   ``qmrestore vzdump-qemu-201-2020_11_22-21_42_16.vma.lzo 201 --storage vd-hdd-1000 -unique 1`` 
opsi-VM     202   ``qmrestore vzdump-qemu-202-2020_11_22-21_35_56.vma.lzo 202 --storage vd-hdd-1000 -unique 1``
docker-VM   203   ``qmrestore vzdump-qemu-203-2020_11_22-21_31_19.vma.lzo 203 --storage vd-hdd-1000 -unique 1``
=========== ===== =============================================================================================

1. Hier wird als Beispiel der Server-Snapshot mit der ID 200 (lmn7-opnsense) auf dem vd-hdd-1000 Storage über folgenden Befehl importiert:

.. code::

   qmrestore vzdump-qemu-201-2020_11_22-21_42_16.vma.lzo 201 --storage vd-hdd-1000 -unique 1

.. figure:: media/install-on-proxmox_17_console-qmrestore.png
   :align: center
   :alt: Schritt 17

2. Wurden die gewünschten Maschinen erfolgreich importiert, sollten diese mit ihren IDs und Namen auf der Weboberfläche von Proxmox links aufgelistet zu sehen sein.

.. figure:: media/install-on-proxmox_18_vm-imported.png
   :align: center
   :alt: Schritt 18


Anpassung der VM-Einstellungen vor dem ersten Starten
=====================================================

Die VMs können nun vor dem Start recht einfach auf die eigenen Bedürfnisse und Anforderungen angepasst werden. So dürften z. B. die Größen für die Festplatten für größere Schulen zu klein sein, sodass diese angepasst werden müssen. Zudem sind die Netzwerkeinstellungen zu prüfen und ggf. anzupassen.

Diese Anpassungen können in der WebUI des Proxmox-Host recht einfach vorgenommen werden. Für nachstehende Änderungen müssen die VMs heruntergefahren sein, so wie dies direkt nach dem Import der Fall ist.

.. Auslagerung Kapitel Festplatten-Vergrößerung Beginn 

VM Festplattengrösse anpassen
-----------------------------

Am Beispiel der OPNSense VM werden die Anpassungen nachstehend erläutert.

Ausgangssituation:

.. figure:: media/install-on-proxmox_19_vm-overview.png
   :align: center
   :alt: Schritt 19

Die OPNSense VM wurde mit dem Namen `lmn7-opnsense` under `VM-ID: 200` angelegt. In der Übersicht erkennst du, dass derzeit
eine Festplatte mit einer Größe von 10 GiB eingerichtet wurde. 
Für den Einsatz in einem Produktivserver einer Schule dürfte dies zu klein sein. Die Festplattengröße kannst du nun wie folgt anpassen:

1. Wähle links im Menü die gewünschte VM aus und wähle dann in der Spalte daneben (Kontextmenü der VM) den Eintrag `Hardware` aus.

2. Rechts werden nun die Hardware-Komponenten der VM aufgelistet. Markiere den Eintrag `Hard disk`.

.. figure:: media/install-on-proxmox_20_vm-select-hdd.png
   :align: center
   :alt: Schritt 21

3. Klicke danach auf den Button `Resize Disk`, um die Festplatte der VM zu vergrößern.

.. hint:: 

   Auf diesem Wege ist nur eine Vergrößerung des Plattenplatzes möglich, eine Verkleinerung hingegen nicht!

4. Es erscheint ein neues Fenster, in dem du angeben must, um wieviel GiB du die Festplatte vergrößern willst. 

.. figure:: media/install-on-proxmox_21_vm-hdd-resize.png
   :align: center
   :alt: Schritt 21

5. In dem Beispiel sind 10 GByte gegeben, um auf 50 GByte zu kommen, trägst Du nun 40 GByte ein. Danach siehst Du folgenden Eintrag:

.. figure:: media/install-on-proxmox_22_vm-hdd-status.png
   :align: center
   :alt: Schritt 22

Für die anderen VMs werden die Festplatten in gleicher Weise vergrößert. 

Bei der Server-VM ist zu beachten, dass diese über zwei Festplatten verfügt. Die kleine Festplatte weist zu Beginn 25 GByte die größere 100 GByte auf. Beide sind zu vergrößern. Hierbei ist auf eine ausreichende Größe zu achten, da auf dem Server neben den Nutzer- und Klassendaten auch die von Linbo gespeicherten Festplattenabbilder der Clients abgelegt werden.

.. Auslagerung Kapitel Festplatten-Vergrößerung Ende

VM Netzwerkeinstellungen prüfen
-------------------------------

Die OPNSense VM weist zwei Netzwerkkarten auf, wie nachstehend dargestellt:

.. figure:: media/install-on-proxmox_23_vm-network-overview.png
   :align: center
   :alt: Schritt 23

.. todo:: hier weiter
   Erklärung bezüglich vmbr5 immer noch nötig?

Die Netzwerkkarte `net0` ist hier mit der Bridge `vmbr0` verbunden. Diese ist derzeit noch für das rote Netz / externes Netz zuständig. Im nächsten Schritt wird dies geändert, so dass die VMs mit der internen Schnittstelle an die Bridge `vmbr0` und die externe Schnittstelle der OPNSense-VM auf die dann externe Bridge `vmbr1` anzuschliessen ist.

Die Netzwerkkarte `net1` ist hier mit der Bridge `vmbr5` verbunden, die wir bislang gar nicht haben. Diese Netzwerkkarte muss nun mit unserer Bridge für das externe Netz `vmbr1` - Anpassungen siehe nächster Schritt - verbunden werden.

Wähle hierzu die Netzwerkarte `net1` aus und klicke auf `Edit`. Es erscheint ein Fenster mit den Einstellungen der Netzwerkkarte.
Ändere den Eintrag für die Bridge auf `vmbr1` wie in der Abb. zu sehen ist:

.. figure:: media/install-on-proxmox_24_vm-network-edit.png
   :align: center
   :alt: Schritt 24

Danach müssen für die OPNSense-VM die Netzwerkeintragungen wie folgt aussehen:

.. figure:: media/install-on-proxmox_25_vm-network-status.png
   :align: center
   :alt: Schritt 25

Für die VMs `server, opsi, docker` müssen die Einstellungen für die Netzzwerkkarte ebenfalls überprüft werden.
Alle müssen mit der `Bridge vmbr0 (internes Netz)` - siehe nächster Schritt - verbunden werden. Dies erfolgt wie zuvor dargestellt.

Proxmox - Host: Zugriff von außen unterbinden
=============================================

Um nach der Erstinstallation und -konfiguration den Zugriff auf den Proxmox - Host von außen zu unterbinden, ist nun die Netzwerkschnittstelle und die IP für den Proxmox-Host zu ändern. Zudem ist die Verkabelung zu ändern.

Das Management-Interface (WebUI) des Proxmox-Host ist immer auf `vmbr0` festgelegt. Daher müssen nun die IP-Einstellungen, 
die DNS-Auflösung und der Hostname an mehreren Stellen geändert werden.

Dies erledigst du mit folgenden drei Konfigurationsschritten:

**1. Ändern der sog. interfaces**

Du öffnest wie zuvor beschrieben die Shell des Proxmox-Host.
Dann editierst Du die Datei ``/etc/network/interfaces`` und speicherst die Änderungen.

Mit den in der Dokumentation zuvor angegebenen Adressen änderst Du die Eintragungen wie folgt:

.. code::

  auto lo
  iface lo inet loopback
  
  iface eno1 inet manual
  
  iface eno2 inet manual

  auto vmbr0
  iface vmbr0 inet static # externe NIC 
        address 10.0.0.20 #IP aus dem internen / gruenen Netz - IP des Proxmox-Host
        netmask 255.255.0.0  # Subnetzmaske 16 = 255.255.0.0
        gateway 10.0.0.254  #IP der OPNSense Firewall
        bridge-ports eno1 # erste NIC an vmbr0 gebunden
        bridge-stp off
        bridge-fd 0
  #Bridge green / intern

  auto vmbr1
  iface vmbr1 inet manual
        bridge-ports eno2 # Bridge an zweite NIC gebunden 
        bridge-stp off
        bridge-fd 0
  #Bridge red / extern

Physikalisch ist bislang die erste Netzwerkkarte mit dem (DSL-)Router und die zweite Netzwerkkarte mit dem Switch zu verbinden, der für das interne Netz genutzt wird - wie zuvor beschrieben. Dies ändert sich nun. Die Netzwerkkarte `eno1` wird auf den `internen Switch` verkabelt und die Netzwerkkarte `eno2` wird auf den `externen -Swicth / (DSL-)Router` verkabelt.

**2. Ändern des Hostnames**

Öffne die Datei ``/etc/hosts`` und ändere diese wie folgt:

.. code::

   127.0.0.1 localhost.localdomain localhost
   10.0.0.20 hv01.linuxmuster.lan hv01

IPv6 - Einträge mit `::1` oder mit `fe` und `ff` beginnend können so bleiben.

**3. Ändern der DNS-Auflösung**

Öffne die Datei ``/etc/resolv.conf`` und ändere diese wie folgt:

.. code::

   search linuxmuster.lan
   nameserver 10.0.0.254

Dies ist die interne IP-Adresse der OPNSense Firewall.

Zur Übernahme der Einstellungen ist der Proxmox-Host neu zu starten. (`Reboot`)

.. attention::

   Nach dem Neustart kannst du nicht mehr mit dem Laptop, der bislang auf dem Switch für das externe Netz steckt und eine IP aus dem Bereich 192.168.199.x/24 hat, mit der Proxmox-GUI verbinden. Schließe die erste Netzwerkkarte (eno1) des Servers und den Admin-Laptop auf den internen Switch an und konfiguriere den Laptop mit der IP 10.0.0.10/16, Gateway & DNS 10.0.0.254. Stecke das Netzwerkkabel der zweiten Netzwerkkarte (eno2) auf den externen Switch / (DSL-)Router).

Die WebUI des Proxmox-Host erreichst du über den Laptop mit der IP `10.0.0.10/16`, der am internen Switch angeschlossen ist, mit der Adresse `https://10.0.0.20:8006`.

Virtuelle Maschinen starten
===========================

Nachdem du dich mit dem Proxmox-Host neu verbunden hast, starte zunächst die Firewall-VM (OPNSense). 
Anschließend startest du die anderen VMs.

Nach dem ersten Start der Server-VM laufen diverse automatische Anpassungen ab, wie die Auslastung der CPU zeigt: 

.. figure:: media/install-on-proxmox_26_cpu-utilization.png
   :align: center
   :alt: CPU-Auslastung

Bevor du fortfährst warte ab, bis die Auslastung zurückgegangen ist. 

Nachdem dein Hypervisor läuft und die VM erfolgreich gestartet sind, muss das Setup deiner
linuxmuster.net-Installation durchgeführt werden. 

Konfiguriere zuerst die Firewall, indem Du dort die Netzwerschnittstellen korrekt zuweist und die IP-Adressen zuordnest. 
Diese sorgt nun dafür, dass das gesamte System Zugriff auf exterene Netze / das Internet hat.

Zum jetzigen Zeitpunkt hat dein Proxmox-Host keine Internet-Verbindung. Diese erhält dieser erst wieder, wenn die OPNSense-VM eingerichtet wurde.

============================ =================
Weiter geht es mit dem Setup |follow_me2setup|
============================ =================

..
   ================================================ ===========================================
   Weiter geht es mit der Anpassung der Festplatten |follow_me2linux-adjusting_hard_drive_size|
   ================================================ ===========================================

