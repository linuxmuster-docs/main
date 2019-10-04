.. _install-on-proxmox-label:

============================
 Virtualisierung mit Proxmox
============================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_


In diesem Dokument findest du eine "Schritt für Schritt" Anleitungen zum
Installieren der linuxmuster.net-Musterlösung in der Version 7.0 auf
einem Proxmox-Host. 
Lies zuerst die Abschnitte :ref:`release-information-label` und
:ref:`prerequisites-label`, bevor du dieses Kapitel durcharbeitest.

Voraussetzungen
===============

* Der Proxmox-Host ist bereits installiert.
* Die iso-Images für OPNSense, Ubuntu-Server 18.04 und optional Ubuntu-Desktop sind für den Proxmox-Host erreichbar.

Nach der Installation gemäß dieser Anleitung erhältst du eine
einsatzbereite Umgebung bestehend aus
 
* einer Firewall (OPNsense für linuxmuster.net) als virtuelle Maschine (VM), 
* einem Server (linuxmuster.net) als VM und
* einem Admin PC ebenfalls als VM. Natürlich kann der Admin PC auch ein normaler Laptop mit Linux oder Windows als Betriebssystem sein. 

Das folgenden Bild zeigt schematisch eine einfache Form der Implementierung der
Musterlösung mit dem gewählten (Standard-)Netzwerk ``10.0.0.0/16``:

.. figure:: media/install-on-proxmox-image01.png

Ähnliche, nicht dokumentierte, Installationen gelten für einen
OPSI-Server und einen Docker-Host, die dann ebenso auf dem Proxmox-Host
laufen können.

Vorgehensweise
==============

* Zunächst erzeugen wir eine VM für die Firewall OPNSense.
* Dann Integrieren wir den Admin PC ins Schulnetz.
* Jetzt konfigurieren wir die OPNSense über das Webinterface.
* Schließlich installieren wir den Ubuntu-Server und richten linuxmuster.net ein.

.. toctree::
   :caption: Menü 
   :maxdepth: 2

   buildopnsense
   buildserver

