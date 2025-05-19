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
   
**d) Aktualisiere die Paketquellen**

.. code::

   sudo apt update 

**e) Aktualisiere die bestehende linuxmuster.net 7.2 Installation** mit folgendem Befehl:

.. code::

   /usr/sbin/linuxmuster-release-upgrade | tee /root/migration-to-lmn73.log

Auf diese Weise siehst Du die Rückmeldungen des Upgrade Skriptes und es wird parallel eine Log-Datei mitgeschrieben.

Das Upgrade dauert eine ganze Zeit, da sowohl linuxmuster.net auf die Version 7.3 als auch Ubuntu auf die version 24.04 LTS aktualisiert werden.

Zu Beginn erhälst Du auf der Konsole den Hinweis, dass Du vor dem Upgrade einen Snapshot Deiner VM anlegen solltest. Zum Start des Upgrades musst Du dann den in der Konsole angezeigten Text eingeben und dies mit ENTER bestätigen. Danach startet das Upgrade.

Prüfe während des Upgrades, ob Fehler ausgegeben werden. Am Ende des Upgrades wird der Server automatisch neu gestartet. Melde Dich erneut an und prüfe die zuvor mitgeschriebene Log-Datei `/root/migration-to-lmn73.log` auf mögliche Fehlerhinweise.

Prüfe zudem, ob alle Dienste korrekt gestartet wurden.

.. code::

   systemctl list-units --state=failed
 
**f) Firewall neu starten** 
   
Achte darauf, dass Du nach dem Update ebenfalls die Firewall neu startest.

**g) Ubuntu Server LTS aktualisieren**

Dein System sollte nun mit Ubuntu 24.04 LTS und linuxmuster.net v7.3 laufen.

Aktualisiere jetzt nochmals den Server auf den aktuellsten Paketstand. 

.. code::

   linuxadmin@server:~$ sudo -i
   root@server:~$ apt update && apt dist-upgrade -y
   

 

