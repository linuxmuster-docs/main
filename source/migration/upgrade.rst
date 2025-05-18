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

   /usr/sbin/linuxmuster-release-upgrade

Prüfe während des Upgrades, ob Fehler ausgegeben werden.

Starte nach dem Upgrade den Server neu:

.. code::

   sudo reboot

Nach dem Neustart prüfe, ob es Fehlermeldungen oder Hinweise gab, indem Du die Dienste prüfst und in den Log-Dateien nachsiehst:

.. code::

   systemctl list-units --state=failed
   less /var/log/ajenti/ajenti.log
 
**f) Firewall neu starten** 
   
Achte darauf, dass Du nach dem Update ebenfalls die Firewall neu startest.

**g) Ubuntu Server LTS aktualisieren**

Dein System sollte nun mit Ubuntu 24.04 LTS und linuxmuster.net v7.3 laufen.

Aktualisiere jetzt nochmals den Server auf den aktuellsten Paketstand. 

.. code::

   linuxadmin@server:~$ sudo -i
   root@server:~$ apt update && apt dist-upgrade -y
   

 

