.. include:: /guided-inst.subst

.. _import-proxmox-vms-label:

====================================
Importieren der Virtuellen Maschinen
====================================


.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_,
                   `@maurice <https://ask.linuxmuster.net/u/Maurice>`_


Nachdem du den Host für die virtuellen Maschinen fertiggestellt hast, müssen diese nun importiert werden.

Unter Proxmox ist ein Import einer VM, die zuvor unter Proxmox als Backup gesichert wurde, der bevorzugte Weg.

VM Templates herunterladen
--------------------------

Fertige VM-Snapshots für Proxmox stellt linuxmuster.net auf dem eigenen Download-Server bereit. https://download.linuxmuster.net/proxmox/v7/latest/

Um die Maschinen importieren zu können, müssen diese zuerst auf den Hypervisor geladen werden. Die VMs können über die Shell von Proxmox mit dem wget-Befehl direkt heruntergeladen werden. 

Für eine linuxmuster.net v7 Umgebung werden die Server-VM und als Firewall die OPNsense®-VM benötigt. Optional sind zusätzlich eine OPSI-VM und eine Docker-VM für deine linuxmuster.net-Umgebung verfügbar. 

Für die VMs wären folgende Befehle in der Shell von hv01 einzugeben: 

=========== ===================================================================================================
VM          Download-Befehl                                                                                   
=========== ===================================================================================================
opnsense-VM wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo
server-VM   wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-201-2020_12_19-19_31_29.vma.lzo
opsi-VM     wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-202-2020_12_19-19_37_48.vma.lzo
docker-VM   wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-203-2020_12_19-19_43_09.vma.lzo
=========== ===================================================================================================

Beispiel für die opensense-VM:

.. code::

   root@hv01:~# wget https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo
   --2020-12-20 12:01:46--  https://download.linuxmuster.net/proxmox/v7/latest/vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo
   Resolving download.linuxmuster.net (download.linuxmuster.net)... 95.217.39.154
   Connecting to download.linuxmuster.net (download.linuxmuster.net)|95.217.39.154|:443... connected.
   HTTP request sent, awaiting response... 200 OK
   Length: 3838493301 (3.6G)
   Saving to: ‘vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo’

   20_12_19-19_23_00.vma   5%[>                       ] 186.40M  10.4MB/s

.. hint:: Solltest du einen ``FEHLER 404: File not found`` erhalten, musst du die Dateinamen anpassen. Die neuen Dateinamen (aktualisierten) musst du dem oben genannten Link entnehmen und bei allen Nennungen in der Dokumentation verwenden.

Nach dem Herunterladen der Backup-Dateien sollten sich diese mittels ``ls -lh`` in der Proxmox-Shell anzeigen lassen.

.. code::

   root@hv01:~# ls -lh
   total 15G
   -rw-r--r-- 1 root root 3.6G Dez 19 23:30 vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo
   -rw-r--r-- 1 root root 4.1G Dez 19 23:51 vzdump-qemu-201-2020_12_19-19_31_29.vma.lzo
   -rw-r--r-- 1 root root 4.0G Dez 19 23:54 vzdump-qemu-202-2020_12_19-19_37_48.vma.lzo
   -rw-r--r-- 1 root root 4.1G Dez 19 23:59 vzdump-qemu-203-2020_12_19-19_43_09.vma.lzo

Die Besonderheiten zu den Archiv-Namen der VMs sind in nachstehendem Hinweis erläutert.

.. hint::

   Sollte ein Proxmox-Host mit der Version 6.2 zum Einsatz kommen, sind die einzelnen Sicherungen der VMs
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
opnsense-VM 200   ``qmrestore vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo 200 --storage vd-hdd-1000 -unique 1`` 
server-VM   201   ``qmrestore vzdump-qemu-201-2020_12_19-19_31_29.vma.lzo 201 --storage vd-hdd-1000 -unique 1`` 
opsi-VM     202   ``qmrestore vzdump-qemu-202-2020_12_19-19_37_48.vma.lzo 202 --storage vd-hdd-1000 -unique 1``
docker-VM   203   ``qmrestore vzdump-qemu-203-2020_12_19-19_43_09.vma.lzo 203 --storage vd-hdd-1000 -unique 1``
=========== ===== =============================================================================================

1. Hier wird als Beispiel der opensense-Snapshot mit der ID 200 (lmn7-opnsense) auf dem vd-hdd-1000 Storage über folgenden Befehl importiert:

.. code::

   qmrestore vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo 200 --storage vd-hdd-1000 -unique 1

.. code::

   root@hv01:~# qmrestore vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo 200 --storage vd-hdd-1000 -unique 1
   restore vma archive: lzop -d -c /root/vzdump-qemu-200-2020_12_19-19_23_00.vma.lzo | vma extract -v -r /var/tmp/vzdumptmp19171.fifo - /var/tmp/vzdumptmp19171
   CFG: size: 442 name: qemu-server.conf
   DEV: dev_id=1 size: 10737418240 devname: drive-scsi1
   CTIME: Sat Dec 19 19:23:01 2020
   new volume ID is 'vd-hdd-1000:vm-200-disk-0'
   map 'drive-scsi1' to '/dev/vd-hdd-1000/vm-200-disk-0' (write zeros = 0)
   progress 1% (read 107413504 bytes, duration 1 sec)
   progress 2% (read 214761472 bytes, duration 1 sec)
   progress 3% (read 322174976 bytes, duration 2 sec)
   progress 4% (read 429522944 bytes, duration 3 sec)

2. Wurden die gewünschten Maschinen erfolgreich importiert, sollten diese mit ihren IDs und Namen auf der Weboberfläche von Proxmox links aufgelistet zu sehen sein.

.. figure:: media/install-on-proxmox_33_vm-imported.png
   :align: center
   :alt: Proxmox-Übersicht VMs des hv01

Zur Veranschaulichung eine Grafik, die den Status nach dem Import der VM zeigt.

.. figure:: media/install-on-proxmox_34_network-after-import.svg
   :align: center
   :alt: Status Netzwerk nach dem Importieren

Anpassung der VM-Einstellungen vor dem ersten Starten
=====================================================

Die VMs können nun vor dem Start recht einfach auf die eigenen Bedürfnisse und Anforderungen angepasst werden. So dürften z. B. die Größen für die Festplatten für größere Schulen zu klein sein. Zudem sind die Netzwerkeinstellungen zu prüfen und gegebenenfalls zu berichtigen.

Diese Anpassungen können in der WebUI des Proxmox-Host recht einfach vorgenommen werden. Für nachstehende Änderungen müssen die VMs heruntergefahren sein, so wie dies jetzt direkt nach dem Import der Fall ist.

VM HDD anpassen
---------------

Um die Größe der Festplatten der importierten VMs anzupassen sind mehrere Schritte erforderlich.
Nachstehender Link führt dich zur Anpassung der HDD Größe der VMs.

+--------------------------------------------------------------------+-------------------------------------------+
| Vorbereiten der Festplatten-Anpassung                              | |follow_me2hd-resize|                     |
+--------------------------------------------------------------------+-------------------------------------------+

Solltest du mit den vorgegebenen Festplattengrößen weitermachen wollen, zum Beispiel weil du eine Probeinstallations vornimmst, dann kannst du diesen Anpassung der Festplattengröße überspringen

+--------------------------------------------------------------------+-------------------------------------------+
| Weiter mit der Netzwerk-Anpassung                                  | |follow_me2network_b|                     |
+--------------------------------------------------------------------+-------------------------------------------+
