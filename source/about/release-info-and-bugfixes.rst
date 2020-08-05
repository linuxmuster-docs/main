.. Installationsleitfaden documentation master file, created by
   sphinx-quickstart on Sat Nov  7 15:29:20 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
   
Release-Informationen und Fehlerkorrekturen
===========================================

.. sectionauthor:: `Das Dokuteam <https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_

.. hint::

   * Release-Informationen werden im Forum im Thread `Neue Pakete für lmn7 <https://ask.linuxmuster.net/t/neue-pakete-fuer-lmn7/5237/13>`_ veröffentlicht.
   * Fehler und deren Korrekturen, die ein manuelles Eingreifen erfordern werden hier im Abschnitt :ref:`bugfixes-label` dokumentiert und aktualisiert.


Release-Informationen früherer Versionen
----------------------------------------

* `Release-Information zur linuxmuster.net 6.2 <https://docs.linuxmuster.net/de/v6/release-information/index.html>`_
* `Release-Informationen zur linuxmuster.net 5.1, 6.0 und 6.1 <https://www.linuxmuster.net/wikiarchiv/dokumentation:handbuch:preparation:features>`_

Wartungsplan
------------

+---------+------------------------+----------------+
| Version | Veröffentlichungsdatum | Supportende    |
+=========+========================+================+
|  7.0    | 17.04.2020             | nicht in Sicht |
+---------+------------------------+----------------+
|  6.2    | 15.07.2016             | Ende 2021      |
+---------+------------------------+----------------+

.. _bugfixes-label:


Fehlerkorrekturen
-----------------

.. _found-and-fixed-problems-label:
  
Gefundene und behobene Probleme
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Manche Aktualisierungen erfordern einen manuellen Eingriff, hier
werden diese aufgelistet und auf die nötigen Schritte verwiesen:

* für Installationen vor dem 9.7.2020 erfordert ein Update auf
  linuxmuster-base7 >= 7.0.72 folgenden Eingriff: 

  Bearbeite nach dem Update die Datei ``/etc/samba/smb.conf`` und
  ergänze im Abschnitt `[global]` die Zeilen, so dass folgende Zeilen
  dabei sind:

  .. code:: console

     server ~ # nano /etc/samba/smb.conf
     [global]
     ...
     rpc_server:spoolss = external
     rpc_daemon:spoolssd = fork
     spoolss:architecture = Windows x64
     printing = cups
     printcap name = cups
     ...

  Starte dann Samba/AD neu:

  .. code:: console

     server ~ # systemctl restart samba-ad-dc.service



