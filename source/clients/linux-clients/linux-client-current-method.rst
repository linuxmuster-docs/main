.. include:: /guided-inst.subst

.. _install-linux-clients-current-label:

=========================
Linux-Client installieren
=========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_, 
                   `@dorian <https://ask.linuxmuster.net/u/dorian>`_

linuxmuster.net stellt für Ubuntu-Clients ein Paket ``linuxmuster-linuxclient7`` bereit, das den korrekten Domänenbeitritt durchführt und es ermöglicht, das Management beider Client-Betriebssystemen (Linux und Windows) durch Auslesen der GPO-Konfigurationen im Active Directory zu vereinheitlichen.

Es werden ein Ubuntu Desktop 20.04 LTS sowie Ubuntu Distributionen mit GDM3 und Gnome Desktop unterstützt.

Voraussetzung
=============

Du hast bereits:
  - einen PC angeschlossen / eine VM definiert,
  - diese(n) als Gerät in linuxmuster eingebunden,
  - einen PXE Start des PCs / der VM mit Linbo ausgeführt,
  - mit Linbo die Festplatte partioniert und formatiert.

Falls dies noch nicht so ist, starte zuerst mit den Schritten, die im Kapitel :ref:`add-computer-label` beschrieben wurden und führe danach die, in dieser Anleitung beschriebenen Schritte durch.

Einrichten eines Linux-Clients
==============================

Client OS installieren
----------------------

Gebe im PC / der VM nun an, dass von dem gewünschten ISO-Image gestartet werden soll. Hierbei ist darauf zu achten, dass die Boot-Reihenfolge so geändert wird, dass zuerst von dem ISO-Image gestartet wird.

Stelle also beim PC im BIOS die Bootreihenfolge so um, dass von CD oder USB-Stick das Ubuntu ISO-Image gestartet wird. Ändere in der VM bei den VM-Einstellungen die Bootreihenfolge. Achte darauf, dass als CD/Boot-Image das gewünschte Ubuntu 20.04 Image eingehangen wurde und definiere dieses als erstes Startmedium. Speichere die Einstellungen der VM.

Starte nun den PC/die VM mit den neuen Einstellungen, so dass Ubuntu vom ISO-Image startet. Nachdem der Start ausgeführt wurde und der erste Ubuntu Desktop erscheint, wähle auf dem Erstbildschirm aus, dass du Ubuntu installieren möchtest.

Installation Ubuntu
-------------------

Die gibst in den ersten Schritten der Installation die gewünschte Sprache und Tastaturbelegung an.

Bei der ``Installationsart`` wählst du ``Etwas Anderes`` aus.

.. figure:: media/01-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation Method

Du hattest mit Linbo ja bereits die Festplatte partitioniert und formatiert, so dass du nun für die Installation die hierfür vorgesehene Partition auswählen und zugleich das Root-Verzeichnis ``/`` hier einhängen musst.

Es werden dir die bereits vorhandenen Partitionen und Dateisysteme angezeigt. Je nach genutzter Virtualisierungsumgebung können die Festplattenbezeichnungen hier auch als ``/dev/sda`` und die Partionen als ``/dev/sda1`` etc. angezeigt werden.

Wähle, wie in der nachstehenden Abb. zu sehen ist, die Partition aus, auf der Ubuntu installiert werden soll.

.. figure:: media/02-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation Method - Partitions

Klicke nun auf ``Ändern`` und es erscheint nachstehendes Fenster:

.. figure:: media/03-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation Method - Partition Settings

Belasse die angezeigte Größe und das Dateisystem. Setze den Haken bei ``Partition formatieren`` und wähle als ``Einbindungspunkt`` das Root-Verzeichnis ``/`` aus.

Klicke auf ``ok`` und es werden dir die Einstellungen nochmals angezeigt (siehe nachstehende Abb.):

.. figure:: media/04-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation Method - Partitions Overview

Stimmen diese Einstellungen nun für die Installation von Ubuntu, so setze diese mit dem Button ``Jetzt installieren`` fort.

Im Verlaufe der Installation wirst du nach dem Benutzer und dem Kennwort gefragt. Gebe hier als Benutzer ``linuxadmin`` ein und passe den Namen des Rechners auf den des PC / der VM an, wie dieser in der Gerätekonfiguration des linuxmuster.net Server steht.

.. figure:: media/05-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation: linuxadmin user

Am Ende der Installation wirst du aufgefordert, den Rechner neu zu starten. Fahre die VM herunter und werfe das ISO-Image aus.

Erstimage erstellen
-------------------

Passe die Boot-Reihenfolge für den PC / die VM jetzt so an, dass diese wieder via PXE Linbo bootet. Du siehst Dann die Startoptionen in Linbo für das installierte Ubuntu 20.04.

.. figure:: media/06-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation: Create first image

Klicke nun unten rechts auf das Werkzeug-Icon, um zum Menü für die Imageerstellung zu gelangen.

.. figure:: media/07-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation: Menue Tools

Du wirst nach nach dem Passwort des Benutzers ``root`` gefragt. Gebe dieses ein. Deine Eingabe wird hierbei nicht angeziegt.

.. figure:: media/08-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation: root login

Klicke dann auf ``anmelden`` und du gelangst zu folgender Ansicht:

.. figure:: media/09-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation: linbo menue for imaging

Klicke auf das große Festplatten-Icon, da in der Ecke rechts unten farblich markiert ist, um nun ein Image zu erstellen.

Es wird ein neues Fenster geöffnet:

.. figure:: media/10-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation: linbo imaging

Wähle aus, dass du ein neues Image erstellen möchtest, gebe einen Namen für das Image an und klicke auf ``erstellen + hochladen``.

Erscheint die Meldung, dass das Image erfolgreich hochgeladen werden konnte, so klicke unten rechts, das oberste Symbol, um dich auf den Tools von Linbo abzumelden. 

.. figure:: media/11-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Installation: leave tools menue

Klicke nun das große Festplattensymbol, um Ubuntu synchronisiert zu starten.

Packet linuxmuster-linuxclient7 installieren
--------------------------------------------

Melde dich an dem gestarteten Ubuntu 20.04 als Benutzer ``linuxadmin`` an, der sudo - Berechtigungen hat.

.. figure:: media/12-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Setup: Login as linuxadmin

Installiere das Paket ``linuxmuster-linuxclient7.deb`` wie folgt:

1. Trage das linuxmuster.net Repository ein
2. Trage den GPG Schlüssel hierfür ein
3. Installiere das Paket

1. Schritt
^^^^^^^^^^

Öffen ein Terminal unter Ubuntu mit ``strg+t`` oder klicke unten links auf die Kacheln und gebe in der Suchzeile für Anwendungen ``Terminal`` ein.

Im Terminal erstelle die Datei ``lmn7-client.list``, um das Repository für den linuxmuster-client einzubinden. Rufe hierzu für den Editor Nano mit folgendem Befehl zur Anlage der neuen Datei auf: ``sudo nano /etc/apt/sources.list.de/lmn7-client.list`` und trage folgendes Repository ein:

.. code::

   deb [trusted=yes] https://archive.linuxmuster.net  focal/

2. Schritt
^^^^^^^^^^

Aktualisiere die Paketinformationen mit ``sudo apt update``.
Lade den Schlüssel des Archivs herunter und füge diesen apt hinzu:

.. code::

   wget https://archive.linuxmuster.net/archive.linuxmuster.net.key | sudo apt-add key -

Aktualisiere die Paketinformationen mit ``sudo apt update`` erneut. 

Es kann sein, dass du den Hinweis erhälst, dass es GPG-Fehler gibt.

.. figure:: media/13-linux-client-ubu-install.png
   :align: center
   :alt: Ubuntu Setup: GPG errors

Diese Fehler kannst du beheben, indem du nachstehenden Befehl angibst.

.. code::

   sudo apt -o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true update

Der Fehler wird zwar weiterhin angezeigt. Du kannst nun aber das linuxmuster-linuxlcient7 - Paket installieren.

3. Schritt
^^^^^^^^^^
Führe die Installation der linuxclient7 - Pakets mit ``sudo apt install linuxmuster-linuxclient7 -y`` durch.

Setup
-----

Rufe nun das Setup für den linuxmuster Linux-Client wie folgt auf:

.. code::

   sudo linuxmuster-linuxclient7 setup

Für den Domänenbeitritt wird dann das Kennwort des Domänen-Admins ``global-admin`` abgefragt.

Am Ende des Domänen-Beitritts erfolgt eine Bestätigung, dass dieser erfolgreich durchgeführt wurde. Falls nicht, muss das Setup für linuxmuster-linuxclient7 erneut durchlaufen werden.

.. hint::

   Danach sollte unbedingt S O F O R T ein neues Image mit Linbo erstellt werden. Beim Neustart via PXE darf Ubuntu N I C H T mit dem Synchronisations-Button gestartet werden. Nachstehende Abschnitte beschreiben das Vorgehen.

Image vorbereiten
-----------------

Der Linux-Client muss nun für die Erstellung des Images vorbereitet werden.
Rufe hierzu den Befehl auf:

.. code::

   sudo linuxmuster-linuxclient7 prepare-image

Der Client erhält Aktualisierungen und es werden einige Dateien (journalctl & apt-caches) vor der Image-Erstellung aufgeräumt.

Die Home-Laufwerke der AD-user auf dem Client werden ebenfalls geleert.

Image erstellen
---------------

Führe einen Reboot des Linux-Client durch, so dass die VM via PXE in Linbo bootet.

Nun erstellst du in Linbo genauso wie zuvor unter **Erstimage erstellen** das Image des neuen Muster-Clients für Linux

Wurde der Vorgang erfolgreich beendet, kannst du nun unter der Reiterkarte ``Start`` den vorbereiteten Linux-Client synchronisiert starten und sich als Benutzer der Domäne anmelden.

Eigene Anpassungen im Image
===========================

Um den Linux-Client als Mustervorlage zu aktualisieren und Anpassungen vorzunehmen, startest du die VM synchronisiert und meldest dich lokal am Linux-Client mit dem Benutzer ``linuxadmin`` an.

Danach installierst du die benötigte Software und nimmst die gewünschten Einstellungen vor.

Beispielsweise installierst du auf dem Linux-Client zuerst Libre-Office:

..code::

   sudo apt update
   sudo apt install libreoffice

Hast du alle Anpassungen vorgenommen, must du noch den Linux-Client zur Erstellung des Imaging vorbereiten.

Diese Arbeiten werden mit folgendem Befehl durchgeführt:

.. code::

 sudo linuxmuster-linuxclient7 prepare-image

.. hint::

  Sollte während des Updates oder der Image-Vorbereitung die Meldung kommen, dass lokale Änderungen der PAM-Konfiguration außer Kraft gesetzt werden sollen, wähle hier immer ``Nein`` (siehe Abb.), da sonst der konfigurierte Login nicht mehr funktioniert.

.. figure:: media/14-linux-client-ubu-update-pam.png
   :align: center
   :alt: Linux-Client: Update - PAM Settings

Solltest du versehentlich auf ``ja`` geklickt haben, kannst du dies mit folgendem Befehl reparieren:

.. code::

  sudo linuxmuster-linuxclient7 upgrade

Nach der Vorbereitung des Image bootest du den Linux-Client erneut und erstellst wiederum, wie zuvor beschrieben, ein neues Image.


Serverseitige Anpassungen
=========================

Damit der Linux-Client die Drucker automatisch ermittelt und der Proxy korrekt angesteuert wird, ist es erforderlich, dass auf dem linuxmuster.net Server einige Anpassungen vorgenommen werden.


Proxy-Einstellungen
-------------------

Bei der Anmeldung vom Linux-Client werden sog. Hook-Skripte aufgerufen und ausgeführt.

Diese finden sich auf dem linuxmuster.net Server im Verzeichnis: ``/var/lib/samba/sysvol/linuxmuster.lan/scripts/default-school/custom/linux/``

.. hint::

   Ersetze ``linuxmuster.net`` durch den von dir beim setup festgelegten Domänennamen und ersetze ggf. ``default-school`` ebenfalls durch den von dir festgelegten Namen.

Hier findet sich das Skript ``logon.sh``, das immer dann ausgeführt wird, wenn sich ein Benutzer am Linux-Client anmeldet.

Auf dem Server sind im Logon-Skript Einstellungen für den zu verwenden Proxy-Server zu verwenden, sofern dieser von den Linux-Clients zwingend mit SSO verwendet werden soll.

Editiere die Datei ``/var/lib/samba/sysvol/linuxmuster.lan/scripts/default-school/custom/linux/logon.sh`` und füge folgende Zeilen hinzu. Passe die ``Proxy_Domain`` für dein Einsatzszenario an.

.. code::

  PROXY_DOMAIN=linuxmuster.lan #change it to your DOMAIN
  PROXY_HOST=http://firewall.$PROXY_DOMAIN
  PROXY_PORT=3128

  # set proxy via env (for Firefox)
  lmn-export no_proxy=127.0.0.0/8,10.0.0.0/8,192.168.0.0/16,172.16.0.0/12,localhost,.local,.$PROXY_DOMAIN
  lmn-export http_proxy=$PROXY_HOST:$PROXY_PORT
  lmn-export ftp_proxy==$PROXY_HOST:$PROXY_PORT
  lmn-export https_proxy==$PROXY_HOST:$PROXY_PORT

  # set proxy gconf (for Chrome)
  gsettings set org.gnome.system.proxy ignore-hosts "['127.0.0.0/8','10.0.0.0/8','192.168.0.0/16','172.16.0.0/12','localhost','.local','.$PROXY_DOMAIN']"
  gsettings set org.gnome.system.proxy mode "manual"
  gsettings set org.gnome.system.proxy.http port "$PROXY_PORT"
  gsettings set org.gnome.system.proxy.http host "$PROXY_HOST"
  gsettings set org.gnome.system.proxy.https port "$PROXY_PORT"
  gsettings set org.gnome.system.proxy.https host "$PROXY_HOST"
  gsettings set org.gnome.system.proxy.ftp port "$PROXY_PORT"
  gsettings set org.gnome.system.proxy.ftp host "$PROXY_HOST"


Drucker vorbereiten
-------------------

.. hint:: 

   Dies sind nur kurze allgemeine Hinweise. Im Kapitel :ref:`howto-install-printer-label` finden sich ausführliche Hinweise.

Damit Drucker automatisch gefunden werden und via GPO administriert werden können, ist es erforderlich, dass auf dem Server unter CUPS die Drucker einen identischen Namen aufweisen, so wie diese als Geräte in der ``/etc/linuxmuster/sophomorix/default-school/devices.csv`` eingetragen wurden.

Drucker können im Active Directory Gruppen zugeordnet werden.

Um ein Suchen nach Druckern auf den Clients zu unterbinden, so dass nur die Drucker zugeordnet werden, wie diese in den GPOs für die Gruppen definiert wurden, muss auf dem Server in der Datei ``etc/cups/cupsd.conf`` der Eintrag ``Browsing On`` auf ``Browsing Off`` umgestellt werden.


(Optional) Migration eines bestehenden Linux-Clients
====================================================

Wird ein Ubuntu 20.04 Linux-Client eingesetzt, der mit den bisherigen linuxmuster-client-servertools und dem Befehl linuxmuster-client eingerichtet wurde, so kann dieser vorbereitete Client migriert werden, so dass die aktuell gepflegten Pakete für linuxmuster-linuxclient7 genutzt werden können.

Vorgehen
--------

1. VM anlegen und vorbereiten wie unter :ref:`add-computer-label` beschrieben.
2. Für Linbo die start.conf der Hardwareklasse anpassen, so dass das bisherige Image angegeben wird.
3. Start VM via PXE
4. Anmelden als Benutzer ``linuxadmin``
5. ggf. Backup der eigenen Skripte unter ``/etc/linuxmuster-client`` - diese werden automatisch gelöscht!
6. entferne den alten Linux-Client vollständig
7. Entferne das ale Proxy-Skript auf dem Client
8. Entferne lightdm als Anmeldemanager
9. Installiere gdm3 als Anmeldemanager
10. Führe das Setup des neuen Pakets linuxmuster-linuxlient7 aus wie zuvor beschrieben
11. Erstelle ein neues Image.


.. attention:: Du musst als Benutzer linuxadmin angemeldet bleiben, solange bis das Setup des neuen Pakets linuxmuster-linuxclient7 vollständig abgeschlossen ist!

Zu den Schritten 6. bis 10. findest du nachstehend Hinweise zur Umsetzung.

Entferne die alten Linux-Client Pakete
--------------------------------------

Hast du den alten Linux-Client in der VM erfolgreich gestartet, meldest du dich als Benutzer ``linuxadmin`` an.

Entferne danach die alten Linux-Client Pakete mit folgendem Befehl:

.. code::

   sudo apt purge linuxmuster-client-adsso

Entferne der Verzeichnis ``linuxmuster-client`` mit folgendem Befehl:

.. code::

   sudo rm -r /etc/linuxmuster-client

Entferne anschliessend das Proxy-Setup-Skript auf dem alten Linux-Client mit:

.. code::

  sudo rm /etc/profile.d/linuxmuster-proxy.sh


Anmeldemanager wechseln
-----------------------

Das neue Paket linuxmuster-linuxclient7 benötigt als Anmeldemanager gdm3 und Gnome, so dass zuerst der bisherige Anmeldemanager zu deinstallieren ist. Die Dokumentation geht hier dabei davon aus, dass lightdm zu deinstallierenn ist. Ggf. must du das auf deinen genutzten Anmeldemanager anpassen.

Lösche den Anmeldemanager ``lightdm`` mit dem Befehl:

.. code::

   sudo apt purge lightdm

Danach installierst du ``gdm3`` mit:

.. code:: 

   sudo apt install --reinstall gdm3

Räume danach die Pakete im Apt-cache auf mit:

.. code::

   sudo apt autoremove

.. attention::

   Bleibe weiterhin als Benutzer linuxadmin angemeldet, solange bis du das Setup des neuen Paketes linuxmuster-linuxclient7 abgeschlossen hast.

Führe nun alle Schritte zur  Installation und zum Setup des neuens linuxmuster-linuxclient7 Pakets aus.

Nach Abschluss des Setups erstellst du ein neues Image.


Weiterführende Dokumentation
============================

- `Entwicklerdokumentation <https://github.com/linuxmuster/linuxmuster-linuxclient7/wiki/Setup>`_
- :ref:`using-linbo-label`

