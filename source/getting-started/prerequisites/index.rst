=================
 Voraussetzungen
=================

.. sectionauthor:: C. Weikl, T. Küchel

Linuxmuster.net wird als Zwei-Server-Lösung (Firewall und
linuxmuster.net-Server) betrieben. Optional können weitere Server wie
z.B. ein Docker-Host eingesetzt werden. Daneben gibt es mindestens
eine Trennung in zwei logische Netzwerke, meist sind aber drei oder
mehr Netzwerke gefordert (WLAN, DMZ, Lehrernetz).  Zuguterletzt kann
die linuxmuster.net bequem virtualisiert oder ohne Virtualisierung
betrieben werden.

Daraus leiten sich Voraussetzungen an Hardware, Netzwerkstrukturen und
Software ab, die in diesem Kapitel beleuchtet werden.



Hardware
========

Jeder der Server kann einzeln direkt auf der Hardware installiert
werden. Es müssen dann die Hardware-Voraussetzungen erfüllt sein, die
für die Firewall (standardmäßig OPNsense) und den Server (Ubuntu
Server 18.04 LTS) ebenfalls gelten.  Diese Installationsmethode eignet
sich auch für im folgenden nicht explizit beschriebene Virtualisierungen.

Ohne Virtualisierung
--------------------

OPNsense
~~~~~~~~

OPNSense ist für x86-32 und x86-64 Bit Architekturen verfügbar und kann auf 
SD-Karte, SSD oder HDDs installiert werden. Als Basis nutzt OPNsense das 
Betriebssystem FreeBSD.

Es wird empfohlen folgende Hardware-Anforderungen zu erfüllen, um die Mehrzahl
der Einsatzszenarien abzudecken:

+---------------------+-------------------------------------+
| Prozessor           | ≥ 1 GHz Multi-Core CPU (64 Bit)     |
+---------------------+-------------------------------------+
| RAM                 | ≥ 1 GB                              |
+---------------------+-------------------------------------+
|Installationsmethode | Video (VGA)                         |
+---------------------+-------------------------------------+
|Festplatte           | 120 GB SSD                          |
+---------------------+-------------------------------------+
|NIC                  | mind. 2 (intern + extern),          |
|                     | oder  3 (inter + extern + WLAN)     |
+---------------------+-------------------------------------+

Weitere Hinweise zu möglichen Hardwareanforderungen bei unterschiedlichen
Einsatzszenarien finden sich hier_.

.. _hier: https://wiki.opnsense.org/manual/hardware.html#hardware-requirements

Hinweise zu den Anforderungen von FreeBSD bzw. zur Kompatibilität mit 
eingesetzten Hardware-Komponenten finden sich unter der `HCL - Hardware Compatibility List`_.

.. _HCL - Hardware Compatibility List: https://www.freebsd.org/releases/11.1R/hardware.html


Ubuntu-Server lmn.v7
~~~~~~~~~~~~~~~~~~~~

Für linuxmuster.net v7 wird als Basis Ubuntu Server 18.04 LTS eingesetzt.

Es wird empfohlen folgende Hardware-Anforderungen zu erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | ≥ 1 GHz Multi-Core CPU (64 Bit)     |
+---------------------+-------------------------------------+
| RAM                 | 4 GB                                |
+---------------------+-------------------------------------+
|Festplatte           | 250 GB - 500 GB SSD oder HDD        |
+---------------------+-------------------------------------+


Docker-Host Ubuntu-Server
~~~~~~~~~~~~~~~~~~~~~~~~~

Es wird empfohlen folgende Hardware-Anforderungen zu erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | ≥ 1 GHz Multi-Core CPU (64 Bit)     |
+---------------------+-------------------------------------+
| RAM                 | 4 GB                                |
+---------------------+-------------------------------------+
|Festplatte           | 120 GB SSD oder HDD                 |
+---------------------+-------------------------------------+


OPSI auf Ubuntu-Server
~~~~~~~~~~~~~~~~~~~~~~

Es wird empfohlen folgende Hardware-Anforderungen zu erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | ≥ 1 GHz Multi-Core CPU (64 Bit)     |
+---------------------+-------------------------------------+
| RAM                 | 4 GB                                |
+---------------------+-------------------------------------+
|Festplatte           | 120 GB - 250 GB SSD oder HDD        |
+---------------------+-------------------------------------+


Mit Virtualisierung
-------------------

In der folgenden Tabelle finden Sie die Systemvoraussetzungen zum
Betrieb der bereitgestellten virtuellen Maschinen (VM) für
linuxmuster.net v7. Die Werte in der Spalte *Default* sind die
voreingestellten Werte der VMs beim Import, diese Werte bilden
gleichzeitig die Mindestvoraussetzungen.  Festplatten- und
Arbeitsspeicher der VMs müssen addiert werden, um die
Gesamtanforderung zu bestimmen.

.. hint::

   Wer mehrere Images hat, oder mehrere Sicherungen der Images
   vorhalten will sollte beim HDD-Speicherplatz deutlich mehr
   veranschlagen! Daran erinnert in der Tabelle die Zeile
   "Daten+Backup".

   **Beispiel:**
   Drei Images mit je 30G. Von jedem Image sollen drei Kopien vorgehalten werden, dann 
   ist man schon bei 270G benötigtem HDD-Speicher. Dabei ist noch nicht berücksichtigt,
   dass auch im Verzeichnis /home Platz pro Benutzer benötigt wird. Dieser Platz ist 
   abhängig von der Anzahl der Benutzer und der Anwendungen. 
   Hier sollte man zwischen 500G und 1000G einplanen.

Es wird empfohlen, dass die VMs (virtuellen Maschinen) auf externen
Speicher abgelegt werden (z.B.  NFS-Speicher oder iSCSI-Speicher), um
die Virtualisierungsumgebung ggf. bei Bedarf ausbauen zu können und
auch ausfallsichere Szenarien leichter umsetzen zu können.


+---------------+------------+-----------------------+-----------------------+---------+----------+
| **IP**        | **VM**     | **HDD**                                       |**RAM**             |
|               |            +-----------------------+-----------------------+---------+----------+
|               |            | Default               |Empfohlen              |Default  |Empfohlen |
+===============+============+=======================+=======================+=========+==========+
| 10.0.0.1/16   | Server     | 1.: 25GB, 2.: 100GB   | 250GB+                | 4GB     | 8GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| /             | /          | 500GB Daten+Backup    | 1000GB+               | /       | /        |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.2/16   | Opsi       | 100B                  | 100GB+                | 4GB     | 4GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.3/16   | Dockerhost | 20GB                  | 20GB                  | 512MB   | 512MB+   |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.4/16   | XOA        | 15GB                  | 15GB                  | 1GB     | 1GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.254/16 | OPNsense   | 10GB                  | 10GB+                 | 1GB     | 1GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+

.. hint::

   Die XenOrchestra-Appliance (XOA) wird nur benötigt, wenn eine
   Virtualisierung mit XCP-ng erfolgen soll. Mithilfe von XenOrchestra
   kann die Virtualisierungsumgebung XCP-ng web-basiert verwaltet
   werden und es können hierüber auch sog. Enterprise-Funktionen wie
   z.B. Backup, Replikation etc. konfiguriert werden.

Für die Virtualisierung sollte der Host (Hypervisor) mit wenigstens
drei Netzwerkkarten ausgestattet sein. Zudem sollte dieser mit 2-8 GB
zusätzlichem Arbeitsspeicher und ca 20 GB weiterem Festplattenplatz
für den Betrieb des Hypervisors selbst ausgestattet sein.

Bei minimaler Ausstattung (ohne Opsi, Docker und XOA) einer mittleren
Schule (ca. 500 Benutzer) *kann* ein kleiner Server oder ein gut
ausgestatteter PC ausreichend sein.

+---------------+-----------------+-----------------------+-----------------------+---------+----------+
| **Schule**    | **Features**    | **HDD**                                       |**RAM**             |
|               |                 +-----------------------+-----------------------+---------+----------+
|               |                 | Default               |Empfohlen              |Default  |Empfohlen |
+===============+=================+=======================+=======================+=========+==========+
| mittelgroß    | minimal         | ~650GB                | 1500GB+               | 8GB     | 16GB+    |
+---------------+-----------------+-----------------------+-----------------------+---------+----------+
| groß          | normal          | ~1000GB               | 2000GB+               | 10GB    | 16GB+    |
+---------------+-----------------+-----------------------+-----------------------+---------+----------+

.. _`net-infrastructure-label`:

Netzwerkstruktur
================

Je nach Einsatzszenario kann die Netzwerkstruktur der linuxmuster.net
angepasst werden. Vor der Installation sollte man über den Umfang der
eingesetzten Geräte ungefähr Bescheid wissen und dementsprechend die
IP-Bereiche groß wählen oder mehrere Subnetze einführen.

IP-Bereiche
-----------

Die linuxmuster.net-Lösung kann mit unterschiedlichen IP-Bereichen
arbeiten. Standardmäßig wird das interne Netz aus dem privaten
IPv4-Bereich 10.0.x.x mit einer 16-bit Netzmaske 255.255.0.0 eingerichtet.

Die virtuellen Appliances sind mit dem Netz 10.0.0.0/16
voreingestellt.  Jedoch kann man sowohl die bisher in früheren
Versionen von linuxmuster.net verwendeten Netze, wie 10.16.0.0/12 oder
10.32.0.0/12, usw. weiterverwenden, als auch komplett andere private
Adressbereiche angeben, sollten es zwingende Gründe geben.

Jede Zeile der folgenden Tabelle stellt eine Möglichkeit dar.

+-------------------+-----------------+------------+----------------------------------+
| Beginn IP-Bereich | Ende IP-Bereich | Server-IP  | Üblich in                        |
+===================+=================+============+==================================+
| 10.0.0.0          | 10.0.255.255    | 10.0.0.1   | voreingestellt in VMs von lmn-v7 |
+-------------------+-----------------+------------+----------------------------------+
| 10.16.0.0         | 10.31.255.255   | 10.16.1.1  | in linuxmuster.net ≤ 6.2 üblich  |
+-------------------+-----------------+------------+----------------------------------+
| 10.32.0.0         | 10.47.255.255   | 10.32.1.1  | in linuxmuster.net ≤ 6.2 möglich |
+-------------------+-----------------+------------+----------------------------------+
| ...               | ...             | ...        | ...                              |
+-------------------+-----------------+------------+----------------------------------+
| 10.224.0.0        | 10.239.255.255  | 10.224.1.1 | in linuxmuster.net ≤ 6.2 möglich |
+-------------------+-----------------+------------+----------------------------------+
| 192.168.0.0       | 192.168.255.255 | 192.168.0.1| nicht üblich                     |
+-------------------+-----------------+------------+----------------------------------+

Bei der Installation entscheiden Sie sich für einen der
Bereiche. Liegen keine besonderen Anforderungen (z.B. Testbetrieb von
linuxmuster.net in einem weiteren produktiv laufenden
linuxmuster.net-System) vor, wird empfohlen den voreingestellten
Bereich zu verwenden oder bei einer Migration den früheren Bereich zu
behalten. Im vorliegenden Dokument enthaltene Screenshots werden immer
mit einem der ersten beiden Bereiche gemacht.

Getrennte Netze und VLAN
------------------------

Immer häufiger (z.B. durch Vorgaben vom Kultusministerium) besteht
Bedarf an einer weiteren Trennung des internen Netzes in mehrere
logisch von einander relativ getrennte Netze. Linuxmuster.net erlaubt
sehr flexibel eine beliebige Einteilung des großen pädagogischen
Netzes in Subnetze. Darüberhinaus sind komplett getrennte Netze für
WLAN oder eine demilitarisierte Zone (DMZ) ohne Einschränkungen möglich.

Wer vor der Entscheidung steht, Subnetze oder VLANs einzurichten,
sollte das Kapitel :ref:`Netzsegmentierung mit linuxmuster.net
<subnetting-basics-label>` lesen.


Aus historischen und anschaulichen Gründen verwendet die
linuxmuster.net in der Dokumentation weiterhin die Farbzuordnung, die
durch die Firewall-Lösung "IPFire" geprägt wurde:

*  Das interne Netzwerk wird GRÜNES Netzwerk genannt (davon kann es nach Netzsegmentierung mehrere geben).
*  Das externe Netzwerk wird ROTES Netzwerk genannt, es ist über einen Router mit dem Internet verbunden.
*  Optional kann z.B. für WLAN-Accesspoints ein weiteres Netzwerk aufgebaut werden (BLAU/LILA), für welches andere Zugangsberechtigungen als denen im grünen Netzwerk gelten.
*  Ebenso optional kann eine sog. demilitarisierte Zone (DMZ) als zusätzliches Netzwerk (ORANGE) aufgebaut werden.

.. figure:: media/preamble/einfaches-netz.png
   :align: center
   :alt: Schematischer Aufbau eines Computernetzes mit linuxmuster.net.

   Schematischer Aufbau eines Computernetzes mit linuxmuster.net.




Virtualisierung
===============

Wenn man linuxmuster.net virtualisiert betreibt, gelten zu den obigen
Voraussetzungen noch folgende Hinweise:

- Das Netzwerk wird virtualisiert. Dadurch werden virtuelle Switche
  ("bridges") erstellt, denen die richtigen Schnittstellen zugeordnet
  werden müssen. Mit zusätzlichem VLAN wird die Konfiguration auf dem
  Hypervisor schnell komplex, die physikalische Verkabelung kann aber
  einfacher werden.

- Der Speicherplatz wird virtualisiert. Darauf muss man bei der
  Verwendung externer (iSCSI) wie interner Speichersysteme (LVM)
  achten. Dies kann auch zur Vereinfachung eines Backupverfahren
  beitragen.

- Da der VM-Host die einzelnen VMs zunächst kapselt, ist es aus
  Sicherheitsgründen empfehlenswert, den VM-Host nicht ins selbe Netz
  seiner VMs einzubinden. Außerdem wird der Zugriff auf die Daten
  eventuell erschwert.

Hypervisoren
------------

Die Voraussetzungen für einen virtualisierten Betrieb besteht
natürlich darin, vorab den Hypervisor/den VM-Host installiert zu haben
und Zugriff auf dessen Verwaltung zu haben. Wo es uns möglich ist,
haben wir eine Anleitung dazu geschrieben, um auf die Besonderheiten
der Schulnetzumgebung an geeigneter Stelle hinzuweisen. Für alle
anderen Fälle, wird im folgenden der Ablauf einer Installation
skizziert.

KVM/qemu/Proxmox als Hypervisor:
  Ausführliche Informationen findest Du im Kapitel :ref:`install-on-kvm-label`.

Xen als Hypervisor:
  Ausführliche Informationen findest Du im eigenen Kapitel :ref:`install-on-xen-label`.

VMWare als Hypervisor:
  :fixme: anybody?

VirtualBox als Hypervisor:
  VirtualBox wird häufig als Testsystem verwendet. Die
  `Entwicklerdokumentation
  <https://github.com/linuxmuster/linuxmuster-base7/wiki/Die-Appliances>`_
  beschreibt diese Konfiguration.

Software
========

.. Für gängige Virtualisierungsmethoden gibt es (unterschiedliche)
   Abbilder zum Download und zum Einspielen in das Hostsystem. 

Für hier beschriebene Virtualisierungsmethoden benötigt man neben der
Virtualisierungssoftware noch die bereitgestellten VM-Appliances
(Abbilder).

Für eine Installation direkt auf der Hardware oder einer Installation
von Grund auf innerhalb (anderer) Virtualisierungen benötigt man
	
- `Ubuntu 18.04 LTS 64-bit PC (AMD64) server install image
  <http://releases.ubuntu.com/bionic/ubuntu-18.04-live-server-amd64.iso>`_

- `OpnSense <https://opnsense.org/download>`_

..
   Um sicher zu stellen, dass die Datei richtig heruntergeladen wurde, kannst du die SHA1-Summe prüfen. Auf der Konsole eines Linuxbetriebsystems steht z.B. der Befehl ``sha1sum`` zur Verfügung:

   .. code-block:: console

      sha1sum ubuntu-18.04-live-server-amd64.iso

   Als Ausgabe erhält man die Prüfsumme, z.B.

   .. code-block:: console

      0b3490de9839c3918e35f01aa8a05c9ae286fc94 *ubuntu-18.04-live-server-amd64.iso

   Dies so erhalten Prüfsumme muss mit von Ubuntu zur Verfügung gestellten `Summe <http://releases.ubuntu.com/bionic/SHA1SUMS>`_ (Zeile ubuntu-18.04-live-server-amd64.iso) übereinstimmen.

Checkliste
==========

Nutzen Sie die :download:`Checkliste
<./media/preamble/checklist/checklist.pdf>`, um alle während der
Installation gemachten Einstellungen festzuhalten. Es handelt sich um
ein PDF-Formular, Sie können es also auch am PC ausfüllen. Halten Sie
diese Checkliste bereit, wenn Sie den Telefon-Support in Anspruch
nehmen wollen.
