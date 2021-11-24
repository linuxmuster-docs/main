.. include:: /guided-inst.subst

.. _adjusting_hard_drive_size-label:

=============================
Anpassen der Festplattengröße
=============================
.. sectionauthor:: `@toheine <https://ask.linuxmuster.net/u/toheine>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
.. hint::

   Achtung: Dies ist noch eine unvollständige Beschreibung. Findest du Fehler oder kannst zur Verbesserung beitragen, dann wende dich bitte an einen der Autoren des Abschnittes.
   
   
Hast du die vorbereiteten VMs in die jeweilige Virtualisierungsplattform importiert, so 
weisen die virtuellen Festplatten der VMs noch die Größen auf, die nicht auf deine schulische
Situation und Bedürfnisse bzw. auf deine IT-Infrastuktur angepasst sind.

Nachstehende Übersicht zeigt dir, die voreingestellten HDD-Größen in den VMS und
die empfohlenen Größen bei produktivem Betrieb der lmn7. Letzteres hängt von der Größe
der Schule und deinen Anforderungen ab.

Bei Ablage von mehreren Images für die linuxmuster Clients ist es zu empfehlen, hier
deutlich mehr HDD-Speicher für die Server VM zuzuordnen.


+---------------+-----------------+-----------------------+-------------+
| VM            | Anzahl HDDs     | Festplatten                         |
|               |                 +-----------------------+-------------+
|               |                 | Standard/Default (VM) | Empfohlen   |
+===============+=================+=======================+=============+
| server lmn7   | 2 HDDs          | hdd1:  25GB           | 150GB+      |
|               |                 |                       |             |
|               |                 | hdd2: 100GB           | 1000GB+     |
+---------------+-----------------+-----------------------+-------------+
| docker lmn7   | 1 HDD           |       100GB           |  200GB+     |
+---------------+-----------------+-----------------------+-------------+
| opsi lmn7     | 1 HDD           |       100GB           |  500GB+     |
+---------------+-----------------+-----------------------+-------------+
| opnsense lmn7 | 1 HDD           |        10GB           |  200GB+     |
+---------------+-----------------+-----------------------+-------------+


Übersicht zum Vorgehen
----------------------

Folgender Ablauf zur Anpassung der Festplattengrößen ist einzuhalten:

1. In der Virtualisierungsumgebung ein Snapshot der VM ausführen. Auf diesen Stand
   kannst du zurückkehren, sofern bei den nachfolgenden Schritten etwas nicht funktioniert.
2. In der Virtualisierungsumgebung die HDDs der VM erweitern.
3. Größenänderung in den VMs bekannt machen.

.. hint::

   Die VM der OPNsense® benötigt bei der Anpassung ein etwas anderes Vorgehen, da hier ein 
   BSD Linux zum Einsatz kommt. Die entsprechenden Hinweise finden sich im entsprechenden Abschnitt 

Anpassung Hypervisor
--------------------

Starte nun mit Punkt 1, indem du nachstehend deine eingesetzte Virtualisierungsumgebung auswählst und
gemäß der Dokumentation die Festplattengröße deiner VMs im Hypervisor anpasst.

=================================== ======================
Vorbereiten der Proxmox-Festplatten |follow_me2proxmox-hd|
Vorbereiten der XCP-ng-Festplatten  |follow_me2xcp-ng-hd|
Vorbereiten der KVM-Festplatten     |follow_me2kvm-hd|
=================================== ======================

.. ===================== ==========================
   Installationsoptionen |follow_me2installoptions|
   ===================== ==========================

.. toctree::
   :maxdepth: 2
   :caption:  Festplatten-Anpassung
   :hidden:  

   hard-drive-size-proxmox
   hard-drive-size-xcp-ng
   hard-drive-size-kvm
   
.. Anpassung VMs
   -------------

   Passe nun die Größe der Festplatten in den VMs selbst wie nachstehend beschrieben an.
   
.. toctree::
   :maxdepth: 2
   :caption:  Festplatten-Anpassung
   :hidden:  
   
   hard-drive-size-vm
   hard-drive-size-opnsense-vm

