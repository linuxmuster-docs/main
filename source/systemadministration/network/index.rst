============================
(v6.2) Netzwerkkonfiguration
============================

:fixme: Portal-Lösung mit OPNsense

.. toctree::
   :maxdepth: 1

   coovawifi/index


.. _linuxmuster-freeradius-label:

(v6.2) Authentifizierung mit RADIUS
===================================

Viele Geräte und Anwendungen, wie z.B. Access Points, Captive Portals
oder Wireless Controller, bieten neben einer einfachen
Benutzerauthentifizierung auch eine Überprüfung mit Hilfe eines
RADIUS-Servers an (WPA-Enterprise, 802.1X).

.. toctree::
   :maxdepth: 1

   radius

.. _subnetting-basics-label:

(v6.2) Netzwerksegmente / Subnetting
====================================

Es kann datenschutzrechtliche und technische Gründe geben, das grüne
(interne) Schulnetz in mehrere Segmente aufzuteilen. Diese Anleitung
soll den einfachsten Spezialfall dokumentieren, das grüne Netz in drei
Segmente aufzuteilen. Eine Erweiterung um weitere Subnetzbereiche,
beispielsweise Klassenraumweise, ist später ohne Schwierigkeiten
möglich.

.. toctree::
   :maxdepth: 1

   subnetting-basics/vorbemerkungen
   subnetting-basics/workstations-vorbereiten
   subnetting-basics/switches-vorbereiten
   subnetting-basics/switch-konfiguration
   subnetting-basics/switch-kaskadiert
   subnetting-basics/server-umstellen

.. _subnetting-unifi-label:

(v6.2) Unifi-WLAN-Lösung für linuxmuster.net
============================================

Eine WLAN-Lösung für Schulen sollte mindestens zwei WLAN-Netze aufspannen. 

- Das Lehrernetz für schuleigene Geräte, wie Beamer, Laptops oder
  Chromecasts, und für private Geräte der Lehrer, die auf Beamer und
  Chromecasts zugreifen wollen.
- Das Schülernetz für Schüler.

In der hier vorgestellten Lösung kommen Accesspoints von Unifi und der
kostenlose Unifi-Controller zum Einsatz.

.. toctree::
  :maxdepth: 1

  unifiwifi/topology
  unifiwifi/switch
  unifiwifi/unificontroller




