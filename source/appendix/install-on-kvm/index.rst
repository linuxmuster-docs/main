==========================
 Virtualisierung über KVM
==========================

Vorbereitung für die Installation
=================================

Es wird für die Installation ein Ubuntu Server 64bit in der Version 18.04 LTS angenommen.

Lade die aktuellen OVA-Abbilder von der `Webseite <https://github.com/linuxmuster/linuxmuster-base7/wiki/Die-Appliances>`_ herunter.

.. code-block:: console

   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-opnsense-20181109.ova
   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-server-20181109.ova
   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-opsi-20181109.ova
   # wget http://fleischsalat.linuxmuster.org/ova/lmn7-docker-20181109.ova

und überprüfe die md5-Summe mit dem entsprechenden Werkzeug und
vergleiche mit der Webseite auf Integrität.

Firewall
~~~~~~~~

Importiere die Firewall-Appliance

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
      <source dev='/dev/storage/lmn7-opnsense'/>
   ...

Netzwerkanpassung
~~~~~~~~~~~~~~~~~

- KVM Host stellt eine virtuelle Bridge br0 über eth0 bereit, das mit
  dem Internet-Router verbunden ist.
- KVM-Host stellt eine virtuelle Bridge br1 über eth1 bereit, das mit
  dem grünen Netzwerk verbunden ist.


