.. _install-from-scratch-label:

====================
Install from Scratch
====================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_


In diesem Dokument findest du eine "Schritt für Schritt" Anleitungen zum
Installieren der linuxmuster.net-Musterlösung direkt auf der Hardware.
Lies zuerst die Abschnitte :ref:`release-information-label` und
:ref:`prerequisites-label`, bevor du dieses Kapitel durcharbeitest.

Voraussetzungen
===============

* Es steht zwei Hardware-Server und eine funktionierende Netzwerkverbindung zur Verfügung.

Nach der Installation gemäß dieser Anleitung erhältst du eine
einsatzbereite Umgebung bestehend aus
 
* einer Firewall (OPNsense für linuxmuster.net), 
* einem Server (linuxmuster.net) und
* einem Admin PC ebenfalls als VM. 

Natürlich kann der Admin PC auch ein normaler Laptop mit Linux oder Windows als Betriebssystem sein. 

Vorgehensweise
==============

* Zunächst installieren wir die Firewall OPNSense.
* Dann Integrieren wir den Admin PC ins Schulnetz.
* Jetzt konfigurieren wir die OPNSense über das Webinterface.
* Schließlich installieren wir den Ubuntu-Server und richten linuxmuster.net ein.

.. toctree::
   :caption: Menü 
   :maxdepth: 2

   buildopnsense
   buildserver

