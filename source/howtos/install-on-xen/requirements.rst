Systemvoraussetzungen
=====================

In der unten aufgeführten Tabelle finden Sie die Systemvoraussetzungen
zum Betrieb der bereitgestellten virtuellen Maschinen. Die
Systemanforderungen für die Installation von XenServer selbst finden Sie
im Web unter support.citrix.com sowie xenserver.org

Die Werte in der Spalte Default sind die voreingestellten Werte der VMs
beim Import, diese Werte bilden gleichzeitig die Mindestvoraussetzungen.
Festplatten- und Arbeitsspeicher der VMs müssen addiert werden um die
Gesamtanforderung zu bestimmen.

Hinweis:

Wer mehrere Images hat, oder mehrere Sicherungen der Images vorhalten will 
sollte beim HDD-Speicherplatz deutlich mehr veranschlagen!

Beispiel:

Drei W7-Images a 30 G. Von jedem Image sollen drei Kopien vorgehalten werden, dann 
ist man schon bei 270 G benötigtem HDD-Speicher. Dabei ist noch nicht berücksichtigt,
dass auch in /home Platz benötigt wird. Dieser Platz ist abhängig von der Anzahl der
Benutzer und der Anwendungen. Hier sollte man zwischen 500 G und 1000 G einplanen.

+---------------+----------+-----------------------+-----------------------+---------+----------+
| **IP**        | **VM**   | **HDD**                                       |**RAM**             |
|               |          +-----------------------+-----------------------+---------+----------+
|               |          | Default               |Empfohlen              |Default  |Empfohlen |
+===============+==========+=======================+=======================+=========+==========+
| 10.16.1.1     | Server   | 70GB                  | 250GB+                | 4GB     | 8GB+     |
+---------------+----------+-----------------------+-----------------------+---------+----------+
| 10.16.1.2     | Opsi     | 50GB                  | 50GB+                 | 2GB     | 2GB+     |
+---------------+----------+-----------------------+-----------------------+---------+----------+
| 10.16.1.3     | Unifi    | 20GB                  | 20GB                  | 512MB   | 512MB+   |
+---------------+----------+-----------------------+-----------------------+---------+----------+
| 10.16.1.4     | XOA      | 8GB                   | 8GB                   | 1GB     | 1GB+     |
+---------------+----------+-----------------------+-----------------------+---------+----------+
| 10.16.1.5     | Chilli   | 20GB                  | 20GB                  | 512MB   | 512MB+   |
+---------------+----------+-----------------------+-----------------------+---------+----------+
| 10.16.1.254   | IPFire   | 4,5GB                 | 4,5GB+                | 256MB   | 1GB+     |
+---------------+----------+-----------------------+-----------------------+---------+----------+

Für den Betrieb des Hypervisors (XenServer) sollten ca. 2 bis 5 GB
Arbeitsspeicher eingeplant werden. Um nach Anleitung installieren zu
können, sollte der Server mit mindestens 2 Netzwerkkarten bestückt sein.
Durch VLANs kann der Betrieb aber auch bereits mit nur einer NIC
erfolgen, bspw. 10Gbit-Karte an Core-VLAN-Switch.

