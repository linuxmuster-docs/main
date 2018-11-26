.. _install-on-kvm-label:

==========================
 Virtualisierung über KVM
==========================

.. sectionauthor:: N.N., T.Küchel


In diesem Dokument findest Du "Schritt für Schritt" Anleitungen zum
Installieren der linuxmuster.net-Musterlösung in der Version 7.0 auf
Basis von KVM unter Ubuntu Server 18.04 LTS.

Im folgenden Bild ist die einfachste Form der Implementierung der
Musterlösung schematisch dargestellt:

..
   .. figure:: media/install-on-kvm-image01.png

:fixme: picture redo

Nach der Installation gemäß dieser Anleitung erhältst Du eine
einsatzbereite Umgebung bestehend aus

* einer Firewall (opnsense) und 
* eines Servers (server)

Vorbereitung für die Installation
=================================

Es wird für die Installation auf dem KVM-Host ein Ubuntu Server 64bit
in der Version 18.04 LTS angenommen, der so konfiguriert ist, dass er
das Internet erreicht.  Ebenso sollte ein Admin-PC konfiguriert sein.

Lade auf dem KVM-Host die aktuellen OVA-Abbilder von der `Webseite
<https://github.com/linuxmuster/linuxmuster-base7/wiki/Die-Appliances>`_
herunter.

.. code-block:: console

   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-opnsense-20181109.ova
   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-server-20181109.ova
   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-opsi-20181109.ova
   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-docker-20181109.ova

und überprüfe die md5-Summe mit dem entsprechenden Werkzeug und
vergleiche mit der Webseite auf Integrität.

Nach der Integration bietet es sich an, die Hardware der importierten
Appliances anzupassen und z.B. die Festplattentypen auf "virtio" zu
stellen.

Netzwerkanpassungen des KVM-Hosts
=================================



Firewall
========

Importiere die Firewall-Appliance `lmn7-opnsense`.

.. code-block:: console

   # virt-convert lmn7-opnsense-*.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-opnsense-20181109-disk1.vmdk /var/lib/libvirt/images/lmn7-opnsense-20181109-disk1.raw
   Creating guest 'lmn7-opnsense'.

Wer als Speichermedium lieber das LVM verwendet, der muss die
Festplattengröße ermitteln, ein logical volume erstellen, das
Abbild nochmals kopieren und die Konfiguration editieren.

.. code-block:: console

   # qemu-img info /var/lib/libvirt/images/lmn7-opnsense-*disk1.raw | grep virtual\ size
   virtual size: 10G (10737418240 bytes)
   # lvcreate -L 10737418240b -n opnsense vghost
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-opnsense-*disk1.raw /dev/vghost/opnsense
   # virsh edit lmn7-opnsense
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/vghost/opnsense'/>
   ...

Netzwerkanpassung der Firewall
------------------------------
   
Die Netzwerkkarten der Appliance werden in der Reihenfolge importiert,
wie sie in Appliance definiert wurden:

1. `LAN, 10.0.0.254/16`, d.h. diese Schnittstelle wird auf der
   pädagogischen Seite des Netzwerks angeschlossen
2. `WAN, DHCP`, d.h. diese Schnittstelle wird auf der Internetseite
   angeschlossen
3. `OPT1, unkonfiguriert`, d.h. diese Schnittstelle wird für optionale
   Netzwerke verwendet und muss zunächst nicht angeschlossen werden.

Öffne die Konfiguration und editiere die erste Schnittstelle, so dass
sie sich im Schulnetzwerk befindet, hier im Beispiel wird diese an die
virtuelle Brücke `br-green` mit dem Stichwort `bridge` und dem Typ
`bridge` angeschlossen. Die MAC-Adresse sollte bei dieser Gelegenheit
auch (beliebig) geändert werden.

.. code-block:: console

   # virsh edit lmn7-opnsense
   ...
   <interface type='bridge'>
      <mac address='52:54:00:20:ea:70'/>
      <source bridge='br-green'/>
   ...

Die zweite Schnittstelle sollte genauso dem Typ `bridge` zugeordnet
werden, allerdings an die Brücke `br-red` angeschlossen werden.

.. code-block:: console

   # virsh edit lmn7-opnsense
   ...
   <interface type='bridge'>
      <mac address='52:54:00:d2:0c:62'/>
      <source bridge='br-red'/>
   ...

Starte die Firewall. Der Admin-PC sollte sich nach ca. 3 Minuten mit
der Firewall verbinden lassen.


.. code-block:: console

   # ping 10.0.0.254
   PING 10.0.0.254 (10.0.0.254) 56(84) bytes of data.
   64 bytes from 10.0.0.254: icmp_seq=1 ttl=64 time=0.183 ms
   64 bytes from 10.0.0.254: icmp_seq=2 ttl=64 time=0.242 ms

Sollte diese Verbindung nicht gelingen, dann empfiehlt sich ein
Admin-PC, mit dem man direkt auf der Konsole von `virt-manager` die
Firewall erreicht und die Netzkonfiguration der opnsense überprüfen
und korrigieren kann.


Server
======

Importiere die Server-Appliance `lmn7-server`.

.. code-block:: console

   # virt-convert lmn7-server-20181109.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-server-20181109-disk1.vmdk /var/lib/libvirt/images/lmn7-server-20181109-disk1.raw
   Running /usr/bin/qemu-img convert -O raw lmn7-server-20181109-disk2.vmdk /var/lib/libvirt/images/lmn7-server-20181109-disk2.raw   
   Creating guest 'lmn7-server'.

Festplattengrößen für den Server
--------------------------------
   
An dieser Stelle sollte man die Festplattengrößen an seine eigenen
Bedürfnisse anpassen. Beispielhaft wird die zweite Festplatte und das
darin befindliche server-LVM vergrößert, so dass ``/dev/vg_srv/linbo``
und ``/dev/vg_srv/default-school`` auf jeweils 175G vergrößert werden.

Zunächst wird der Container entsprechend (10+10+175+175 GB) vergrößert, dann der mit
Hilfe von `kpartx` aufgeschlossen.

.. code-block:: console

   # qemu-img resize -f raw /var/lib/libvirt/images/lmn7-server-*disk2.raw 370G
   Image resized.
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk2.raw | grep virtual\ size
   virtual size: 370G (397284474880 bytes)
   # kpartx -av /var/lib/libvirt/images/lmn7-server-*disk2.raw
   # vgdisplay -s vg_srv
   "vg_srv" <100,00 GiB [<100,00 GiB used / 0,00 GiB free]

Durch kpartx wurde der Container über ein so genanntes loop-device
geöffnet und das darin liegende LVM wurde auf dem Serverhost
hinzugefügt. Daher kann jetzt sowohl das loop-device als `physical
volume` vergrößert als auch die `logical volumes` vergrößert werden.
Zu letzt muss noch das Dateisystem geprüft und erweitert werden.

.. code-block:: console

   # pvresize /dev/loop0 
   Physical volume "/dev/loop0" changed
   1 physical volume(s) resized / 0 physical volume(s) not resized
   # vgdisplay -s vg_srv
   "vg_srv" <370,00 GiB [<100,00 GiB used / 270,00 GiB free]

   # lvresize /dev/vg_srv/default-school -L 175G
   Size of logical volume vg_srv/default-school changed from 40,00 GiB (10240 extents) to 175,00 GiB (44800 extents).
   Logical volume vg_srv/default-school successfully resized.
   # e2fsck -f /dev/vg_srv/default-school
   ...
   linbo: 1010/2621440 Dateien (0.6% nicht zusammenhängend), 263136/10485760 Blöcke
   # resize2fs /dev/vg_srv/default-school
   ...
   Das Dateisystem auf /dev/vg_srv/default-school is nun 45875200 (4k) Blöcke lang.

   # lvresize /dev/vg_srv/linbo -L 175G
     Insufficient free space: 34560 extents needed, but only 34559 available
   # lvresize /dev/vg_srv/linbo -l +34599     
   Size of logical volume vg_srv/linbo changed from <40,00 GiB (10239 extents) to <175,00 GiB (44799 extents).
   Logical volume vg_srv/linbo successfully resized.
   # e2fsck -f /dev/vg_srv/linbo
   ...
   default-school: 13/2621440 Dateien (0.0% nicht zusammenhängend), 242386/10484736 Blöcke
   # resize2fs /dev/vg_srv/linbo
   ...
   Das Dateisystem auf /dev/vg_srv/linbo is nun 45874176 (4k) Blöcke lang.

Um den Container wieder ordentlich zu schließen, muss man die `volume
group` abmelden und mit `kpartx` abschließen.

.. code-block:: console

   # vgchange -a n vg_srv
   0 logical volume(s) in volume group "vg_srv" now active
   # kpartx -dv /var/lib/libvirt/images/lmn7-server-*disk2.raw 
   loop deleted : /dev/loop0

Auch hier muss man, wenn man als Speichermedium auf dem Host lieber
LVM verwendet, weitere Anpassungen vornehmen.Hier habe ich auch den
Festplattentyp auf `virtio` und die Festplattenbezeichnung daher auf
`vdX` umgestellt.

.. code-block:: console

   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk1.raw | grep virtual\ size
   virtual size: 25G (26843545600 bytes)
   # lvcreate -L 26843545600b -n serverroot vghost
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-*disk1.raw /dev/vghost/serverroot
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/vghost/serverroot'/>
      <target dev='vda' bus='virtio'/>
   ...
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk2.raw | grep virtual\ size
   virtual size: 370G (397284474880 bytes)
   # lvcreate -L 397284474880b -n serverdata vghost
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/vghost/serverdata'/>
      <target dev='vdb' bus='virtio'/>      
   ...

Netzwerkanpassung des Servers
-----------------------------
   
Es muss nur eine Netzwerkschnittstelle angepasst werden und in die
Brücke `br-green` gestöpselt werden.

.. code-block:: console

   # virsh edit lmn7-server
   ...
   <interface type='bridge'>
      <mac address='52:54:00:9f:b8:af'/>
      <source bridge='br-green'/>
   ...


Test der Verbindungen
---------------------

Teste, ob du von deinem Admin-PC auf die Firewall mit dem
Standardpasswort `Muster!` kommst, teste dann ob du auch auf den
Server kommst.

.. code-block:: console

   # ssh 10.0.0.254 -l root
   # ssh 10.0.0.1 -l root   

