.. include:: ../../guided-inst.subst

.. _lmn_pre_install-label:

=============================
Server auf lmn7.2 vorbereiten
=============================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_
                  

Nachdem Du die Firewall und den Server wie beschrieben installiert hast, müssen beide Maschinen fertig konfiguriert werden.

Passe zuerst die Zeitzone an und deinstalliere cloud-init.

Vorbereitungen
==============

Zeitservereinstellungen überprüfen
----------------------------------

Nachdem Du nun den Server vorbereitet hast, überprüfe die Zeiteinstellungen auf dem Server. Dazu gibst Du in der Konsole folgenden Befehl an:

.. code-block:: Bash

   timedatectl
   
Es wird hier noch die UTC-Zeit angegeben. Wie für die OPNsense muss nun die Zeitzone angepasst werden.
Die erfolgt mit folgendem Befehl:

.. code-block:: Bash

   sudo timedatectl set-timezone Europe/Berlin
   # erneute Ausgabe der Zeiteinstellungen mit
   timedatectl
   
Du solltest nun als Zeitzone ``Europe/Berlin`` und die korrekte Lokalzeit sowie die korrkte UTC - Zeit angezeigt bekommen.
 
 
Cloud-init deinstallieren
-------------------------

Cloud-init kannst Du unter Ubuntu mit folgenden Schritten löschen:

.. code-block:: Bash

   # Disable start
   sudo touch /etc/cloud/cloud-init.disabled
   # Uninstall
   sudo apt purge cloud-init
   sudo rm -rf /etc/cloud/ && sudo rm -rf /var/lib/cloud/

Default-Locale setzen
---------------------

Erzeuge zuerst die Locales mit:

.. code-block:: Bash

   sudo localectl status
   System Locale: LANG=C.UTF-8
       VC Keymap: n/a
      X11 Layout: de
       X11 Model: pc105

Prüfe, welche Locales installiert sind:

.. code-block::

   locale -a
   C
   C.utf8
   POSIX

Sollte das Paket Locales nicht installiert sein, führe folgenden Befehl aus:

.. code-block::

   sudo apt install apt-utils locales

Erzeuge nun die Locales neu:

.. code-block::

   sudo dpkg-reconfigure locales
   
   Configuring locales

   Locales are a framework to switch between multiple languages and allow users to
   use their language, country, characters, collation order, etc.
   
   Please choose which locales to generate. UTF-8 locales should be chosen by
   default, particularly for new installations. Other character sets may be useful
   for backwards compatibility with older systems and software.
   
   1. All locales                      252. gl_ES ISO-8859-1
   2. C.UTF-8 UTF-8                    253. gl_ES.UTF-8 UTF-8
   3. aa_DJ ISO-8859-1                 254. gl_ES@euro ISO-8859-15
   4. aa_DJ.UTF-8 UTF-8                255. gu_IN UTF-8
   5. aa_ER UTF-8                      256. gv_GB ISO-8859-1
   6. aa_ER@saaho UTF-8                257. gv_GB.UTF-8 UTF-8
   7. aa_ET UTF-8                      258. ha_NG UTF-8
   8. af_ZA ISO-8859-1                 259. hak_TW UTF-8
   9. af_ZA.UTF-8 UTF-8                260. he_IL ISO-8859-8
   10. agr_PE UTF-8                    261. he_IL.UTF-8 UTF-8
   11. ak_GH UTF-8                     262. hi_IN UTF-8
   12. am_ET UTF-8                     263. hif_FJ UTF-8

   Locales to be generated: de_DE.UTF-8 
   
    1. None  2. C.UTF-8  3. de_DE.UTF-8
   Default locale for the system environment: 3
   
   Generating locales (this might take a while)...
   de_DE.UTF-8... done
   Generation complete.

Du kannst die Default-Locale ggf. auch mit folgenden Befehl neu setzen:

.. code-block:: Bash

   $sudo localectl set-locale LANG=de_DE.UTF-8


.. attention:: Wichtiger Hinweis, schon jetzt!

   Solltest Du mit Deiner Konfiguration von unseren Standard-Vorgaben bei dem zuletzt genannten Punkt abweichen, musst Du Deine Einstellungen unbedingt bei Aufruf des Skriptes lmn-prepare anpassen!
   
Letzter Test vor Anwendung des Skriptes lmn-appliance
-----------------------------------------------------

Als letzte Überprüfung, bevor Du das Skript einsetzt, verbinde Dich vom Server aus mit der Firewall via ssh.

.. code-block:: Bash

   ssh root@10.0.0.254

Du solltest Dich nach der Eingabe des Passwortes ``Muster!`` auf der Konsole der OPNsense |reg| wiederfinden. Eventuell musst Du auch vorher deren Key akzeptieren. Mit ``0`` solltest Du Dich wieder ausloggen und zurück auf der Server-Konsole sein.

Sollte dieser Test erfolgreich sein, steht der abschließenden Vorbereitung nach einem Neustart nichts mehr im Wege.

.. code-block:: Bash

   # Reboot
   sudo reboot

Das Skript lmn-appliance
========================

Das Skript ``lmn-appliance`` bereitet den Server / die Appliance vor:

- Es bringt das Betriebssystem auf den aktuellen Stand,
- richtet das linuxmuster.net-Paket-Repo ein,
- installiert das Paket linuxmuster-prepare und
- startet dann das Vorbereitungsskript lmn-prepare,
  - das die für das jeweilige Appliance-Profil benötigten Pakete installiert,
  - das Netzwerk konfiguriert,
  - das root-Passwort auf Muster! setzt und
  - im Falle des Serverprofils optional LVM einrichtet.

.. hint::

   Erstelle jetzt einen Snapshot Deiner Server-VM.   

Wenn Du nicht mehr an Deinem Server eingeloggt bist, melde Dich erneut an.

Überprüfe Deine Festplatten und Partitionen mit 

.. code::

   lsblk
   
   NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
   sda      8:0    0   50G  0 disk 
   ├─sda1   8:1    0    1M  0 part 
   └─sda2   8:2    0   50G  0 part /
   sdb      8:16   0  200G  0 disk 
   sr0     11:0    1 1024M  0 rom  

In o.g. Beispiel wurde Ubuntu Server auf der 1. Festplatte (sda) installiert. Die zweite Festplatte (sdb) kennt noch keine Partitionen.

Skript herunterladen
--------------------

Führe danach folgende Befehle in der Eingabekonsole aus:

Wechsele Deinen Log-in und werde zu ``root``, falls du es nicht mehr sein solltest:

.. code-block:: Bash
 
  sudo -i

Lade das lmn-appliance Skript herunter und setze die Ausführungsberechtigung:

.. code-block:: Bash
  
   wget https://raw.githubusercontent.com/linuxmuster/linuxmuster-prepare/master/lmn-appliance
   chmod +x lmn-appliance

Aufruf lmn-appliance
--------------------

Das Skript ist generell wie folgt zu starten:

.. code-block:: Bash

  ./lmn-appliance <Optionen>

Die möglichen Optionen findest Du hier dokumentiert: https://github.com/linuxmuster/linuxmuster-prepare

Für unsere Beispielkonfiguration rufe nun das Skript ``lmn-appliance`` so auf, dass Dein Server vorbereitet wird. Das LVM wird dann auf  der zweiten Festplatte eingerichtet wird.

.. code-block:: Bash

  ./lmn-appliance -p server -u -l /dev/sdb

Mit dem Parametern -u (unattended) und -l wird dann ein LVM - hier auf der 2. Festplatte (sdb) - mit folgenden Werten eingerichtet:

- var: 10 GiB
- linbo: 40 GiB
- global: 10GiB
- default-school: restlicher Plattenplatz

Installation mit Deinen Vorgaben
================================

Nachstehendes Beispiel geht davon aus, dass Du eine zweite HDD mit einer Größe von 1TiB hast.

.. code-block:: Bash

  ./lmn-appliance -p server -l /dev/sdb -v var:50,linbo:500,global:50,default-school:100%FREE

Es wird hier also mit dem Profil server auf der zweiten Festplatte (/dev/sdb) ein LVM eingerichtet. Auf der zweiten Platte werden vier Volumes mit den Größen

- var: 50GiB
- linbo: 500GiB
- global: 50GiB
- default-school: verbleibender Rest der zweiten Festplatte - hier 400 GiB -

eingerichtet.

.. attention::

  Passe die Größenangaben auf Deine Situation an.

Ablauf
======

Es wird zuerst das LVM auf der zweiten Platte eingerichtet, danach werden alle erforderliche Pakete geladen und installiert. Dies kann etwas dauern. Nach Abschluss des Installations- und Vorbereitungsarbeiten wirst Du aufgefordert, den Server neu zu starten.

.. code-block:: Bash

  ## Passwords
  # root ... OK!
  # linuxadmin ... OK!
  ## Writing configuration
  
  ## The system has been prepared with the following values:
  # Profile   : server
  # Hostname  : server
  # Domain    : linuxmuster.lan
  # IP        : 10.0.0.1
  # Netmask   : 255.255.0.0
  # Firewall  : 10.0.0.254
  # Gateway   : 10.0.0.254
  # Interface : ens18
  # Swapsize  : 2G
  # LVM device: /dev/sdb
  # LVM vlms  : var:10,linbo:40,global:10,default-school:100%FREE
  
  ### Finished - a reboot is necessary!

Ist lmn-appliance ohne Fehler durchgelaufen, starte danach den Server neu mit dem Befehl: 

.. code-block:: Bash

  reboot

Danach steht dem Setup v7.2 nichts mehr im Wege.

Paketquellen eintragen
======================

.. hint::

   Dies muss nur ausgeführt werden, sofern Du den Server bzw. die VM nicht mit dem Skript ``lmn-appliance`` vorbereitet haben solltest.

Es müssen für linuxmuster.net v7.2 sowohl die Paketquellen für die v7.1 als auch die Paketquellen für die v7.2 eingetragen werden.

Zur Eintragung der Paketquellen führe folgende Befehle in der Eingabekonsole aus:

.. code-block:: Bash

   sudo sh -c 'wget -qO- "https://deb.linuxmuster.net/pub.gpg" | gpg --dearmour -o /usr/share/keyrings/linuxmuster.net.gpg'

.. hint:: -O --> [-][Großbuchstabe O]

Damit installierst Du den Key für das Repository von linuxmuster.net und aktivierst ihn.

Danach fügst Du zuest das Linuxmuster 7.1 Repository hinzu.

.. code-block:: Bash

   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linuxmuster.net.gpg] https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'

Zuletzt fügst Du das Linuxmuster 7.2 Repository hinzu.

.. code-block:: Bash

   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linuxmuster.net.gpg] https://deb.linuxmuster.net/ lmn72 main" > /etc/apt/sources.list.d/lmn72.list'

Aktualisiere die Softwareliste des Servers:

.. code-block:: Bash

   sudo apt update


