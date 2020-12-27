.. include:: /guided-inst.subst

.. _hard_drive_size_opnsense_vm-label:

===================================================
Aktualisieren der Festplattengrößen der OPNSense VM
===================================================

.. hint::

   Achtung: Diese Dokumentation ist noch nicht ganz fertig und muss weiter getestet werden. Diesen Abschnitt must du nur ausführen, sofern du in deinem Hypervisor die HDD-Größe der OPNSense bereits vergrößert hast. Ansonsten kannst Du bei der Einrichtung mit dem Kapitel ``Netzbereich anpassen`` fortfahren.
   
..
   ==================== ======================
   Netzbereich anpassen |follow_me2modify-net|
   ==================== ======================

============================== ==========================
Proxmox - Netzbereich anpassen |follow_me2proxmox-backhd|
XCP-ng  - Netzbereich anpassen |follow_me2xcp-ng-backhd|
KVM     - Netzbereich anpassen |follow_me2kvm-backhd|
============================== ==========================

   
Überblick
---------
OPNSense basiert auf FreeBSD, so dass die Erweiterung der Festplattengröße von dem Vorgehen der
Server-VM abweicht. Gleich bleibt, dass zu Beginn ein Snapshot erstelt werden sollte und die 
Virtuelle Disk im Hypervisor vergrößert werden muss.

..
   =================================== ======================
   Um die Festplattengröße für die OPNsense zu erweitern ist wie folgt vorzugehen:
   0.  Zuerst ein Snapshot der OPNsense VM erstellen. Auf diesen Stand kannst Du zurückkehren, falls bei den nachstehenden Schritten Fehler auftreten.  
   1.  Im Hypervisor die Größe für die Festplatte der OPNSense erweitern (im ausgeschalteten Zustand).
   2.  VM starten.
   3.  In der Konsole  ``df -h`` angeben
   4.  gpart show
   5.  Dort wird unterhalb von MBR ein freier Bereich angezeigt
   6.  gpart resize -i 1 ada0 (sofoern vorher als Device auch ada0 angezeigt wurde)
   7.  gpart resize -i 1 ada0
   8.  gpart show ada0
   9.  gpart resize -i 1 ada0s1 (es wird die root partition vergrößert - unsere vm hat ja nur diese)
   10. gpart show ada0s1
   11. df -h
   12. ggf. Neustart
   =================================== ======================

Vorgehen
--------

Nach der Vergrößerung er virtuellen Platte und dem Systemstart wird überprüft ob die
Änderung vom System erkannt wird. Ein erstes ``df -h`` verrät uns dass derzeit nur der bisher 
verwendete Platz zu Verfügung steht:



.. code::
  
  root@OPNsense:~ # df -h
  Filesystem           Size    Used   Avail Capacity  Mounted on
  /dev/ufs/OPNsense    9.7G    1.8G    7.1G    20%    /
  devfs                1.0K    1.0K      0B   100%    /dev
  devfs                1.0K    1.0K      0B   100%    /var/dhcpd/dev
  devfs                1.0K    1.0K      0B   100%    /var/unbound/dev
  df -h

Mit ``gpart`` können wir die Platte und die verfügbaren Partitionen analysieren

.. code::

  root@OPNsense:~ # gpart show
  =>       63  104857537  da0  MBR  (50G)
           63   20964762    1  freebsd  [active]  (10G)
     20964825   83892775       - free -  (40G)

  =>       0  20964762  da0s1  BSD  (10G)
           0        16         - free -  (8.0K)
          16  20964746      1  freebsd-ufs  (10G)

Es ist zu erkennen dass die Platte da0 nur 10G nutzt. Weitere 40G stehen zu Verfügung. Wir müssen
daher da0 den kompletten Bereich zu Verfügung stellen:

.. code::

  root@OPNsense:~ # gpart resize -i 1 da0
  da0s1 resized

Wir sehen nun mit ``gpart``, dass die Platte nun den komplett verfügbaren Platz verwendet. Die Partition 
da0s1 nutzt allerdings noch nicht den kompletten Platz:

.. code::

  root@OPNsense:~ # gpart show
  =>       63  104857537  da0  MBR  (50G)
           63  104857537    1  freebsd  [active]  (50G)
  
  =>        0  104857537  da0s1  BSD  (50G)
            0         16         - free -  (8.0K)
           16   20964746      1  freebsd-ufs  (10G)
     20964762   83892775         - free -  (40G)

Wir können jetzt mit dem gleichen Aufruf wie oben, die Partition vergrößern:

.. code::

  root@OPNsense:~ # gpart resize -i 1 da0s1
  da0s1a resized

Es ist zu erkennen, dass die Vergrßerung letztendlich durchgeführt wurde:

.. code::

  root@OPNsense:~ # gpart show
  =>       63  104857537  da0  MBR  (50G)
           63  104857537    1  freebsd  [active]  (50G)
  
  =>        0  104857537  da0s1  BSD  (50G)
            0         16         - free -  (8.0K)
           16  104857521      1  freebsd-ufs  (50G)

Weiterführende Erklärungen zu FreeBSD zu diesem Thema findest du hier: 

https://unix.stackexchange.com/questions/117023/expanding-the-disk-size-on-pfsense-under-vmware-esxi

============================== ==========================
Proxmox - Netzbereich anpassen |follow_me2proxmox-backhd|
XCP-ng  - Netzbereich anpassen |follow_me2xcp-ng-backhd|
KVM     - Netzbereich anpassen |follow_me2kvm-backhd|
============================== ==========================

