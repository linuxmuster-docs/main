.. include:: ../../guided-inst.subst

.. _lmn_pre_install-label:

=============================
Server auf lmn7.1 vorbereiten
=============================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
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

   timedatectl set-timezone Europe/Berlin
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
   sudo apt-get purge cloud-init
   sudo rm -rf /etc/cloud/ && sudo rm -rf /var/lib/cloud/
   # Reboot
   sudo reboot

Das Skript lmn-prepare
========================

Installation des Pakets ``linuxmuster-prepare``
------------------------------------------------

Wenn Du nicht mehr an Deinem Server eingeloggt bist, melde Dich erneut an.

Führe danach folgende Befehle in der Eingabekonsole aus:

.. code-block:: Bash

   sudo wget -q "https://deb.linuxmuster.net/pub.gpg" -O /etc/apt/trusted.gpg.d/linuxmuster.net.gpg

.. hint:: -O --> [-][Großbuchstabe O]

Damit installierst Du den Key für das Repository von linuxmuster.net und aktivierst ihn.

Die nächste Zeile fügt das Linuxmuster 7.1 Repository hinzu.

.. code-block:: Bash

   sudo sh -c 'echo "deb https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'

Aktualisiere die Softwareliste des Servers mittels

.. code-block:: Bash

   sudo apt update

Damit ist die Vorbereitung abgeschlossen und Du installierst das Paket "linuxmuster-prepare".

.. code-block:: Bash

   sudo apt install linuxmuster-prepare

Nachdem Du den Befehl mit ``J`` bestätigt hast, wird das Skript lmn-prepare auf den Server geladen, welches |...|

   - die benötigten Linuxmuster-Pakete und die benötigten anderen Pakete installiert,
   - das Betriebssystem des Servers nochmals auf den aktuellen Stand bringt,
   - das root-Passwort auf Muster! setzt,
   - das Netzwerk konfiguriert und
   - im Falle des Serverprofils das LVM eingerichtet.

.. attention:: Wichtiger Hinweis, schon jetzt!

   Solltest Du mit Deiner Konfiguration von unseren Standard-Vorgaben bei dem zuletzt genannten Punkt abweichen, müssen Deine Einstellungen unbedingt vor dem Aufruf des Skriptes lmn-prepare eingearbeitet sein!

   :ref:`basis_opnsense`
   
   :ref:`basis_server-label`

Letzter Test vor Anwendung des Skriptes "lmn-prepare"
-------------------------------------------------------

Als letzte Überprüfung, bevor Du das Skript einsetzt, verbinde Dich vom Server aus mit der Firewall via ssh.

.. code-block:: Bash

   ssh root@10.0.0.254

Du solltest Dich nach der Eingabe des Passwortes ``Muster!`` auf der Konsole der OPNsense |reg| wiederfinden. Eventuell musst Du auch vorher deren Key akzeptieren. Mit ``0`` solltest Du Dich wieder ausloggen und zurück auf der Server-Konsole sein.

Sollte dieser Test erfolgreich sein, steht der abschließenden Vorbereitung nichts mehr im Wege:

Aufruf lmn-prepare
--------------------

Wechsele Deinen Log-in und werde ``root``:

.. code-block:: Bash
 
   sudo -i

Für die weitere Konfiguration nutzt Du unser lmn-prepare Script. Hilfe erhältst Du mittels

.. code-block:: Bash

   lmn-prepare -h

Hier ein Auszug mit den benötigten Optionen, die Du gleich anwenden wirst.

.. code-block:: Bash

   Usage: lmn-prepare [options]

   [options] are:

   -x, --force                 : Force run on an already configured system.
   -i, --initial               : Prepare the appliance initially for rollout.
   -s, --setup                 : Further appliance setup (network, swapsize).
                                 on the profile).
   |...|
   -p, --profile=<profile>     : Host profile to apply, mandatory. Expected
                                 values are "server" or "ubuntu".
   -l, --pvdevice=<device>     : Initially sets up lvm on the given device (server
                                 profile only). <device> can be a partition or an
                                 entire disk.
   -v, --volumes=<volumelist>  : List of lvm volumes to create (to be used together
                                 with -l/--pvdevice). Syntax (size in GiB):
                                 <name>:<size>,<name>:<size>,...
   |...|

#####

Installation mit Standard-Vorgaben
----------------------------------

Hast Du eine zweite HDD mit 100GiB kannst Du lmn-prepare mit den Standard-Werten ausführen.

.. code::

   lmn-prepare -i -p server -l /dev/sdb -u


Mit dem Parameter ``-u`` wird dann ein LVM - hier auf der 2. Festplatte (sdb) - mit folgenden Werten eingerichtet:

- var: 10 GiB
- linbo: 40 GiB
- global: 10GiB
- default-school: restlicher Plattenplatz


Installation mit Deinen Vorgaben
---------------------------------

Nachstehendes Beispiel geht davon aus, dass Du eine zweite HDD mit einer Größe von 1TiB hast.

.. code-block:: Bash

   lmn-prepare -i -p server -l /dev/sdb -v var:50,linbo:500,global:50,default-school:100%FREE

Für zusätzliche Informationen bitte https://github.com/linuxmuster/linuxmuster-prepare beachten.

Es wird hier also eine Erstinstallation (-i) mit dem Profil ``server`` auf der zweiten Festplatte (/dev/sdb) durchgeführt. Auf der zweiten Platte  werden vier Volumes mit 

- var: 50GiB
- linbo: 500GiB
- global: 50GiB
- default-school: verbleibender Rest der zweiten Festplatte - hier 400 GiB -

eingerichtet.

.. attention::

   Passe die Größenangaben auf Deine Situation an.

Ablauf
------

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


Ist lmn-prepare ohne Fehler durchgelaufen, starte den Server nun neu mit dem Befehl: ``reboot``

Danach steht dem :ref:`setup-label` nichts mehr im Wege.
