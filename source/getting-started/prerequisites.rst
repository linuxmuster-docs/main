.. _prerequisites-label:

=================
 Voraussetzungen
=================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_

Linuxmuster.net wird als Zwei-Server-Lösung (Firewall und
linuxmuster.net-Server) betrieben. Optional können weitere Server wie
z.B. ein Docker-Host eingesetzt werden. Daneben gibt es mindestens
eine Trennung in zwei logische Netzwerke, meist sind aber drei oder
mehr Netzwerke gefordert (WLAN, DMZ, Lehrernetz). Zu guter Letzt kann
die linuxmuster.net bequem virtualisiert oder ohne Virtualisierung
betrieben werden.

Daraus leiten sich Voraussetzungen an Hardware, Netzwerkstrukturen und
Software ab, die in diesem Kapitel beleuchtet werden.

Hardware
========

OPNsense
--------

OPNSense ist für x86-32 und x86-64 Bit Architekturen verfügbar und
kann auf SD-Karte, SSD oder HDDs installiert werden. Es wird empfohlen
folgende Hardware-Anforderungen zu erfüllen, um die Mehrzahl der
Einsatzszenarien abzudecken:

+---------------------+-------------------------------------+
| Prozessor           | >= 1 GHz Multi-Core CPU (64 Bit)    |
+---------------------+-------------------------------------+
| RAM                 | >= 1 GB                             |
+---------------------+-------------------------------------+
|Installationsmethode | Video (VGA)                         |
+---------------------+-------------------------------------+
|Festplatte           | mind. 20GB, z.B. 120 GB SSD         |
+---------------------+-------------------------------------+
|NIC                  | mind. 2 (intern + extern),          |
|                     | oder  3 (intern + extern + WLAN)    |
+---------------------+-------------------------------------+

Weitere Hinweise zu möglichen Hardwareanforderungen bei
unterschiedlichen Einsatzszenarien finden sich `hier
<https://wiki.opnsense.org/manual/hardware.html#hardware-requirements>`_.

Als Basis nutzt OPNsense das Betriebssystem FreeBSD.  Hinweise zu den
Anforderungen von FreeBSD bzw. zur Kompatibilität mit eingesetzten
Hardware-Komponenten finden sich unter der `HCL - Hardware
Compatibility List
<https://www.freebsd.org/releases/11.1R/hardware.html>`_


Server linuxmuster v7
---------------------

Für linuxmuster.net v7 wird als Basis ein Ubuntu Server 18.04 LTS
eingesetzt. Es wird empfohlen folgende Hardware-Anforderungen zu
erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | >= 1 GHz Multi-Core CPU (64 Bit)    |
+---------------------+-------------------------------------+
| RAM                 | >= 4 GB                             |
+---------------------+-------------------------------------+
|Festplatte System +  | - vorkonfiguriert sind 25GB + 100GB | 
|Daten                | - mind. 500GB für Daten und Backup  |
|                     | - empfohlen >= 1TB                  |
+---------------------+-------------------------------------+

Docker-Host bzw. OPSI-Host auf Basis eines Ubuntu-Servers
---------------------------------------------------------

Es wird empfohlen, je Server folgende Hardware-Anforderungen zu
erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | >= 1 GHz Multi-Core CPU (64 Bit)    |
+---------------------+-------------------------------------+
| RAM                 | >= 4 GB (OPSI), >= 1 GB (Docker)    |
+---------------------+-------------------------------------+
|Festplatte           | 100 GB+, nach Bedarf                |
+---------------------+-------------------------------------+


Für eine virtuelle Installation aller obigen Maschinen müssen die
Mindestwerte für die Hardware addiert werden.

Festplattenspeicher
  Der Festplattenplatz für den Server hängt stark von der Nutzerzahl und
  der mehr oder weniger intensiven Verwendung von LINBO-Abbildern
  ab. Ebenso muss für Backup weiterer Festplattenplatz z.B. auf einem
  NAS eingeplant werden.

  Selbstverständlich können sowohl Daten als auch (bei
  Virtualisierung) die Server auf externem Speicher abgelegt werden
  (z.B. NFS-Speicher oder iSCSI-Speicher), um die
  Virtualisierungsumgebung ggf. bei Bedarf ausbauen zu können und auch
  ausfallsichere Szenarien leichter umsetzen zu können.


So *kann* bei minimaler Ausstattung (ohne Opsi und Docker) einer
mittleren Schule (ca. 500 Benutzer) ein kleiner Server oder ein gut
ausgestatteter PC ausreichend sein, selbst wenn alle Server
virtualisiert laufen.

+---------------+-----------------+-----------------------+-----------------------+---------+----------+
| **Schule**    | **Features**    | **Festplatten**                               | **RAM**            |
|               |                 +-----------------------+-----------------------+---------+----------+
|               |                 | Standard              |Empfohlen              |Standard |Empfohlen |
+===============+=================+=======================+=======================+=========+==========+
| mittelgroß    | minimal         | ~650GB                | 1500GB+               | 8GB     | 16GB+    |
+---------------+-----------------+-----------------------+-----------------------+---------+----------+
| groß          | normal          | ~1000GB               | 2000GB+               | 10GB    | 16GB+    |
+---------------+-----------------+-----------------------+-----------------------+---------+----------+

..
  .. hint:: 
  Abbilder für drei verschiedene Hardwareklassen haben ca. 40G. Von
     jedem Image sollen drei Kopien vorgehalten werden, dann ist man
     schon bei 120G benötigtem Festplattenplatz alleine für die
     Arbeitsplätze.
  
     Auch im Verzeichnis ``/home`` oder im Cloudspeicher sollte man
     Platz pro Benutzer einplanen. Bei 5GB für 100 Lehrer und 500MB für
     1000 Schüler kommt man auf weitere 1000GB.



.. _`net-infrastructure-label`:

Netzwerkstruktur
================

Je nach Einsatzszenario muss die Netzwerkstruktur der linuxmuster.net
zu Beginn der Installation angepasst werden. Man sollte man über den
Umfang der eingesetzten Geräte ungefähr Bescheid wissen und
dementsprechend den IP-Bereich nicht zu klein wählen oder Subnetze
einführen. Ebenso muss man den IP-Bereich auf die Umgebung
(z.B. Verwaltungsnetz, extern vorgegebene Netze) abstimmen um
Überschneidungen zu vermeiden.

IP-Bereiche
-----------

Die linuxmuster.net-Lösung kann mit unterschiedlichen IP-Bereichen
arbeiten. Standardmäßig wird das interne Netz aus dem privaten
IPv4-Bereich 10.0.x.x mit der 16-bit Netzmaske 255.255.0.0 eingerichtet.
Die virtuellen Appliances sind mit diesem Netz voreingestellt.

Jedoch kann man sowohl die bisher in früheren Versionen von
linuxmuster.net verwendeten Netze, wie 10.16.0.0/12 oder 10.32.0.0/12,
usw. weiterverwenden, als auch komplett andere private Adressbereiche
angeben, sollte es zwingende Gründe geben.

Jede Zeile der folgenden Tabelle stellt eine Möglichkeit dar.

+-------------------+-----------------+------------+----------------------------------+
| Beginn IP-Bereich | Ende IP-Bereich | Server-IP  | Üblich in                        |
+===================+=================+============+==================================+
| 10.0.0.0          | 10.0.255.255    | 10.0.0.1   | voreingestellt in VMs von lmn-v7 |
+-------------------+-----------------+------------+----------------------------------+
| 10.16.0.0         | 10.31.255.255   | 10.16.1.1  | in linuxmuster.net < 7   üblich  |
+-------------------+-----------------+------------+----------------------------------+
| 10.32.0.0         | 10.47.255.255   | 10.32.1.1  | in linuxmuster.net < 7   möglich |
+-------------------+-----------------+------------+----------------------------------+
| ...               | ...             | ...        | ...                              |
+-------------------+-----------------+------------+----------------------------------+
| 192.168.0.0       | 192.168.255.255 | 192.168.0.1| nicht üblich                     |
+-------------------+-----------------+------------+----------------------------------+

Bei der Neuinstallation entscheidest du dich für einen der Bereiche.
Bei einer Migration wird empfohlen den früheren Bereich zu behalten,
alleine schon um eine Umkonfiguration der Netzwerkswitche zu
vermeiden.

Standard IP-Adressen
--------------------

Einige IP-Adressen sind standardmäßig für spezielle Server/Dienste
vorgesehen.

+------------+---------------+--------------+
| **Server** |**IP-Bereich** |**IP-Bereich**|
|            |10.0.0.0/16    |10.16.0.0/12  |
+============+===============+==============+
| OPNsense   | 10.0.0.254    | 10.16.1.254  |
+------------+---------------+--------------+
| Server     | 10.0.0.1      | 10.16.1.1    |
+------------+---------------+--------------+
| Opsi       | 10.0.0.2      | 10.16.1.2    |
+------------+---------------+--------------+
| Dockerhost | 10.0.0.3      | 10.16.1.3    |
+------------+---------------+--------------+
| XOA (*)    | 10.0.0.4      | 10.16.1.4    |
+------------+---------------+--------------+
| Admin-PC   | 10.0.0.10     | 10.16.1.10   |
+------------+---------------+--------------+

.. hint::

   (*) Die XenOrchestra-Appliance (XOA) wird nur benötigt, wenn eine
   Virtualisierung mit XCP-ng erfolgen soll. Mithilfe von XenOrchestra
   kann die Virtualisierungsumgebung XCP-ng web-basiert verwaltet
   werden und es können hierüber auch sog. Enterprise-Funktionen wie
   z.B. Backup, Replikation etc. konfiguriert werden.



Netz-Grundstruktur
------------------

Aus historischen und anschaulichen Gründen verwendet die
linuxmuster.net in der Dokumentation weiterhin die Farbzuordnung, die
durch die Firewall-Lösung "IPFire" geprägt wurde:

.. figure:: media/simple-network.png
   :align: center
   :alt: Schematischer Aufbau eines Computernetzes mit linuxmuster.net.

   Schematischer Aufbau eines Computernetzes mit linuxmuster.net.


* Das interne Netzwerk wird GRÜNES Netzwerk genannt 
* Das externe Netzwerk wird ROTES Netzwerk genannt, es ist über einen Router mit dem Internet verbunden.
* Optional kann eine sog. demilitarisierte Zone (DMZ) als zusätzliches Netzwerk (ORANGE) aufgebaut werden.
* Optional kann z.B. für WLAN-Accesspoints ein weiteres Netzwerk
  aufgebaut werden (BLAU/LILA), für welches andere
  Zugangsberechtigungen als im grünen Netzwerk gelten.

Das obige Prinzip ist bereits ein Beispiel für Netzwerksegmentierung,
das im nächsten Abschnitt näher erläutert wird.


Getrennte Netze und VLAN
------------------------

Immer häufiger (z.B. durch Vorgaben vom Kultusministerium oder
Lastverteilung) besteht Bedarf an einer weiteren Trennung des internen
Netzes in mehrere logisch von einander relativ getrennte
Netze. Neben den relativ stark abgetrennten Netzen für WLAN oder eine
demilitarisierte Zone (DMZ) wie oben abgebildet, erlaubt
linuxmuster.net Lösung sehr flexibel eine beliebige Einteilung des
Schulnetzes in Subnetze.

Wer vor der Entscheidung steht, Subnetze oder VLANs einzurichten,
sollte das Kapitel :ref:`Netzsegmentierung mit linuxmuster.net
<subnetting-basics-label>` lesen.


Virtualisierung
===============

Wenn man linuxmuster.net virtualisiert betreibt, gelten zu den obigen
Voraussetzungen noch folgende Hinweise:

- Das Netzwerk wird virtualisiert. Dadurch werden virtuelle Switche
  ("bridges") erstellt, denen die richtigen Schnittstellen zugeordnet
  werden müssen. Der Virtualisierungshost (Hypervisor) sollte
  wenigstens mit drei Netzwerkkarten ausgestattet sein.  Mit
  zusätzlichem VLAN wird die Konfiguration auf dem Hypervisor schnell
  komplex, die physikalische Verkabelung kann aber einfacher werden.

- Der Speicherplatz wird virtualisiert. Darauf muss man bei der
  Verwendung externer (iSCSI) wie interner Speichersysteme (LVM)
  achten. Dies kann auch zur Vereinfachung eines Backupverfahrens
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
  Ausführliche Informationen findest Du im Kapitel :ref:`install-on-kvm-label` und :ref:`install-on-proxmox-label`.

Xen als Hypervisor:
  Ausführliche Informationen findest Du im eigenen Kapitel :ref:`install-on-xen-label`.

VMware ESXi als Hypervisor:
  :fixme: anybody?

VirtualBox als Hypervisor:
  VirtualBox wird häufig im Testbetrieb und weniger im
  Produktivbetrieb verwendet. Die `Entwicklerdokumentation
  <https://github.com/linuxmuster/linuxmuster-base7/wiki/Die-Appliances>`_
  beschreibt diese Konfiguration. Es muss mindestens die Version 6.0
  verwendet werden.

.. _getting-started-downloads-label:

Download
========

Für eine Installation direkt auf der Hardware oder einer anderweitigen
Installation von Grund auf benötigt man
	
- `Ubuntu 18.04 LTS 64-bit PC (AMD64) server install image
  <http://releases.ubuntu.com/bionic/>`_

- `OpnSense <https://opnsense.org/download>`_

Für die eine virtualisierte Installation benötigt man neben der
Virtualisierungssoftware noch die bereitgestellten VM-Appliances
(Abbilder).

VMs - Hinweise
--------------

linuxmuster.net bietet vorgefertigte virtuelle Maschinen zum direkten Import für die jeweilige 
Virtualisierungsumgebung an, um die Installations- und Konfigurationszeiten stark zu verringern.

- Für XCP-ng als Opensource-Virtualisierungsumgebung werden die VMs im
  XVA-Format zum direkten Import angeboten. Die XVA-Dateien sind
  zusätzlich mit ZIP komprimiert worden.
- Für andere Virtualisierer (Open Source: KVM, Proxmox, VirtualBox)
  werden die VMs im OVA-Format bereitgestellt. Dieses kann i.d.R. von
  der Mehrzahl der Virtualisierer erfolgreich importiert werden.
- Für alle Virtualisierer, für die kein Import möglich ist, bietet es
  sich entweder an, die OVA-Dateien händisch zu entpacken und die
  Einstellungen händisch einzurichten, oder eine Installation von
  Grund auf zu starten.

Zu den jeweiligen Download-Dateien der VMs werden ebenfalls die
SHA1-Werte zur Überprüfung der Datenintegrität bereitgestellt.

Nachstehende Übersicht gibt eine Kurzübersicht zu den angebotenen VMs mit anschließendem 
Link zur Download-Übersicht.

.. _getting-started-OVA-label:

Appliances OVA
--------------

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         | 
+====================+======================================================================+
| lmn7.opnsense      | OPNsense Firewall VM  der linuxmuster.net v7                         |                  
+--------------------+----------------------------------------------------------------------+
| lmn7.server        | Server der linuxmuster.net v7                                        | 
+--------------------+----------------------------------------------------------------------+

Nachstehende VMs sind optional, sofern eine paketorientierte Softwareverteilung für 
Windows-Clients (OPSi), eigene Web-Services mithilfe eines sog. Docker-Hosts betrieben
und/oder eine WLAN-Anbindung via Ubiquiti bereitgestellt werden soll.

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         | 
+====================+======================================================================+
| lmn7.opsi          | OPSI VM der lmn v7                                                   |
+--------------------+----------------------------------------------------------------------+
| lmn7.docker        | Bereitstellung eigener Web-Dienste mithilfe eines Docker-Hosts       |
+--------------------+----------------------------------------------------------------------+
| lmn7.unifi         | Controller der Ubiquiti WLAN - Lösung                                |
+--------------------+----------------------------------------------------------------------+


Download der OVAs unter: `Download OVAs VM v7 <https://download.linuxmuster.net/ova/v7/latest/>`_   

Zur Installation mit KVM: :ref:`Installation KVM <install-on-kvm-label>`

.. _getting-started-XVA-label:

Appliances XVA
--------------

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         | 
+====================+======================================================================+
| lmn7.xoa           | web-basierte VM zur Verwaltung von XCP-ng angepasst an die lmn v7    |
+--------------------+----------------------------------------------------------------------+ 
| lmn7.opnsense      | OPNSense Firewall VM  der linuxmuster.net v7                         |                  
+--------------------+----------------------------------------------------------------------+
| lmn7.server        | Server der linuxmuster.net v7                                        | 
+--------------------+----------------------------------------------------------------------+

Nachstehende VMs sind optional, sofern eine paketorientierte Softwareverteilung für 
Windows-Clients (OPSi), eigene Web-Services mithilfe eines sog. Docker-Hosts betrieben
und/oder eine WLAN-Anbindung via Ubiquiti bereitgestellt werden soll.

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         | 
+====================+======================================================================+
| lmn7.opsi          | OPSI VM der lmn v62                                                  |
+--------------------+----------------------------------------------------------------------+
| lmn7.docker        | Bereitstellung eigener Web-Dienste mithilfe eines Docker-Hosts       |
+--------------------+----------------------------------------------------------------------+
| lmn7.unifi         | Controller der Ubiquiti WLAN - Lösung                                |
+--------------------+----------------------------------------------------------------------+

Die VMs sind bereits alle auf die Standard-Installation für linuxmuster.net v7 vorbereitet und 
die sog. XCP-ng Tools sind bereits installiert.

Download der XVAs unter: `Download XVAs VM v7 <https://download.linuxmuster.net/xcp-ng/v7/latest/>`_


Virtualisierungssoftware XCP-ng
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Die Download-Links zur Installation der XCP-ng Virtualisierungssoftware finden Sie nachstehend:

+--------------------+----------------------------------------------------------------------+
| Programm           | Beschreibung                                                         | 
+====================+======================================================================+
| XCP-ng             | `Installationsdatenträger <https://xcp-ng.org/#easy-to-install>`_    | 
+--------------------+----------------------------------------------------------------------+
| XCP-ng Center      | Windows - Programm zur Verwaltung von der Virtualisierungsumgebung   |                             
+--------------------+----------------------------------------------------------------------+
| Download-Link:                                                                            |
| `XCP-ng Center <https://github.com/xcp-ng/xenadmin/releases>`_                            |
+--------------------+----------------------------------------------------------------------+

Zur Installation mit XCP-ng: :ref:`Installation XCP-ng <install-on-xen-label>`


Vorgehen
========

Nachdem du entschieden hast, ob und wie du eine Virtualisierung
einsetzt, beginnst du mit Installation der Virtualisierung nach einer
der oben beschriebenen Anleitungen zu Hypervisoren im Anhang dieser
Dokumentation.

Alternativ installierst du von Grund auf die Serverbetriebssysteme
*Ubuntu Server* und *OPNSense* direkt auf der Hardware oder innerhalb
einer deiner Virtualisierungslösung.

Jetzt kann die eigentliche Installation mit der eventuellen Anpassung
des Netzbereiches und der Erstkonfiguration beginnen, wie sie im
:ref:`nächsten Kapitel <setup-using-selma-label>` beschrieben wird.


..
   Um sicher zu stellen, dass die Datei richtig heruntergeladen wurde, kannst du die SHA1-Summe prüfen. Auf der Konsole eines Linuxbetriebsystems steht z.B. der Befehl ``sha1sum`` zur Verfügung:

   .. code-block:: console

      sha1sum ubuntu-18.04-live-server-amd64.iso

   Als Ausgabe erhält man die Prüfsumme, z.B.

   .. code-block:: console

      0b3490de9839c3918e35f01aa8a05c9ae286fc94 *ubuntu-18.04-live-server-amd64.iso

   Dies so erhalten Prüfsumme muss mit von Ubuntu zur Verfügung gestellten `Summe <http://releases.ubuntu.com/bionic/SHA1SUMS>`_ (Zeile ubuntu-18.04-live-server-amd64.iso) übereinstimmen.
.. 
  Checkliste
  ==========
  
  Nutzen Sie die :download:`Checkliste
  <./media/preamble/checklist/checklist.pdf>`, um alle während der
  Installation gemachten Einstellungen festzuhalten. Es handelt sich um
  ein PDF-Formular, Sie können es also auch am PC ausfüllen. Halten Sie
  diese Checkliste bereit, wenn Sie den Telefon-Support in Anspruch
  nehmen wollen.
