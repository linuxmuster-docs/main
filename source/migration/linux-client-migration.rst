.. include:: ../guided-inst.subst

.. _install-linux-clients-migration-label:

Migration eines bestehenden Linux-Clients
=========================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_, 
                   `@dorian <https://ask.linuxmuster.net/u/dorian>`_

Wird ein Ubuntu 20.04 Linux-Client eingesetzt, so kann dieser vorbereitete Client migriert werden, so dass die aktuell gepflegten Pakete für linuxmuster-linuxclient7 genutzt werden können.

Vorgehen
--------

1. VM anlegen und vorbereiten wie unter :ref:`hardware-registration-label` beschrieben.
2. Für Linbo die start.conf der Hardwareklasse anpassen, so dass das bisherige Image angegeben wird.
3. Start der VM via PXE
4. Anmelden als Benutzer ``linuxadmin``
5. ggf. Backup der eigenen Skripte unter ``/etc/linuxmuster-client`` - diese werden automatisch gelöscht!
6. Entferne den alten Linux-Client vollständig
7. Entferne das ale Proxy-Skript auf dem Client
8. Entferne lightdm als Anmeldemanager
9. Installiere gdm3 als Anmeldemanager
10. Führe das Setup des neuen Pakets linuxmuster-linuxlient7 aus (:ref:`install-linux-clients-current-label`)
11. Erstelle ein neues Image.


.. attention:: 

   Du musst als Benutzer ``linuxadmin`` angemeldet bleiben, solange bis das Setup des neuen Pakets linuxmuster-linuxclient7 vollständig abgeschlossen ist!

Zu den Schritten 6. bis 10. findest Du nachstehend Hinweise zur Umsetzung.

Entferne die alten Linux-Client Pakete
--------------------------------------

Hast Du den alten Linux-Client in der VM erfolgreich gestartet, meldest Du Dich als Benutzer ``linuxadmin`` an.

Entferne danach die alten Linux-Client Pakete mit folgendem Befehl:

.. code::

   sudo apt purge linuxmuster-client-adsso

Anmeldemanager wechseln
-----------------------

Das neue Paket linuxmuster-linuxclient7 benötigt als Anmeldemanager gdm3 und Gnome, so dass zuerst der bisherige Anmeldemanager zu deinstallieren ist. Die Dokumentation geht hier dabei davon aus, dass lightdm zu deinstallierenn ist. Ggf. must Du das auf Deinen genutzten Anmeldemanager anpassen.

Lösche den Anmeldemanager ``lightdm`` mit dem Befehl:

.. code::

   sudo apt purge lightdm

Danach installierst Du ``gdm3`` mit:

.. code:: 

   sudo apt install --reinstall gdm3

Räume danach die Pakete im apt-cache auf:

.. code::

   sudo apt autoremove

.. attention::

   Bleibe weiterhin als Benutzer linuxadmin angemeldet, solange bis Du das Setup des neuen Paketes linuxmuster-linuxclient7 abgeschlossen hast.

Führe nun alle Schritte zur Installation und zum Setup des neuen linuxmuster-linuxclient7 Pakets aus wie diese im Kapitel :ref:`install-linux-clients-current-label` beschrieben sind.

Nach Abschluss des Setups erstellst Du ein neues Image.
