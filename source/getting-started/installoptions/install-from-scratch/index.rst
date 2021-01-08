.. _install-from-scratch-label:

====================
Install from Scratch
====================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_


In diesem Dokument findest du eine "Schritt-für-Schritt" Anleitung zur Installation der linuxmuster.net Musterlösung direkt auf der Hardware. 
Falls du die linuxmuster.net doch virtualisiert aufsetzen möchtest, aber lieber alles selbst installierst, bist du in dieser Anleitung ebenfalls richtig.

Lies zuerst die Abschnitte :ref:`what-is-new-label` und
:ref:`prerequisites-label`, bevor du dieses Kapitel durcharbeitest.

Nach der Installation gemäß dieser Anleitung erhältst du eine
einsatzbereite Umgebung bestehend aus
 
* einer Firewall (OPNsense® für linuxmuster.net), 
* und einem Server (linuxmuster.net).

Im Laufe der Installation brauchst du einen Admin-PC. Das kann ein normaler Laptop mit Linux oder Windows als Betriebssystem sein. 

**Vorgehensweise**

* Zunächst installieren wir die Firewall OPNsense®.
* Dann integrieren wir den Admin-PC in das Schulnetz.
* Jetzt konfigurieren wir die OPNsense® über das Webinterface.
* Schließlich installieren wir den Ubuntu-Server und richten linuxmuster.net ein.

.. toctree::
   :caption: Menü 
   :maxdepth: 2

   buildopnsense
   buildserver

