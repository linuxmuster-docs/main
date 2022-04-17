.. _setup-label:

==========
Setup v7.1
==========

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
           `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_
           
.. hint::

   Alle linuxmuster 6.x Systeme können statt einer Neuinstallation über eine :ref:`migration-label` umgezogen werden, dennoch ist die
   Erstkonfiguration hier eine notwendige Voraussetzung. 

   Alle linuxmuster 7.0 Systeme werden lediglich über ein Upgrade :ref:`upgrade-from-7.0-label` auf linuxmuster v7.1 aktualisiert. 
   Ein erneutes Setup ist dann nicht mehr erforderlich.
   
Es gibt 2 Möglichkeiten die Erstkonfiguration durchzuführen: 

1. Setup mit der Schulkonsole :ref:`setup-gui-label`
2. Setup im Terminal: :ref:`setup-console-label` 

Lies zunächst alle wichtigen Hinweise des Setup-Kapitels und mache dann entweder auf der Schulkonsole (grafisch / GUI) oder im Terminal weiter.
   

Wichtige Hinweise
=================

* Nach Abschluss dieses Setups sind die Domäne und andere Details des Netzwerks permanent festgelegt und nur durch Neuinstallation änderbar. Es ist daher wichtig, zu diesem Zeitpunkt ein **Snapshot/Backup von Server und Firewall** anzufertigen. Sollte es beim Setup Fehler geben, oder Einstellungen nochmals geändert werden müssen, sind die virtuellen Maschinen auf den Stand des Snapshots zurückzusetzen und das Setup muss erneut aufgerufen werden.
* Beim Domänennamen ist zu beachten, dass der **erste** Teil der Domäne nicht länger als 15 Zeichen sein darf! Dies ergibt sich aus den Samba/AD-Vorgaben. Im Beispiel ``server.linuxmuster.lan`` ist ``server`` der Rechnername und ``linuxmuster.lan`` die Domäne. Die Domäne ``linuxmuster`` darf nicht länger als **15 Zeichen** sein.
* Will man eine Domäne nutzen, die auch extern auflösbar ist, sollte zusätzlich eine Subdomäne verwendet werden. Zum Beispiel``linuxmuster.meineschule.de`` statt ``meineschule.de``. Der erste Part ``linuxmuster`` wird in diesem Beispiel dann als SAMBA-Domäne verwendet. Der volle Name(FQDN) des Servers ist dann ``server.linuxmuster.meineschule.de``.
* Alle Hosts die im Setup konfiguriert werden, müssen bereits laufen (OPNsense und Server). Diese müssen sich im internen LAN gegenseitig erreichen.
* v6.x Systeme, die mit Hilfe der Migration auf linuxmuster.net 7.1 migriert werden, können eine neue (oder die alte) Domäne konfigurieren.

Anpassung des Netzbereichs
==========================

Die Standardkonfiguration, sieht vor, dass das Schulnetz die lokale Domäne ``linuxmuster.lan`` bekommt und Geräte im Netzbereich ``10.0.0.0/16``
sind. Wenn ein anderer Netzbereich verwendet werden soll, *muss* an dieser Stelle eine Anpassung vorgenommen werden.

v6.x Systeme, die mit Hilfe der Migration auf linuxmuster.net 7.1 migriert werden, sollten den bisherigen Netzbereich behalten.

.. hint::

   Die Anpassungen zur Netzkonfiguration sind vor der Ausführung der Erstkonfiguration durchzuführen. Zur Durchführung der Anpassungen
   folge bitte dem Kapitel :ref:`modify-net-label`.
