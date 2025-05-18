.. include:: ../guided-inst.subst

.. _upgrade-from-7.2-label:

=====================
Upgrade v7.2 auf v7.3
=====================

.. attention::

   Vor dem Upgrade auf linuxmuster.net v7.3 solltest Du unbedingt jeweils einen Snapshot Deiner VMs anlegen (Server und Firewall).


Ablauf
------

1. Bringe zuerst den lmn7.2 Server auf den aktuellsten Paketstand.

Führe dazu in der Konsole folgende Befehle aus:

.. code::

   sudo apt update
   sudo apt dist-upgrade

2. Falls Du OPNsense |reg| als Firewall einsetzt, aktualisiere diese zunächst auf eine Version > 25.1.

3. Trage die neuen Paketquellen auf dem Server ein.


Neue Paketquellen eintragen
---------------------------

Nachdem Du als Benutzer ``linuxadmin`` angemeldet bist, wechselst Du nun zum Benutzer root mit:

.. code::

   sudo -i

**a) Auskommentieren der alten Paketquellen**

Rufe die bisherigen Paketquellen auf und kommentiere dien Einträge mit einem # - Zeichen aus.

.. code::

   nano /etc/apt/sources.list.d/lmn72.list   
   
   # deb https://deb.linuxmuster.net/ lmn72 main
   # deb https://deb.linuxmuster.net/ lmn72 main

**b) Importiere den Schlüssel für die Paketquellen**

.. code::

   wget -qO- "https://deb.linuxmuster.net/pub.gpg" | gpg --dearmour -o /usr/share/keyrings/linuxmuster.net.gpg
   
**c) Füge die Paketquellen hinzu**

.. code::

   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linuxmuster.net.gpg] https://deb.linuxmuster.net/ lmn73 main" > /etc/apt/sources.list.d/lmn73.list'
   
**d) Aktualisiere die Paketuellen**

.. code::

   sudo apt update 

**e) Aktualisiere die bestehende linuxmuster.net 7.2 Installation** mit folgendem Befehl:

.. code::

   /usr/sbin/linuxmuster-release-upgrade --force --reboot

Prüfe nach dem Reboot, ob es Fehlermeldungen oder Hinweise gab, indem Du die Dienste prüfst und in den Log-Dateien nachsiehst:

.. code::

   systemctl list-units --state=failed
   less /var/log/ajenti/ajenti.log
   
Aktualisiere die Pakete erneut:

.. code::

   apt update && apt dist-upgrade
 
**f) Firewall neu starten** 
   
Achte darauf, dass Du nach dem Update ebenfalls die Firewall neu startest.

**g) Paketquellen bereinigen**

Nach dem Releasse upgrade wurden weitere Paketquellen eingetragen.
Lösche die alten Paketquellen mit:

.. code::

   rm /etc/apt/source.list.de/lmn72.list
   rm /etc/apt/source.list.de/lmn73.list
 
In dem Verzeichnis verleibt noch eine Datei lmn.list mit den linuxmuster Paketquellen.

**h) Ubuntu Server LTS aktualisieren**

Aktualisiere danach das Betriebssystem auf dem Server von Ubuntu 22.04 LTS auf die Version Ubuntu 24.04 LTS. 

Zuvor muss der Server auf den aktuellen Paketstand gebracht werden. 

.. code::

   linuxadmin@server:~$ sudo -i
   root@server:~$ apt update && apt dist-upgrade -y
   root@server:~$ do-release-upgrade -d

Nach der Überprüfung siehst Du, wieviele Pakete aktualisiert, neu installiert und gelöscht werden. Bestätige den Vorgang zur Durchführung des Upgrades mit ``j``.

Während des Upgrades erhältst Du mehrere Nachfragen. 
Für einige Dienste (z.B. samba, ssh) wirst Du gefragt, ob die Konfigurationsdatei aktualisiert werden soll.

.. attention::

   Die Nachfrage zur Aktualisierung der Konfigurationsdateien für diese Dienste musst Du unbedingt mit ``N`` beantworten.
   Beispiele (keine Garantie auf Vollständigkeit) sind: ``/etc/security/limits.conf``, ``/etc/ntp.conf``, ``/etc/system/system.conf``, ``/etc/samba/smb.conf``, ``/etc/sshd/sshd_config``

Zudem müssen während oder nach der Installation einige neuere Bibliotheken installiert und einige Dienste neu gestartet werden. Diese werden Dir in einer Liste angezeigt. Bestätige deren Neustart mit ``OK``.

Danach wirst Du gefragt, ob Du die lokale Version bestimmter Dienste beibehalten möchtest. Beantworte dies jeweils mit ``Ja/OK``.

Nach der Aktualisierung der Pakete wirst Du gefragt, ob die alten Pakete entfernt werden sollen. Bestätige dies mit ``J``.

Danach wirst Du aufgefordert das System neu zu starten. Führe einen ``Reboot`` aus.


