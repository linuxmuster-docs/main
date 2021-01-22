.. include:: /guided-inst.subst

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
Abschnitte :ref:`what-is-new-label` und
:ref:`prerequisites-label`, bevor du dieses Kapitel durcharbeitest.

Im folgenden Bild ist die einfachste Form der Implementierung der
Musterlösung schematisch mit dem gewählten (Standard-)Netzwerk ``10.0.0.0/16``
dargestellt:

.. figure:: media/install-on-kvm-image01.png

Nach der Installation gemäß dieser Anleitung erhältst du eine
einsatzbereite Umgebung bestehend aus

* einem Host (KVM) für alle virtuellen Maschinen, 
* einer Firewall (OPNsense für linuxmuster.net) und 
* einem Server (linuxmuster.net)

Ähnliche, nicht dokumentierte, Installationen gelten für einen
OPSI-Server und einen Docker-Host, die dann ebenso auf dem KVM-Host
laufen können.

Voraussetzungen
===============

* Der Internetzugang des KVM-Hosts sollte (zunächst) gewährleistet
  sein. Entweder bekommt er von einem Router per DHCP eine externe
  IP-Adresse, Gateway und einen DNS-Server oder man trägt eine
  statische IP, Gateway und einen DNS-Server von Hand ein.
* Sofern ein Admin-PC eingerichtet wird, sollte dieser die Möglichkeit
  haben, sich bei Bedarf in das entsprechende Netzwerk
  einzuklinken. Im Servernetzwerk bekommt der Admin-PC die IP-Adresse
  ``10.0.0.10/16`` mit Gateway und DNS-Server jeweils ``10.0.0.254``.
  Es bietet sich ein Ubuntu-Desktop mit der Software `virt-manager`
  an.

Download der Appliances OVA
===========================

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         |
+====================+======================================================================+
| lmn7.opnsense      | OPNsense Firewall VM  der linuxmuster.net v7                         |
+--------------------+----------------------------------------------------------------------+
| lmn7.server        | Server der linuxmuster.net v7                                        |
+--------------------+----------------------------------------------------------------------+

Nachstehende VMs sind optional, sofern eine paketorientierte Softwareverteilung für Windows-Clients (OPSi), eigene Web-Services mithilfe eines sog. Docker-Hosts betrieben und/oder eine WLAN-Anbindung via Ubiquiti bereitgestellt werden soll.

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

Vorgehen
========

1. Der KVM-Host wird an einen Router angeschlossen, so dass er ins
   Internet kommt (per DHCP oder statischer IP), es wird ein
   heruntergeladenes Ubuntu Server 64bit von einem USB-Stick auf dem
   KVM-Host installiert.
2. Die Software für KVM und die Zeitsynchronisation werden installiert
   und konfiguriert.
3. Das virtuelle Netzwerk wird auf dem KVM-Host konfiguriert.
4. Das heruntergeladene Abbild der Firewall wird importiert, an die
   neue Netzwerkumgebung angepasst und die Netzwerkverbindung zur
   Firewall getestet. In der Firewall wird optional die externe
   Netzwerkanbindung konfiguriert.
5. Der Server wird importiert, die Festplattengrößen an eigene
   Bedürfnisse angepasst und die Netzwerkverbindung angepasst und
   getestet.
6. Abschließende Konfigurationen auf dem KVM-Host


Bereitstellen des KVM-Hosts
===========================

.. hint::

   Der KVM-Host bildet das Grundgerüst für die Firewall *OPNsense* und
   den Schulserver *server*. Da KVM im Gegensatz zu Xen oder VMWare
   auf die Virtualisierungsfunktionen der CPU angewiesen ist, müssen
   diese natürlich vorhanden sein und eventuell im BIOS aktiviert
   werden.

Die folgende Anleitung beschreibt die *einfachste* Implementierung
ohne Dinge wie VLANs, Teaming/Bonding oder RAIDs. Diese Themen werden
in zusätzlichen Anleitungen betrachtet.

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
  
  Sollte die automatische Netzwerkkonfiguration per DHCP nicht
  erfolgreich sein, kannst du auch manuell IP-Adresse, Gateway und
  DNS-Server eingestellen (z.B. für die Kunden von Belwue).
  Wichtig ist die richtige Schnittstelle auszuwählen.

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
und welche IP-Adresse du auf einem Netzwerk hast. Im folgenden
Beispiel wird als externe IP-Adresse immer die IP ``192.168.1.2/16``
verwendet, die per DHCP von einem Router zugeordnet wurde.

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

   $ sudo apt install libvirt-bin qemu-kvm kpartx qemu-utils
   $ sudo apt --no-install-recommends install virtinst

Einrichten der Zeitsynchronisation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


Vorbereitungen für den Import der virtuellen Maschinen
------------------------------------------------------

Download der virtuellen Maschinen
  Lade auf dem KVM-Host die aktuellen OVA-Abbilder und die entsprechenden 
  `sha`-Summen von der `Webseite <https://download.linuxmuster.net/ova/v7/latest/>`_ herunter.

  Beispielhaft für die Version vom 24.7.2019:

  .. code-block:: console
     
     # wget https://download.linuxmuster.net/ova/v7/latest/lmn7-opnsense-20190724.ova
     # wget https://download.linuxmuster.net/ova/v7/latest/lmn7-opnsense-20190724.ova.sha
     # wget https://download.linuxmuster.net/ova/v7/latest/lmn7-server-20190724.ova
     # wget https://download.linuxmuster.net/ova/v7/latest/lmn7-server-20190724.ova.sha

  Überprüfe die `sha`-Summe mit dem entsprechenden Werkzeug und
  vergleiche mit der Webseite auf Integrität.
  
  .. code-block:: console
     
     # shasum -c *.sha
     lmn7-opnsense-20190724.ova: OK
     lmn7-server-20190724.ova: OK

.. hint:: 
  
   In der weiteren
   Anleitung wird statt der Dateien mit Datumsstempel wie ``20190724``
   die Datei mit ``*`` verwendet. Solange du nur je ein (das aktuelle)
   OVA-Abbild vorliegen hast, funktionieren die Befehle auch mit dem
   ``*``.

.. 
 KVM-Anpassungen
  Nach der Integration bietet es sich an, die Hardware der
  importierten Appliances anzupassen und z.B. die Festplattentypen auf
  "virtio" zu stellen. Ebenso habe ich den Typ der "Grafikkarte" von
  `spice` auf `vnc` gesetzt.

  
Netzwerkkonfiguration des KVM-Hosts
-----------------------------------
   
Nach Installation der KVM-Software (``virbr0*`` wurden automatisch
hinzugefügt) ist die Netzwerksituation folgende:

.. code-block:: console

   $ ip -br addr list
   lo               UNKNOWN        127.0.0.1/8 ::1/128 
   enp0s8           DOWN        
   enp0s17          UP             192.168.1.2/16 fe80::ae1c:ba12:6490:f75d/64
   virbr0           DOWN           192.168.122.1/24 
   virbr0-nic       DOWN           

In diesem Schritt wird die direkte Verbindung des KVM-Hosts mit dem
Internet gekappt und eine virtuelle Verkabelung über so genannte
`bridges` erstellt.  Zunächst werden die Brücken ``br-red``
(Internetseite) und ``br-server`` (Schulnetzseite) definiert.  Zuletzt
kann der KVM-Host auch über die Brücke ``br-red`` eine IP-Adresse ins
Internet bekommen, genau wie er über die Brücke ``br-server`` auch im
pädagogischen Netzwerk auftauchen kann. Letzteres ist nicht zu empfehlen.

.. hint::

   Die Netzwerkkonfiguration wird seit Ubuntu 18.04 standardmäßig über
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
	   dhcp4: no
	   addresses: [ ]
         br-server:
           interfaces: [enp0s8]
	   addresses: [ ]

  Diese Netzwerkkonfiguration kann nun ausprobiert und angewandt werden.

  .. code-block:: console

     $ sudo netplan try

  .. hint::

     Potenzielle Fehlerquellen sind nicht konsequent eingerückte
     Zeilen oder TABs.

     .. code-block:: console

	Invalid YAML at /etc/netplan/01-netcfg.yaml line 6 column 0: found character that cannot start any token

     Bei fehlerhaften Anläufen lohnt es sich, den
     KVM-host zu rebooten und die Netzwerkkonfiguration erneut zu
     betrachten. 
  
KVM-Host auch im Internet
  Soll später nicht nur die Firewall sondern auch der KVM-Host im
  Internet erreichbar sein, dann muss der entsprechende Block so aussehen:

  .. code-block:: yaml

     network:
       ...
       bridges:
         br-red:
           interfaces: [enp0s17]
	   dhcp4: yes
         br-server:
       ...

  Wer bisher einen statischen Zugang eingerichtet hatte, der kann das
  genauso hier tun. Der entsprechende Abschnitt wäre beispielhaft

  .. code-block:: yaml

       bridges:
         br-red:
           interfaces: [enp0s17]
	   addresses: [141.1.2.5/29]
	   gateway4: 141.1.2.3
	   nameservers:
             addresses: [129.143.2.1]

	 
Import der Firewall
===================

Importiere die Firewall-Appliance `lmn7-opnsense`, fahre sie gleich
herunter und benenne sie um

.. code-block:: console

   # virt-convert lmn7-opnsense-*.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-opnsense-20190724-disk001.vmdk /var/lib/libvirt/images/lmn7-opnsense-20190724-disk001.raw
   Creating guest 'lmn7-opnsense-20190724.ovf'.
   # virsh shutdown lmn7-opnsense-20190724.ovf
   Domain ... is being shutdwon
   # virsh domrename lmn7-opnsense-20190724.ovf lmn7-opnsense

Festplatten in das Host-LVM importieren
---------------------------------------

Die virtuellen Maschinen werden in Produktivsystemen auf einem LVM
liegen. Dafür muss die Festplattengröße ermittelt, ein `logical volume`
erstellt, das Abbild nochmals kopiert und die Konfiguration
editiert. Der Bus wird auf `virtio` gestellt, dann heißt die
Schnittstelle auch `vda`.

.. code-block:: console

   # qemu-img info /var/lib/libvirt/images/lmn7-opnsense-*disk001.raw | grep virtual\ size
   virtual size: 10G (10737418240 bytes)
   # lvcreate -L 10737418240b -n opnsense host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-opnsense-*disk001.raw /dev/host-vg/opnsense
   # virsh edit lmn7-opnsense
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/host-vg/opnsense'/>
      <target dev='vda' bus='virtio'/>
      <address .../>           <---- delete this line, will be autocreated correctly
   ...

Jetzt kann das Abbild in ``/var/lib/libvirt/images`` gelöscht werden.

.. code-block:: console

   # rm /var/lib/libvirt/images/lmn7-opnsense-*disk001.raw

Netzwerkanpassung der Firewall
------------------------------
   
Die Netzwerkkarten der Appliance werden in der Reihenfolge importiert,
wie sie in der Appliance definiert wurden:

1. `LAN, 10.0.0.254/16`, d.h. diese Schnittstelle wird auf der
   pädagogischen Seite des Netzwerks angeschlossen
2. `WAN, DHCP`, d.h. diese Schnittstelle wird auf der Internetseite
   angeschlossen und ist als DHCP-Client konfiguriert.
3. `OPT1, unkonfiguriert`, d.h. diese Schnittstelle wird für optionale
   Netzwerke verwendet und muss zunächst nicht angeschlossen werden.

Öffne die KVM-Konfiguration und editiere die erste Schnittstelle, so
dass diese sich im Schulnetzwerk befindet, hier im Beispiel wird sie
an die virtuelle Brücke ``br-server`` mit dem Stichwort `bridge` und
dem Typ `bridge` angeschlossen. Die MAC-Adresse sollte bei dieser
Gelegenheit auch (beliebig) geändert werden.

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

Die dritte Schnittstelle kann zunächst gelöscht werden. Wenn später
ein weiteres Netzwerk eingerichtet wird, z.B. ``br-dmz`` für eine so
genannte demilitarisierte Zone, in der sich Webserver
u.ä. befinden. Kann der Abschnitt wieder hinzugefügt werden und taucht
in der OPNsense als ``OPT1`` wieder auf.

Start und Konsolenlogin
~~~~~~~~~~~~~~~~~~~~~~~

Starte die Firewall. 

.. code-block:: console

   # virsh start lmn7-opnsense
   Domain lmn7-opnsense started

Auf Konsolenebene kannst du dich per ssh (siehe oben) oder über die
serielle Konsole einwählen. Ein zusätzliches `Enter` hilft, um das
``login:`` zu sehen.

.. code-block:: console

   # virsh console lmn7-opnsense
   Connected to domain lmn7-opnsense
   Escape character is ^]
   
   login: root
   Password:
   Last login: Sun Mar 17 17:12:21 on ttyv0
   ...
   LAN (em0)       -> v4: 10.0.0.254/16
   WAN (em1)       -> v4/DHCP4: 192.168.1.23/16
   ...
   0) Logout                              7) Ping host
   1) Assign interfaces                   8) Shell
   2) Set interface IP address            9) pfTop
   ...

Man erkennt, dass die Firewall die Netzwerkkarten für innen (LAN) und
außen (WAN, hier über DHCP) richtig zugeordnet hat.
   
Mit der Tastenkombination ``STRG-5`` verlässt man die serielle Konsole.


Optional: Externe Netzwerkanbindung der Firewall einrichten
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Wer eine statische IP-Adresse in der Firewall braucht, der muss diese
konfigurieren. Konfiguriere die WAN-Schnittstelle über ``2)`` im
Hauptmenü der OPNsense und folge den Anweisungen dort, eine feste
IP-Adresse einzugeben. Die relevanten Zeilen sind beispielhaft:

.. code-block:: console

   Configure IPv4 address WAN interface via DHCP? [Y/n] n
   Enter the new WAN IPv4 address. Press <ENTER> for none:
   > 141.1.2.4
   Enter the new WAN IPv4 subnet bit count (1 to 32):
   > 29
   For a WAN, enter the new WAN IPv4 upstream gateway address.
   > 141.1.2.3
   Do you want to use the gateway as the IPv4 name server, too? [Y/n] n
   Enter the IPv4 name server or press <ENTER> for none:
   > 129.143.2.4
   Configure IPv6 address WAN interface via DHCP6? [Y/n] n
   Enter the new WAN IPv6 address. Press <ENTER> for none:
   > 
   Do you want to revert to HTTP as the web GUI protocol? [y/N] 

Optional: Umstellung des Netzbereichs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Wer einen anderen Netzbereich als ``10.0.0.0/16`` im internen Netzwerk
haben möchte, muss auch hier die IP-Adresse der Firewall
ändern. Beispielhaft wird die Änderung in den beliebten bisherigen
Netzbereich ``10.16.0.0/12`` vollzogen.

Die relevanten Zeilen sind:

.. code-block:: console

   Available interfaces:
   1 - LAN (em0 - static)
   2 - WAN (em1 - dhcp, dhcp6)
   Enter the number of the interface to configure: 1

   Configure IPv4 address LAN interface via DHCP? [y/N] n
   Enter the new LAN IPv4 address. Press <ENTER> for none:
   > 10.16.1.254
   ...
   Enter the new LAN IPv4 subnet bit count (1 to 32):
   > 12
   For a WAN, enter the new LAN IPv4 upstream gateway address.
   For a LAN, press <ENTER> for none:
   >
   Configure IPv6 address LAN interface via WAN tracking? [Y/n] n
   Configure IPv6 address LAN interface via DHCP6? [y/N] n
   Enter the new LAN IPv6 address. Press <ENTER> for none:
   >
   Do you want to enable the DHCP server on LAN? [y/N] n
   Do you want to revert to HTTP as the web GUI protocol? [y/N] n
   Writing configuration...done.
   ...

Test der Netzwerkverbindung zur Firewall
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Um die Verbindung zur Firewall im Netzwerk ``br-server`` zu testen,
muss ein zweiter Rechner in diesem Netzwerk konfiguriert werden. Du
kannst wie unten beschrieben den optionalen Admin-PC anschließen und
mit der IP ``10.0.0.10``, Netzmaske ``16`` bzw. ``255.255.0.0`` und
Gateway ``10.0.0.254`` konfigurieren.

Alternativ kann zeitweilig der KVM-Host selbst als Admin-PC
konfiguriert. Dafür wird wieder die netplan-Datei editiert

.. code-block:: console

   # nano /etc/netplan/01-netcfg.yaml

Der entsprechende Block lautet dann:
   
.. code-block:: yaml

   network:
     ...
     bridges:
     ...
       br-server:
         interfaces: [enp0s8]
	 addresses: [10.0.0.10/16]
	 gateway4: 10.0.0.254
	 nameservers:
           addresses: [10.0.0.254]

``netplan try`` und ein Enter schließt die Änderung ab.

Jetzt solltest du die Firewall vom Admin-PC (oder vom KVM-Host) aus
anpingen können.
	   
.. code-block:: console

   $ ping 10.0.0.254
   PING 10.0.0.254 (10.0.0.254) 56(84) bytes of data.
   64 bytes from 10.0.0.254: icmp_seq=1 ttl=64 time=0.183 ms
   64 bytes from 10.0.0.254: icmp_seq=2 ttl=64 time=0.242 ms
   ...
   STRG-C

Ebenso ist dann ein Einloggen mit dem voreingestellten Passwort
`Muster!` möglich:
   
.. code-block:: console
		
   $ ssh 10.0.0.254 -l root
   Password for root@OPNsense.localdomain:
   ...
   LAN (em0)       -> v4: 10.0.0.254/16
   WAN (em1)       -> v4: 141.1.2.4/29
   ...

Ausloggen mit ``exit`` oder ``STRG-D``.
		
Import des Servers
==================

Importiere die Server-Appliance `lmn7-server`.

.. code-block:: console

   # virt-convert lmn7-server-*.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-server-xxxxxxxx-disk001.vmdk /var/lib/libvirt/images/lmn7-server-xxxxxxxx-disk001.raw
   Running /usr/bin/qemu-img convert -O raw lmn7-server-xxxxxxxx-disk002.vmdk /var/lib/libvirt/images/lmn7-server-xxxxxxxx-disk002.raw   
   Creating guest 'lmn7-server-20190724.ovf'.
   # virsh shutdown lmn7-server-20190724.ovf
   # virsh domrename lmn7-server-20190724.ovf lmn7-server
   
Festplattengrößen für den Server anpassen
-----------------------------------------
   
An dieser Stelle muss man die Festplattengrößen für den
Produktiveinsatz an seine eigenen Bedürfnisse anpassen. Für einen
Testbetrieb kann die Erweiterung ausfallen und man kann gleich mit dem
Import in ein LVM fortsetzen.

Beispielhaft wird die zweite Festplatte und das darin befindliche
server-LVM vergrößert, so dass ``/dev/vg_srv/linbo`` und
``/dev/vg_srv/default-school`` auf jeweils 175G vergrößert werden.

Zunächst wird der Container entsprechend (auf 10+10+175+175 GB)
vergrößert, dann der mit Hilfe von `kpartx` aufgeschlossen.

.. code-block:: console

   # qemu-img resize -f raw /var/lib/libvirt/images/lmn7-server-*disk002.raw 370G
   Image resized.
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk002.raw | grep virtual\ size
   virtual size: 370G (397284474880 bytes)
   # kpartx -av /var/lib/libvirt/images/lmn7-server-*disk002.raw
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
   # lvresize /dev/vg_srv/linbo -l +34559     
   Size of logical volume vg_srv/linbo changed from <40,00 GiB (10239 extents) to <175,00 GiB (44799 extents).
   Logical volume vg_srv/linbo successfully resized.
   # e2fsck -f /dev/vg_srv/linbo
   ...
   default-school: 13/2621440 Dateien (0.0% nicht zusammenhängend), 242386/10484736 Blöcke
   # resize2fs /dev/vg_srv/linbo
   ...
   Das Dateisystem auf /dev/vg_srv/linbo is nun 45874176 (4k) Blöcke lang.

Um den Container wieder ordentlich zu schließen, muss man die `volume
group` abmelden und mit `kpartx` abschließen, ein letztes `vgdisplay
-s` überprüft, ob nur noch das Host-LVM übrig geblieben ist.

.. code-block:: console

   # vgchange -a n vg_srv
   0 logical volume(s) in volume group "vg_srv" now active
   # kpartx -dv /var/lib/libvirt/images/lmn7-server-*disk002.raw 
   loop deleted : /dev/loop0
   # vgdisplay -s
   "host-vg" < GiB [xxx GiB used / yyy free]
   
Festplatten in das Host-LVM importieren
---------------------------------------

Auch hier wird als Speichermedium auf dem Host LVM verwendet, wofür
die selben Anpassung wie bei der Firewall nötig sind, ebenso werden
die Schnittstellen mit dem Bussystem wieder umbenannt (`vda`, `vdb`,
`virtio`).

.. code-block:: console

   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk001.raw | grep virtual\ size
   virtual size: 25G (26843545600 bytes)
   # lvcreate -L 26843545600b -n serverroot host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-*disk001.raw /dev/host-vg/serverroot
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      ...
      <source dev='/dev/host-vg/serverroot'/>
      <target dev='vda' bus='virtio'/>
      <address ...           <- zeile löschen
   ...
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk002.raw | grep virtual\ size
   virtual size: 370G (397284474880 bytes)
   # lvcreate -L 397284474880b -n serverdata host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-*disk002.raw /dev/host-vg/serverdata
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      ...
      <source dev='/dev/host-vg/serverdata'/>
      <target dev='vdb' bus='virtio'/>      
      <address ...           <- zeile löschen
   ...

Die ursprünglichen Abbilder in ``/var/lib/libvirt/images`` können
gelöscht werden. Eventuell kann man damit warten, ob man die Abbilder
als Recoveryabbilder behält, bis ein Backupsystem eingerichtet ist.

.. code-block:: console

   # rm /var/lib/libvirt/images/lmn7-server-*.raw

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


Start und Konsolenlogin
~~~~~~~~~~~~~~~~~~~~~~~

Starte den Server.

.. code-block:: console

   # virsh start lmn7-server
   Domain lmn7-server started

In der bereitgestellten lmn7-server-Appliance ist der Server ebenfalls
vom KVM-Host aus über die serielle Schnittstelle erreichbar.

.. code-block:: console
		
   # virsh console lmn7-server
   Connected to domain lmn7-server
   Escape character is ^]
   
   Ubuntu 18.04.2 LTS server ttyS0
   
   server login: root
   Password: 
   Welcome to Ubuntu 18.04.2 LTS (GNU/Linux 4.15.0-46-generic x86_64)
   ...

Mit der Tastenkombination ``STRG-5`` verlässt man die serielle Konsole.

Optional: Umstellung des Netzbereichs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Wer einen anderen Netzbereich als ``10.0.0.0/16`` im internen Netzwerk
haben möchte, muss auch hier die IP-Adresse des Servers
ändern. Beispielhaft wird die Änderung in den beliebten bisherigen
Netzbereich ``10.16.0.0/12`` vollzogen.

Ersetze die Adresse ``10.0.0.1/16`` in der netplan-Konfiguration durch
``10.16.1.1/16``, das Gateway und die Nameserver-IP-Adresse durch die
entsprechende IP-Adresse der Firewall. Starte danach die
Netzwerkkonfiguration neu.
  
.. code-block:: console
  		
   # nano /etc/netplan/01-netcfg.yaml

Der entsprechende Teilblock sieht dann so aus:

.. code-block:: yaml

   ethernets:
     eth0:
       dhcp4: no
       dhcp6: no
       addresses: [10.16.1.1/12]
       gateway4: 10.16.1.254
       nameservers:
         addresses: [10.16.1.254]

.. code-block:: console
  		
   # netplan try

Test der Netzwerkverbindung zum Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Teste, ob du vom Admin-PC (oder als solcher konfigurierten KVM-Host)
oder von der Firewall per ssh auf den Server mit dem Standardpasswort
`Muster!` kommst.

.. code-block:: console
		
   # ssh 10.0.0.1 -l root
   root@10.0.0.1's password: 
   Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-38-generic x86_64)
   ...

Eventuell hilft ein Neustart der virtuellen Maschine, wenn man mehrere
Änderungen an der Netzwerkkonfiguration vorgenommen hat.

Teste, ob du vom Server aus zur Firewall kommst:

.. code-block:: console

   server~$ ping 10.0.0.254

Docker und OPSI
===============

Die Installationen der bereitgestellten Docker- und OPSI-Appliances
funktionieren nach dem gleichen Verfahren wie bei der Server-Appliance
nur einfacher, da hier nur eine Festplatte (ohne zusätzliches LVM) zu
importieren ist. Beide gehören mit ihren IP-Adressen in das Netz
``br-server`` und das darunter liegende Ubuntu lässt sich wie beim
Server auf den gewünschten Netzbereich einstellen.

   
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

Wer seinem KVM-Host die IP-Adresse `10.0.0.10` des Admin-PCs gegeben
hat, sollte dies rückgängig machen. Der KVM-Host sollte nicht im
pädagogischen Netzwerk auftauchen.

Wer seinen KVM-Host nicht (mehr) im Internet stehen haben will, der
muss auch hier die Adresskonfiguration auf dem KVM-Host unter dem
Abschnitt ``br-red`` rückgängig machen.
   

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

Es empfiehl sich nun, die Möglichkeiten des Backups und der schnellen
Wiederherstellung der virtuellen Maschinen, wenn man die Wiederholung
obiger Konfigurationen bei einem Neuanfang vermeiden will.

Snapshot und Backup der KVM-Maschinen
=====================================

Backup der Festplatten-Abbilder mittels LVM2
--------------------------------------------

Mit Hilfe von LVM2 kann man sehr schnell Snapshots der aktuellen
Festplattenabbilder erstellen. Diese Snapshots kann man dann für ein
Backup der Daten zu diesem Zeitpunkt verwenden. Alternativ kann man
ein später unbrauchbares Laufwerk schnell wieder auf den Stand
des Snapshots bringen.

Einstellung von LVM2
~~~~~~~~~~~~~~~~~~~~

Um Schaden am System im internen LVM des Servers ``vg_srv`` zu
verhindern, sollte man das logical volume ``/dev/host-vg/serverdata``
und sein Snapshot ``/dev/host-vg/serverdata-backup`` aus dem Scan nach
internen LVMs herausfiltern. Das geschieht in der Datei
``/etc/lvm/lvm.conf`` und man sucht und ersetzt die Variable
``global_filter``

.. code-block:: console

   ...
   # This configuration option has an automatic default value.                                                                                                     
   # global_filter = [ "a|.*/|" ]                                                                                                                                  
   global_filter = [ "r|^/dev/host-vg/serverdata.*$|" ]
   ...

Um zu testen, dass der Filter in ``/etc/lvm/lvm.conf`` erfolgreich das
interne LVM ``vg_srv`` ausblendet, ruft man ``lvs`` auf. In der Liste
der LV sollte dann kein ``vg_srv`` auftauchen.

Snapshot erstellen
~~~~~~~~~~~~~~~~~~

Einen Snapshot kann man im laufenden Betrieb erstellen, wenn das
Dateisystem der VM dies unterstützt. Das LVM sagt dem Dateisystem,
sich in einen konsistenten Zustand zu bringen. Sicherheitshalber kann
man aber für die Erstellung auch die VM herunterfahren.

Ein Snapshot erstellt ein neues logical volume (LV) zum Zeitpunkt der
Erstellung. Zunächst ist der Snapshot identisch mit dem laufenden und
verbraucht keinen Speicherplatz. Sobald am laufenden LV Änderungen
passieren, wird der alte Inhalt im dem Snapshot gespeichert. Man muss
bei der initialen Erstellung eine Größe für den Snapshot wählen.
Natürlich kann die Summe aller geänderten Daten die Größe des
Snapshots erreichen, dann funktioniert das Prinzip nicht mehr. Für die
folgenden Zwecke werden etwa 5% des originalen volumes als Größe
gewählt, da in einem überschaubaren Zeitraum der Snapshot wieder
entfernt wird.

.. code-block:: console

   # lvcreate -s /dev/host-vg/opnsense -L 2G -n opnsense-backup
   Using default stripesize 64,00 KiB.
   Logical volume "opnsense-backup" created.
   # lvcreate -s /dev/host-vg/serverroot -L 5G -n serverroot-backup
   Using default stripesize 64,00 KiB.
   Logical volume "serverroot-backup" created.
   # lvcreate -s /dev/host-vg/serverdata -L 20G -n serverdata-backup
   Using default stripesize 64,00 KiB.
   Logical volume "serverdata-backup" created.
   # lvs
   LV                VG      Attr        LSize   Pool Origin   Data%  Meta%  Move Log Cpy%Sync Convert
   opnsense          host-vg owi-aos---   10,00g                                                      
   opnsense-backup   host-vg swi-a-s---    2,00g      opnsense 0,05                                   
   serverdata        host-vg owi-aos---  370,00g                                                        
   serverdata-backup host-vg swi-a-s---   20,00g      serverdata 0,01                                   
   serverroot        host-vg owi-aos---   25,00g                                                        
   serverroot-backup host-vg swi-a-s---    5,00g      serverroot 0,00                                   

In der Tabelle sieht man bei den Attributen, welches das Original und
welches der Snapshot ist (Spalte 1). In Spalte 6 steht, ob ein LV
geöffnet, d.h. z.B. gemountet ist ("o") oder nicht.

Snapshot zurückführen
~~~~~~~~~~~~~~~~~~~~~

Will man das Abbild in den Zustand vor dem Snapshot zurückführen, muss
man den Client stoppen und dann den Snapshot "mergen". Dies geht
relativ schnell.

.. code-block:: console

   # virsh shutdown lvm7-opnsense
   # lvconvert --mergesnapshot /dev/host-vg/opnsense-backup 
   Merging of volume host-vg/opnsense-backup started.
   host-vg/opnsense: Merged: 100,00%

Für den Server, der zwei Abbilder hat, müssen natürlich alle Abbilder
zurückgeführt werden, damit ein konsistenter Zustand hergestellt wird.

.. code-block:: console

   # virsh shutdown lvm7-server
   # lvconvert --mergesnapshot /dev/host-vg/serverroot-backup 
   Merging of volume host-vg/serverroot-backup started.
   host-vg/serverroot: Merged: 100,00%

Falls beim logischen Laufwerk ``serverdata`` das interne LVM sichtbar
wurde (``lvs`` zeigt sie an), weil z.B. der Filter nicht funktioniert,
dann müssen zunächst die internen logischen Laufwerke geschlossen
werden, sonst kann der Snapshot nicht zusammengeführt werden.

.. code-block:: console

   # lvchange -a n /dev/vg_srv/*  --- nur für den Fall, dass der Filter nicht funktioniert hat
   # vgchange -a n vg_srv         --- nur für den Fall, dass der Filter nicht funktioniert hat
   # lvconvert --mergesnapshot /dev/host-vg/serverdata-backup 
   Merging of volume host-vg/serverdata-backup started.
   host-vg/serverdata: Merged: 100,00%

Snapshot als Basis für ein Datei-Backup verwenden
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Will man den Snapshot für die Erstellung eines dateibasierten Backups
verwenden, z.B. mit `rsync` oder `rsnapshot`, muss man das logical
volume (LV) für das Hostsystem aufschließen, die Dateien kopieren und
wieder zuschließen. Danach kann man den Snapshot entfernen.

Am Beispiel der OPNsense wird auf ein NAS oder ein Verzeichnis
gesynced, deren Zielverzeichnis zuvor existieren müssen.

.. code-block:: console

   # kpartx -av /dev/host-vg/opnsense-backup
   # mount /dev/mapper/host--vg-opnsense--backup1 /mnt
   # rsync -aP /mnt/ user@NAS:/targetdir-opnsense/
   oder
   # rsync -aP /mnt/ /srv/backup/opnsense/
   ...
   # umount /mnt
   # kpartx -dv /dev/host-vg/opnsense-backup
   # lvremove /dev/host-vg/opnsense-backup

Die Root-Platte der Server-VM kann wie im Fall der OPNsense entpackt
und kopiert werden, wobei nur die zweite Partition die Daten enthält,
die erste ist eine BIOS-Partition.

.. code-block:: console
		
   # kpartx -av /dev/host-vg/serverroot-backup 
   add map host--vg-serverroot--backup1 (253:10): 0 2048 linear 253:5 2048
   add map host--vg-serverroot--backup2 (253:12): 0 52422656 linear 253:5 4096
   # mount /dev/mapper/host--vg-serverroot--backup2 /mnt
   ... --- backup der Root-Partition
   # umount /mnt
   # kpartx -dv /dev/host-vg/serverroot-backup
   del devmap : host--vg-serverroot--backup2
   del devmap : host--vg-serverroot--backup1
   # lvremove -y /dev/host-vg/serverroot-backup

Die Daten-Platte der Server-VM ist ungleich komplexer, weil ein
weiteres LVM in der Platte ``/dev/host-vg/serverdata`` steckt, das
freigelegt werden muss. Dafür nimmt man den oben eingerichteten Filter
heraus und LVM findet automatisch die genestete VG ``vg_srv``.  Ein
Snapshot ist nicht möglich, weil die VG keinen freien Speicher für
einen Snapshot zur Verfügung hat. Es ist also notwendig, die Server-VM
zu stoppen. Dann aktiviert man die VG und kann dann direkt die LVs
mounten. Nach dem Backup und umounten, deaktiviert man die VG, kann
die Server-VM wieder starten und versteckt die VG wieder über die
Filter.

Alternativ entscheidet man sich für ein deutlich einfacheres
komplettes Backup der Platten der Server-VM.


Backup kompletter Abbilder
--------------------------

Komplette Kopien für ein Backup der Festplattenabbilder kann man mit
`qemu-img` vornehmen. Am Beispiel der OPNsense, wird zuerst die VM
heruntergefahren, das Abbild (in ein komprimiertes Abbild in ein
Backup-Verzeichnis) kopiert und dann wieder hochgefahren.

.. code-block:: console

   # virsh shutdown lmn7-opnsense
   # export BDATE=$(date +%Y_%m_%d_%H_%M)
   # qemu-img convert -O qcow2 /dev/host-vg/opnsense /srv/backup/opnsense_${BDATE}.qcow2   
   # ln -sf /srv/backup/opnsense_${BDATE}.qcow2 /srv/backup/opnsense_latest.qcow2
   # virsh start lmn7-opnsense

Am Beispiel des Servers

.. code-block:: console

   # virsh shutdown lmn7-server
   # export BDATE=$(date +%Y_%m_%d_%H_%M)
   # qemu-img convert -O qcow2 /dev/host-vg/serverroot /srv/backup/server_disk1_${BDATE}.qcow2
   # qemu-img convert -O qcow2 /dev/host-vg/serverdata /srv/backup/server_disk2_${BDATE}.qcow2
   # ln -sf /srv/backup/server_disk1_latest.qcow2 /srv/backup/server_disk1_${BDATE}.qcow2
   # ln -sf /srv/backup/server_disk2_latest.qcow2 /srv/backup/server_disk2_${BDATE}.qcow2   
   # virsh start lmn7-server

Im Prinzip könnte auch eine komplette Kopie eines Snapshot-LVs gemacht
werden. Andererseits möchte man so ein vollständiges Backup der VM
besser in einem heruntergefahrenen Zustand machen. Um die Downtime zu
minimieren, kann man ein Snapshot erstellen, die VM wieder hochfahren,
die Snapshot-LVs mit `qemu-img` konvertieren und dann die Snapshots
wieder löschen, beispielhaft an der OPNsense:

.. code-block:: console

   # virsh shutdown lmn7-opnsense
   # lvcreate -s /dev/host-vg/opnsense -L 2G -n opnsense-backup
   # virsh start lmn7-opnsense
   # export BDATE=$(date +%Y_%m_%d_%H_%M)
   # qemu-img convert -O qcow2 /dev/host-vg/opnsense-backup /srv/backup/opnsense_${BDATE}.qcow2
   # ln -sf /srv/backup/opnsense_${BDATE}.qcow2 /srv/backup/opnsense_latest.qcow2
   # lvremove /dev/host-vg/opnsense-backup

Recovery kompletter Abbilder
----------------------------

Die Wiederherstellung kompletter Abbilder verläuft analog zum Import
der Appliances. Der Befehl `qemu-img` muss als Ziel das logical
volume (LV) haben, welches vorher existieren muss. Je nachdem, wie der
Zustand des KVM-Hosts vor der Wiederherstellung ist, muss man

- wenn der KVM-Host unverändert ist nur das Backup in die bestehenden
  LVs zurückspielen.

- nach einer Neuinstallation des KVM-Hosts die Volume Group und die
  LVs erstellen, die Metadaten für die VM rekonstruieren, dann das
  Backup zurückspielen

Das reine Zurückspielen des letzten Backups in ein unverändertes
System geht am Beispiel der OPNsense so:

.. code-block:: console

   # virsh shutdown lmn7-opnsense
   # qemu-img convert -O raw  /srv/backup/opnsense_latest.qcow2 /dev/host-vg/opnsense
   # virsh start lmn7-opnsense

Entsprechend funktioniert das Zurückspielen für den Server oder andere VMs.

Die Rekonstruktion der Meta-Daten sollte es genügen, das Verzeichnis
``/etc/libvirtd/`` auf dem KVM-Host wiederherzustellen, wurde für
diese Dokumentation noch nicht getestet. Darüberhinaus ist die
Erstellung der volume group und die Erstellung der LVs notwendig.

============================ =================
Weiter geht es mit dem Setup |follow_me2setup|
============================ =================

..
   ================================================ ===========================================
   Weiter geht es mit der Anpassung der Festplatten |follow_me2linux-adjusting_hard_drive_size|
   ================================================ ===========================================

