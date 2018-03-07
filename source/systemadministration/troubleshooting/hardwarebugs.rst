
.. _knownbugs-label:

==========================
Bekannte Hardware-Probleme
==========================


Fehlerhafte Atheros-Chipsätze
=============================

Mit der neuen Art und Weise LINBO über PXE zu booten kommen manche
Implementationen von Atheros-Chipsätzen nicht zurecht. Dies wirkt sich
dadurch aus, dass die Systeme beim Booten über das Netzwerk in einem
sehr frühen Stadium hängen bleiben.

Teste bitte vor dem Upgrade auf Linbo 2.3.x, ob Sie Systeme mit
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


Probleme mit Grafikkarten-Treibern
==================================

Der Linbo-64bit-Kernel enthält ab LINBO 2.3.31 (ca. Januar 2018) modularisierte Grafiktreiber.
Es könnte damit auf mancher Hardware der Start der Linbo-GUI fehlschlagen. In dem Fall sollte
man den Kernelparameter `nomodeset` in der `start.conf.example` ergänzen:

.. code-block:: console

   # /var/linbo/start.conf.example im Abschnitt [LINBO]
   [LINBO]
   ...
   KernelOptions = ... nomodeset
