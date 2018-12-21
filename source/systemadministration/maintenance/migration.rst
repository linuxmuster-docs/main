===============================
 Migration auf linuxmuster 7.0
===============================

Es wird eine Migration der Benutzerinformationen (Namen, Passwort,
Projekte), Computerinformationen (``workstations``), der Benutzerdaten
(`/home`), Tausch- und Projektverzeichnisse und der Geräte-Abbilder
(`/var/linbo`) unterstützt.

Nicht migriert werden Beschreibungen von Projekten, Quota-Tabellen und
Rollen, die Geräte bekommen. Diese müssen von Hand angepasst werden.

Voraussetzungen
===============

Es muss als Quellsystem linuxmuster.net in der Version 6.2 installiert
sein. Es ist sehr wahrscheinlich, dass auch ab Version 6.1 und 6.0
eine Migration funktioniert. Dies wurde nicht offiziell
getestet. (Stand: Dez. 2018)

Wer eine alte paedML Linux (zwischen Version 4.0.6 und 5.1.0) besitzt,
für den kann der `Upgradepfad
<http://docs.linuxmuster.net/de/v62/systemadministration/migration/index.html>`_
über eine Migration zu einer linuxmuster.net 6.2 eine Option sein.

Die Migration wird in die Standard-Schulinstanz `default-school` vorgenommen.

Vorgehen
--------

1. Zunächst installiert man auf dem Quellsystem (Version 6.x) das
   Paket `sophomorix-dump` und exportiert die Daten  (ca. 15MByte).
    
2. Danach importiert man diese Daten auf einem Zielsystem (Version
   7.x) und rekonstruiert dort Benutzer, Passwörter, Projekte und
   Geräte, etc.
 
Export der Daten unter linuxmuster.net 6.x
==========================================

Der Server 6.x muss sich in einem synchronisierten Zustand befinden,
d.h. der Befehl auf der Konsole ``sophomorix-check`` darf keine
hinzuzufügenden oder zu verändernden Benutzer anzeigen.
Dafür führt man folgende Schritte als `root` nacheinander aus:

.. code-block:: console

   # sophomorix-check
   ...
   # sophomorix-add
   ...
   # sophomorix-move
   ...
   # sophomorix-kill
   ...

Jetzt sollte ein ``sophomorix-check`` keine Benutzer mehr verändern
wollen.

sophomorix-dump installieren
----------------------------

Installiere jetzt ``sophomorix-dump`` aus dem babo-Repository oder
lade das entsprechende Debian-Paket von der Webseite herunter

.. code-block:: console

   server ~ # apt-get update
   server ~ # apt-get install sophomorix-dump
   ...
   sophomorix-dump (3.63.2-1) wird eingerichtet ...

Alternativ kannst du (z.B. wenn du das babo-Repository nicht
einbinden kannst) unter http://pkg.linuxmuster.net/babo/ die
neueste Version `sophomorix-dump_u.v.w-z_all.deb` herausfinden,
herunterladen und installieren:

.. code-block:: console

   server ~ # wget http://pkg.linuxmuster.net/babo/sophomorix-dump_3.63.2-1_all.deb
   server ~ # dpkg -i sophomorix-dump_3.63.2-1_all.deb
   ...
   sophomorix-dump (3.63.2-1) wird eingerichtet ...

Daten exportieren
-----------------

Führe das Skript ``sophomorix-dump`` aus

.. code-block:: console

   server ~ # sophomorix-dump
   ...
       * Dump OK: /root/sophomorix-dump/data/etc/linuxmuster/subnets
   ########### End: Results of dump ##########
   WARNINGs in Results of dump are OK:
   
     /etc/sophomorix/virusscan/sophomorix-virusscan-excludes.conf
     /etc/sophomorix/virusscan/sophomorix-virusscan.conf
     /var/lib/sophomorix/virusscan/penalty.db
       are only needed, if you had configured sophomorix for scanning viruses

Die Zusammenfassung zeigt Fehler und Warnungen an. Warnungen und der folgende Fehler:
``ERROR dumping: /root/sophomorix-dump/data/etc/sophomorix/user/mail/*`` könnnen ignoriert werden.

Die exportierten Daten (bis zu 15MByte) liegen jetzt in
``/root/sophomorix-dump``. Kopiere dieses Verzeichnis auf den Server
mit Version 7.x.


Import der Daten unter linuxmuster.net 7.x
==========================================
