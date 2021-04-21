.. include:: /guided-inst.subst

.. _setup-label:

=================
Erstkonfiguration
=================

.. sectionauthor:: `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_, `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_


Vorgehen
========

Nachdem du in deiner Virtualisierungsumgebung die benötigten VMs importiert, angepasst und gestartet hast, geht es nun an die
Anpassung und Einrichtung von linuxmuster.net an deine Bedürfnisse.

Für das erstmalige Setup hast Du zwei Möglichkeiten dieses auszuführen. 
 
  1. Mithilfe einer graphischen Benutzeroberfläche (der sog. ``Web-UI``), die dir weitere Hinweise gibt und dich schrittweise durch das Setup führt.
  2. Mithilfe der Vorgabe von Konfigurationswerten in einer Setup-datei und dem Aufruf des Setup via Server-Konsole.

.. hint::

   Alle linuxmuster 6.x Systeme können statt einer Neuinstallation
   über eine :ref:`migration-label` umgezogen werden, dennoch ist die
   Erstkonfiguration hier eine notwendige Voraussetzung.

Festlegungen - Hinweise
=======================

* Nach Abschluss dieses Setups sind die Domäne und andere Details des
  Netzwerks permanent festgelegt und nur durch eine Neuinstallation
  änderbar. Es ist daher sinnvoll, zu diesem Zeitpunkt ein
  ``Snapshot/Backup`` von Server, Firewall und bei Benutzung von
  Dockerhost und OPSI-Host anzufertigen. Bei einem Fehlschlag müssen
  alle diese Maschinen zurückgesetzt werden.

* Während des Setups ist ein Domänenname anzugeben. Hierbei 
  ist zu beachten, dass der **erste** Teil der
  ``Domäne nicht länger als 15 Zeichen`` haben darf. Der Rechnername ist
  damit nicht gemeint. Im Beispiel ``server.linuxmuster.lan`` ist
  ``server`` der Rechner-Kurzname und ``linuxmuster.lan`` die
  Domäne. Dann darf ``linuxmuster`` nicht länger als 15 Zeichen sein.
* Will man eine andere (z.B. auch extern auflösbare) Domäne haben,
  muss man eventuell eine Subdomäne verwenden,
  bspw. ``linuxmuster.magical-animal-school.edu`` statt
  ``magical-animal-school.edu``. Der erste Part ``LINUXMUSTER`` wird
  in diesem Beispiel dann als SAMBA-Domäne verwendet. Der voll Name
  (FQHN) des Servers ist dann
  ``server.linuxmuster.magical-animal-school.edu``.
* Alle Hosts die im Setup konfiguriert werden sollen (docker(mail),
  OPSI) müssen bereits laufen.
* Systeme, die mit Hilfe der Migration auf linuxmuster.net 7.0
  migriert werden, können hier eine neue (oder die alte)
  konfigurieren.

====== ====================== ==========================================
  Nr.      Arbeitsschritt            Hinweis / Bemerkung
====== ====================== ==========================================
  1     Snapshots alles VMs    Sollten beim Setup Fehler auftreten,
        erstellen              kann so schnell gestartet werden.

  2     Domänenname festlegen  <subdomain/samba>.<Domain>.<tld>

                               Subdomain/Samba: max. 15 Zeichen

                               Domain intern: linuxmuster

                               Domain extern: meine-schule

                               TLD intern: lan

                               TLD extern: de

                               nach Möglichkeit externe URL angeben

  3     alle benotigten VMs   im Setup werden benötigte Dienste  
        vorher starten        abgefragt, so dass diese VMs laufen müssen
====== ====================== ==========================================


Anpassung des Netzbereiches
===========================

Die Standardkonfiguration wie sie über die Appliances mitgeliefert
wird, sieht vor, dass das Schulnetz die lokale Domäne
``linuxmuster.lan`` bekommt und Geräte im Netzbereich ``10.0.0.0/16``
stehen. Wenn ein anderer Netzbereich (z.B. der bisher beliebte
Netzbereich ``10.16.0.0/12``) verwendet werden soll, *muss* an dieser
Stelle eine Anpassung vorgenommen werden.

Systeme, die mit Hilfe der Migration auf linuxmuster.net 7.0 migriert
werden, sollten den bisherigen Netzbereich behalten. Für die Beibehaltung
des bisherigen Standards der v6.2 mit einem ``10.16.0.0./12`` Netz gibt
es den Begriff ``do-it-like-babo``.

.. hint::

   Die Anpassungen zur Netzkonfiguration sind vor der Ausführung der 
   Erstkonfiguration durchzuführen. Zur Durchführung der Anpassungen
   folge bitte dem Kapitel :ref:`modify-net-label`.

Setup
=====

Rufe nun mit nachstehenden Links, die von dir gewünschte Setup-Methode auf:

+--------------------------------------------------------------------+-------------------------------------------+
| Graphisches Setup mit der Web-UI                                   | |follow_me2setup-with-web-ui|             |
+--------------------------------------------------------------------+-------------------------------------------+
| Setup auf der lmn-Server-Konsole                                   | |follow_me2setup-on-server-konsole|       |
+--------------------------------------------------------------------+-------------------------------------------+


.. toctree::
   :maxdepth: 1
   :caption: Linuxmuster.net Setup
   :hidden:
  
   with-web-ui
   at-server-konsole
