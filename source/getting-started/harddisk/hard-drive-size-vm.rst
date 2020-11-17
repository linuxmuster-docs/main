.. include:: /guided-inst.subst

.. _hard_drive_size_vm-label:

==========================================
Aktualisieren der Server-Festplattengrößen
==========================================

.. hint::

   Achtung: Dies ist noch eine zu weiter zu testende Beschreibung

Vorgehen
--------

1. Prüfen, ob die neuen HDD-Größen an die VM durchgereicht werden.
2. Partitionsgrößen prüfen
3. HDD1 anpassen
4. HDD2 mit dem LVM anpassen
5. Reboot
6. Tests durchführen

HDD-Größen prüfen
-----------------

Auf der Konsole der Server-VM prüfst du zuerst, welche Festplatten des Hypervisor auch
in der VM durchgereicht werden und welche Bezeichnung diese haben. 
Die im Hypervisor geänderten Größen werden hier bereits angezeigt, aber die Partitionen wurden noch nicht auf 
die neuen Größen angepasst.

Gebe hierzu folgenden Befehl ein:

.. code::
   
   root@server:~# lsblk
   NAME                  MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   sr0                    11:0    1 1024M  0 rom  
   xvda                  202:0    0  155G  0 disk 
   ├─xvda1               202:1    0    1M  0 part 
   └─xvda2               202:2    0   24G  0 part /
   xvdb                  202:16   0 1000G  0 disk 
   ├─vg_srv-var          253:0    0  9,8G  0 lvm  /var
   ├─vg_srv-linbo        253:1    0   40G  0 lvm  /srv/linbo
   ├─vg_srv-global       253:2    0  9,8G  0 lvm  /srv/samba/global
   └─vg_srv-default--school
                         253:3    0   40G  0 lvm  /srv/samba/schools/default-school
   
Die Bezeichnung ``xvda`` steht in XCP-ng für die 1. HDD der VM, ``xvdb`` für die 2. HDD der VM. 
``xvda1``ist dann die 1. Parition auf der 1. HDD der VM in XCP-ng, ``vg-*`` steht dann für ein LVM auf der 
jeweils zugeordneten Festplatte, in obigem Beispiel befindet sich das LVM auf der 2. Festplatte (xvdb).

Dateisystem prüfen
------------------

Lasse dir nun dien aktuellen Größen des Dateisystems  ausgeben.

.. code::

   root@server: ~# df

    Dateisystem Größe Benutzt Verf. Verw% Eingehängt auf
    udev 5,9G 0 5,9G 0% /dev
    tmpfs 1,2G 7,7M 1,2G 1% /run
    /dev/xvda2 25G 5,7G 18G 25% /
    tmpfs 5,9G 0 5,9G 0% /dev/shm
    tmpfs 5,0M 0 5,0M 0% /run/lock
    tmpfs 5,9G 0 5,9G 0% /sys/fs/cgroup
    /dev/mapper/vg_srv-global 9,8G 37M 9,3G 1% /srv/samba/global
    /dev/mapper/vg_srv-linbo 40G 347M 37G 1% /srv/linbo
    /dev/mapper/vg_srv-default–school 40G 74M 38G 1% /srv/samba/schools/default-school
    /dev/mapper/vg_srv-var 9,8G 1,2G 8,1G 13% /var
    tmpfs 1,2G 0 1,2G 0% /run/user/0
    
Hier werden noch die alten Partitionsgrößen angegeben.   

HDD1 anpassen
-------------

Partitionen auf der 1. HDD **prüfen**:

.. code::

   fdisk /dev/xvda
   
   Warning: GPT - PMBR Größenunterschied (52428799 != 304087039) wird durch write korrigiert.
   
In diesem Fall fdisk wieder ohne Schreibvorgang verlassen und dieses Problem zunächst lösen.

Rufe auf der Eingabekonsole das Programm ``parted`` auf.

.. code::

   root@server: ~# parted /dev/xvda
   
   print
   
Es wird dann ein Größenproblem für die 1. HDD angezeigt und parted bietet eine Auswahloption an, um dieses
Problem zu beheben. Wähle nun diese Options aus, damit das Größenproblem gelöst wird und verlasse dann parted wieder
durch Angabe des Befehls ``quit``.

Danach erneut ``fdisk`` aufrufen, die 2. Partition löschen und neu mit neuer Größe anlegen.

.. code::

   fdisk /dev/xvda
   
   p (print - zeigt Partitionen an)

   d (delete - danach Partitionsnr. angeben)
   
   n (new - neue Partition anlegen, gleicher Startpunkt wie zuvor, Ende = verbleibende HDD-Größe)
   
   w (write - schreibt die Änderungen auf die 1. HDD.)
   
Nun muss die Partition noch auf die neue Größe erweitert werden. Gebe in der Konsole nun an:

.. code::

   resize2fs /dev/xvda2
   
Danach wird nun die neue Größe gauf der 1. HDD gentutzt.


HDD2 mit dem LVM anpassen
-------------------------
 
In o.g. VM auf XCP-ng befindet sich auf der 2. HDD ``/dev/xvdb`` ein LVM.

Folgende Begriffe sind hierbei relevant:

a) Physical Volume (PV)
b) Volume Group (VG)
c) Logical Volume (LV)

a) Anpassen der PV - Größe auf die gesamte neue Festplattengröße

PV ermitteln

.. code::

   root@server:/srv/linbo# pvscan
   PV /dev/xvdb VG vg_srv lvm2 [<100,00 GiB / 0 free]

PV Größenanpassung testen

.. code::

   pvresize /dev/xvdb
   Physical volume „/dev/xvdb“ changed
   1 physical volume(s) resized / 0 physical volume(s) not resized

b) LV-Größen anpassen

.. code:: 

   lvextend -L+100G /dev/mapper/vg_srv-var
   lvextend -L+200G /dev/mapper/vg_srv-linbo
   lvextend -L+100G /dev/mapper/vg_srv-global
   lvextend -l +100%FREE /dev/mapper/vg_srv-default–school

c) Dateisystem an die neuen Größen anpassen:

.. code::

   resize2fs /dev/mapper/vg_srv-var
   resize2fs /dev/mapper/vg_srv-linbo
   resize2fs /dev/mapper/vg_srv-global
   resize2fs /dev/mapper/vg_srv-default–school

   Beispielausgabe:
   resize2fs 1.44.1 (24-Mar-2018)
   Dateisystem bei /dev/mapper/vg_srv-var ist auf /var eingehängt; Online-Größenänderung ist
   erforderlich
   old_desc_blocks = 2, new_desc_blocks = 14
   Das Dateisystem auf /dev/mapper/vg_srv-var is nun 28835840 (4k) Blöcke lang.

d) Ergebnis prüfen

.. code::

   root@server: ~# df

   Dateisystem Größe Benutzt Verf. Verw% Eingehängt auf
   udev 5,9G 0 5,9G 0% /dev
   tmpfs 1,2G 7,7M 1,2G 1% /run
   /dev/xvda2 25G 5,7G 18G 25% /
   tmpfs 5,9G 0 5,9G 0% /dev/shm
   tmpfs 5,0M 0 5,0M 0% /run/lock
   tmpfs 5,9G 0 5,9G 0% /sys/fs/cgroup
   /dev/mapper/vg_srv-global 207G 59M 199G 1% /srv/samba/global
   /dev/mapper/vg_srv-linbo 433G 368M 415G 1% /srv/linbo
   /dev/mapper/vg_srv-default–school 236G 85M 226G 1% /srv/samba/schools/default-school
   /dev/mapper/vg_srv-var 109G 1,2G 103G 2% /var
   tmpfs 1,2G 0 1,2G 0% /run/user/0

Reboot
------

Starte nun die Server-VM neu, um zu prüfen, ob die vorgenommenen Größenanpassungen funktionsfähig sind und der Reboot korrekt ausgeführt wird.

.. code::

   root@server: ~# reboot
   
Tests durchführen
-----------------

Nachdem die VM wieder gestart ist, melde dich an der Konsole an und prüfe mithilfe nachstehender Befehle, ob die Platten- und Partitionsgrößen
nun deinen wünschen tatsächlich entsprechen.

.. code::

   root@server:~# lsblk
   NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   sr0                       11:0    1 1024M  0 rom  
   xvda                     202:0    0  145G  0 disk 
   ├─xvda1                  202:1    0    1M  0 part 
   └─xvda2                  202:2    0  145G  0 part /
   xvdb                     202:16   0 1000G  0 disk 
   ├─vg_srv-var             253:0    0  110G  0 lvm  /var
   ├─vg_srv-linbo           253:1    0  440G  0 lvm  /srv/linbo
   ├─vg_srv-global          253:2    0  210G  0 lvm  /srv/samba/global
   └─vg_srv-default--school 253:3    0  240G  0 lvm  /srv/samba/schools/default-school

.. code::

   root@server:~# df -h
   Dateisystem                        Größe Benutzt Verf. Verw% Eingehängt auf
   udev                                5,9G       0  5,9G    0% /dev
   tmpfs                               1,2G    6,8M  1,2G    1% /run
   /dev/xvda2                          143G     13G  125G   10% /
   tmpfs                               5,9G       0  5,9G    0% /dev/shm
   tmpfs                               5,0M       0  5,0M    0% /run/lock
   tmpfs                               5,9G       0  5,9G    0% /sys/fs/cgroup
   /dev/mapper/vg_srv-global           207G     59M  199G    1% /srv/samba/global
   /dev/mapper/vg_srv-default--school  236G     43G  184G   19% /srv/samba/schools/default-school
   /dev/mapper/vg_srv-var              109G    3,5G  101G    4% /var
   /dev/mapper/vg_srv-linbo            433G     40G  376G   10% /srv/linbo
   tmpfs                               1,2G       0  1,2G    0% /run/user/0




===================== ==========================
Installationsoptionen |follow_me2installoptions|
===================== ==========================



.. 
   =================================== ======================
   Vorbereiten der Proxmox-Festplatten |follow_me2proxmox-hd|
   Vorbereiten der XCP-ng-Festplatten  |follow_me2xcp-ng-hd|
   Vorbereiten der KVM-Festplatten     |follow_me2kvm-hd|
   =================================== ======================

