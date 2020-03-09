.. _install-on-proxmox-label:

============================
 Virtualisierung mit Proxmox
============================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

.. note::

   Achtung: Abschnitt ist noch fertigzustellen - work in progess

Proxmox ist eine OpenSource-Virtualisierungsplattform. diese kombiniert KVM- und 
Container-basierte Virtualisierung und vewaltet virtuelle Maschinen, Container,
Storage, virtuelle Netzwerke und Hochverfügbarkeits-Cluster übersichtlich über die zentrale 
Managmentkonsle.

Das web-basierte Verwaltungs-Interface läuft direkt auf dem Server, so dass kein 
zusätzlicher PC für die Verwaltung und den Zugriff auf die Virtualisierungsplattform 
benötigt wird.

In diesem Dokument findest Du "Schritt-für-Schritt" Anleitungen für die
Installation der linuxmuster.net-Musterlösung in der Version 7 auf
Basis von Proxmox. 

Für die Installation mit Proxmox und linuxmuster v7 wird der 
``IP-Bereich 10.0.0.0/16`` genutzt. Es gilt nachstehende Zuordnung
der IPs zu den VMs bzw. genutzten Hosts.

+--------------+--------------------+
| VM           | IP                 | 
+==============+====================+
| OPNsense     | 10.0.0.254/16      |
+--------------+--------------------+
| Server       | 10.0.0.1/16        | 
+--------------+--------------------+
| OPSI         | 10.0.0.2/16        | 
+--------------+--------------------+
| Dockerhost   | 10.0.0.3/16        |
+--------------+--------------------+
| Proxmox      | 10.0.0.10/16       |
+--------------+--------------------+

Lies zuerst die Abschnitte :ref:`release-information-label` 
und :ref:`prerequisites-label`, bevor Du dieses Kapitel durcharbeitest.

Nach der Installation gemäß dieser Anleitung erhältst Du eine
einsatzbereite Umgebung bestehend aus

* einem Host (Proxmox) für alle virtuellen Maschinen, 
* einer Firewall (OPNsense)  
* einem Server (linuxmuster.net)

Ähnliche, nicht dokumentierte, Installationen gelten für einen
OPSI-Server und einen Docker-Host, die dann ebenso auf dem Proxmox-Host
laufen können.

Voraussetzungen
===============

* Der Internetzugang des Proxmox-Hosts sollte zunächst gewährleistet sein, 
  d.h. dass dieser zunächst z.B. an einem Router angeschlossen wird. Sobald später 
  die Firewall OPNSense korrekt eingerichtet ist, bekommt der Proxmox-Host eine
  IP-Adresse im Schulnetz.

.. hint:: 

   Virtualisierungs-Hosts sollten grundsätzlich niemals im gleichen Netz wie 
   andere Geräte sein, damit dieser nicht von diesen angegriffen werden kann.
   In dieser Dokumentation wird zur Vereinfachung der Fall dokumentiert, dass
   der Proxmox-Host sich im internen Schulnetz befindet.

Bereitstellen des Proxmox-Hosts
===============================

.. hint:: 

   Der Proxmox-Host bildet das Grundgerüst für die Firewall *OPNsense* und
   den Schulserver *server*. Die Virtualisierungsfunktionen der CPU sollten 
   zuvor im BIOS aktiviert worden sein.

Die folgende Anleitung beschreibt die *einfachste* Implementierung
ohne Dinge wie VLANs, Teaming oder RAID. Diese Themen werden in
zusätzlichen Anleitungen betrachtet.

* :ref:`Anleitung Netzwerksegmentierung <subnetting-basics-label>` 

Download-Quellen
----------------

Die Download-Quellen für den Proxmox-Host selbst finden sic hier:

https://www.proxmox.com/de/downloads

Dort findet sich das ISO-Image zur Installation von Proxmox (derzeit Version 6.1-1).

Laden Sie dieses Image herunter und erstellen Sie einen bootfähigen USB-Stick zur weiteren installation.

Die Proxmox-VMs finden Sie als ``vma.lzo`` Dateien zum direkten Import in Proxmox unter nachstehendem Link:

https://www.netzint.de/education/downloads/education-proxmox70

Laden Sie sich dort die gewünschten VMs herunter.


Erstellen eines USB-Sticks zur Installation des Proxmox-Host
------------------------------------------------------------

USB-Stick erstellen: Nachdem Sie die ISO-Datei für Proxmox heruntergeladen haben,
wechseln Sie in das Download-Verzeichnis. Ermitteln Sie den korrekten Buchstaben für 
den USB-Stick unter Linux. X ist durch den korrekten Buchstaben zu ersetzen und 
dann ist nachstehender Befehl einzugeben:

.. code-block:: console
 
   dd if=proxmox-ve_6.1-1.iso of=/dev/sdX bs=8M status=progress oflag=direct


Installieren von Proxmox
------------------------

Vom USB-Stick booten, danach erscheint folgender Bildschirm:

.. figure:: media/image_1.png
   :align: center
   :alt: Schritt 1 

Wäheln Sie ``Install Proxmox VE`` und starten Sie die
Installtion mit ``ENTER``.

.. figure:: media/image_2.png
   :align: center
   :alt: Schritt 2

Bestätigen Sie das ``End-User Agreement`` mit ``Enter``.

.. figure:: media/image_3.png
   :align: center
   :alt: Schritt 3

Wählen Sie die gewünschte Festplatte auf dem Server zur 
Installation aus. Haben Sie mehrere einzelne Festplatten im Server
verbaut und kein RAID-Verbund definiert, so können Sie an dieser
Stelle in der INstallation mithilfe der Schaltfläche ``Optionen``
weitere Einstellungen aufrufen. Hier können Sie z.B. mehrere Festplatten 
angeben, die in einem ZFS-Pool definiert werden sollen. Dies ist für das
Erstellen von sog. Snapshots von Vorteil. Soll aber an dieser Stelle 
nicht vertieft werden.

.. figure:: media/image_4.png
   :align: center
   :alt: Schritt 4

Legen Sie ein Kennwort für den Administrator des Proxmox-Host und eine E-Mail
Adresse fest. Klicken Sie auf ``Weiter``.

.. figure:: media/image_5.png
   :align: center
   :alt: Schritt 5

Legen Sie die IP-Adresse des Proxmox-Host im internen Netz fest. Hier wurde die 
interne IP-Adresse ``10.0.0.10/16`` festgelegt.

.. figure:: media/image_6.png
   :align: center
   :alt: Schritt 6

Bestätigen Sie den Installationsfortgang.

.. figure:: media/image_7.png
   :align: center
   :alt: Schritt 7

.. figure:: media/image_8.png
   :align: center
   :alt: Schritt 8

Starten Sie den Host neu und melden Sie sich als Benutzer ``root`` mit dem bei der Installation
festgelegten Kennwort am Proxmox-Host an.

.. figure:: media/image_9.png
   :align: center
   :alt: Schritt 9

.. figure:: media/image_10.png
   :align: center
   :alt: Schritt 10

.. figure:: media/image_11.png
   :align: center
   :alt: Schritt 11 

.. figure:: media/image_12.png
   :align: center
   :alt: Schritt 12





