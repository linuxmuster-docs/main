.. include:: ../../guided-inst.subst

.. _adjusting_hard_drive_size-label:

=============================
Anpassen der Festplattengröße
=============================
.. sectionauthor:: `@toheine <https://ask.linuxmuster.net/u/toheine>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

Must Du aufgrund geänderter Anforderungen die bereits eingerichteten Festplattengrößen in Deiner Virtualisierungsumgebung ändern,
dann ist es hilfreich, sich an nachstehend beschriebenen Ablauf und Hinweisen zu orientieren.


Übersicht zum Vorgehen
----------------------

Folgender Ablauf zur Anpassung der Festplattengrößen ist einzuhalten:

1. In der Virtualisierungsumgebung ein Snapshot der VM ausführen. Auf diesen Stand
   kannst Du zurückkehren, sofern bei den nachfolgenden Schritten etwas nicht funktioniert.
2. In der Virtualisierungsumgebung die HDDs der VM erweitern.
3. Größenänderung in den VMs bekannt machen.

.. hint::

   Die VM der OPNsense® benötigt bei der Anpassung ein etwas anderes Vorgehen, da hier ein 
   BSD Linux zum Einsatz kommt. Die entsprechenden Hinweise finden sich im entsprechenden Abschnitt 

Anpassung Hypervisor
--------------------

Starte nun mit Punkt 1, indem Du nachstehend Deine eingesetzte Virtualisierungsumgebung auswählst und
gemäß der Dokumentation die Festplattengröße Deiner VMs im Hypervisor anpasst.

.. toctree::
   :maxdepth: 2
   :caption:  Festplatten-Anpassung
   :hidden:  

   hard-drive-size-proxmox
   hard-drive-size-vm
   hard-drive-size-opnsense-vm
   
