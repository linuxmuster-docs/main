
Eine WLAN-Lösung für Schulen sollte mindestens zwei WLAN-Netze aufspannen. 

- Das Lehrernetz für schuleigene Geräte, wie Beamer, Laptops oder Chromecasts, und für private Geräte der Lehrer, die auf Beamer und Chromecasts zugreifen wollen.
- Das Schülernetz für Schüler.

.. figure:: media/vlantopologie.png
   :alt: VLAN-Topologie

In der hier vorgestellten Lösung kommen Accesspoints von Unifi und der kostenlose Unifi-Controller zum Einsatz. 

Die Geräte im Lehrernetz werden in die Datei `/etc/linuxmuster/workstations` aufgenommen. Das Lehrernetz ist ein Teil des Schulnetzes. Damit können sich beispielsweise Benutzer mit einem Schullaptop per WLAN wie gewohnt anmelden und auf ihre Daten zugreifen.

Im Schülernetz müssen sich die Benutzer für das WLAN mit ihrem Benutzernamen und Kennwort anmelden. Über die Schulkonsole kann einem Schüler oder einer Gruppe von Schülern das WLAN freigeschaltet oder gesperrt werden. Eine Verwaltung der Benutzergeräte durch den Netzwerkberater entfällt. 

Die Netztopologie
=================

Sollen 2 WLANs über einen Accesspoint (AP) ausgestrahlt werden, muss mindestens ein Netzwerk ein getaggtes VLAN sein.

.. figure:: media/vlantopologie.png
   :alt: VLAN-Topologie

Im Beispiel ist der Hypervisor (z.B. Proxmox) mit einem Netzwerkkabel mit dem Switch verbunden. 

Die virtuellen Maschinen sollten somit nicht direkt mit der Netzwerkkarte des Hypervisors verbunden sein. Es muss noch zusätzlich die VLAN-ID angegeben werden.

Im Beispiel werden die Datenpakete des Unifi-Controllers mit der Nummer 16 gekennzeichnet. Man sagt getaggt.

.. figure:: media/vlannetzwerkkarte.png
   :alt: VLAN-Netzwerkkarte

