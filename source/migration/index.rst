.. include:: /guided-inst.subst

.. _migration-label:

=======================
Übersicht zur Migration
=======================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_


Um auf die linuxmuster 7.4 zu migrieren:

1. Führe ein Update Deiner bisherigen linuxmuster.net Version auf linuxmuster v7.3 mit den aktuellsten Paketen durch.
2. Falls Du OPNsense |reg| als Firewall einsetzt, aktualisiere diese auf Version >= v26.1.
3. Für die OPNsense |reg|: Die bestehenden Firewall-Regeln werden bei einem Upgrade der OPNsense |reg| mitgenommen. Nach dem Update müssen diese unbedingt
   in das neue Format für die Firewall-Regeln migriert werden. Dies erfolgt nach folgendem Vorgehen: https://www.thomas-krenn.com/en/wiki/OPNsense_26.1_Firewall_Rule_Migration
4. Führe danach das ``linuxmuster-release-upgrade`` durch. Falls erforderlich führe nach dem Upgrade einen Neustart der Server durch.
5. Falls Du den File-Server installiert hast, führe für diesen ein release-upgrade auf Ubuntu 26.04 LTS durch.

Eine ausführliche Schritt-für-Schritt-Anleitung zu diesen Punkten findest Du unter :ref:`Upgrade v7.3 auf v7.4 <upgrade-from-7.3-label>`.

