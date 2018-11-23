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

Download des Systems
====================

- wget OVAs: Server, Firewall, Opsi, Docker


Anpassung der Festplattenkapazitäten
====================================


Start der Installation und Erstkonfiguration
============================================
