Vorbemerkungen
==============

Diese Dokumentation stellt die Netzwerksegmentierung und die zugehörigen Konfigurationsschritte für die Nutzung mehrerer Netzsegmente vor. Diese Struktur ist auf die eigenen Gegebenheiten / Anforderungen entsprechend anzupassen.

Geplante Zielstruktur
---------------------

Das linuxmuster.net-Netzwerk soll unter Verwendung eines L3-Switches und weiterer managebarer L2-Switches in 8 Segmente unterteilt werden.

* ``VLAN Internet``, Netzwerkadressen IP-Netz der Firewall an der Schnittstelle rot (z.B. 192.168.10.0/28)
* ``VLAN Server``, Netzwerkadressen 10.16.1.0/24 (für alle Server/-VMs)
* ``VLAN WLAN``,   Netzwerkadressen 172.16.16.0/24 (für das WLAN-Netz)
* ``VLAN DMZ``,    Netzwerkadressen 172.16.17.0/24 (für den Betrieb eigener, extern erreichbarer Web-Dienste)
* ``VLAN Lehrer``, Netzwerkadressen 10.30.10.0/24 (für den Zugriff mit Lehrer PCs, Laptops)
* ``VLAN Gaeste``, Netzwerkadressen 10.30.20.0/24 (für den Zugriff mit Gast-Geräten)
* ``VLAN Raum100``, Netzwerkadressen 10.20.100.0/24 (für den Zugriff mit Schulungsgeräten im Raum 100)
* ``VLAN Raum200``, Netzwerkadressen 10.20.200.0/24 (für den Zugriff mit Schulungsgeräten im Raum 200)

Für die Unterteilung sind auf **allen** Switches entsprechende VLANs in gleicher Weise einzurichten. Die Verbindungen zwischen den Switches werden als Trunks (bzw. Tagged-Ports) definiert, die über Gerätegrenzen hinweg die Daten den VLANs zuordnen. Die Ports auf den Switches sind jeweils den gewünschten VLANs zuzuordnen (port-basierte VLANs), so dass die an den Ports angeschlossenen Geräte ihre Daten in das zugeordnete VLAN schicken.

Der L3-Switch erhält in jedem VLAN die letzte nutzbare IP-Adresse - also z.B. für das ``VLAN Lehrer`` die IP 10.30.10.254 / 24. Nur im ``VLAN Server`` erhält der L3-Switch die IP 10.16.1.253/24, da die Firewall in diesem Subnetz bereits die IP 10.16.1.254/24 nutzt.

VLAN IDs und Gateway-IPs
------------------------

In dieser Dokumentation werden folgende VLAN-IDs und Gateway-IPs verwendet: 

* ``VLAN Internet``: 	ID 5, GW-IP: IP aus dem Netz der Firewall an der Schnittstelle rot (z.B. 192.168.10.14/28 - FW-IP: 192.168.10.2/28, IP des DSL-Routers: 192.168.1.1/28)
* ``VLAN Server``: 	ID 10,  GW-IP 10.16.1.253/24 (Firewall: 10.16.1.254/24)
* ``VLAN WLAN``: 	ID 20,  GW-IP 172.16.16.253/24 (Firewall: 172.16.16.254/24)
* ``VLAN DMZ``:		ID 30,  GW-IP 172.16.17.253/24 (Firewall: 172.16.17.254/24)
* ``VLAN Lehrer``:	ID 40,  GW-IP 10.30.10.254/24
* ``VLAN Gaeste``:	ID 50,  GW-IP 10.30.20.254/24
* ``VLAN Raum100``:	ID 100, GW-IP 10.20.100.254/24
* ``VLAN Raum200``:	ID 200, GW-IP 10.20.200.254/24

Damit DHCP-Anfragen der Clients aus dem internen (grünen) Netz an den Server 10.16.1.1 weitergeleitet werden, muss auf dem L3-Switch ein DHCP-Relay-Agent konfiguriert werden. Entsprechende Hinweise finden sich dann bei der Konfiguration des L3-Switches. 

.. image:: media/vlan-infrastructure-presets.png
   :alt: Struktur: Segmentiertes Netz
   :align: center

.. important::

   Abb. ggf. anpassen, damit alle Switch-Verbindungen lila dargestellt werden. 

In der Abbildung wird die Verbindung zwischen beiden Switches sowie zwischen dem L3-Switch und dem VM-Server lila als Trunk (Cisco) bzw. Tagged-Port (HP) gekennzeichnet. Dies bedeutet, dass der Uplink zwischen den Switches so zu konfigurieren ist, dass die VLAN-Tags weitergereicht werden. An dem L2-Switch werden die Ports dann jeweils den erforderlichen VLANs zugeordnet (port-basierte VLANs). Für den VM-Server bedeutet dies, dass der Datenverkehr aller VLANs hierin weitergeleitet wird und dann die Daten gemäß ihrem VLAN-Tag der jeweiligen VM zugeordnet werden.

Verfügt der VM-Server über mehrere Netzwerkschnittstellen, so sollten diese gebündelt werden (je nach Hersteller werden hierfür die Begriffe NIC Bonding, LinkAggregation, Etherchannel) verwendet, um den Datendurchsatz zu verbessern. Dies kann ebenfalls für die Verbindung zwischen den Switches (Uplinks) genutzt werden. In dieser Dokumentation soll die LinkAggregation am Beispiel des L3-Switches verdeutlicht werden. Es werden für 8 Ethernetschnittstellen vier Link-Aggregation Ports bestehend aus jeweils zwei Ethernetschnittstellen gebildet, die dann entsprechend konfiguriert werden.

Vorbereitungen
--------------  

Im ersten Schritt werden die in der Datei ``/etc/linuxmuster/workstations`` verwalteten Rechner so geordnet, dass Sie in weiteren Schritten automatisch in das richtige Subnetz einsortiert werden.
