.. include:: ../../guided-inst.subst

.. _lmn_pre_install-label:

=============================
Server auf lmn7.2 vorbereiten
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
   sudo apt-get purge cloud-init
   sudo rm -rf /etc/cloud/ && sudo rm -rf /var/lib/cloud/
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

Skript herunterladen
--------------------

Wenn Du nicht mehr an Deinem Server eingeloggt bist, melde Dich erneut an.

Führe danach folgende Befehle in der Eingabekonsole aus:

.. code-block:: Bash

  wget https://raw.githubusercontent.com/linuxmuster/linuxmuster-prepare/master/lmn-appliance
  chmod +x lmn-appliance

Das Skript ist wir folgt zu starten:

.. code-block:: Bash

  ./lmn-appliance <Optionen>

Führe aber zuvor nachstehende Schritte aus.

Default-Locale setzen
---------------------

Passe noch vor der Ausführung von lmn-prepare auf dem Server die ``Default-Locale`` an.

Erzeuge zuerst die Locales mit:

.. code-block:: Bash

   $sudo locale-gen
   Generating locales (this might take a while)...
   de_DE.UTF-8... done
   en_GB.UTF-8... done
   en_US.UTF-8... done
   fr_FR.UTF-8... done
   Generation complete.

Setze nun die Default-Locale. Diese muss unbedingt in o.g. Ausgabe enthalten sein!

.. code-block:: Bash

   $sudo localectl set-locale LANG=de_DE.UTF-8


.. attention:: Wichtiger Hinweis, schon jetzt!

   Solltest Du mit Deiner Konfiguration von unseren Standard-Vorgaben bei dem zuletzt genannten Punkt abweichen, müssen Deine Einstellungen unbedingt vor dem Aufruf des Skriptes lmn-prepare eingearbeitet sein!

   :ref:`basis_opnsense`
   
   :ref:`basis_server-label`

Letzter Test vor Anwendung des Skriptes lmn-appliance
-----------------------------------------------------

Als letzte Überprüfung, bevor Du das Skript einsetzt, verbinde Dich vom Server aus mit der Firewall via ssh.

.. code-block:: Bash

   ssh root@10.0.0.254

Du solltest Dich nach der Eingabe des Passwortes ``Muster!`` auf der Konsole der OPNsense |reg| wiederfinden. Eventuell musst Du auch vorher deren Key akzeptieren. Mit ``0`` solltest Du Dich wieder ausloggen und zurück auf der Server-Konsole sein.

Sollte dieser Test erfolgreich sein, steht der abschließenden Vorbereitung nichts mehr im Wege:

Aufruf lmn-appliance
--------------------

Wechsele Deinen Log-in und werde ``root``:

.. code-block:: Bash

   sudo -i

Rufe nun das Skript ``lmn-appliance`` so auf, dass eine Server Appliance vorbereitet wird und das LVM auf der zweiten Festplatte eingerichtet wird.

.. code-block:: Bash

  ./lmn-appliance -p server -u -l /dev/sdb

Mit dem Parameter -u wird dann ein LVM - hier auf der 2. Festplatte (sdb) - mit folgenden Werten eingerichtet:

    var: 10 GiB

    linbo: 40 GiB

    global: 10GiB

    default-school: restlicher Plattenplatz

Weitere Skript-Parameter findest Du hier dokumentiert: https://github.com/linuxmuster/linuxmuster-prepare


Installation mit Deinen Vorgaben
================================

Nachstehendes Beispiel geht davon aus, dass Du eine zweite HDD mit einer Größe von 1TiB hast.

.. code-block:: Bash

  lmn-appliance -i -p server -l /dev/sdb -v var:50,linbo:500,global:50,default-school:100%FREE

Es wird hier also eine Erstinstallation (-i) mit dem Profil server auf der zweiten Festplatte (/dev/sdb) durchgeführt. Auf der zweiten Platte werden vier Volumes mit

    var: 50GiB

    linbo: 500GiB

    global: 50GiB

    default-school: verbleibender Rest der zweiten Festplatte - hier 400 GiB -

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

   sudo wget -qO- "https://deb.linuxmuster.net/pub.gpg" | gpg --dearmour -o /usr/share/keyrings/linuxmuster.net.gpg

.. hint:: -O --> [-][Großbuchstabe O]

Damit installierst Du den Key für das Repository von linuxmuster.net und aktivierst ihn.

Danach fügst Du zuest das Linuxmuster 7.1 Repository hinzu.

.. code-block:: Bash

   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linuxmuster.net.gpg] https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'

Zuletzt fügst Du das Linuxmuster 7.2 Repository hinzu.

.. code-block:: Bash

  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linuxmuster.net.gpg] https://deb.linuxmuster.net/ lmn72 main" > /etc/apt/sources.list.d/lmn72.list'

Aktualisiere die Softwareliste des Servers mittels

.. code-block:: Bash

   sudo apt update