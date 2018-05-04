=================
 Voraussetzungen
=================

Linuxmuster.net wird als Zwei-Server-Lösung (Firewall und
linuxmuster.net-Server) betrieben. Jeder der Server kann "auf dem
Blech" installiert werden, sofern die Hardware-Voraussetzungen für die
Firewall (standardmäßig opnsense) und den Server (Ubuntu) gegeben
sind.

Hardware
========

:fixme: https://github.com/linuxmuster-docs/main/issues/128

Virtualisierung
===============

KVM/qemu als Hypervisor
-----------------------

- Proxmox als Virtualisierungslösung

Xen als Hypervisor
------------------

- XenServer als Virtualisierungslösung

:fixme: https://github.com/linuxmuster-docs/main/issues/130


VMWare als Hypervisor
---------------------

VirtualBox als Hypervisor
-------------------------

Software
========

Download der Software
---------------------
Lade dir zunächst die benötigte Software herunter, beachte dabei die Versionshinweise sorgfältig.

OpnSense
````````

:fixme: Download opnsense

Ubuntu Server 18.04 LTS
```````````````````````

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
```````````
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

Bei der Installation entscheiden Sie sich für einen der Bereiche. Liegen keine besonderen Anforderungen (z.B. Testbetrieb von linuxmuster.net in einem weiteren produktiv laufenden linuxmuster.net-System) vor, wird empfohlen den Bereich 16-31 zu verwenden.  |br| Dies hat auch den Vorteil, dass alle im vorliegenden Dokument enthaltenen Screenshots bei einer Installation mit diesem Bereich gemacht wurden.

Netzwerknamen der Firewall-Lösung IPFire
````````````````````````````````````````
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
```````````````````
Die linuxmuster.net-Lösung unterstützt auch komplexere Netzwerkstrukturen mit

* subnetting
* VLANS
* Bonding

Siehe dazu auch :doc:`Netzsegmentierung mit linuxmuster.net <../network/subnetting-basics/index/>`


Checkliste
==========

Nutzen Sie die :download:`Checkliste
<./media/preamble/checklist/checklist.pdf>`, um alle während der
Installation gemachten Einstellungen festzuhalten. Es handelt sich um
ein PDF-Formular, Sie können es also auch am PC ausfüllen. Halten Sie
diese Checkliste bereit, wenn Sie den Telefon-Support in Anspruch
nehmen wollen.
