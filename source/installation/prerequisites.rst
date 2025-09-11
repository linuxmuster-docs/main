
.. _prerequisites-label:

==================
 Vorüberlegungen
==================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_

Linuxmuster.net wird als Zwei-Server-Lösung (Firewall und linuxmuster.net-Server) auf einem Hypervisor (Proxmox) betrieben. 

Optional können weitere Server wie z. B. ein Docker-Host eingesetzt werden. Daneben gibt es mindestens eine Trennung in zwei logische Netzwerke, meist sind aber drei oder mehr davon gefordert (WLAN, DMZ, Lehrernetz).

Daraus leiten sich Voraussetzungen an Hardware, Netzwerkstrukturen und Software ab, die in diesem Kapitel benannt werden.

Hardware
========

OPNsense®
---------

OPNsense® ist für x86-32 und x86-64 Bit Architekturen verfügbar und kann auf SD-Karte, SSDs oder HDDs installiert werden. Folgende Mindestanforderung muss erfüllt sein:

==================== ==================================
Prozessor            >= 1.5 GHz Multi-Core CPU (64 Bit)
RAM                  >= 4 GiB
Installationsmethode Video (VGA)
Festplatte           mind. 20 GByte, z.B. 120 GByte SSD
NIC                  - mind. 2 (intern + extern)
                     - oder  3 (intern + extern + WLAN)
==================== ==================================

.. attention::

   Die Firewall erstellt viele Log-Einträge, so dass der Festplattenplatz und zudem auch der Arbeitsspeicher deutlich über der Mindestanforderung liegen sollten. Als Standard
   schreibt die OPNsense Einträge für einen 30 Tageszeitraum mit. Wir raten, den Zeitraum in den Einstellungen (``System --> Einstellungen --> Protokollierung``) 
   individuell zu verkleinern und nur bei Bedarf und ausreichendem Plattenplatz zu erhöhen. Ein logrotate müsste bei Bedarf in der crontab angelegt werden.

   Empfehlung: RAM --> 8GiB, HDD --> 50GiB


Weitere Hinweise zu möglichen Hardwareanforderungen bei unterschiedlichen Einsatzszenarien finden sich `hier <https://wiki.opnsense.org/manual/hardware.html#hardware-requirements>`_.

Als Basis nutzt OPNsense® v24.1 das Betriebssystem FreeBSD v13.2. Hinweise zu den Anforderungen von FreeBSD bzw. zur Kompatibilität mit eingesetzten Hardware-Komponenten finden sich unter der `HCL - Hardware Compatibility List <https://www.freebsd.org/releases/11.1R/hardware.html>`_.


Server linuxmuster v7.2
-----------------------

Für linuxmuster.net v7.2 wird als Basis Ubuntu Server 22.04 LTS eingesetzt. Es wird empfohlen folgende Hardware-Mindestanforderungen zu erfüllen:

========================= ===========================================
Prozessor                 >= 2 GHz Multi-Core CPU (64 Bit)
RAM                       >= 4 GByte
Festplatte System + Daten - mind. 25 GiB + 100 GiB
                          - mind. 500 GiB für Daten und Backup
                          - empfohlen >= 1 TiB
========================= ===========================================

Festplattenspeicher
-------------------

Der Festplattenplatz für den Server hängt stark von der Nutzerzahl und der intensiven Verwendung von LINBO-Abbildern ab. Ebenso muss für Backups weiterer Festplattenplatz z.B. auf einem NAS eingeplant werden.

Selbstverständlich können sowohl Daten als auch (bei Virtualisierung) die Server auf externem Speicher abgelegt werden (z. B. NFS-Speicher oder iSCSI-Speicher), um die Virtualisierungsumgebung ggf. bei Bedarf ausbauen zu können und auch ausfallsichere Szenarien leichter umsetzen zu können.

So *kann* bei minimaler Ausstattung einer mittleren Schule (ca. 500 Benutzer) ein kleiner Server oder ein gut ausgestatteter PC ausreichend sein, selbst wenn alle Server virtualisiert laufen.

========== ======== ========== =========== ======== =========
\                          Festplatten            RAM
---------- -------- ---------------------- ------------------
Schule     Features Standard   Empfohlen   Standard Empfohlen
========== ======== ========== =========== ======== =========
mittelgroß minimal  ~650 GByte 1500+ GByte 8 GByte  16+ GByte
groß       normal   ~1000GB    2000GB+     10GB     16GB+
========== ======== ========== =========== ======== =========

..
  .. hint::
  Abbilder für drei verschiedene Hardwareklassen haben ca. 40G. Von jedem Image sollen drei Kopien vorgehalten werden, dann ist man schon bei 120G benötigtem Festplattenplatz alleine für die Arbeitsplätze.
  
  Auch im Verzeichnis ``/home`` oder im Cloud-Speicher sollte man Platz pro Benutzer einplanen. Bei 5GB für 100 Lehrer und 500MB für 1000 Schüler kommt man auf weitere 1000GB.


.. _`net-infrastructure-label`:

Netzwerkstruktur
================

In Abhängigkeit vom Einsatzszenario muss die Netzwerkstruktur der linuxmuster.net zu Beginn der Installation angepasst werden. Man sollte vor der Installation über den Umfang der eingesetzten Geräte Bescheid wissen. Dementsprechend den IP-Bereich nicht zu klein wählen, oder Subnetze einführen. Ebenso muss man den IP-Bereich auf die Umgebung (z.B. Verwaltungsnetz, extern vorgegebene Netze) abstimmen, damit keine Überschneidungen auftreten.

IP-Bereiche
-----------

Die linuxmuster.net-Lösung kann mit unterschiedlichen IP-Bereichen arbeiten. Standardmäßig wird das interne Netz aus dem privaten IPv4-Bereich 10.0.x.x mit der
16-Bit Netzmaske 255.255.0.0 (/16) eingerichtet.

Andere private Adressbereiche sind prinzipiell möglich, müssen aber händisch vorbereitet werden. :ref:`modify-net-label`

Standard IP-Adressen
--------------------

Einige IP-Adressen sind für spezielle Server/Dienste vorgesehen:

========== ===========
Server     IP-Bereich
           10.0.0.0/16
========== ===========
OPNsense®  10.0.0.254
Server     10.0.0.1
Admin-PC   10.0.0.10
========== ===========

Netz-Grundstruktur
------------------

Die Aufteilung der Netzbereiche mit linuxmuster.net sind in der Dokumentation mit Farben gekennzeichnet, um diese deutlich voneinander abzuheben:

.. figure:: media/simple-network.png
   :align: center
   :alt: Schematischer Aufbau eines Computernetzes mit linuxmuster.net.

   Schematischer Aufbau eines Computernetzes mit linuxmuster.net.


* Das interne Netzwerk wird GRÜNES Netzwerk (GREEN) genannt.
* Das externe Netzwerk wird ROTES Netzwerk (RED) genannt, es ist über einen Router mit dem Internet verbunden.
* Optional kann z.B. für WLAN-Accesspoints ein weiteres Netzwerk aufgebaut werden (BLAU - BLUE), für welches andere Zugangsberechtigungen als im grünen Netzwerk gelten.
* Optional kann eine sog. demilitarisierte Zone (DMZ) als zusätzliches Netzwerk (ORANGE) aufgebaut werden, um z.B. extern zugängliche Web-Services bereitzustellen.

Daraus ergeben sich folgende Mindestvoraussetzungen für einen Virtualisierungshost:

* mindestens zwei Netzwerk-Interfaces (rotes und grünes Netz)
* bei WLAN-Nutzung eine zusätzliche Netzwerkkarte (blaues Netz)
* sollen Serverdienste im Internet von außen zugänglich sein, empfehlen wir diese in die DMZ auszulagern. Dafür wird eine weiteres Netzwerk-Interface benötigt (oranges Netz)

Durch die fortschreitende Digitalisierung in der Bildung ist der Auf- bzw. Ausbau einer funktionalen WLAN-Infrastruktur für jede Schule eine gute Entscheidung. Daraus ergibt sich aus unserer Sicht die Empfehlung zu mindestens drei Netzwerkkarten. Willst Du für alle möglichen Einsatzszenarien gut gerüstet sein, empfiehlt sich allerdings gleich den Virtualisierungshost mit vier und mehr Netzwerk-Interfaces auszulegen.

Das obige Prinzip ist bereits ein Beispiel für die Netzwerksegmentierung, die im nächsten Abschnitt näher erläutert wird.


Getrennte Netze und VLAN
------------------------

Immer häufiger (z.B. durch Vorgaben vom Kultusministerium oder Lastverteilung) besteht Bedarf an einer weiteren Trennung des internen Netzes in mehrere logisch voneinander getrennte Netze. Neben den getrennten Netzen für WLAN oder eine demilitarisierte Zone (DMZ) wie oben abgebildet, erlaubt linuxmuster.net sehr flexibel eine beliebige Einteilung des Schulnetzes in Subnetze.

Wer vor der Entscheidung steht, Subnetze und/oder VLANs einzurichten, sollte zuvor das Kapitel :ref:`Netzsegmentierung mit linuxmuster.net <subnetting-basics-label>` lesen.


Virtualisierung
===============

Wenn man linuxmuster.net virtualisiert betreibt, gelten zu den obigen Voraussetzungen noch folgende Hinweise:

* Das Netzwerk wird virtualisiert. Dadurch werden virtuelle Switche ("sog. bridges") erstellt, denen die richtigen Schnittstellen zugeordnet werden müssen.

  Wird kein Layer 3 - Switch eingesetzt, sollte der Virtualisierungshost (Hypervisor) wenigstens mit der obengenannten Anzahl von Netzwerkkarten ausgestattet sein.

  Mit dem Einsatz eines Layer 3 - Switches wird die Konfiguration auf dem Hypervisor schnell komplex, die physikalische Verkabelung kann dadurch aber einfacher werden. So lassen sich auch neue Anforderungen durch zusätzliche VLANs realisieren.

* Der Speicherplatz wird virtualisiert. Darauf muss man bei der Verwendung externer (iSCSI/NFS) wie interner Speichersysteme (LVM) achten. Dies kann auch zur Vereinfachung eines Backupverfahrens beitragen. Es wird empfohlen sog. ``Shared Storage`` bei der Virtualisierung einzusetzen, um dadurch flexibler bei der Erweiterung zu sein (z.B. NAS-System mit iSCSI oder NFS-Anbindung).

* Da der VM-Host die einzelnen VMs kapselt, ist es aus Sicherheitsgründen empfehlenswert, diesen in ein eigenes Netzsegment zu bringen. Der VM-Host sollte nicht im internen Netz der VMs sein.

Hypervisoren
------------

Die Voraussetzungen für einen virtualisierten Betrieb besteht natürlich darin, vorab den Hypervisor/den VM-Host installiert zu haben und Zugriff auf dessen Verwaltung zu haben.

Wo es uns möglich ist, haben wir eine Anleitung dazu geschrieben, um auf die Besonderheiten der Schulnetzumgebung an geeigneter Stelle hinzuweisen.
