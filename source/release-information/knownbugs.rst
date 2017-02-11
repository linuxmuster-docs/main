
.. _knownbugs-label:

===================
 Bekannte Probleme
===================


Fehlerhafte Atheros-Chipsätze
=============================

Mit der neuen Art und Weise LINBO über PXE zu booten kommen manche
Implementationen von Atheros-Chipsätzen nicht zurecht. Dies wirkt sich
dadurch aus, dass die Systeme beim Booten über das Netzwerk in einem
sehr frühen Stadium hängen bleiben.

Testen Sie bitte vor dem Upgrade auf Linbo 2.3.x, ob Sie Systeme mit
Atheros-Chipsätzen besitzen.

Lösungsweg
----------

- Zunächst muss im BIOS die lokale Festplatte als Bootmedium
  eingestellt werden. Dabei sollte man überprüfen, ob in der
  jeweiligen start.conf die Cache-Partition als ``Bootable=yes``
  markiert ist.

- Ist das System in einem unbootbaren Zustand, muss man ein CD- oder
  USB-Bootmedium erstellen, um die lokale LINBO-Installation
  wiederherzustellen. Lesen Sie dazu die Anleitung in den
  Releaseinformationen von LINBO:
  :ref:`release-linbo-bootmedium-label`

Reparatur und Neuerstellen eines Abbildes nach Partitionierung
==============================================================


Ab Version 2.3.0 wird ein anderer Partitionsprogramm verwendet. Leider
kommt Windows mit einer Neupartitionierung nicht zurecht.  Im normalen
Betrieb gibt es keine Probleme. Erst dann, wenn Sie einen Computer neu
partitionieren müssen, quittiert Windows mit einer Fehlermeldung den
Dienst beim Start dieses Images:

.. code-block:: bash

   ...

   Status 0xc0000000e

   Info: The boot selection failed because a required device is inaccessible.


Lösungsweg
----------

Abhilfe schafft,

- Windows mit Hilfe der Boot-DVD zu reparieren (Systemstartreparatur),
- danach Windows ohne Synchronisation zu starten und wieder zu rebooten. 
- Beim Reboot erstellen Sie ein neues Image, das danach auf allen
  anderen Rechnern ausgerollt werden kann und auch nach einer neuen
  Partitionierung normal funktioniert.




