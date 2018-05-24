=================
 Voraussetzungen
=================

Linuxmuster.net wird als Zwei-Server-Lösung (Firewall und
linuxmuster.net-Server) betrieben. Optional können weitere Server 
wie z.B. ein Docker-Host eingesetzt werden. Jeder der Server kann 
auch einzeln direkt auf der Hardware installiert werden. Es müssen 
die Hardware-Voraussetzungen erfüllt sein, die für die Firewall 
(standardmäßig OPNsense) und den Server (Ubuntu Server 18.04 LTS) 
ebenfalls gelten.  Diese Installationsmethode eignet sich auch für 
nicht explizit beschriebene Virtualisierungen.

Für gängige Virtualisierungsmethoden gibt es (unterschiedliche)
Abbilder zum Download und zum Einspielen in das Hostsystem.

Hardware
========

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
| Prozessor           | >= 1 GHz Multi-Core CPU (64 Bit)    |
+---------------------+-------------------------------------+
| RAM                 | >= 1 GB                             |
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
eingesetzten Hardware-Komponenten finden sich unter der HCL - Hardware Compatability List_.

.. _List: https://www.freebsd.org/releases/11.1R/hardware.html


Ubuntu-Server lmn.v7
~~~~~~~~~~~~~~~~~~~~

Für linuxmuster.net v7 wird als Basis Ubuntu Server 18.04 LTS eingesetzt.

Es wird empfohlen folgende Hardware-Anforderungen zu erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | >= 1 GHz Multi-Core CPU (64 Bit)    |
+---------------------+-------------------------------------+
| RAM                 | 4 GB                                |
+---------------------+-------------------------------------+
|Festplatte           | 250 GB - 500 GB SSD oder HDD        |
+---------------------+-------------------------------------+


Docker-Host Ubuntu-Server
~~~~~~~~~~~~~~~~~~~~~~~~~

Es wird empfohlen folgende Hardware-Anforderungen zu erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | >= 1 GHz Multi-Core CPU (64 Bit)    |
+---------------------+-------------------------------------+
| RAM                 | 4 GB                                |
+---------------------+-------------------------------------+
|Festplatte           | 120 GB SSD oder HDD                 |
+---------------------+-------------------------------------+


OPSI auf Ubuntu-Server
~~~~~~~~~~~~~~~~~~~~~~

Es wird empfohlen folgende Hardware-Anforderungen zu erfüllen:

+---------------------+-------------------------------------+
| Prozessor           | >= 1 GHz Multi-Core CPU (64 Bit)    |
+---------------------+-------------------------------------+
| RAM                 | 4 GB                                |
+---------------------+-------------------------------------+
|Festplatte           | 120 GB - 250 GB SSD oder HDD        |
+---------------------+-------------------------------------+


Für Virtualisierungsumgebungen
------------------------------

In der unten aufgeführten Tabelle finden Sie die Systemvoraussetzungen
zum Betrieb der bereitgestellten virtuellen Maschinen für linuxmuster.net v7. 
Die Systemanforderungen für die Installation einer Virtualisierungsumgebung finden 
Sie weiter unten_.

.. _unten: #virtualisierung

Die Werte in der Spalte Default sind die voreingestellten Werte der VMs
beim Import, diese Werte bilden gleichzeitig die Mindestvoraussetzungen.
Festplatten- und Arbeitsspeicher der VMs müssen addiert werden, um die
Gesamtanforderung zu bestimmen.

**Hinweis:**

Wer mehrere Images hat, oder mehrere Sicherungen der Images vorhalten will 
sollte beim HDD-Speicherplatz deutlich mehr veranschlagen!

**Beispiel:**

Drei Images mit je 30G. Von jedem Image sollen drei Kopien vorgehalten werden, dann 
ist man schon bei 270G benötigtem HDD-Speicher. Dabei ist noch nicht berücksichtigt,
dass auch im Verzeichnis /home Platz pro Benutzer benötigt wird. Dieser Platz ist 
abhängig von der Anzahl der Benutzer und der Anwendungen. 
Hier sollte man zwischen 500G und 1000G einplanen.

+---------------+------------+-----------------------+-----------------------+---------+----------+
| **IP**        | **VM**     | **HDD**                                       |**RAM**             |
|               |            +-----------------------+-----------------------+---------+----------+
|               |            | Default               |Empfohlen              |Default  |Empfohlen |
+===============+============+=======================+=======================+=========+==========+
| 10.0.0.1/16   | Server     | 1.: 25GB, 2.: 100GB   | 250GB+                | 4GB     | 8GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.2/16   | Opsi       | 100B                  | 100GB+                | 4GB     | 4GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.3/16   | Dockerhost | 20GB                  | 20GB                  | 512MB   | 512MB+   |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.4/16   | XOA        | 15GB                  | 15GB                  | 1GB     | 1GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+
| 10.0.0.254/16 | OPNsense   | 10GB                  | 10GB+                 | 1GB     | 1GB+     |
+---------------+------------+-----------------------+-----------------------+---------+----------+

**Hinweis:**

Die XOA-Appliance wird nur benötigt, wenn eine Virtualisierung mit XCP-ng erfolgen soll. Mithilfe 
von XenOrchestra kann die Virtualisierungsumgebung XCP-ng web-basiert verwaltet werden und es können
hierüber auch sog. Enterprise-Funktionen wie z.B. Backup, Replikation etc. konfiguriert werden.

Für die Virtualisierung sollte der Host mit wenigstens drei Netzwerkkarten ausgestattet sein. Zudem 
sollte dieser mit 4 - 8 GB zusätzlichem Arbeitsspeicher und ca 20 GB weiterem Festplattenplatz 
für den Betrieb des Hypervisors selbst ausgestattet sein.

Es wird empfohlen, dass die VMs (virtuellen Maschinen) auf externen Speicher abgelegt werden (z.B. 
NFS-Speicher oder iSCSI-Speicher), um die Virtualisierungsumgebung ggf. bei Bedarf ausbauen zu können 
und auch ausfallsichere Szenarien leichter umsetzen zu können.

Virtualisierung
===============

KVM/qemu als Hypervisor
-----------------------

KVM
~~~
Der Installationsablauf ist

# KVM-Host vorbereiten
# OVA-Abbilder herunterladen, einspielen und aktualisieren
# Anpassung der Festplattenkapazitäten an eigene Bedürfnisse
# Start der Installation und Erstkonfiguration

Proxmox
~~~~~~~

:fixme: unklar, ob Proxmox die OVAs verdauen kann

Der Installationsablauf ist

# Proxmox-Host vorbereiten
# OVA-Abbilder herunterladen, einspielen und aktualisieren
# Anpassung der Festplattenkapazitäten an eigene Bedürfnisse
# Start der Installation und Erstkonfiguration


Xen als Hypervisor
------------------

XCP-ng
~~~~~~

Der Installationsablauf ist

1. XCP-ng vorbereiten: XCP-ng herunterladen, Supplemental Pack mit VMs herunterladen
2. XCP-ng Installationsmedium erstellen
3. XenServer installieren und zugleich Supplemental Pack installieren
4. VMs aktualisieren und Anpassung der Festplattenkapazitäten an eigene Bedürfnisse
5. Start Erstkonfiguration

Für weitere Installationsdetails siehe Installation XCP-ng Server_.

.. _Server: ../install-on-xen/index.html


VMWare als Hypervisor
---------------------

:fixme: anybody?

VirtualBox als Hypervisor
-------------------------

Der Installationsablauf ist

# VirtualBox-Host vorbereiten
# OVA-Abbilder herunterladen, einspielen und aktualisieren
# Anpassung der Festplattenkapazitäten an eigene Bedürfnisse
# Start der Installation und Erstkonfiguration

Software
========

Download und Upgrade der Abbilder
---------------------------------

Lade dir zunächst die benötigte Software herunter, beachte dabei die Versionshinweise sorgfältig.

OpnSense
~~~~~~~~
:fixme: Download opnsense

Linuxmuster
~~~~~~~~~~~

:fixme: Download Linuxmuster

optional: docker und opsi
~~~~~~~~~~~~~~~~~~~~~~~~~

:fixme: download opsi & co

	
From scratch: Ubuntu Server 18.04 LTS
-------------------------------------

:fixme: gehört dann doch wieder zur alternativen Installation

Lade dir das Iso-Image ( `Ubuntu 18.04 LTS 64-bit PC (AMD64) server install image <http://releases.ubuntu.com/bionic/ubuntu-18.04-live-server-amd64.iso>`_ ) herunter und brenne es auf eine CD oder auf einen USB-Stick

Um sicher zu stellen, dass die Datei richtig heruntergeladen wurde, kannst du die SHA1-Summe prüfen. Auf der Konsole eines Linuxbetriebsystems steht z.B. der Befehl ``sha1sum`` zur Verfügung:

.. code-block:: console

   sha1sum ubuntu-18.04-live-server-amd64.iso

Als Ausgabe erhält man die Prüfsumme, z.B.

.. code-block:: console

   0b3490de9839c3918e35f01aa8a05c9ae286fc94 *ubuntu-18.04-live-server-amd64.iso

Dies so erhalten Prüfsumme muss mit von Ubuntu zur Verfügung gestellten `Summe <http://releases.ubuntu.com/bionic/SHA1SUMS>`_ (Zeile ubuntu-18.04-live-server-amd64.iso) übereinstimmen.


.. _`net-infrastructure-label`:

Netzwerkstruktur
================

IP-Bereiche
-----------
Die linuxmuster.net-Lösung kann mit unterschiedlichen IP-Bereiche arbeiten. Jede Zeile der folgenden Tabelle stellt eine Möglichkeit dar.

+---------+-------------------+-----------------+------------+--------------+
| Auswahl | Beginn IP-Bereich | Ende IP-Bereich | Server-IP  | IPFire-IP    |
+=========+===================+=================+============+==============+
| 16-31   | 10.16.0.0         | 10.31.255.255   | 10.16.1.1  | 10.16.1.254  |
+---------+-------------------+-----------------+------------+--------------+
| 32-47   | 10.32.0.0         | 10.47.255.255   | 10.32.1.1  | 10.32.1.254  |
+---------+-------------------+-----------------+------------+--------------+
| ...     | ...               | ...             | ...        | ...          |
+---------+-------------------+-----------------+------------+--------------+
| 224-239 | 10.224.0.0        | 10.239.255.255  | 10.224.1.1 | 10.224.1.254 |
+---------+-------------------+-----------------+------------+--------------+

Bei der Installation entscheiden Sie sich für einen der Bereiche. Liegen keine besonderen Anforderungen (z.B. Testbetrieb von linuxmuster.net in einem weiteren produktiv laufenden linuxmuster.net-System) vor, wird empfohlen den Bereich 16-31 zu verwenden. Dies hat auch den Vorteil, dass alle im vorliegenden Dokument enthaltenen Screenshots bei einer Installation mit diesem Bereich gemacht wurden.

Netzwerknamen der Firewall-Lösung IPFire
----------------------------------------
Linuxmuster.net ordnet den unterschiedlichen Netzwerken Farben zu:

*  Das interne Netzwerk wird GRÜNES Netzwerk genannt.
*  Das externe Netzwerk wird ROTES Netzwerk genannt, es ist über einen Router mit dem Internet verbunden.
*  Optional kann z.B. für WLAN-Accesspoints ein weiteres Netzwerk aufgebaut werden (BLAU), für welches andere Zugangsberechtigungen als denen im grünen Netzwerk gelten.
*  Ebenso optional kann eine sog. demilitarisierte Zone (DMZ) als zusätzliches Netzwerk (ORANGE) aufgebaut werden.

.. figure:: media/preamble/einfaches-netz.png
   :align: center
   :alt: Schematischer Aufbau eines Computernetzes mit linuxmuster.net.

   Schematischer Aufbau eines Computernetzes mit linuxmuster.net.

Hinweise für Profis
-------------------
Die linuxmuster.net-Lösung unterstützt auch komplexere Netzwerkstrukturen mit

* subnetting
* VLANS
* Bonding

Siehe dazu auch :doc:`Netzsegmentierung mit linuxmuster.net <../../systemadministration/network/subnetting-basics/index/>`


Checkliste
==========

Nutzen Sie die :download:`Checkliste
<./media/preamble/checklist/checklist.pdf>`, um alle während der
Installation gemachten Einstellungen festzuhalten. Es handelt sich um
ein PDF-Formular, Sie können es also auch am PC ausfüllen. Halten Sie
diese Checkliste bereit, wenn Sie den Telefon-Support in Anspruch
nehmen wollen.
