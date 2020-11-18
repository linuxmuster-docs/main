.. include:: /guided-inst.subst

.. _hard_drive_size_opnsense_vm-label:

===================================================
Aktualisieren der Festplattengrößen der OPNSense VM
===================================================

.. hint::

   Achtung: Diese Dokumentation ist noch nicht ganz fertig und muss weiter getestet werden
   Diesen Abschnitt must du nur ausführen, sofern du in deinem Hypervisor die HDD-Größe der OPNSense bereits vergrößert hast.
   Ansonsten kannst Du bei der Einrichtung mit dem Kapitel ``Netzbereich anpassen`` fortgahren.
   
==================== ======================
Netzbereich anpassen |follow_me2modify-net|
==================== ======================
   
Überblick
---------
OPNSense basiert auf FreeBSD, so dass abweichend zu dem beschriebenen Vorgehen zur Erweiterung der Festplattengröße der
Server-VM das Vorgehen abweicht.

Um die Festplattengröße für die OPNsense zu erweitern ist wie folgt vorzugehen:


0.  Zuerst ein Snapshot der OPNsense VM erstellen. Auf diesen Stand kannst Du zurückkehren, falls bei den nachstehenden Schritten Fehler auftreten.  
1.  Im Hypervisor die Größe für die Festplatte der OPNSense erweitern (im ausgeschalteten Zustand).
2.  VM starten.
3.  In der Konsole  ``df -h`` angeben
4.  gpart show
5.  Dort wird unterhalb von MBR ein freier Bereich angezeigt
6.  gpart resize -i 1 ada0 (sofoern vorher als Device auch ada0 angezeigt wurde)
7.  gpart resize -i 1 ada0
8.  gpart show ada0
9.  gpart resize -i 1 ada0s1 (es wird die root partition vergrößert - unsere vm hat ja nur diese)
10. gpart show ada0s1
11. df -h
12. ggf. Neustart

Vorgehen
--------

Die o.g. wesentlichen Schritte werden nachstehend mit Screenshots verdeutlicht:

Schritt 1

   .. figure:: media/01-opnsense-resize-hdd-show.png
     :align: center
     :alt: HDD-resize: show
   
Schritt 2   
   
   .. figure:: media/02-opnsense-resize-hdd-df.png
     :align: center
     :alt: HDD-resize: df
   
Schritt 3
   
   .. figure:: media/03-opnsense-resize-hdd-gpart-show.png
     :align: center
     :alt: HDD-resize: gpart show

Schritt 4
   
   .. figure:: media/04-opnsense-resize-hdd-resize.png
     :align: center
     :alt: HDD-resize: gpart resize
   
   
Weiterführende Erklärungen zu FreeBSD zu diesem Thema findest du hier: 

  https://unix.stackexchange.com/questions/117023/expanding-the-disk-size-on-pfsense-under-vmware-esxi
      
 



.. 
   =================================== ======================
   Vorbereiten der Proxmox-Festplatten |follow_me2proxmox-hd|
   Vorbereiten der XCP-ng-Festplatten  |follow_me2xcp-ng-hd|
   Vorbereiten der KVM-Festplatten     |follow_me2kvm-hd|
   =================================== ======================

