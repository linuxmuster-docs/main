===============================
 Migration auf linuxmuster 7.0
===============================

Umfang dieser Anleitung
=======================

Es wird nur eine Migration der Benutzerinformationen (Namen, Passwort,
Projekte) und der Computerinformationen unterstützt. Die Benutzerdaten
(`/home`), Tauschverzeichnisse, die Geräte-Abbilder (`/var/linbo`) und
evtl. Subnetze müssen vom Netzwerkberater oder (wo möglich) von den
Benutzern selbst umgezogen werden.

Voraussetzungen
===============

Es muss als Quellsystem linuxmuster.net in der Version 6.2 installiert
sein. Es ist sehr wahrscheinlich, dass auch ab Version 6.1 und 6.0
eine Migration funktioniert. Dies wurde nicht offiziell
getestet. (Stand: Nov. 2018)

Wer eine alte paedML Linux (zwischen Version 4.0.6 und 5.1.0) besitzt,
für den kann der `Upgradepfad
<http://docs.linuxmuster.net/de/v62/systemadministration/migration/index.html>`_
über eine Migration zu einer linuxmuster.net 6.2 eine Option sein.

Die Migration wird in die Standard-Schulinstanz `default-school` vorgenommen.

Vorgehen
========

1. Zunächst installiert man auf dem Quellsystem (Version 6.x) das
   Paket `sophomorix-dump` installieren und die Daten exportieren
   (ca. 15MByte)
    
2. Danach importiert man diese Daten auf einem Zielsystem (Version
   7.0) und rekonstruiert dort Benutzer, Passwörter, Projekte und
   Geräte.
 

