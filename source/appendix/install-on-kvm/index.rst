.. _install-on-kvm-label:

==========================
 Virtualisierung über KVM
==========================

.. sectionauthor:: `morbweb <https://ask.linuxmuster.net/u/morpweb>`_, `jolly-jump <https://ask.linuxmuster.net/u/jolly-jump>`_


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
---------------------------------



Firewall
--------

Importiere die Firewall-Appliance `lmn7-opnsense`.

.. code-block:: console

   # virt-convert lmn7-opnsense-20181109.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-opnsense-20181109-disk1.vmdk /var/lib/libvirt/images/lmn7-opnsense-20181109-disk1.raw
   Creating guest 'lmn7-opnsense'.

Wer als Speichermedium lieber das LVM verwendet, der muss die
Festplattengröße ermitteln, ein logical volume erstellen, das
Abbild nochmals kopieren und die Konfiguration editieren.

.. code-block:: console

   # qemu-img info /var/lib/libvirt/images/lmn7-opnsense-20181109-disk1.raw | grep virtual\ size
   virtual size: 10G (10737418240 bytes)
   # lvcreate -L 10737418240b -n opnsense vghost
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-opnsense-20181109-disk1.raw /dev/vghost/opnsense
   # virsh edit lmn7-opnsense
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/vghost/opnsense'/>
   ...

Netzwerkanpassung der Firewall
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
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
------

Importiere die Server-Appliance `lmn7-server`.

.. code-block:: console

   # virt-convert lmn7-server-20181109.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-server-20181109-disk1.vmdk /var/lib/libvirt/images/lmn7-server-20181109-disk1.raw
   Running /usr/bin/qemu-img convert -O raw lmn7-server-20181109-disk2.vmdk /var/lib/libvirt/images/lmn7-server-20181109-disk2.raw   
   Creating guest 'lmn7-server'.

Auch hier muss man, wenn man als Speichermedium lieber LVM verwendet,
weitere Anpassungen vornehmen. Hier bietet sich an, die zweite
Festplatte an seine eigenen Bedürfnisse anzupassen und gleich passend
zu vergrößern, das interne LVM aufzuschließen und auf die externe
Größe zu vergrößern.

.. code-block:: console

   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk1.raw | grep virtual\ size
   virtual size: 25G (26843545600 bytes)
   # lvcreate -L 26843545600b -n serverroot vghost
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-20181109-disk1.raw /dev/vghost/serverroot
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/vghost/serverroot'/>
   ...
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk2.raw | grep virtual\ size
   virtual size: 100G (107374182400 bytes)   
   # lvcreate -L 350G -n serverdata vghost
   ...
   ...


Netzwerkanpassung des Servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
Es muss nur eine Netzwerkschnittstelle angepasst werden und in die
Brücke `br-green` gestöpselt werden.

.. code-block:: console

   # virsh edit lmn7-server
   ...
   <interface type='bridge'>
      <mac address='52:54:00:20:ea:70'/>
      <source bridge='br-green'/>
   ...


Test der Verbindungen
~~~~~~~~~~~~~~~~~~~~~

Teste, ob du von deinem Admin-PC auf die Firewall mit dem
Standardpasswort `Muster!` kommst, teste dann ob du auch auf den
Server kommst.

.. code-block:: console

   # ssh 10.0.0.254 -l root

