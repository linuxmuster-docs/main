.. _install-on-kvm-label:

==========================
 Virtualisierung über KVM
==========================

.. sectionauthor:: `@morbweb <https://ask.linuxmuster.net/u/morpweb>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,
		   `@MachtDochNix (pics) <https://ask.linuxmuster.net/u/MachtDochNix>`_


In diesem Dokument findest du "Schritt für Schritt" Anleitungen zum
Installieren der linuxmuster.net-Musterlösung in der Version 7.0 auf
Basis von KVM unter Ubuntu Server 18.04 LTS. Lies zuerst die
Abschnitte :ref:`release-information-label` und
:ref:`prerequisites-label`, bevor du dieses Kapitel durcharbeitest.

Im folgenden Bild ist die einfachste Form der Implementierung der
Musterlösung schematisch mit dem gewählten (Standard-)Netzwerk ``10.0.0.0/12``
dargestellt:

.. figure:: media/install-on-kvm-image01.png

Nach der Installation gemäß dieser Anleitung erhältst du eine
einsatzbereite Umgebung bestehend aus

* einem Host (KVM) für alle virtuellen Maschinen, 
* einer Firewall (OPNSense) und 
* eines Servers (linuxmuster.net)

Ähnliche, nicht dokumentierte, Installationen gelten für einen
OPSI-Server und einen Docker-Host, die dann ebenso auf dem KVM-Host
laufen können.

Voraussetzungen
===============

* Es wird vorausgesetzt, dass du einen Administrationsrechner
  (Admin-PC genannt) besitzt, den du je nach Bedarf in die
  entsprechenden Netzwerke einstecken kannst und dessen
  Netzwerkkonfiguration entsprechend vornehmen kannst. Für diese
  Anleitung reicht ein Rechner mit ssh-Software aus, empfohlen wird
  allerdings ein Ubuntu-Desktop mit der Verwaltungssoftware
  `virt-manager`.

* Der Internetzugang des Admin-PCs und auch des KVM-Hosts sollte
  zunächst gewährleistet sein, d.h. dass beide zunächst z.B. an einem
  Router angeschlossen werden, über den die beiden per DHCP ins
  Internet können. Sobald später die Firewall korrekt eingerichtet
  ist, bekommt der Admin-PC und bei Bedarf auch der KVM-Host eine
  IP-Adresse im Schulnetz.

Bereitstellen des KVM-Hosts
===========================

.. hint:: 

   Der KVM-Host bildet das Grundgerüst für die Firewall *OPNsense* und
   den Schulserver *server*. Da KVM im Gegensatz zu Xen oder VMWare
   auf die Virtualisierungsfunktionen der CPU angewiesen ist, müssen
   diese natürlich vorhanden sein und eventuell im BIOS aktiviert
   werden.

Die folgende Anleitung beschreibt die *einfachste* Implementierung
ohne Dinge wie VLANs, Teaming oder Raids. Diese Themen werden in
zusätzlichen Anleitungen betrachtet.

* :ref:`Anleitung Netzwerksegmentierung <subnetting-basics-label>` 

.. _preface-usb-stick-label:

Erstellen eines USB-Sticks für den KVM-Host
-------------------------------------------

Download für den KVM-Host
  Es wird für die Installation auf dem
  KVM-Host ein Ubuntu Server 64bit in der Version 18.04 LTS
  verwendet. Es wird das alternative Installationsimage für
  DVD/USB-Stick verwendet, welches `hier unter "Download the alternate
  installer"
  <https://www.ubuntu.com/download/alternative-downloads#alternate-ubuntu-server-installer>`_
  heruntergeladen werden kann. Im Menü findet sich auch der Term
  "traditional installer".

Hilfreiche Befehle sind (Vorsicht - mit ``dd`` werden vorhandene Daten
unwiderruflich zerstört) hier aufgeführt. Der Name des
USB-Stick-Gerätes muss vorher herausgefunden werden, z.B. mit ``fdisk
-l``, er wird aus Sicherheitsgründen hier mit ``/dev/sdX`` bezeichnet.

Löschen des MBRs des USB-Sticks
  .. code-block:: console
     
     # sudo dd if=/dev/zero of=/dev/sdX bs=1M count=10

Größe des ISOs herausfinden
  .. code-block:: console
    
     # du -b ubuntu-18.04.1-server-amd64.iso
     749731840	ubuntu-18.04.1-server-amd64.iso

Kopieren des ISOs auf den Stick
  .. code-block:: console
  
     # sudo dd if=ubuntu-18.04.1-server-amd64.iso | sudo pv -s 749731840 | sudo dd of=/dev/sdX bs=1M && sync
     [sudo] Passwort für linuxadmin: 
     715MiB 0:00:09 [73,1MiB/s] [====================================================================>] 100%            
     0+168504 Datensätze ein
     0+168504 Datensätze aus
     749731840 bytes (750 MB, 715 MiB) copied, 9,78505 s, 76,6 MB/s

Natürlich können auch alle anderen gängigen Tools zur Erstellung
genutzt werden. Im folgenden Video ist die Prozedur anhand einer
älteren ISO-Datei dargestellt, verläuft aber äquivalent mit jeder
aktuellen Ubuntu-Version:

.. raw:: html

   <p>
   <iframe width="696" height="392" src="https://www.youtube.com/embed/7NIoQpSSVQw?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
   </p>
..


Installation des KVM-Hosts
--------------------------

.. tip::

   **Tl;dr** 

   * Achte auf die Auswahl der korrekten Netzwerkschnittstelle für
     einen Internetzugang
   * Erstelle einen Nutzer ``linuxadmin`` mit einem sicheren
     Passwort
   * Richte ein LVM auf deiner Festplatte/RAID mit ``25GB`` für das
     Betriebssystem des KVM-Hosts ein
   * Wähle das Pakets *OpenSSH server* 
   * Nach Reboot, Update des Systems und Installation von ``qemu-kvm``
     und ``libvirt-bin``

Netzwerkeinrichtung
  Nach Sprach- und Keyboardauswahl wird das Netzwerk eingerichtet. Es
  muss die primäre Schnittstelle ausgewählt werden, die einen Zugang zum
  Internet ermöglicht.
  
  .. figure:: media/kvmhost-install-network.png
  
  Sollte die Netzwerkkonfiguration nicht erfolgreich sein, wähle eine
  andere Schnittstelle und stelle sicher, dass die richtige
  Schnittstelle auch per DHCP eine IP-Adresse bekommen kann.

Rechnername, Benutzername, Passwort, Zeitzone
  Es wird empfohlen wie im Beispiel ``host`` als Rechnernamen zu
  verwenden. Der Benutzername wird im Beispiel ``linuxadmin`` genannt
  und dazu ein sicheres Passwort vergeben. Die Zeitzone sollte bereits
  richtig erkannt werden.

Festplatten partitionieren
  Im Beispiel wird `Geführt - gesamte Platte verwenden und LVM
  einrichten` gewählt. Wer eine Festplatte bzw. ein RAID verwendet,
  die eine Partitionierung enthält, dem wird dementsprechend die
  Option zur Wiederverwendung angeboten. Hat man bereits eine
  exisitierenden Partition und ein existierendes LVM und will sie
  `nicht` wiederverwenden, so muss dementsprechend zustimmen, dass die
  existierenden Daten entfernt werden.

  Im Anschluss muss man auf alle Fälle dem Schreiben der Änderungen
  auf die Speichergeräte zustimmen.

  .. figure:: media/kvmhost-install-write-partitiontable.png

  Die folgende Abfrage bezieht sich tatsächlich auf die Größe der
  Partition die für den KVM-Host verwendet werden soll. Dies wird
  dementsprechend niedrig, z.B. bei ``25GB`` angesetzt.

  .. figure:: media/kvmhost-install-root-vg-size.png

  Wenn man im nächsten Dialog das Schreiben auf die Festplatte
  zunächst `ablehnt`,

  .. figure:: media/kvmhost-install-decline-diskchanges.png

  bekommt man eine Übersicht über die aktuell vorgesehene
  Konfiguration und hat erweitertete Änderungsmöglichkeiten (RAID,
  Verschlüsselung, etc.). 

  .. figure:: media/kvmhost-install-overviewchanges.png

  Über `Partitionierung beenden und Änderungen übernehmen` kann man
  nun den zunächst abgelehnten Dialog bestätigen.
  
Paketmanager und Softwareauswahl
  Der HTTP-Proxy wird leer gelassen, sofern du freien Internetzugang
  hast. Im nächsten Dialog sollte ``OpenSSH server`` gewählt werden.

  .. figure:: media/kvmhost-install-tasksel.png

  Am Ende der Installation musst du noch die Installation von GRUB in
  den Bootbereich bestätigen. Der KVM-Host wird rebootet.
  
Update und Softwareinstallation des KVM-Hosts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nach einem Reboot loggst du dich als ``linuxadmin`` ein und führst
zunächst ein Update aus. Das ist (Stand: Dez. 2018) notwendig, damit
die spätere Konfiguration funktioniert. Der erste Befehl zeigt Dir, ob
du eine IP-Adresse auf einem Netzwerk hast.

.. code-block:: console

   $ ip -br addr list
   lo               UNKNOWN        127.0.0.1/8 ::1/128 
   enp0s8           DOWN        
   enp0s17          UP             192.168.1.2/16 fe80::ae1c:ba12:6490:f75d/64
   $ sudo apt update
   $ sudo apt full-upgrade -y

Unter Umständen werden Dialoge erneut abgefragt, die schon bei der
Installation beantwortet wurden (z.B. Tastaturkonfiguration).

Installiere danach die qemu/KVM-Software durch Bestätigen der Fragen

.. code-block:: console

   $ sudo apt install libvirt-bin qemu-kvm kpartx
   $ sudo apt --no-install-recommends install virtinst

Nach Installation der KVM-Software werden weitere virtuelle Netzwerk-Schnittstellen sichtbar

.. code-block:: console

   $ ip -br addr list
   lo               UNKNOWN        127.0.0.1/8 ::1/128 
   enp0s8           DOWN        
   enp0s17          UP             192.168.1.2/16 fe80::ae1c:ba12:6490:f75d/64
   virbr0           DOWN           192.168.122.1/24 
   virbr0-nic       DOWN           

  
Netzwerkkonfiguration des KVM-Hosts
-----------------------------------

In diesem Schritt wird die direkte Verbindung des KVM-Hosts mit dem
Internet ersetzt durch eine virtuelle Verkabelung über so genannte
`bridges`.  Zunächst werden die Brücken ``br-red`` (Internetseite) und
``br-server`` (Schulnetzseite) definiert und der KVM-Host bekommt über
die Brücke ``br-red`` eine IP-Adresse.

.. hint::

   Die Netzwerkkonfiguration wird seit 18.04 standardmäßig über
   netplan realisiert. Wer seinen KVM-Host von früheren
   Ubuntu-Versionen updatet, bei dem wird nicht automatisch `netplan`
   installiert, sondern `ifupdown` wird mit der Konfigurationsdatei
   ``/etc/network/interfaces`` beibehalten.

Namen der Netzwerkkarten
  Mit folgendem Befehl werden alle physischen Netzwerkkarten
  (teilweise umbenannt) gefunden:

  .. code-block:: console
     
     # dmesg | grep eth
     [    9.230673] e1000e 0000:08:00.0 eth0: (PCI Express:2.5GT/s:Width x4) 00:30:48:dd:ee:ff
     [    9.273215] e1000e 0000:11:00.1 eth1: (PCI Express:2.5GT/s:Width x4) 00:30:48:aa:bb:cc
     [    9.432342] e1000e 0000:08:00.0 enp0s8: renamed from eth0
     [    9.654232] e1000e 0000:11:00.1 enp0s17: renamed from eth1

Anpassen der Netzwerkkonfiguration
  .. code-block:: console

     $ sudo nano /etc/netplan/01-netcfg.yaml

  Die Netzwerkkonfiguration enthält standardmäßig die Schnittstelle,
  die bei der Installation mit dem Internet verbunden war. Diese
  Schnittstelle wird dann auch mit der Brücke ``br-red`` verbunden. 
     
  .. code-block:: yaml

     network:
       version: 2
       renderer: networkd
       ethernets:
         enp0s8:
	   dhcp4: no
	 enp0s17:
	   dhcp4: no
     bridges:
       br-red:
         interfaces: [enp0s17]
	 dhcp4: yes
       br-server:
         interfaces: [enp0s8]
	 addresses: [ ]

  Diese Netzwerkkonfiguration muss nun angewandt werden.

  .. code-block:: console

     $ sudo netplan apply

  .. hint::

     Potenzielle Fehlerquellen sind nicht konsequent eingerückte
     Zeilen oder TABs.

     .. code-block:: console

	Invalid YAML at /etc/netplan/01-netcfg.yaml line 6 column 0: found character that cannot start any token
  
  Jetzt sollte der KVM-Host (diesselbe) IP-Adresse über die Brücke
  bekommen haben. 
     
  .. code-block:: console

     $ ip -br addr list
     lo               UNKNOWN        127.0.0.1/8 ::1/128 
     enp0s8           DOWN        
     enp0s17          UP
     virbr0           DOWN           192.168.122.1/24 
     virbr0-nic       DOWN           
     br-red           UP             192.168.1.2/16 fe80::ae1c:ba12:6490:f75d/64
     br-server        DOWN


SSH-Zugang und Zeit-Synchronisation
-----------------------------------

Einrichten des SSH-Zugangs auf Zertifikatsbasis
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Die Remote-Administration des KVM-Hosts soll per SSH und Zertifikaten
erfolgen. 

Erstellen von SSH-Zertifikaten auf dem Admin-PC und Kopieren auf den KVM-Host
  .. code-block:: console

     # ssh-keygen
     # ssh-copy-id linuxadmin@192.168.1.2

Ab jetzt kann jegliche Konfiguration über ein Einloggen auf dem
KVM-Host vom Admin-PC aus erfolgen.

Einrichten der Zeit-Synchronisation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Immer eine gute Sache ist es, z.B. in Logfiles die korrekte Zeit zu
finden. Aus diesem Grund erfolgt die Konfiguration eines NTP-Clients.

.. code-block:: console

   Installieren von ntpdate
   $ sudo apt install ntpdate

   Einmaliges Stellen der Uhrzeit
   $ sudo ntpdate 0.de.pool.ntp.org

   Installieren des NTP-Daemons
   $ sudo apt install ntp

   Anzeigen der Zeitsynchronisation
   $ sudo ntpq -p

.. raw:: html

	<p> <iframe width="696" height="392"
	src="https://www.youtube.com/embed/tHqFTfS99xo?rel=0"
	frameborder="0" allow="autoplay; encrypted-media"
	allowfullscreen></iframe> </p>
..


Vorbereitungen für den Import der virtuellen Maschinen
------------------------------------------------------

Download Virtuelle Maschinen
  Lade auf dem KVM-Host die aktuellen OVA-Abbilder von der `Webseite
  <https://github.com/linuxmuster/linuxmuster-base7/wiki/Die-Appliances>`_
  herunter, die zu dem Adressbereich gehören, den du brauchst
  (``10.0.0.1/16`` oder ``10.16.1.1/12``)

  .. code-block:: console
     
     # wget http://fleischsalat.linuxmuster.org/ova/lmn7-opnsense-20181109.ova
     # wget http://fleischsalat.linuxmuster.org/ova/lmn7-server-20181109.ova
     # wget http://fleischsalat.linuxmuster.org/ova/lmn7-opsi-20181109.ova
     # wget http://fleischsalat.linuxmuster.org/ova/lmn7-docker-20181109.ova

  Überprüfe die `md5`-Summe mit dem entsprechenden Werkzeug und
  vergleiche mit der Webseite auf Integrität. In der weiteren Anleitung
  wird statt der Dateien mit Datumsstempel ``20181109`` die Datei mit
  ``*`` verwendet. Solange du nur je ein (das aktuelle) OVA-Abbild
  vorliegen hast, funktionieren die Befehle auch mit dem ``*``.

KVM-Anpassungen
  Nach der Integration bietet es sich an, die Hardware der
  importierten Appliances anzupassen und z.B. die Festplattentypen auf
  "virtio" zu stellen. Ebenso habe ich den Typ der "Grafikkarte" von
  `spice` auf `vnc` gesetzt.

Import der Firewall
===================

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
   # lvcreate -L 10737418240b -n opnsense host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-opnsense-*disk1.raw /dev/host-vg/opnsense
   # virsh edit lmn7-opnsense
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/host-vg/opnsense'/>
   ...

Falls das Abbild erfolgreich ins LVM des Hosts übertragen wurde,
kann das Abbild in ``/var/lib/libvirt/images`` gelöscht werden.

Netzwerkanpassung der Firewall
------------------------------
   
Die Netzwerkkarten der Appliance werden in der Reihenfolge importiert,
wie sie in der Appliance definiert wurden:

1. `LAN, 10.0.0.254/16`, d.h. diese Schnittstelle wird auf der
   pädagogischen Seite des Netzwerks angeschlossen
2. `WAN, DHCP`, d.h. diese Schnittstelle wird auf der Internetseite
   angeschlossen
3. `OPT1, unkonfiguriert`, d.h. diese Schnittstelle wird für optionale
   Netzwerke verwendet und muss zunächst nicht angeschlossen werden.

Öffne die Konfiguration und editiere die erste Schnittstelle, so dass
sie sich im Schulnetzwerk befindet, hier im Beispiel wird diese an die
virtuelle Brücke ``br-server`` mit dem Stichwort `bridge` und dem Typ
`bridge` angeschlossen. Die MAC-Adresse sollte bei dieser Gelegenheit
auch (beliebig) geändert werden.

.. code-block:: console

   # virsh edit lmn7-opnsense
   ...
   <interface type='bridge'>
      <mac address='52:54:00:20:ea:70'/>
      <source bridge='br-server'/>
   ...

Die zweite Schnittstelle sollte genauso dem Typ `bridge` zugeordnet
werden, allerdings an die Brücke ``br-red`` angeschlossen werden.

.. code-block:: console

   # virsh edit lmn7-opnsense
   ...
   <interface type='bridge'>
      <mac address='52:54:00:d2:0c:62'/>
      <source bridge='br-red'/>
   ...

Test der Verbindung zur Firewall
--------------------------------

.. todo:: 

   Unlogisch. Der Admin-PC sollte erst mal ins ``br-server``-Netzwerk
   gestöpselt werden, damit man damit auf die Adresse 10.0.0.254 der
   Firewall kommt. Allenfalls kommt man auf die bislang unbekannte
   Adresse die die Firewall auf dem WAN-Interface bekommt.

Starte die Firewall. Der Admin-PC sollte sich nach ca. 3 Minuten mit
der Firewall verbinden lassen.

.. code-block:: console

   # virsh start lmn7-opnsense
   Domain lmn7-opnsense started
   # ping 10.0.0.254
   PING 10.0.0.254 (10.0.0.254) 56(84) bytes of data.
   64 bytes from 10.0.0.254: icmp_seq=1 ttl=64 time=0.183 ms
   64 bytes from 10.0.0.254: icmp_seq=2 ttl=64 time=0.242 ms
   ...
   STRG-C
   # ssh 10.0.0.254 -l root
   Password for root@OPNsense.localdomain:
   ...
   LAN (em0)       -> v4: 10.0.0.254/16
   WAN (em1)       -> v4/DHCP4: 192.168.1.23/16
   ...

Man erkennt, dass die Firewall die Netzwerkkarten für innen (LAN) und
außen (WAN) richtig zugeordnet hat. Sollte diese Verbindung nicht
gelingen, dann empfiehlt sich ein Admin-PC, mit dem man über das
Programm `virt-manager` den VM-Host und damit die Firewall über eine
GUI-Verbindung erreicht und die Netzkonfiguration der opnsense
überprüfen und korrigieren kann.

Import des Servers
==================

Importiere die Server-Appliance `lmn7-server`.

.. code-block:: console

   # virt-convert lmn7-server-*.ova
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
   # lvcreate -L 26843545600b -n serverroot host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-*disk1.raw /dev/host-vg/serverroot
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/host-vg/serverroot'/>
      <target dev='vda' bus='virtio'/>
   ...
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk2.raw | grep virtual\ size
   virtual size: 370G (397284474880 bytes)
   # lvcreate -L 397284474880b -n serverdata host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-*disk2.raw /dev/host-vg/serverdata
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/host-vg/serverdata'/>
      <target dev='vdb' bus='virtio'/>      
   ...

Falls die Abbilder erfolgreich ins LVM des Hosts übertragen wurden,
können die Abbilder in ``/var/lib/libvirt/images`` gelöscht werden.

Netzwerkanpassung des Servers
-----------------------------
   
Es muss nur eine Netzwerkschnittstelle angepasst werden und in die
Brücke ``br-server`` gestöpselt werden.

.. code-block:: console

   # virsh edit lmn7-server
   ...
   <interface type='bridge'>
      <mac address='52:54:00:9f:b8:af'/>
      <source bridge='br-server'/>
   ...

Test der Verbindung zum Server
------------------------------

Starte den Server. Teste, ob du von deinem Admin-PC auf den Server mit
dem Standardpasswort `Muster!` kommst.

.. code-block:: console

   # virsh start lmn7-opnsense
   Domain lmn7-opnsense started
   # ssh 10.0.0.1 -l root
   root@10.0.0.1's password: 
   Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-38-generic x86_64)
   ...

Sollte diese Verbindung nicht gelingen, dann empfiehlt sich ein
Admin-PC, mit dem man über das Programm `virt-manager` den VM-Host
erreicht und über eine GUI-Verbindung den Server begutachtet.

.. warning::

   Stand Dez. 2018 bekommt der importierte Server keine IP-Adresse
   weil beim Import mit Sicherheit die Netzwerkschnittstelle einen
   anderen Namen hat als dort, wo die Appliance erstellt
   wurde. D.h. man muss über den `virt-manager` den KVM-Host erreichen
   und den `server` über die GUI-Verbindung richtig konfigurieren:

   .. code-block:: console

      Herausfinden des Netzwerknamens
      server~$ ip -br addr list
      Ersetzen von `ens33` in der netplan-Konfiguration durch den richtigen Namen
      server~$ sudo nano /etc/netplan/01-netcfg.yaml
      Neustart des Netzwerkes
      server~$ sudo netplan apply





Abschließende Konfigurationen
=============================

Aufräumen
---------

Das Paket `virtinst` sowie dessen Abhängigkeiten können deinstalliert
werden, so bleibt das Host-System mit weniger Paketen und weniger
Abhängigkeiten sauberer.

.. code-block:: console

   # apt remove virtinst
   # apt autoremove


Aktivieren des Autostarts der VMs
---------------------------------

Damit die VMs zukünftig bei einem Neustart des KVM-Servers nicht immer
von Hand gestartet werden müssen, ist es sinnvoll den Autostart zu
aktivieren.

.. code-block:: console

   # virsh autostart lmn7-opnsense
   Domain lmn7-opnsense marked as autostarted
   # virsh autostart lmn7-server
   Domain lmn7-server marked as autostarted

Ab jetzt ist eine Installation der Musterlösung möglich. Folge der
:ref:`Anleitung hier <setup-using-selma-label>`.
