Vorbemerkungen
==============

Geplante Zielstruktur
---------------------

Das linuxmuster.net-Netzwerk soll unter Verwendung eines Layer3 fähigen Switches
in 3 Segmente unterteilt werden.

* Servernetz, Netzwerkadressen 10.16.0.0/16
* Lehrernetz, Netzwerkadressen 10.17.0.0/16
* Schülernetz, Netzwerkadressen 10.18.0.0/16

Wie bisher ist eine Einteilung der Rechner eines Raumes im dritten Oktett
problemlos möglich, z.B. alle Rechner in Raum 107 sind im Schülernetz und haben
Adressen aus dem Bereich 10.18.107.x, alle Rechner des Lehrerzimmers
sind im Lehrernetz und haben Adressen aus dem Bereich 10.17.120.x. Die Unterscheidung
der Räume bleibt also im 3. Oktett, die Unterscheidung der Subnetze findet im 2.
Oktett statt.

Für die Unterteilung werden auf den Switches VLANs eingerichtet, diese Anleitung Verwendet 

* für das Servernetz die VLAN-ID 16 
* für das Lehrernetz die VLAN-ID 17
* für das Schülernetz die VLAN-ID 18 

.. image:: media/struktur.png
   :alt: Struktur: Segmentiertes Netz
   :align: center

Im ersten Schritt werden die in der Datei ``/etc/linuxmuster/workstations``
verwalteten Rechner so geordnet, dass Sie in weiteren Schritten automatisch  in
das richtige Subnetz einsortiert werden.
