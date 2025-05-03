.. include:: ../guided-inst.subst

.. _setup-file-server-label:

=================
Setup File-Server
=================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                

File-Server aufnehmen
=====================

Der File-Server muss zuerst als Gerät auf dem linuxmuster.net Server AD/DC als Gerät in die ``devices.csv`` aufgenommen werden.

``Variante A``

Melde Dich als Benutzer ``linuxadmin`` mit dem Passwort ``Muster!`` auf dem linuxmuster.net Server AD/DC an.

Für diese Anmeldung kannst Du die xterm.js Konsole von Proxmox verwenden, wenn Du unserer Anleitung gefolgt bist. Alternativ kannst Du Dich via ssh von einem anderen Rechner mit dem Server verbinden, wenn er sich im gleichen Netzwerksegment befindet.

Im Terminal wirst Du mit dem Erstbildschirm von linuxmuster.net v7.3 begrüßt und es werden die installierten Paketversionen von linuxmuster.net angezeigt.

.. figure:: media/newsetup/lmn-setup-terminal-01.png
   :align: center
   :alt: Terminal after login
   :width: 40%
   
   Welcome to lmn.net
   
Wechsle im Terminal zum Benutzer root mit

.. code::

   sudo -i

Rufe dort im Terminal die Datei auf und trage den File-Server mit seiner Funktion ``server`` ein:

.. code::

   # /etc/linuxmuster/sophomorix/default-school/devices.csv
   server;lmn-file-server;nopxe;52:24:11:4D:97:AB;10.0.0.101;;;;server;;0;;;;SETUP;

Speichere die Änderungen in der Datei.

Rufe danach im Terminal folgenden Befehl auf:

.. code::

   linuxmuster-import-devices
   
``Variante B``

Melde Dich in der WebUI als Benutzer ``global-admin`` an und wähle den Menüpunkt ``Geräte``.

.. figure:: media/newsetup/lmn-file-server-01.png
   :align: center
   :alt: Add File-Server
   :width: 40%
   
   WebUI: Rufe das Menü Geräte auf

Klicke auf Gerät hinzufügen und trage die Daten für Deinen File-Server ein.

.. figure:: media/newsetup/lmn-file-server-02.png
   :align: center
   :alt: Add File-Server Information
   :width: 80%
   
   WebUI: Trage die Daten für den File-Server ein

Klicke auf ``Hinzufügen``. Deine Eintragungen werden Dir in der Liste noch farbig markiert angezeigt, da diese noch nicht importiert wurden.

.. figure:: media/newsetup/lmn-file-server-03.png
   :align: center
   :alt: list file-server 
   :width: 80%
   
   WebUI: Anzeige des neuen Eintrags in der Geräteliste
   
Übernehme nun die Eintragungen mit dem Button ``Speichern & Importieren``.

.. figure:: media/newsetup/lmn-file-server-04.png
   :align: center
   :alt: save and import
   :width: 40%
   
   WebUI: Übernehme den Eintrag mit Speichern & Importieren

Setup des File-Servers
======================

Melde Dich als Benutzer ``linuxadmin`` mit dem Passwort ``Muster!`` auf dem linuxmuster.net File-Server in der Konsole an.

Wechsle im Terminal zum Benutzer root mit

.. code::

   sudo -i

Rufe dort im Terminal das Setup-Programm für den File-Server auf:

.. code::

   linuxmuster-fileserver 
   
.. hint::

   still to be completed


Aktualisierung der Freigaben
============================

.. hint::

   still to be completed






