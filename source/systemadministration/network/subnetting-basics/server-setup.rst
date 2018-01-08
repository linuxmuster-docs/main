Umstellen des Servers auf Subnetting
====================================


Das Umstellen auf Subnetzbetrieb geschieht per Setuproutine mit

.. code::

   # linuxmuster-setup --modify

oder im Falle einer Neuinstallation mit

.. code::

   # linuxmuster-setup --first

Dazu muss die Frage nach dem Subnetting nur mit ``Ja`` beantwortet werden.

Im Verlauf des Setups werden die für Subnetzbetrieb notwendigen Anpassungen auf Server und Firewall vorgenommen:

Die Netzwerkkonfiguration von Server und Firewall wird auf ein 24 Bit-Netz geändert (10.16.1.0/255.255.255.0), sodass diese quasi ein Serversubnetz innerhalb des übergeordneten 12 Bit-Netzes (10.16.0.0/255.240.0.0) bilden. Es werden statische Routen auf Server und Firewall für das übergeordnete 12 Bit-Netz mit der IP-Adresse des Layer-3-Switches als Gateway (10.16.1.253 für das 10.16.0.0er Netz) angelegt, damit das Routing aus den Subnetzen zum Server funktioniert. 

Für die Subnetzkonfiguration wird mit ``/etc/linuxmuster/subnets`` eine neue Konfigurationsdatei eingerichtet. Für jeden in ``/etc/linuxmuster/workstations`` definierten Raum wird automatisch ein Subnetz mit 24 Bit-Netzwerkpräfix (Netzmaske 255.255.255.0) angelegt. Die DHCP-Konfiguration wird dergestalt angepasst, dass die bisherige freie IP-Range für die Rechneraufnahme (z.B. 10.16.1.100-10.16.1.200) entfällt. Freie IP-Ranges müssen künftig in ``/etc/linuxmuster/subnets`` für jedes Subnetz definiert werden. Die DHCP-Subnetzkonfiguration wird danach von ``import_workstations`` in die Konfigurationsdatei ``/etc/dhcp/dhcpd.conf.linuxmuster`` geschrieben.

Die Standardnetzmaske 255.240.0.0 bleibt global gültig. Subnetze werden innerhalb des durch die globale Netzmaske vorgegebenen IP-Bereichs) angelegt. Dabei sind 24 Bit- (Netzmaske 255.255.255.0), als auch 16 Bit-Subnetze (Netzmaske 255.255.0.0) möglich. 

Subnetze einrichten / Aufbau der Konfigurationsdatei
----------------------------------------------------

Subnetze werden über die Konfigurationsdatei ``/etc/linuxmuster/subnets`` eingerichtet und konfiguriert. Sie enthält pro Zeile eine Subnetzdefinition, die aus sechs mit Semikolon getrennten Feldern besteht (Kommentarzeilen sind erlaubt):

+---------------+----------+--------------+---------------+----------------------+----------------------+
|Feld 1         |Feld 2    |Feld 3        |Feld 4         |Feld 5                |Feld 6                |
+===============+==========+==============+===============+======================+======================+
|Netz-IP/Präfix |Gateway-IP|Erste Range-IP|Letzte Range-IP|Intranet-Zugriff (0/1)|Internet-Zugriff (0/1)|
+---------------+----------+--------------+---------------+----------------------+----------------------+


**Konfiguration für das Ausgangsbeispiel**

+-----------+--------------+-------------+--------------+---------------+----------------+----------------+
|Bezeichnung|Netz-IP/Präfix|Gateway-IP   |Erste Range-IP|Letzte Range-IP|Intranet-Zugriff|Internet-Zugriff|
+===========+==============+=============+==============+===============+================+================+
|Raum 100   |10.20.100.0/24|10.20.100.254|10.20.100.100 |10.20.100.200 	|      nein 	 |     nein       |
+-----------+--------------+-------------+--------------+---------------+----------------+----------------+
|Raum 200   |10.20.200.0/24|10.20.200.254|10.20.200.100 |10.20.200.200 	|      nein 	 |     nein       |
+-----------+--------------+-------------+--------------+---------------+----------------+----------------+
|Lehrer     |10.30.10.0/24 |10.30.10.254 |      /       |      / 	|      nein 	 |     nein       |
+-----------+--------------+-------------+--------------+---------------+----------------+----------------+
|Gaeste     |10.30.20.0/24 |10.30.20.254 |10.30.20.1    |10.30.20.253 	|      nein 	 |      ja        |
+-----------+--------------+-------------+--------------+---------------+----------------+----------------+


Daraus ergibt sich folgender Aufbau der Konfigurationsdatei ``/etc/linuxmuster/subnets``:

.. code::

   # Raum 100
   10.20.100.0/24;10.20.100.254;10.20.100.100;10.20.100.200;0;0
   # Raum 200
   10.20.200.0/24;10.20.200.254;10.20.200.100;10.20.200.200;0;0
   # Lehrkräftenetz
   10.30.10.0/24;10.30.10.254;;;0;0
   # Gästenetz
   10.30.20.0/24;10.30.20.254;10.30.20.1;10.30.20.253;0;1

Beachten Sie, dass Änderungen der Subnetzkonfiguration erst wirksam werden, wenn sie durch Ausführung des Befehls

.. code:: 

   # import_workstations

in das System übernommen wurden.

.. important::

   Sonderstellung für Serversubnetz: Das Servernetz wird automatisch per default ohne freie Range angelegt und daher auch nicht 
   in ``/etc/linuxmuster/subnets`` eingetragen. Hosts, die Teil des Servernetzes sein sollen, benötigen also immer einen Eintrag 
   in ``/etc/linuxmuster/workstations``.

Wird in ``/etc/linuxmuster/workstations`` ein neuer Host hinzugefügt, dessen IP-Adresse in keines der aktuell definierten Subnetze passt, legt ``import_workstations`` für ihn ein neues 24 Bit-Subnetz an. Das bedeutet auch, bei der Umstellung auf Subnetzbetrieb wird Ihre in ``/etc/linuxmuster/workstations`` angelegte Raumstruktur automatisch in Subnetze aufgeteilt.

Denken Sie daran neue Subnetze in der VLAN-Konfiguration ihrer Switche entsprechend zu ergänzen.

Interner und externer Zugriff
-----------------------------

In der Konfigurationsdatei ``/etc/linuxmuster/subnets`` lässt sich für jedes Subnetz festlegen, ob IP-Adressen aus der frei definierten Range Zugriff auf Intranet-Resourcen8) (Feld 5) oder Internet (Feld 6) haben. Dabei bedeuten

    0 = kein Zugriff
    1 = Zugriff erlaubt

Zwei Dinge sind hierbei zu beachten:

Voreinstellungen für die Intranet- und Internetsperre für Räume und einzelne (in ``/etc/linuxmuster/workstations definierte``) Rechner werden nach wie vor über die Schulkonsole (Aktueller Raum) bzw. die Konfigurationsdatei ``/etc/linuxmuster /room_defaults`` vorgenommen.

**Ausnahme**: Wird für die freie Range eines Subnetzes das Internet freigegeben (1 in Feld 6), ist für importierte Rechner dieses Subnetzes die Internetsperre wirkungslos. Falls Sie also z.B. für mobile Geräte ein Netz mit freiem Internetzugriff benötigen, konfigurieren Sie dafür besser ein eigenes Subnetz.

