Vorbemerkungen
==============

Diese Dokumentation stellt die Netzwerksegmentierung und die zugehörigen Konfigurationsschritte für die Nutzung mehrerer Netzsegmente vor. Diese Struktur ist auf die eigenen Gegebenheiten / Anforderungen entsprechend anzupassen.

Geplante Zielstruktur
---------------------

Das linuxmuster.net-Netzwerk soll unter Verwendung eines L3-Switches und weiterer managebarer L2-Switches in 8 Segmente unterteilt werden.

+--------------+----------------------------------------------+-----------------------------+
| VLAN Name    | Verwendung                                   |  Netzwerkadressen           |
+==============+==============================================+=============================+
| ``Internet`` | alle Server in ROT                           | IP-Netz der Firewall an ROT |
+--------------+----------------------------------------------+-----------------------------+
| ``Server``   | alle Server/-VMs in GRÜN                     | 10.16.1.0/24                |
+--------------+----------------------------------------------+-----------------------------+
| ``WLAN``     | ein WLAN-Netz                                | 172.16.16.0/24              |
+--------------+----------------------------------------------+-----------------------------+
| ``DMZ``      | Betrieb eigener, extern erreichbarer Dienste | 172.16.17.0/24              |
+--------------+----------------------------------------------+-----------------------------+
| ``Lehrer``   | Zugriff mit Lehrer PCs, Laptops              | 10.30.10.0/24               | 
+--------------+----------------------------------------------+-----------------------------+
| ``Gaeste``   | Zugriff mit Gast-Geräten                     | 10.30.20.0/24               |
+--------------+----------------------------------------------+-----------------------------+
| ``Raum100``  | Zugriff mit Schulungsgeräten im Raum 100     | 10.20.100.0/24              |
+--------------+----------------------------------------------+-----------------------------+
| ``Raum200``  | Zugriff mit Schulungsgeräten im Raum 200     | 10.20.200.0/24              |
+--------------+----------------------------------------------+-----------------------------+

Für die Unterteilung sind auf **allen** Switches entsprechende VLANs in gleicher Weise einzurichten. Die Verbindungen zwischen den Switches werden als Trunks (bzw. Tagged-Ports) definiert, die über Gerätegrenzen hinweg die Daten den VLANs zuordnen. Die Ports auf den Switches sind jeweils den gewünschten VLANs zuzuordnen (port-basierte VLANs), so dass die an den Ports angeschlossenen Geräte ihre Daten in das zugeordnete VLAN schicken.

Der L3-Switch erhält in jedem VLAN die letzte nutzbare IP-Adresse -
also z.B. für das ``VLAN Lehrer`` die IP `10.30.10.254`, außer dort,
wo die Firewall im jeweiligen Subnetz bereits diese IP-Adresse nutzt.

VLAN IDs und Gateway-IPs
------------------------

In dieser Dokumentation werden folgende VLAN-IDs und Gateway-IPs verwendet: 

.. attention: tables have to be translateable, there should be enough room for the sentences in another language

+-------------------+---------+------------------------------------------------------------+
| VLAN Name         | VLAN ID | Gateway-IP  (+ Firewall-IP )                               |
+===================+=========+============================================================+
| ``VLAN Internet`` |     5   | IP aus dem Netz der Firewall an der Schnittstelle ROT [1]_ |
+-------------------+---------+------------------------------------------------------------+
| ``VLAN Server``   |    10   |  10.16.1.253 (Firewall: 10.16.1.254)                       |
+-------------------+---------+------------------------------------------------------------+
| ``VLAN WLAN``     | 	 20   |  172.16.16.253 (Firewall: 172.16.16.254)                   |
+-------------------+---------+------------------------------------------------------------+
| ``VLAN DMZ``      |    30   |  172.16.17.253 (Firewall: 172.16.17.254)                   |
+-------------------+---------+------------------------------------------------------------+
| ``VLAN Lehrer``   |    40   |  10.30.10.254                                              |
+-------------------+---------+------------------------------------------------------------+
| ``VLAN Gaeste``   |    50   |  10.30.20.254                                              |
+-------------------+---------+------------------------------------------------------------+
| ``VLAN Raum100``  |   100   |  10.20.100.254                                             |
+-------------------+---------+------------------------------------------------------------+
| ``VLAN Raum200``  |   200   |  10.20.200.254                                             |
+-------------------+---------+------------------------------------------------------------+

.. [1] z.B. GW-IP: 192.168.10.14/28 + FW-IP: 192.168.10.2/28 und IP des DSL-Routers: 192.168.1.1/28


Damit DHCP-Anfragen der Clients aus dem internen (grünen) Netz an den Server 10.16.1.1 weitergeleitet werden, muss auf dem L3-Switch ein DHCP-Relay-Agent konfiguriert werden. Entsprechende Hinweise finden sich dann bei der Konfiguration des L3-Switches. 

.. image:: media/vlan-infrastructure-presets.png
   :alt: Struktur: Segmentiertes Netz
   :align: center

.. important::

   Abb. ggf. anpassen, damit alle Switch-Verbindungen lila dargestellt werden. 

In der Abbildung wird die Verbindung zwischen beiden Switches sowie zwischen dem L3-Switch und dem VM-Server lila als Trunk (Cisco) bzw. Tagged-Port (HP) gekennzeichnet. Dies bedeutet, dass der Uplink zwischen den Switches so zu konfigurieren ist, dass die VLAN-Tags weitergereicht werden. An dem L2-Switch werden die Ports dann jeweils den erforderlichen VLANs zugeordnet (port-basierte VLANs). Für den VM-Server bedeutet dies, dass der Datenverkehr aller VLANs hierin weitergeleitet wird und dann die Daten gemäß ihrem VLAN-Tag der jeweiligen VM zugeordnet werden.

Verfügt der VM-Server über mehrere Netzwerkschnittstellen, so sollten diese gebündelt werden (je nach Hersteller werden hierfür die Begriffe NIC Bonding, LinkAggregation, Etherchannel) verwendet, um den Datendurchsatz zu verbessern. Dies kann ebenfalls für die Verbindung zwischen den Switches (Uplinks) genutzt werden. In dieser Dokumentation soll die LinkAggregation am Beispiel des L3-Switches verdeutlicht werden. Es werden für 8 Ethernetschnittstellen vier Link-Aggregation Ports bestehend aus jeweils zwei Ethernetschnittstellen gebildet, die dann entsprechend konfiguriert werden.

