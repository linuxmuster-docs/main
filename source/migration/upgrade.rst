.. include:: ../guided-inst.subst

.. _upgrade-from-7.2-label:

=====================
Upgrade v7.2 auf v7.3
=====================

1. Bringe zuerst den lmn7.2 Server auf den aktuellsten Paketstand.

Führe dazu in der Konsole folgende Befehle aus:

.. code::

   sudo apt update
   sudo apt dist-upgrade

2. Falls Du OPNsense |reg| als Firewall einsetzt, aktualisiere dies zunächst auf eine Version > 25.1.

3. Neue Paketquellen auf dem Server eintragen:

Nachdem Du als Benutzer ``linuxadmin`` angemeldet bist, wechselst Du nun zum Benutzer root mit:

.. code::

   sudo -i

a) Auskommentieren der alten Paketquellen

Rufe die bisherigen Paketquellen auf und kommentiere dien Einträge mit einem # - Zeichen aus.

.. code::

   nano /etc/apt/sources.list.d/lmn72.list   
   
   # deb https://deb.linuxmuster.net/ lmn72 main
   # deb https://deb.linuxmuster.net/ lmn72 main

b) Importiere den Schlüssel für die Paketquellen

.. code::

   wget -qO- "https://deb.linuxmuster.net/pub.gpg" | gpg --dearmour -o /usr/share/keyrings/linuxmuster.net.gpg
   
c) Füge die Paketquellen hinzu

.. code::

   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linuxmuster.net.gpg] https://deb.linuxmuster.net/ lmn73 main" > /etc/apt/sources.list.d/lmn73.list'
   
d) Aktualisiere die Paketuellen mit:

.. code::

   sudo apt update 

e) Aktualisiere die bestehende linuxmuster.net 7.2 Installation mit folgendem Befehl:

.. code::

   /usr/sbin/linuxmuster-release-upgrade --force --reboot
   


Aktualisiere danach das Betriebssystem auf dem Server von Ubuntu 22.04 LTS auf die Version Ubuntu 24.04 LTS. 


Gib dazu auf der Server-Konsole ein:

.. code::

   linuxadmin@server:~$ sudo -i
   root@server:~$ do-release-upgrade

Nach der Überprüfung siehst Du, wieviele Pakete aktualisiert, neu installiert und gelöscht werden.
Bestätige den Vorgang zur Durchführung des Upgrades mit ``j``.

Während des Upgrades erhältst Du mehrere Nachfragen. 
Für einige Dienste (z.B. samba, ssh) wirst Du gefragt, ob die Konfigurationsdatei aktualisiert werden soll.

.. attention::

   Die Nachfrage zur Aktualisierung der Konfigurationsdateien für diese Dienste musst Du unbedingt mit ``N`` beantworten.
   Beispiele (keine Garantie auf Vollständigkeit) sind: ``/etc/security/limits.conf``, ``/etc/ntp.conf``, ``/etc/system/system.conf``, ``/etc/samba/smb.conf``, ``/etc/sshd/sshd_config``

Zudem müssen während oder nach der Installation einiger neuerer Bibliotheken einige Dienste neu gestartet werden. Diese werden Dir in einer Liste angezeigt. Bestätige deren Neustart mit ``OK``.

Danach wirst Du gefragt, ob Du die lokale Version bestimmter Dienste beibehalten möchtest. Beantworte dies jeweils mit ``Ja/OK``.

Nach der Aktualisierung der Pakete wirst Du gefragt, ob die alten Pakete entfernt werden sollen. Bestätige dies mit ``J``.

Danach wirst Du aufgefordert das System neu zu starten. Führe einen ``Reboot`` aus.

