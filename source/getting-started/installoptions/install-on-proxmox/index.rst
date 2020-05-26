.. _install-on-proxmox-label:

============================
 Virtualisierung mit Proxmox
============================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@maurice <https://ask.linuxmuster.net/u/Maurice>`_

Proxmox ist eine OpenSource-Virtualisierungsplattform. Diese kombiniert KVM- und Container-basierte Virtualisierung und vewaltet virtuelle Maschinen, Container, Storage, virtuelle Netzwerke und Hochverfügbarkeits-Cluster übersichtlich über die zentrale Managmentkonsle.

Das web-basierte Verwaltungs-Interface läuft direkt auf dem Server.

Diese Dokumentation stellt eine "Schritt-für-Schritt" Anleitungen für die
Installation der linuxmuster.net-Musterlösung in der Version 7 auf
Basis von Proxmox dar.

Es werden diverse Installationsautomatismen verwendet, sodass keine erweiterten Kenntnisse für die Installation notwendig sind. Eine vollständige Installation des Hypervisors, der Import aller VMs sowie die Konfiguration laut Anleitung benötigen ca. 80 Minuten.

Proxmox VE eignet sich für den virtuellen Betrieb von linuxmuster.net besonders, da er nahtlos dem OpenSource-Konzept entspricht. Der Einsatz wird auf jeglicher Markenhardware unterstützt und es gibt zahlreiche professionelle 3rd-Party Software für Backup und andere Features. Die meiste „NoName-Hardware“ kann ebenfalls nativ verwendet werden.

Diese Anleitung beinhaltet Angaben zu den notwendigen Systemanforderungen und Festplattenkonfigurationen, der Proxmoxinstallation und -integration sowie der anschließenden Hypervisorinstallation und -integration von Proxmox.

Zusätzlich sind Beschreibungen enthalten, wie du von uns bereitgestellte Vorlagen für virtuelle Maschinen der linuxmuster-Komponenten importieren kannst.

Systemvoraussetzungen
=====================

In der unten aufgeführten Tabelle findest du die Systemvoraussetzungen zum Betrieb der von uns bereitgestellten virtuellen Maschinen. Die Systemanforderungen für die Installation von Proxmox selbst finden sich im Web unter https://www.proxmox.com/de/proxmox-ve/systemanforderungen. 

Die Werte sind die voreingestellten Werte der VMs beim Import und bilden gleichzeitig die Mindestvoraussetzungen. Für die Installation mit Proxmox und linuxmuster v7 wird der 
``IP-Bereich 10.0.0.0/16`` genutzt.

+--------------+--------------------+-------------------+--------+
| VM           | IP                 | HDD               | RAM    |
+==============+====================+===================+========+
| OPNsense     | 10.0.0.254/16      | 40 GiB            | 4 GiB  |
+--------------+--------------------+-------------------+--------+
| Server       | 10.0.0.1/16        | 50 GiB u 100 GiB  | 8 GiB  |
+--------------+--------------------+-------------------+--------+
| OPSI         | 10.0.0.2/16        | 100 GiB           | 4 GiB  |
+--------------+--------------------+-------------------+--------+
| Docker-Host  | 10.0.0.3/16        | 100 GiB           | 6 GiB  |
+--------------+--------------------+-------------------+--------+
| Proxmox-Host | 10.0.0.10/16       | 100 GiB           | 6 GiB  |
+--------------+--------------------+-------------------+--------+

Bevor du dieses Kapitel durcharbeitest, lese bitte zuerst die Abschnitte
  + :ref:`what-is-linuxmuster.net`,
  + (:ref:`release-information-label`),
  +  :ref:`install-overview-label` und
  +  :ref:`prerequisites-label`.

Für den Betrieb des Hypervisors (Proxmox VE) sollten ca. 2 bis 6 GB Arbeitsspeicher eingeplant werden. Um nach Anleitung installieren zu können, sollte der Server mit mindestens 2 Netzwerkkarten bestückt sein. Durch VLANs kann der Betrieb aber auch bereits mit nur einer NIC erfolgen, bsp. 10 Gbit-Karte an einem Core-VLAN-Switch (L3).

Für die Basis dieser Installationsanleitung werden auf dem verfügbaren Speicherplatz des Proxmox-Servers zwei Festplatten eingerichtet. Eine mit 100 GB Speichergröße für die Hypervisorinstallation selbst und eine zweite mit dem restlich verfügbaren Speicherplatz (hier 1700 GB) als Speicher für die virtuellen Maschinen. Eine Aufteilung auf zwei Disks wird empfohlen, wenn vor allem viel Speicher für Bakup-, Schuldaten usw. benötigt wird. Eine einzelne Disk kann aber je nach Anforderung für die linuxmuster-Umgebung ausreichend sein.

* Der Internetzugang des Proxmox-Hosts sollte zunächst gewährleistet sein, d.h. dass dieser zunächst z.B. an einem Router angeschlossen wird. Sobald später die Firewall OPNSense korrekt eingerichtet ist, bekommt der Proxmox-Host eine IP-Adresse im Schulnetz.

.. hint:: 

   Virtualisierungs-Hosts sollten grundsätzlich niemals im gleichen Netz wie andere Geräte sein, damit dieser nicht von diesen angegriffen werden kann. In dieser Dokumentation wird zur Vereinfachung der Fall dokumentiert, dass der Proxmox-Host sich im internen Schulnetz befindet.

Bereitstellen des Proxmox-Hosts
===============================

.. hint:: 

   Der Proxmox-Host bildet das Grundgerüst für die Firewall *OPNsense* und
   den Schulserver *server*. Die Virtualisierungsfunktionen der CPU sollten 
   zuvor im BIOS aktiviert worden sein.

Die folgende Anleitung beschreibt die *einfachste* Implementierung
ohne Dinge wie VLANs, Teaming oder RAID. Diese Themen werden in
zusätzlichen Anleitungen betrachtet.

* :ref:`Anleitung Netzwerksegmentierung <subnetting-basics-label>` 

Die Download-Quellen für den Proxmox-Host selbst finden sich hier:

https://www.proxmox.com/de/downloads

Dort findet sich das ISO-Image zur Installation von Proxmox (derzeit basiert unsere Beschreibung noch auf der Version 6.1).

Lade dir dort dieses Image herunter und erstelle dir einen bootfähigen USB-Stick zur weiteren Installation.


Erstellen eines USB-Sticks zur Installation des Proxmox-Host
------------------------------------------------------------

Nachdem du die ISO-Datei für Proxmox heruntergeladen hast,
wechsel in das Download-Verzeichnis. Ermittel den korrekten Buchstaben für den USB-Stick unter Linux. X ist durch den korrekten Buchstaben zu ersetzen und dann ist nachstehender Befehl einzugeben:

.. code-block:: console
 
   dd if=proxmox-ve_6.1-1.iso of=/dev/sdX bs=8M status=progress oflag=direct


Installieren von Proxmox
========================

Basis-Installation
------------------

Vom USB-Stick booten, danach erscheint folgender Bildschirm:

.. figure:: media/image_1.png
   :align: center
   :alt: Schritt 1 

Wähle ``Install Proxmox VE`` und starten die Installation mit ``ENTER``.

.. figure:: media/image_2.png
   :align: center
   :alt: Schritt 2

Bestätige das ``End-User Agreement`` mit ``Enter``.

.. figure:: media/image_3.png
   :align: center
   :alt: Schritt 3

Wähle die gewünschte Festplatte auf dem Server zur Installation aus. Hast du mehrere einzelne Festplatten im Server verbaut und kein RAID-Verbund definiert, so kannst du an dieser Stelle mithilfe der Schaltfläche ``Optionen`` weitere Einstellungen aufrufen. Hier kannst du z.B. mehrere Festplatten angeben, die in einem ZFS-Pool definiert werden sollen. Dies ist für das Erstellen von sog. Snapshots von Vorteil. Soll aber an dieser Stelle nicht vertieft werden.

Nun bei den Location- and Time-Settings Next wählen:

.. figure:: media/image_4.png
   :align: center
   :alt: Schritt 4

Lege ein Kennwort für den Administrator des Proxmox-Host und eine E-Mail
Adresse fest. Klicke auf ``Weiter``.

.. figure:: media/image_5.png
   :align: center
   :alt: Schritt 5

Lege die IP-Adresse des Proxmox-Host im internen Netz fest. Hier wurde die interne IP-Adresse ``10.0.0.10/16`` festgelegt.

.. figure:: media/image_6.png
   :align: center
   :alt: Schritt 6

Überprüfe auf der Übersichtsseite, dass alle Angaben korrekt sind und fahre anschließend fort.

.. figure:: media/image_7.png
   :align: center
   :alt: Schritt 7

Warte den Abschluss der Installation ab.

.. figure:: media/image_8.png
   :align: center
   :alt: Schritt 8

Nach erfolgreicher Installation lasse Proxmox über ``Reboot`` neustarten.


Proxmox Einrichtung
-------------------

Nach dem Neustart von Proxmox kannst du dich über einen PC, welcher sich im selben Netz befindet, über das
graphische Webinterface auf https://10.0.0.10:8006 mit ``root`` als User name und dem vorher gesetzten Passwort über Login anmelden:

.. figure:: media/image_9.png
   :align: center
   :alt: Schritt 9

Im Fenster ``No valid subscription`` ``OK`` wählen oder Fenster schließen:

.. figure:: media/image_10.png
   :align: center
   :alt: Schritt 10

Updates ermöglichen
-------------------

Um Proxmox Updates installieren zu können, müssen in der Shell

.. figure:: media/image_11.png
   :align: center
   :alt: Schritt 11

folgende Befehle der Reihe nach ausgeführt werden:

.. code::

   sed -i -e 's/^/#/' /etc/apt/sources.list.d/pve-enterprise.list
   echo "deb http://download.proxmox.com/debian stretch pve-no-subscription" >> /etc/apt/sources.list.d/pve-no-subscription.list

.. figure:: media/image_12.png
   :align: center
   :alt: Schritt 12

.. code::

   apt update
   apt upgrade -y

Die Konsole kann nach dem erfolgreichen Update geschlossen werden.
   
Internetzugriff einrichten
--------------------------

Für eine funktionierende Umgebung sollten zwei Netzwerkschnittstellen auf dem Hypervisor eingerichtet sein. Eine für das interne Netz (green, 10.0.0.0/16) und eine für das externe Netz und den Internetzugriff (red, externes Netz). An diesem Punkt ist auf dem Hypervisor lediglich die interne Netzwerkschnittstelle (green), welche bei der Installation eingerichtet wurde. Daher muss nun die zweite Schnittstelle eingerichtet werden, um eine Internetverbindung aufbauen zu können.

Zweite Netzwerkbrücke hinzufügen
++++++++++++++++++++++++++++++++

Bislang ist nur eine Bridge für das interne Netz vorhanden. Um von Proxmox externen Internetzugriff zu erhalten, muss eine zweite Bridge erstellt werden. Dazu das Menü hv01 > Network > Create > Linux Bridge wählen:

.. figure:: media/image_13.png
   :align: center
   :alt: Schritt 13

Unter Bridge/Slave den physiaklischen Ausgangsport eintragen, an dem das externe Netz erreicht wird. In unserem Fall ist das eno4. Im Feld ``Comment`` ``red`` eingeben. Mit ``Create`` die Brücke erstellen:

.. figure:: media/image_14.png
   :align: center
   :alt: Schritt 14

Anschließend Proxmox über den Button ``Reboot`` oben rechts neu starten, um die neuen Networking-Konfigurationen zu laden. (Node hv01 muss dafür im Menü links ausgewählt sein):

.. figure:: media/image_14-1.png
   :align: center
   :alt: Schritt 14-1

Der Firewall müssen dann später beide Interfaces zugeordnet werden

Zweiten Datenträger als Speicher einbinden
++++++++++++++++++++++++++++++++++++++++++

In diesem Schritt wird die zweite Festplatte in Proxmox eingebunden, um diese als Storage für die virtuellen Maschinen zu nutzen.

.. note::

   Die folgenden Schritte nur dann ausführen, wenn vorher eine zweite virtuelle Disk für die virtuellen Maschinen vorbereitet wurde und nicht auf einem einzigen Volume eingerichtet werden soll!

local-lvm(hv01)-Partition entfernen und Speicher freigeben
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Während der Proxmox-Installation wurden die Storages „local“ und „local-lvm“ automatisch auf der ersten virtuellen Festplatte erstellt. Da anfangs für die Linuxmuster-Maschinen eine zweite virtuelle Festplatte als „Storage“ eingerichtet wurde, wird „local-lvm“ nicht benötigt. Deshalb wird nun „local-lvm“ entfernt und „local“ durch den freigewordenen Speicher vergrößert:

1. auf hv01 oben rechts Shell anklicken:

.. figure:: media/image_11.png
   :align: center
   :alt: Shell aufrufen

2. lsblk eingeben und mit der Enter-Taste bestätigen; folgende Ausgabe sollte erscheinen:

.. figure:: media/image_14-2.png
   :align: center
   :alt: Schritt 14-2

3. lvremove /dev/pve/data entfernt local-lvm:

.. figure:: media/image_14-3.png
   :align: center
   :alt: Schritt 14-3

4. lvresize -l +100%FREE /dev/pve/root erweitert den Speicherbereich von local-lvm:

.. figure:: media/image_14-4.png
   :align: center
   :alt: Schritt 14-4

5. mit resize2fs /dev/mapper/pve-root dsa Filesystem anpassen:

.. figure:: media/image_14-5.png
   :align: center
   :alt: Schritt 14-5

6. über lsblk sollte nun zu sehen sein, dass pve-data-Partitionen entfernt wurden:

.. figure:: media/image_14-6.png
   :align: center
   :alt: Schritt 14-6

7. Auf der Weboberfläche von Proxmox über Datacenter → Storage local-lvm (hv01) mit dem Remove Button graphisch entfernen:

.. figure:: media/image_14-7.png
   :align: center
   :alt: Schritt 14-7

Zweiten Datenträger vorbereiten
+++++++++++++++++++++++++++++++

Die zweite virtuelle Festplatte heißt hier sdb und ersetzt die pve-data-Partition, die im vorigen Schritt entfernt wurde. Um diese für Proxmox vorzubereiten, stellt man über Konsolenbefehle einige Konfigurationen ein. Falls die Shell noch nicht geöffnet ist, wie oben beschrieben, öffnen und folgende Befehle eingeben:

(Für folgende Schritte vg- & lv- Namen solltest du an deine Festplattengrößen entsprechend anpassen, die folgenden Grafiken dienen zur Orientierung; „vg-ssd-1700“ eignet sich beispielsweise für ein Volume aus SSDs mit 1700GB )

1. Datenträger vorher partitionieren z.B mit fdisk /dev/sdb → , g → n → w (über lsblk den richtigen
Datenträgernamen herausfinden; in diesem Fall sdb)

.. figure:: media/image_14-8.png
   :align: center
   :alt: Schritt 14-8

2. pvcreate /dev/sd<xy>1
Beispiel: pvcreate /dev/sdb1 und anschließend mit y bestätigen:

.. figure:: media/image_14-9.png
   :align: center
   :alt: Schritt 14-9

3. vgcreate vg-<disk>-<size> /dev/sd<xy>1
mit Beispiel:vgcreate vg-ssd-1700 /dev/sdb1 eine virtuelle Gruppe auf sdb erstellen:

.. figure:: media/image_14-10.png
   :align: center
   :alt: Schritt 14-10

4. lvcreate -l 99%VG -n lv-<disk>-<size> vg-<disk>-<size>
nun das logical volume erstellen; hier ist die virtuelle Festplatte eine SSD mit 1.7TB Speicher, weshalb die Namen im Befehl so angepasst werden: 
Beispiel: lvcreate -l 99%VG -n lv-ssd-1700 vg-ssd-1700:

.. figure:: media/image_14-11.png
   :align: center
   :alt: Schritt 14-11

5. lvconvert –tpype thin-pool vg-<disk>-<size>/lv-<disk>-<size>
Beispiel: lvconvert –tpype thin-pool vg-ssd-1700/lv-ssd-1700 konvertiert den Speicherbereich der
erstellten virtual group als „thin-pool“ (Beachte die zwei Bindestriche vor dem Wort „type“):

.. figure:: media/image_14-12.png
   :align: center
   :alt: Schritt 14-12

Datenträger graphisch als Storage in Proxmox anbinden
+++++++++++++++++++++++++++++++++++++++++++++++++++++

1. Im Menü ``Datacenter > Storage > Add`` wählt man „LVM-Thin“ aus. Im ID-Feld wird der Name des virtuellen Datenträgers angegeben. In diesem Fall ist es eine SSD mit 1.70TB Speicherkapazität, weshalb die Bezeichnung vd-ssd-1700 gewählt wird. Unter Volume Group die erstellte virtuelle Gruppe auswählen, welche hier vg-ssd-1700 ist:

.. figure:: media/image_15-1.png
   :align: center
   :alt: Schritt 15-1

2. Unter Thin Pool das logical volume auswählen:

.. figure:: media/image_15-2.png
   :align: center
   :alt: Schritt 15-2

3. Bei Node den Hypervisor, welcher hier „hv01“ heißt, auswählen:

.. figure:: media/image_15-3.png
   :align: center
   :alt: Schritt 15-3

4. Nun sollte im linken Menü der zweite Storage zu sehen, auf welchem die Maschinen für die Linuxmuster-Lösung installiert werden können:

.. figure:: media/image_15-4.png
   :align: center
   :alt: Schritt 15-4

Importieren der Virtuellen Maschinen
====================================

Nachdem du den Host für die virtuellen Maschinen fertiggestellt hast, müssen diese nun importiert werden.

Dazu gibt es zwei Wege, die wir dir der Vollständigkeitshalber auch beide aufzeigen wollen.

1. Import mittels OVA Dateien
2. Import mittels VM Templates

Welche du verwendest, bleibt dir überlassen. Lese am besten beide Beschreibung bis zum Ende durch und entscheide dann selbst.
Gegenüberstellung von 1 und 2: Vorteile der OVA-Dateien ist deren geringere Größe mit dem Nachteil eines Mehraufwands bei der Installation.

1. OVA Dateien
--------------

Download der Appliances OVA
+++++++++++++++++++++++++++

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         |
+====================+======================================================================+
| lmn7.opnsense      | OPNsense Firewall VM  der linuxmuster.net v7                         |
+--------------------+----------------------------------------------------------------------+
| lmn7.server        | Server der linuxmuster.net v7                                        |
+--------------------+----------------------------------------------------------------------+

Nachstehende VMs sind optional, sofern eine paketorientierte Softwareverteilung für Windows-Clients (OPSI-Server), eigene Web-Services mithilfe eines sog. Docker-Hosts betrieben und/oder eine WLAN-Anbindung via Ubiquiti bereitgestellt werden soll. 
Stelle dir folgende Fragen:

    Wird ein OPSI-Server definitiv nie gebraucht?
    Wird ein Docker-Host definitinv nie gebraucht?
    Wird ein Unifi-Controller von Ubiquiti nie gebraucht?

Sollte deine Antwort auf eine dieser Fragen nicht ein klares "Ja, wird nie gebraucht!" sein, dann raten wir dir diese virtuelle Maschine mitzuinstallieren.

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         |
+====================+======================================================================+
| lmn7.opsi          | OPSI VM der lmn v7                                                   |
+--------------------+----------------------------------------------------------------------+
| lmn7.docker        | Bereitstellung eigener Web-Dienste mithilfe eines Docker-Hosts       |
+--------------------+----------------------------------------------------------------------+
| lmn7.unifi         | Controller der Ubiquiti WLAN - Lösung                                |
+--------------------+----------------------------------------------------------------------+


``Download der OVAs`` unter: `Download OVAs VM v7 <https://download.linuxmuster.net/ova/v7/latest/>`_

Herunterladen der benötigten OVAs kannst du sie direkt über die Shell von Proxmox mit dem wget-Befehl. 

Für die VMs wären es folgende Befehle: 

.. code::

    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-docker-20200421.ova
    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-docker-20200421.ova.sha256
    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-opnsense-20200421.ova
    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-opnsense-20200421.ova.sha256
    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-opsi-20200421.ova
    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-opsi-20200421.ova.sha256
    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-server-20200421.ova
    wget https://download.linuxmuster.net/ova/v7/latest/lmn7-server-20200421.ova.sha256

Um sicherzustellen, dass die Dateien richtig heruntergeladen wurden, solltest du die SHA256-Summe prüfen. 

Dazu lädst du dir die Dateien mit der Endung sha256 ebenfalls herunter.
In der Shell des Proxmox-Hosts steht dir der Befehl ``sha256sum`` zur Verfügung.

Eine Überprüfung hier Beispielhaft für den lmn7.server:

.. code::

    sha256sum -c lmn7-server-20200421.ova.sha256
    
Als Ausgabe erhältst du, wenn der Download korrekt war, ein OK!

.. code::

    lmn7-server-20200421.ova: OK

Entpacken des OVA Templates
+++++++++++++++++++++++++++

Ein OVA Template ist ein tar Archiv, das mehrere Dateien enthält. Es beinhaltet beispielsweise eine Datei für jede virtuelle Disk sowie mehrere Dateien zur Beschreibung der VM Konfiguration. Du benötigst die .ovf Datei, weil sie die Eckdaten der virtuellen Maschine liefert sowie den Verweis auf die virtuellen Festplatten. Um die ovf-Datei und die Disk Images zu erhalten, musst du die .ova Datei mit dem Befehl tar entpacken. Beispielhaft hier für den lmn7.server

.. code::

    tar xvf lmn7-server-20200421.ova

Danach hast du die folgenden Dateien:

lmn7-server.ovf
lmn7-server-disk001.vmdk
lmn7-server-disk002.vmdk
lmn7-server.mf

Import der ovf Datei und erstellen der virtuellen Maschine
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Nun kannst du mit Hilfe von "qm" und der ovf Datei eine entsprechende VM erstellen und die virtuelle Disk importieren lassen. Zusätzlich benötigst du für jede VM eine freie VM ID, in dem gewählten Beispiel ist es die "701" für den lmn-Server.

Außerdem erwartet qm die Angabe eines Speichers, auf den das Disk Image importiert werden soll. Als Speicherort für unsere VM ist "local-lmv" dafür vorgesehen.

.. code::

    qm importovf 701 lmn7-server-20200421.ovf local-zfs

Konfiguration der VM anpassen
+++++++++++++++++++++++++++++

Nun kann über die GUI die neu erstellte VM eingesehen und die Parameter wie Speicher, Anzahl CPUs verändert werden. 

Dies beschriebene Vorgehen ist für alle gewünschten Virtuellen Maschinen angepasst zu wiederholen.


2. VM Templates
---------------

Fertige VM-Snapshots für Proxmox hat die Firma netzint für uns erstellt und sind auf der `Übersichtsseite der Proxmox 7.0 Aplliance <https://www.netzint.de/education/downloads/proxmox-appliance-7-0>`_ bereitgestellt. Für eine linuxmuster.net v7 Umgebung werden die Server-VM lmn70.server_proxmox_2020-04.vma.lzo und als Firewall die VM lmn70.opnsense_proxmox_2020-04.vma.lzo benötigt.

Optional ist zusätzlich eine OPSI-VM und eine Docker-VM für deine linuxmuster.net-Umgebung verfügbar. Um die Maschinen importieren zu können, müsssen diese zuerst auf den Hypervisor geladen werden und anschließend importiert werden.

Heruntergeladen werden können diese z.B. über die Shell von Proxmox mit dem wget-Befehl. 

Für die VMs wären es folgende Befehle: 

.. code::

   wget https://www.netzint.de/lmnvmrepo/lmn70.server_proxmox_2020-04.vma.lzo
   wget https://www.netzint.de/lmnvmrepo/lmn70.opnsense_proxmox_2020-04.vma.lzo
   wget https://www.netzint.de/lmnvmrepo/lmn70.opsi_proxmox_2020-04.vma.lzo
   wget https://www.netzint.de/lmnvmrepo/lmn70.docker_proxmox_2020-04.vma.lzo

.. figure:: media/image_16.png
   :align: center
   :alt: Schritt 16

Liegen die Dateien auf einem PC im selben Netz, können z.B. auch von diesem aus mit scp die Dateien auf Proxmox kopiert werden:

.. code::

    scp lmn70.docker_proxmox_2020-04.vma.lzo root@10.0.0.10:~

+------------+------------------------------------------------------------------------------+
| VM         | Download-Befehl                                                              |
+============+==============================================================================+
|server-VM   | wget https://www.netzint.de/lmnvmrepo/lmn70.server_proxmox_2020-04.vma.lzo   |
+------------+------------------------------------------------------------------------------+
|opsi-VM     | wget https://www.netzint.de/lmnvmrepo/lmn70.opsi_proxmox_2020-04.vma.lzo     |
+------------+------------------------------------------------------------------------------+
|docker-VM   | wget https://www.netzint.de/lmnvmrepo/lmn70.docker_proxmox_2020-04.vma.lzo   |
+------------+------------------------------------------------------------------------------+
|opnsense-VM | wget https://www.netzint.de/lmnvmrepo/lmn70.opnsense_proxmox_2020-04.vma.lzo |
+------------+------------------------------------------------------------------------------+

Alternativ kannst du die Imagedateien lokal über die jeweilgen Download-Button auf der Übersichtsseite https://www.netzint.de/education/downloads/proxmox-appliance-7-0 auf deinen PC herunterladen und anschließend über das „scp“-Tool (Grundkenntnisse notwendig) z.B: mit scp lmn70.server_proxmox_2020-04.vma.lzo root@10.0.0.10:~ auf den Hypervisor übertragen.

VM Templates importieren
========================

Liegen die VMs auf Proxmox, können die Abbilder als neue virtuelle Maschinen in der Shell über das qmrestore-Tool eingefügt werden. Dafür für jede zu importierende Maschine den Befehl anpassen und ausführen. Dabei sollte man sich im selben Verzeichnis befinden, in welchem die Abbilder liegen oder im Befehl den Pfad zur Datei mitangeben.

Der Befehl sollte mit dem Prinzip ``qmrestore <vmname.vma.lzo> <VM-ID> --storage <storage-name> -
unique 1`` (Beachte die zwei Bindestriche vor dem Wort „storage“) angewendet werden.

<vmname.vma.lzo> entspricht dem Dateinamen der TemplateVM. Mit <VM-ID> übergibst du der VM eine ID, wie beispielsweise „101“ oder „701“. <storage-name> ist etwa local oder der Name einer zweiten virtuellen Disk, wie im obigen Beipiel „vd-ssd-1700“-unique 1 generiert eine andere MAC-Addresse, als im Template exportiert.

.. note::

  Sollte ein Proxmox-Host mit der Verion 6.2 zum Einsatz kommen, sind die einzelnen Datei nach folgendem Muster umzubennen und bei qmrestore anzupassen:
  
  vzdump-qemu-xxx-yyyy_mm_dd-hh_mi_ss.vma.lzo
  
  xxx --> ID
  
  yyyy --> Jahr
  
  mm --> Tag
  
  hh --> Stunde
  
  mi --> Minute
  
  ss --> Sekunde
  
  Alle Werte können der Phantasie entnommen werden (getestet mit vzdump-qemu-701-2020_04_20-12_20_00.vma.lzo)

+-------------+------------------------------------------------------------------------------------------+
| VM          | Import-Befehl                                                                            |
+=============+==========================================================================================+
| server-VM   |  ``qmrestore lmn70.server_proxmox_2020-04.vma.lzo 701 -–storage local-lvm -unique 1``    |
+-------------+------------------------------------------------------------------------------------------+
| opsi-VM     |  ``qmrestore lmn70.opsi_proxmox_2020-04.vma.lzo 702 -–storage local-lvm -unique 1``      |
+-------------+------------------------------------------------------------------------------------------+
| docker-VM   |  ``qmrestore lmn70.docker_proxmox_2020-04.vma.lzo 703 -–storage local-lvm -unique 1``    |
+-------------+------------------------------------------------------------------------------------------+
| opnsense-VM |  ``qmrestore lmn70.opnsense_proxmox_2020-04.vma.lzo 704 -–storage local-lvm -unique 1``  |
+-------------+------------------------------------------------------------------------------------------+

1. Hier wird als Beispiel der Server-Snapshot mit der ID 701 auf dem local-lvm-Storage über den Befehl ``qmrestore lmn70.server_proxmox_2020-04.vma.lzo 701 –storage local-lvm -unique 1`` hochgeladen. (Beachte die zwei Bindestriche vor dem Wort „storage“):

.. figure:: media/image_17.png
   :align: center
   :alt: Schritt 17

2. Als VM-IDs kann ebenso 101, 102, 103 etc. gewählt werden. Wurden die gewünschten Maschinen
erfolgreich importiert, sollten diese auf der Weboberfläche von Proxmox (https://10.0.0.10:8006) links aufgelistet zu sehen sein.

.. figure:: media/image_18.png
   :align: center
   :alt: Schritt 18

Netzwerkkarten überprüfen/anpassen
==================================

Standardmäßig ist nach der Installation von Proxmox nur eine Netzwerkbrücke eingerichtet, um an ein externes Netz angebunden zu sein. Da die importierten Maschinen untereinander in dem eigenen internen Netz laufen werden, sollte kontrolliert werden, dass den VMs Server, OPSI und Docker die Netzwerkbrücke für das interne Netz (green) zugewiesen ist. Die Netzwerkbrücken der Firewall-VM OPNSense sollten richtig zugeordnet sein ``net0 ⇒ green; net1 ⇒ red``.

Nachdem dein Hypervisor läuft und die VM erfolgreich importiert wurden, muss dass Setup deiner
linuxmuster.net-Installation durchgeführt werden. Weiter geht es mit dem Kapitel :ref:`Erstkonfiguration <setup-using-selma-label>`.













