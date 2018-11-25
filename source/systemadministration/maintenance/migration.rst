===============================
 Migration auf linuxmuster 7.0
===============================

.. toctree::
  :maxdepth: 2

  keep-lmn-uptodate/index
  backup-migration/index

Migration von linuxmuster.net 6.x
=================================

Es wird nur eine Migration der Benutzerinformationen (Namen, Passwort,
Projekte) und der Computerinformationen erfolgen. Die Benutzerdaten
(`/home`), Tauschverzeichnisse, die Geräte-Abbilder (`/var/linbo`),
evtl. Subnetze vom Netzwerkberater oder (wo möglich) von den Benuztern
selbst umgezogen werden.

Voraussetzungen
---------------

Es muss als Quellsystem linuxmuster.net in der Version 6.2 installiert
sein. Es ist sehr wahrscheinlich, dass auch von der Version 6.1 und
6.0 eine Migration funktioniert. Dies wurde nicht offiziell
getestet. (Stand: Nov. 2018)

Von einer paedml Linux (mind. Version 4.0.6, max. 5.1.0) existiert ein
`Upgradepfad
<http://docs.linuxmuster.net/de/v62/systemadministration/migration/index.html>`_
über eine Migration zu einer linuxmuster.net 6.2. 

Die Migration wird in die Standard-Schulinstanz `default-school` vorgenommen.


Vorgehen
--------

1. Zunächst installiert man auf dem Quellsystem (Version 6.x) das
   Paket `sophomorix-dump` installieren und die Daten exportieren
   (ca. 15MByte)
    
2. Danach importiert man diese Daten auf einem Zielsystem (Version
   7.0) und rekonstruiert dort Benutzer, Passwörter, Projekte und
   Geräte.
 


