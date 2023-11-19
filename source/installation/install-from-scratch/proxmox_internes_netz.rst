.. include:: ../../guided-inst.subst

.. _proxmox_internes_netz-label:

===================================
Proxmox in das interne Netz bringen
===================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_
                  

Nachdem Du die Firewall installierst, eine Erstkonfiguration erstellt und dann einen Snapshot der VM erstellt hast, musst Du jetzt den Proxmox-Host umkonfigurieren.
Ziel ist es, dass der Proxmox-Host nunmehr nur noch im internen Netzwerk (green) erreichbar ist. Der Host wird dann durch die OPNsense - Firewall geschützt. 
Die OPNsense ist zugleich das neue Gateway für den Proxmox-Host, um Zugriffe in das externe Netz zu ermöglichen.

Um dies umzusetzen, sind die Bridges umzukonfigurieren.

1. vmbr0 - red - externes Netzwerk   (IP im Beispiel 192.168.0.20/24)
2. vmbr1 - green - internes Netzwerk (IP im LAN: 10.0.0.20/16)

Rufe auf dem Proxmox-Host eine Eingabekonsole auf und ändere die Datei ``/etc/network/interfaces`` wie folgt:

.. code::

   auto lo
   iface lo inet loopback
   
   iface eno1 inet manual
   
   iface eno2 inet manual
   
   auto vmbr0
   iface vmbr0 inet dhcp       #holt dynamisch eine IP-Adresse
        bridge-ports eno1
        bridge-stp off
        bridge-fd 0
   #red
   
   auto vmbr1
   iface vmbr1 inet manual
        address 10.0.0.20/16
        gateway 10.0.0.254
        bridge-ports eno2
        bridge-stp off
        bridge-fd 0
   #green

Danach must Du noch die Datei ``/etc/hosts`` anpassen:

.. code::

   127.0.0.1 localhost.localdomain localhost
   10.0.0.20 proxmox.mydomain.local proxmox
   
   # The following lines are desirable for IPv6 capable hosts
   
   ::1     ip6-localhost ip6-loopback
   fe00::0 ip6-localnet
   ff00::0 ip6-mcastprefix
   ff02::1 ip6-allnodes
   ff02::2 ip6-allrouters
   ff02::3 ip6-allhosts
   
Starte danach den Proxmox-Host neu.

Hast Du dies erfolgreich umgesetzt, dann hast Du Folgendes erreicht:

.. figure:: media/install-on-proxmox_01_network-4-proxmox-installation.svg
   :align: center
   :scale: 80%
   :alt: Netzwerk für die Proxmox Installation

   Proxmox Netzwerk
   
   
Du musst nun noch den Admin-PC nach dem Neustart des Proxmox-Host auf den internen Switch des grünen Netzes anschließen. Der Admin-PC benötigt nun eine manuelle vergeben IP:

-  IP Address: 10.0.0.10/16
-  Subnetzmaske: 255.255.0.0
-  Gateway: 10.0.0.254
-  DNS: 10.0.0.254,8.8.8.8
   
Danach solltest Du vom Admin-PC aus folgende Hosts erreichen können:

1. 10.0.0.20 - Proxmox-Host
2. 10.0.0.254 - OPNsense
3. 8.8.8.8 - externer DNS-Server
4. linuxmuster.net - externe URL






