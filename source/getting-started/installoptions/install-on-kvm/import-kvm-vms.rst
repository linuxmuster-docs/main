.. include:: /guided-inst.subst

.. _import-kvm-vms-label:

====================================
Importieren der Virtuellen Maschinen
====================================

.. sectionauthor:: `@morbweb <https://ask.linuxmuster.net/u/morpweb>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,
		   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

Nachdem du den Host für die virtuellen Maschinen fertiggestellt hast, müssen diese nun importiert werden.

VM Templates herunterladen
==========================

Fertige VM-Snapshots für KVM stellt linuxmuster.net auf dem eigenen Download-Server bereit. https://download.linuxmuster.net/ova/v7/latest/
 
Um die Maschinen importieren zu können, müssen diese zuerst auf den Hypervisor geladen werden. Die VMs können direkt an der Shell des KVM-Host mit dem wget-Befehl direkt heruntergeladen werden. 

Für eine linuxmuster.net v7 Umgebung werden die Server-VM und als Firewall die OPNsense®-VM benötigt. Optional sind zusätzlich eine OPSI-VM und eine Docker-VM für deine linuxmuster.net-Umgebung verfügbar. 

Für die VMs wären folgende Befehle in der Shell einzugeben.

================== =====================================================================================
VM                 Download-Befehl
================== =====================================================================================
opnsense-VM        wget -A \*opnsense\* -m https://download.linuxmuster.net/ova/v7/latest 
server-VM          wget -A \*server\* -m https://download.linuxmuster.net/ova/v7/latest 
opsi-VM            wget -A \*opsi\* -m https://download.linuxmuster.net/ova/v7/latest 
docker-VM          wget -A \*docker\* -m https://download.linuxmuster.net/ova/v7/latest 
================== =====================================================================================

Für die beiden erforderlichen virtuellen Maschinen Server und OPNSense lassen sich die erforderlichen Dateien wie folgt auf einmal herunterladen.

.. code::
 
    wget -A *opnsense*,*server* -m https://download.linuxmuster.net/ova/v7/latest

.. hint:: 

   Solltest du zusätzlich die optionalen VMs herunterladen wollen, musst du die kommaseparierte Liste ``-A \*opnsense\*,\*server\*`` um die Namen der VMs ergänzen:

   * \*opsi\*
   * \*docker\*
    
Nach dem Herunterladen der Dateien sollten sich diese mittels ``ls -lh`` in der Shell anzeigen lassen. Wechsel dazu erst in das Download-Verzeichnis

.. code::

   cd ~/download.linuxmuster.net/ova/v7/latest/

und lasse dir dessen Inhalt anzeigen.

.. code::

   ls -lh

.. code::

   total 5.1G
   -rw-rw-r-- 1 administrator administrator 2.1G Apr 15  2020 lmn7-opnsense-20200421.ova
   -rw-rw-r-- 1 administrator administrator   93 Apr 21  2020 lmn7-opnsense-20200421.ova.sha256
   -rw-rw-r-- 1 administrator administrator 3.0G Apr 21  2020 lmn7-server-20200421.ova
   -rw-rw-r-- 1 administrator administrator   91 Apr 21  2020 lmn7-server-20200421.ova.sha256

.. hint::

   * Alle Dateien tragen in ihrem Namen einen Zeitstempel. In der weiteren Anleitung wird dieser ``20200421`` durch ein ``*`` ersetzt. Solange du nur je ein (das aktuelle) OVA-Abbild vorliegen hast, funktionieren die Befehle auch mit dem ``*``. Ansonsten musst du den richtigen Zeitstempel einfügen.
   *  Wie du siehst hast du mit dem obigen Befehl auch die Checksummen der Dateien heruntergeladen. 

Es folgt die Überprüfung ob die heruntergeladenen Dateien in Ordnung sind. Dafür nutzt den folgeden Befehl: 
   
.. code:: 

   shasum -c *.sha256

.. code::

   lmn7-opnsense-20200421.ova: OK
   lmn7-server-20200421.ova: OK

Erhälst du nicht für jede Datei ein OK, dann musst du den Download für die fehlerhafte wiederholen.


.. todo::  Hier gilt es weiter zu machen. Der nächste Absatz war auskommentiert. Ob der weg kann ist zu klären.
   
   KVM-Anpassungen

   Nach der Integration bietet es sich an, die Hardware der importierten Appliances anzupassen und z.B. die Festplattentypen auf "virtio" zu stellen. Ebenso habe ich den Typ der "Grafikkarte" von `spice` auf `vnc` gesetzt.


Import der Firewall
===================

Importiere die Firewall-Appliance `lmn7-opnsense`, fahre sie gleich herunter und benenne sie um

.. code::

   # virt-convert lmn7-opnsense-*.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-opnsense-20190724-disk001.vmdk /var/lib/libvirt/images/lmn7-opnsense-20190724-disk001.raw
   Creating guest 'lmn7-opnsense-20190724.ovf'.
   # virsh shutdown lmn7-opnsense-20190724.ovf
   Domain ... is being shutdwon
   # virsh domrename lmn7-opnsense-20190724.ovf lmn7-opnsense

Import des Servers
==================

Importiere die Server-Appliance `lmn7-server`.

.. code::

   # virt-convert lmn7-server-*.ova
   ...
   Running /usr/bin/qemu-img convert -O raw lmn7-server-xxxxxxxx-disk001.vmdk /var/lib/libvirt/images/lmn7-server-xxxxxxxx-disk001.raw
   Running /usr/bin/qemu-img convert -O raw lmn7-server-xxxxxxxx-disk002.vmdk /var/lib/libvirt/images/lmn7-server-xxxxxxxx-disk002.raw   
   Creating guest 'lmn7-server-20190724.ovf'.
   # virsh shutdown lmn7-server-20190724.ovf
   # virsh domrename lmn7-server-20190724.ovf lmn7-server

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

.. todo:: Müsste in den Abschnitt Netzwerk-Anpassung

Netzwerkanpassung der Firewall
==============================
   
Die Netzwerkkarten der Appliance werden in der Reihenfolge importiert, wie sie in der Appliance definiert wurden:

1. `LAN, 10.0.0.254/16`, d.h. diese Schnittstelle wird auf der pädagogischen Seite des Netzwerks angeschlossen 

2. `WAN, DHCP`, d.h. diese Schnittstelle wird auf der Internetseite angeschlossen und ist als DHCP-Client konfiguriert.

3. `OPT1, unkonfiguriert`, d.h. diese Schnittstelle wird für optionale Netzwerke verwendet und muss zunächst nicht angeschlossen werden.

Öffne die KVM-Konfiguration und editiere die erste Schnittstelle, so dass diese sich im Schulnetzwerk befindet, hier im Beispiel wird sie an die virtuelle Brücke ``br-server`` mit dem Stichwort `bridge` und dem Typ `bridge` angeschlossen. Die MAC-Adresse sollte bei dieser Gelegenheit auch (beliebig) geändert werden.

.. code::

   # virsh edit lmn7-opnsense
   ...
   <interface type='bridge'>
      <mac address='52:54:00:20:ea:70'/>
      <source bridge='br-server'/>
   ...

Die zweite Schnittstelle sollte genauso dem Typ `bridge` zugeordnet werden, allerdings an die Brücke ``br-red`` angeschlossen werden.

.. code::

   # virsh edit lmn7-opnsense
   ...
   <interface type='bridge'>
      <mac address='52:54:00:d2:0c:62'/>
      <source bridge='br-red'/>
   ...

Die dritte Schnittstelle kann zunächst gelöscht werden. Wenn später ein weiteres Netzwerk eingerichtet wird, z.B. ``br-dmz`` für eine so genannte demilitarisierte Zone, in der sich Webserver u.ä. befinden. Kann der Abschnitt wieder hinzugefügt werden und taucht in der OPNsense als ``OPT1`` wieder auf.

Start und Konsolenlogin
-----------------------

Starte die Firewall. 

.. code::

   # virsh start lmn7-opnsense
   Domain lmn7-opnsense started

Auf Konsolenebene kannst du dich per ssh (siehe oben) oder über die serielle Konsole einwählen. Ein zusätzliches `Enter` hilft, um das ``login:`` zu sehen.

.. code::

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

Man erkennt, dass die Firewall die Netzwerkkarten für innen (LAN) und außen (WAN, hier über DHCP) richtig zugeordnet hat.
   
Mit der Tastenkombination ``STRG-5`` verlässt man die serielle Konsole.


Optional: Externe Netzwerkanbindung der Firewall einrichten
-----------------------------------------------------------

Wer eine statische IP-Adresse in der Firewall braucht, der muss diese konfigurieren. Konfiguriere die WAN-Schnittstelle über ``2)`` im Hauptmenü der OPNsense und folge den Anweisungen dort, eine feste IP-Adresse einzugeben. Die relevanten Zeilen sind beispielhaft:

.. code::

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
-------------------------------------

Wer einen anderen Netzbereich als ``10.0.0.0/16`` im internen Netzwerk haben möchte, muss auch hier die IP-Adresse der Firewall ändern. Beispielhaft wird die Änderung in den beliebten bisherigen Netzbereich ``10.16.0.0/12`` vollzogen.

Die relevanten Zeilen sind:

.. code::

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
----------------------------------------

Um die Verbindung zur Firewall im Netzwerk ``br-server`` zu testen, muss ein zweiter Rechner in diesem Netzwerk konfiguriert werden. Du kannst wie unten beschrieben den optionalen Admin-PC anschließen und mit der IP ``10.0.0.10``, Netzmaske ``16`` bzw. ``255.255.0.0`` und Gateway ``10.0.0.254`` konfigurieren.

Alternativ kann zeitweilig der KVM-Host selbst als Admin-PC konfiguriert. Dafür wird wieder die netplan-Datei editiert 

.. code::

   # nano /etc/netplan/01-netcfg.yaml

Der entsprechende Block lautet dann:
   
.. code::

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

Jetzt solltest du die Firewall vom Admin-PC (oder vom KVM-Host) aus anpingen können.
	   
.. code:: 

   $ ping 10.0.0.254
   PING 10.0.0.254 (10.0.0.254) 56(84) bytes of data.
   64 bytes from 10.0.0.254: icmp_seq=1 ttl=64 time=0.183 ms
   64 bytes from 10.0.0.254: icmp_seq=2 ttl=64 time=0.242 ms
   ...
   STRG-C

Ebenso ist dann ein Einloggen mit dem voreingestellten Passwort
`Muster!` möglich:
   
.. code::
		
   $ ssh 10.0.0.254 -l root
   Password for root@OPNsense.localdomain:
   ...
   LAN (em0)       -> v4: 10.0.0.254/16
   WAN (em1)       -> v4: 141.1.2.4/29
   ...

Ausloggen mit ``exit`` oder ``STRG-D``.
		
.. todo:: Müsste in den Bereich Netzwerk-Anpassung

Netzwerkanpassung des Servers
-----------------------------
   
Es muss nur eine Netzwerkschnittstelle angepasst werden und in die Brücke ``br-server`` gestöpselt werden.

.. code::

   # virsh edit lmn7-server
   ...
   <interface type='bridge'>
      <mac address='52:54:00:9f:b8:af'/>
      <source bridge='br-server'/>
   ...



Start und Konsolenlogin
^^^^^^^^^^^^^^^^^^^^^^^

Starte den Server.

.. code::

   # virsh start lmn7-server
   Domain lmn7-server started

In der bereitgestellten lmn7-server-Appliance ist der Server ebenfalls vom KVM-Host aus über die serielle Schnittstelle erreichbar.

.. code::
		
   # virsh console lmn7-server
   Connected to domain lmn7-server
   Escape character is ^]
   
   Ubuntu 18.04.2 LTS server ttyS0
   
   server login: root
   Password: 
   Welcome to Ubuntu 18.04.2 LTS (GNU/Linux 4.15.0-46-generic x86_64)
   ...

Mit der Tastenkombination ``STRG-5`` verlässt man die serielle Konsole.

.. todo:: Müsste in den Bereich ?

Optional: Umstellung des Netzbereichs
=====================================

Wer einen anderen Netzbereich als ``10.0.0.0/16`` im internen Netzwerk haben möchte, muss auch hier die IP-Adresse des Servers ändern. Beispielhaft wird die Änderung in den beliebten bisherigen Netzbereich ``10.16.0.0/12`` vollzogen.

Ersetze die Adresse ``10.0.0.1/16`` in der netplan-Konfiguration durch ``10.16.1.1/16``, das Gateway und die Nameserver-IP-Adresse durch die entsprechende IP-Adresse der Firewall. Starte danach die Netzwerkkonfiguration neu.
  
.. code::
  		
   # nano /etc/netplan/01-netcfg.yaml

Der entsprechende Teilblock sieht dann so aus:

.. code:: yaml

   ethernets:
     eth0:
       dhcp4: no
       dhcp6: no
       addresses: [10.16.1.1/12]
       gateway4: 10.16.1.254
       nameservers:
         addresses: [10.16.1.254]

.. code::
  		
   # netplan try

.. todo:: Müsste in den Bereich Netzwerktests

Test der Netzwerkverbindung zum Server
======================================

Teste, ob du vom Admin-PC (oder als solcher konfigurierten KVM-Host) oder von der Firewall per ssh auf den Server mit dem Standardpasswort `Muster!` kommst.

.. code::
		
   # ssh 10.0.0.1 -l root
   root@10.0.0.1's password: 
   Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-38-generic x86_64)
   ...

Eventuell hilft ein Neustart der virtuellen Maschine, wenn man mehrere Änderungen an der Netzwerkkonfiguration vorgenommen hat.

Teste, ob du vom Server aus zur Firewall kommst:

.. code::

   server~$ ping 10.0.0.254

.. todo:: Bleibt hier

Docker und OPSI
===============

Die Installationen der bereitgestellten Docker- und OPSI-Appliances funktionieren nach dem gleichen Verfahren wie bei der Server-Appliance nur einfacher, da hier nur eine Festplatte (ohne zusätzliches LVM) zu importieren ist. Beide gehören mit ihren IP-Adressen in das Netz ``br-server`` und das darunter liegende Ubuntu lässt sich wie beim Server auf den gewünschten Netzbereich einstellen.

   
Abschließende Konfigurationen
=============================

Aufräumen
---------

Das Paket `virtinst` sowie dessen Abhängigkeiten können deinstalliert werden, so bleibt das Host-System mit weniger Paketen und weniger Abhängigkeiten sauberer.

.. code::

   # apt remove virtinst
   # apt autoremove

Wer seinem KVM-Host die IP-Adresse `10.0.0.10` des Admin-PCs gegeben hat, sollte dies rückgängig machen. Der KVM-Host sollte nicht im pädagogischen Netzwerk auftauchen.

Wer seinen KVM-Host nicht (mehr) im Internet stehen haben will, der muss auch hier die Adresskonfiguration auf dem KVM-Host unter dem Abschnitt ``br-red`` rückgängig machen.
   

Aktivieren des Autostarts der VMs
---------------------------------

Damit die VMs zukünftig bei einem Neustart des KVM-Servers nicht immer von Hand gestartet werden müssen, ist es sinnvoll den Autostart zu aktivieren.

.. code::

   # virsh autostart lmn7-opnsense
   Domain lmn7-opnsense marked as autostarted
   # virsh autostart lmn7-server
   Domain lmn7-server marked as autostarted

Es empfiehl sich nun, die Möglichkeiten des Backups und der schnellen Wiederherstellung der virtuellen Maschinen, wenn man die Wiederholung obiger Konfigurationen bei einem Neuanfang vermeiden will.

.. todo:: Sollte in ein neues Systemadministration Unterkapitel Backup

Snapshot und Backup der KVM-Maschinen
=====================================

Backup der Festplatten-Abbilder mittels LVM2
--------------------------------------------

Mit Hilfe von LVM2 kann man sehr schnell Snapshots der aktuellen Festplattenabbilder erstellen. Diese Snapshots kann man dann für ein Backup der Daten zu diesem Zeitpunkt verwenden. Alternativ kann man ein später unbrauchbares Laufwerk schnell wieder auf den Stand
des Snapshots bringen.

Einstellung von LVM2
^^^^^^^^^^^^^^^^^^^^

Um Schaden am System im internen LVM des Servers ``vg_srv`` zu verhindern, sollte man das logical volume ``/dev/host-vg/serverdata`` und sein Snapshot ``/dev/host-vg/serverdata-backup`` aus dem Scan nach internen LVMs herausfiltern. Das geschieht in der Datei ``/etc/lvm/lvm.conf`` und man sucht und ersetzt die Variable ``global_filter``

.. code::

   ...
   # This configuration option has an automatic default value.                                                                                                     
   # global_filter = [ "a|.*/|" ]                                                                                                                                  
   global_filter = [ "r|^/dev/host-vg/serverdata.*$|" ]
   ...

Um zu testen, dass der Filter in ``/etc/lvm/lvm.conf`` erfolgreich das interne LVM ``vg_srv`` ausblendet, ruft man ``lvs`` auf. In der Liste der LV sollte dann kein ``vg_srv`` auftauchen.

Snapshot erstellen
^^^^^^^^^^^^^^^^^^

Einen Snapshot kann man im laufenden Betrieb erstellen, wenn das Dateisystem der VM dies unterstützt. Das LVM sagt dem Dateisystem, sich in einen konsistenten Zustand zu bringen. Sicherheitshalber kann man aber für die Erstellung auch die VM herunterfahren.

Ein Snapshot erstellt ein neues logical volume (LV) zum Zeitpunkt der Erstellung. Zunächst ist der Snapshot identisch mit dem laufenden und verbraucht keinen Speicherplatz. Sobald am laufenden LV Änderungen passieren, wird der alte Inhalt im dem Snapshot gespeichert. Man muss bei der initialen Erstellung eine Größe für den Snapshot wählen. Natürlich kann die Summe aller geänderten Daten die Größe des Snapshots erreichen, dann funktioniert das Prinzip nicht mehr. Für die folgenden Zwecke werden etwa 5% des originalen volumes als Größe gewählt, da in einem überschaubaren Zeitraum der Snapshot wieder entfernt wird.

.. code::

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

In der Tabelle sieht man bei den Attributen, welches das Original und welches der Snapshot ist (Spalte 1). In Spalte 6 steht, ob ein LV geöffnet, d.h. z.B. gemountet ist ("o") oder nicht.

Snapshot zurückführen
^^^^^^^^^^^^^^^^^^^^^

Will man das Abbild in den Zustand vor dem Snapshot zurückführen, muss man den Client stoppen und dann den Snapshot "mergen". Dies geht relativ schnell.

.. code::

   # virsh shutdown lvm7-opnsense
   # lvconvert --mergesnapshot /dev/host-vg/opnsense-backup 
   Merging of volume host-vg/opnsense-backup started.
   host-vg/opnsense: Merged: 100,00%

Für den Server, der zwei Abbilder hat, müssen natürlich alle Abbilder zurückgeführt werden, damit ein konsistenter Zustand hergestellt wird.

.. code::

   # virsh shutdown lvm7-server
   # lvconvert --mergesnapshot /dev/host-vg/serverroot-backup 
   Merging of volume host-vg/serverroot-backup started.
   host-vg/serverroot: Merged: 100,00%

Falls beim logischen Laufwerk ``serverdata`` das interne LVM sichtbar wurde (``lvs`` zeigt sie an), weil z.B. der Filter nicht funktioniert, dann müssen zunächst die internen logischen Laufwerke geschlossen werden, sonst kann der Snapshot nicht zusammengeführt werden.

.. code::

   # lvchange -a n /dev/vg_srv/*  --- nur für den Fall, dass der Filter nicht funktioniert hat
   # vgchange -a n vg_srv         --- nur für den Fall, dass der Filter nicht funktioniert hat
   # lvconvert --mergesnapshot /dev/host-vg/serverdata-backup 
   Merging of volume host-vg/serverdata-backup started.
   host-vg/serverdata: Merged: 100,00%

Snapshot als Basis für ein Datei-Backup verwenden
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Will man den Snapshot für die Erstellung eines dateibasierten Backups verwenden, z.B. mit `rsync` oder `rsnapshot`, muss man das logical volume (LV) für das Hostsystem aufschließen, die Dateien kopieren und wieder zuschließen. Danach kann man den Snapshot entfernen. 

Am Beispiel der OPNsense wird auf ein NAS oder ein Verzeichnis gesynced, deren Zielverzeichnis zuvor existieren müssen.

.. code::

   # kpartx -av /dev/host-vg/opnsense-backup
   # mount /dev/mapper/host--vg-opnsense--backup1 /mnt
   # rsync -aP /mnt/ user@NAS:/targetdir-opnsense/
   oder
   # rsync -aP /mnt/ /srv/backup/opnsense/
   ...
   # umount /mnt
   # kpartx -dv /dev/host-vg/opnsense-backup
   # lvremove /dev/host-vg/opnsense-backup

Die Root-Platte der Server-VM kann wie im Fall der OPNsense entpackt und kopiert werden, wobei nur die zweite Partition die Daten enthält, die erste ist eine BIOS-Partition.

.. code::
		
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

Die Daten-Platte der Server-VM ist ungleich komplexer, weil ein weiteres LVM in der Platte ``/dev/host-vg/serverdata`` steckt, das freigelegt werden muss. Dafür nimmt man den oben eingerichteten Filter heraus und LVM findet automatisch die genestete VG ``vg_srv``.  Ein Snapshot ist nicht möglich, weil die VG keinen freien Speicher für einen Snapshot zur Verfügung hat. Es ist also notwendig, die Server-VM zu stoppen. Dann aktiviert man die VG und kann dann direkt die LVs mounten. Nach dem Backup und umounten, deaktiviert man die VG, kann die Server-VM wieder starten und versteckt die VG wieder über die Filter.

Alternativ entscheidet man sich für ein deutlich einfacheres komplettes Backup der Platten der Server-VM.


Backup kompletter Abbilder
--------------------------

Komplette Kopien für ein Backup der Festplattenabbilder kann man mit `qemu-img` vornehmen. Am Beispiel der OPNsense, wird zuerst die VM heruntergefahren, das Abbild (in ein komprimiertes Abbild in ein Backup-Verzeichnis) kopiert und dann wieder hochgefahren.

.. code::

   # virsh shutdown lmn7-opnsense
   # export BDATE=$(date +%Y_%m_%d_%H_%M)
   # qemu-img convert -O qcow2 /dev/host-vg/opnsense /srv/backup/opnsense_${BDATE}.qcow2   
   # ln -sf /srv/backup/opnsense_${BDATE}.qcow2 /srv/backup/opnsense_latest.qcow2
   # virsh start lmn7-opnsense

Am Beispiel des Servers

.. code::

   # virsh shutdown lmn7-server
   # export BDATE=$(date +%Y_%m_%d_%H_%M)
   # qemu-img convert -O qcow2 /dev/host-vg/serverroot /srv/backup/server_disk1_${BDATE}.qcow2
   # qemu-img convert -O qcow2 /dev/host-vg/serverdata /srv/backup/server_disk2_${BDATE}.qcow2
   # ln -sf /srv/backup/server_disk1_latest.qcow2 /srv/backup/server_disk1_${BDATE}.qcow2
   # ln -sf /srv/backup/server_disk2_latest.qcow2 /srv/backup/server_disk2_${BDATE}.qcow2   
   # virsh start lmn7-server

Im Prinzip könnte auch eine komplette Kopie eines Snapshot-LVs gemacht werden. Andererseits möchte man so ein vollständiges Backup der VM besser in einem heruntergefahrenen Zustand machen. Um die Downtime zu minimieren, kann man ein Snapshot erstellen, die VM wieder hochfahren, die Snapshot-LVs mit `qemu-img` konvertieren und dann die Snapshots wieder löschen, beispielhaft an der OPNsense:

.. code::

   # virsh shutdown lmn7-opnsense
   # lvcreate -s /dev/host-vg/opnsense -L 2G -n opnsense-backup
   # virsh start lmn7-opnsense
   # export BDATE=$(date +%Y_%m_%d_%H_%M)
   # qemu-img convert -O qcow2 /dev/host-vg/opnsense-backup /srv/backup/opnsense_${BDATE}.qcow2
   # ln -sf /srv/backup/opnsense_${BDATE}.qcow2 /srv/backup/opnsense_latest.qcow2
   # lvremove /dev/host-vg/opnsense-backup

Recovery kompletter Abbilder
----------------------------

Die Wiederherstellung kompletter Abbilder verläuft analog zum Import der Appliances. Der Befehl `qemu-img` muss als Ziel das logical volume (LV) haben, welches vorher existieren muss. Je nachdem, wie der Zustand des KVM-Hosts vor der Wiederherstellung ist, muss man 

  - wenn der KVM-Host unverändert ist nur das Backup in die bestehenden LVs zurückspielen.
  - nach einer Neuinstallation des KVM-Hosts die Volume Group und die LVs erstellen, die Metadaten für die VM rekonstruieren, dann das Backup zurückspielen

Das reine Zurückspielen des letzten Backups in ein unverändertes System geht am Beispiel der OPNsense so:

.. code::

   # virsh shutdown lmn7-opnsense
   # qemu-img convert -O raw  /srv/backup/opnsense_latest.qcow2 /dev/host-vg/opnsense
   # virsh start lmn7-opnsense

Entsprechend funktioniert das Zurückspielen für den Server oder andere VMs.

Die Rekonstruktion der Meta-Daten sollte es genügen, das Verzeichnis ``/etc/libvirtd/`` auf dem KVM-Host wiederherzustellen, wurde für diese Dokumentation noch nicht getestet. Darüberhinaus ist die Erstellung der volume group und die Erstellung der LVs notwendig.

+--------------------------------------------------------------------+-------------------------------------------+
| Weiter geht es mit dem Setup                                       | |follow_me2setup|                         |
+--------------------------------------------------------------------+-------------------------------------------+

.. +-------------------------------------------------------------------+---------------------------------------------+
   | Weiter geht es mit der Anpassung der Festplatten                  | |follow_me2linux-adjusting_hard_drive_size| |
   +-------------------------------------------------------------------+---------------------------------------------+
