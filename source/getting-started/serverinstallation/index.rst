====================================
 Installation und Erstkonfiguration
====================================

Der Installationsablauf ist
  
  #. KVM/Proxmox-Host vorbereiten
  #. OVA-Abbilder herunterladen, einspielen und aktualisieren
  #. Anpassung der Festplattenkapazitäten an eigene Bedürfnisse
  #. Start der Installation und Erstkonfiguration


KVM vorbereiten
===============

Netzwerk
--------

- KVM Host stellt eine virtuelle Bridge br0 über eth0 bereit, das mit
  dem Internet-Router verbunden ist.
- KVM-Host stellt eine virtuelle Bridge br1 über eth1 bereit, das mit
  dem grünen Netzwerk verbunden ist.

Storage
-------

- KVM-Host stellt ein LVM bereit auf dem für Server, Firewall und Daten
  Logische Volumes erstellt werden können.

Download der Abbilder
=====================

- wget OVAs: Server, Firewall, Opsi, Docker

Anpassung der Festplattenkapazitäten
====================================

Die Festplatten der Firewall, des Opsi und des Docker-Abbildes können
unverändert übernommen werden. Die Festplattenkapazitäten des
Server-Abbildes sollte an die eigenen Bedürfnisse angepasst werden.



Import der Firewall
===================

Nach dem ersten Start mit `root` und `Muster!` einloggen. Es erscheint
das OPNsense Konsolenmenü.

Unter dem Menüpunkt `1` müssen nun die Netzwerk-Schnittstellen neu
zugeordnet werden. Unter KVM heißen die Adapter vtnet0, vtnet1, usw.
