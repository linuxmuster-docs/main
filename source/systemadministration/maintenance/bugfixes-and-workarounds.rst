.. Installationsleitfaden documentation master file, created by
   sphinx-quickstart on Sat Nov  7 15:29:20 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
   
.. _bugfixes-label:

Fehlerkorrekturen
=================

.. sectionauthor:: `Das Dokuteam <https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_


.. _found-and-fixed-problems-label:
  
Gefundene und behobene Probleme
-------------------------------

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



