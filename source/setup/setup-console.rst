.. include:: /guided-inst.subst

.. _setup-console-label:

==================
Set-up im Terminal
==================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

Melde Dich als Benutzer ``root`` mit dem Passwort ``Muster!`` auf dem Server an.

Für diese Anmeldung kannst Du die xterm.js Konsole von Proxmox verwenden, wenn Du unserer Anleitung gefolgt bist. Alternativ kannst Du Dich via ssh von einem anderen Rechner mit dem Server verbinden, wenn er sich im gleichen Netzwerksegment befindet.

Im Terminal wirst Du mit dem Erstbildschirm von linuxmuster.net v7.1 begrüßt.

.. figure:: media/newsetup/lmn-setup-terminal-01.png
   :align: center
   :alt: Terminal after login

Das Set-up wird über den Befehl ``linuxmuster-setup`` gestartet. 

Erfolgt der Aufruf direkt mittels ``linuxmuster-setup`` *müssen* mindestens folgende Setup-Parameter als Kommandozeilenparameter übergeben werden (in einer Zeile) - die angegebene Werte nach dem Gleichheitszeichen sind selbstverständlich nur Beispielwerte:

.. code:: console

   linuxmuster-setup --location="Bad Tuxhausen" --schoolname="Linus-Benedict-Gesamtschule" --country=de --state=SH

Weitere Parameter *können* auf der Kommandozeile angegeben werden. Werden aber auch in einem Dialogsystem abgefragt. Um alle Parameter zu sehen, verwende |...|

.. code::
  
   linuxmuster-setup --help

Die dazugehörende Ausgabe:

.. code::

   Usage: linuxmuster-setup [options]
   [options] may be:
   -n <hostname>,   --servername=<hostname>   : Set server hostname.
   -d <domainname>, --domainname=<domainname> : Set domainname.
   -r <dhcprange>,  --dhcprange=<dhcprange>   : Set dhcp range.
   -a <adminpw>,    --adminpw=<adminpw>       : Set admin password.
   -e <schoolname>, --schoolname=<schoolname> : Set school name.
   -l <location>,   --location=<location>     : Set school location.
   -z <country>,    --country=<country>       : Set school country.
   -v <state>,      --state=<state>           : Set school state.
   -c <file>,       --config=<file>           : path to ini file with setup values
   -u,              --unattended              : unattended mode, do not ask questions
   -s,              --skip-fw                 : skip firewall setup per ssh
   -h,              --help                    : print this help


Alternativ kannst Du eine Konfigurationsdatei mit dem Parameter ``--config`` übergeben.

Willst Du diese Möglichkeit nutzen, lege eine ``config.txt`` mittels des nächsten Befehls an:

.. code:: 

   echo -e "[setup] \nservername = \ndomainname = \ndhcprange = \nschoolname = \nlocation = \ncountry = \nstate = \nskipfw = False" > ~/config.txt
   
Diese Datei musst Du noch mit Deinen Angaben füllen. Hier beispielhaft mit dem Editor nano gezeigt

.. code:: console
	
   nano ~/config.txt

.. figure:: media/newsetup/lmn-setup-terminal-02a.png
   :align: center
   :alt: Terminal Setup: Editor nano config.txt

Hast Du diese Textdatei mit deinen Einträgen gespeichert ``[Strg]+[X]`` --> ``[Y]`` --> ``[Enter]``, kannst Du das Set-up mit folgendem Befehl aufrufen:

.. code::

   linuxmuster-setup --config /root/config.txt

Nach dessen Aufruf, erscheinen in der Konsole nach und nach nochmals relevante Parameter. Hattest Du diese bereits festgelegt, so siehst Du Deine Werte. Bei nicht festgelegten, siehst Du die standardmäßig vorbelegten Werte. Prüfe alle Parameter und passe deren Werte gegebenenfalls an. 

Klicke jeweils auf ``< OK >``, um zum nächsten Schritt zu gelangen.

.. figure:: media/newsetup/lmn-setup-terminal-02.png
   :align: center
   :alt: Terminal Setup: Parameter 1

Danach gelangst Du zur Angabe der sog. Domain. Beachte bei dessen Festlegung u.g. Hinweise zum FQDN.

.. figure:: media/newsetup/lmn-setup-terminal-03.png
   :align: center
   :alt: Terminal Setup: Parameter 2

.. hint::
  Der ``Domain name`` spielt eine besondere Rolle, insbesondere, wenn eine Adresse verwendet werden soll, die intern und extern identisch sein soll, sodass mit dem FQDN intern und extern gearbeitet wird. **schule.de** oder **linuxmuster.lan** stellen den Domainnamen mit der sog. Top-Level-Domain (TLD) dar. Die TLD **lan** wird nicht extern verwendet, sondern ist nur für den  internen Gebrauch sinnvoll. Die TLD de wird extern genutzt. Hat Deine Schule die de-Domain meineschule.de registriert, dann musst Du hier eine Subdomain angeben, die zugleich die sog. Samba-Domain darstellt. Für den Namen dieser Sub-/Samba-Domain gibt es Einschränkungen, die unbedingt beachtet werden müssen: Es werden nur englische Kleinbuchstaben a bis z akzeptiert. Sonst keinerlei Zeichen. Es dürfen zudem maximal 15 Zeichen verwendet werden. **Richtig**: gshoenningen (12 Zeichen, keine Umlaute und Satzzeichen etc.), **Falsch**: GSO-Heinrich-Böll-Hönningen (26 Zeichen, Großbuchstaben, Umlaute, Bindestriche)

Klicke auf ``< OK >``. Es erscheint der IP-Adressbereich, der für die Rechneraufnahme mit Linbo reserviert wird. In der Abb. ist dies der Bereich ``10.0.0.100`` bis ``10.0.0.200``.

.. figure:: media/newsetup/lmn-setup-terminal-04.png
   :align: center
   :alt: Terminal Setup: Parameter 3

Klicke auf ``< OK >``. Danach gelangst Du zur Eingabe des neuen Administrator-Kennworts. Dieses ist zugleich das neue Kennwort des Benutzers ``gobal-admin`` in der Schulkonsole.

.. figure:: media/newsetup/lmn-setup-terminal-05.png
   :align: center
   :alt: Terminal Setup: Parameter 4

.. todo:: Passwortbeschränkungen einfügen, siehe Setup-WebUi
          Laut WebUI wären das: Valid characters are: a-z A-Z 0-9 ?!§+-@#$%&*( )[ ]{ }

.. hint::

   * Das beim Set-up eingegebene Admin-Passwort wird für folgende administrativen User gesetzt:
      * root auf dem Server
      * root auf der Firewall
      * global-admin (AD)
      * pgmadmin (AD)
      * linbo (/etc/rsyncd.secrets)
   * Es sollten die Passwörter der o.g. User nach dem Set-up geändert werden, sodass jeder User ein eigenes Password hat.


Gebe das Kennwort ein und klicke auf ``< OK >``.

.. figure:: media/newsetup/lmn-setup-terminal-06.png
   :align: center
   :alt: Terminal Setup: Parameter 5

Bestätige dieses Kennwort und klicke auf ``< OK >``.

Danach wird das Set-up gestartet. Es dauert einige Zeit, bis alle erforderlichen Dienste und die OPNsense eingerichtet wurden.

.. figure:: media/newsetup/lmn-setup-terminal-07.png
   :align: center
   :alt: Terminal Setup: Services

Nach Abschluss des Setups siehst Du im Terminal, dass das Set-up beendet wurde.

.. figure:: media/newsetup/lmn-setup-terminal-08.png
   :align: center
   :alt: Terminal Set-up finished

Danach muss noch der Dienst für die WebUI/Schulkonsole oder der Server neu gestartet werden.

.. code::

   # systemctl restart linuxmuster-webui.service

alternativ

.. code::

   # reboot

Das erste Verfahren hat den Vorteil, dass Du nicht die Zeit des Neustarts abwarten, Dich erneut verbinden und anmelden musst.

Nach abgeschlossenem Set-up und eventuellen Neustart des Servers, kannst Du Dich mit einem PC via Browser an der Schulkonsole von linuxmuster.net v7.1 anmelden. Dafür muss sich der Rechner im internen LAN befinden (z.B. 10.0.0.10/16).

Anmeldung an der Schulkonsole als global-admin
==============================================

Öffne die URL ``https://10.0.0.1`` mit dem Admin-PC. Es wurde beim Set-up ein self-signed certificate erstellt, sodass Du dieses beim erstmaligen Aufruf mit dem Browser akzeptieren musst.

.. figure:: media/newsetup/lmn-setup-gui-09.png
   :align: center
   :alt: WebUI: First ssl access

Der Browser zeigt Dir den Warnhinweis an. Klicke auf ``Erweitert ...``.

.. figure:: media/newsetup/lmn-setup-gui-10.png
   :align: center
   :alt: WebUI: Accept certificate

Es erscheint auf der gleichen Seite unten ein weiterer Eintrag. Bestätige diesen, indem Du den Button ``Risiko akzeptieren und fortfahren`` auswählst.

Danach kommst Du zur Anmeldeseite der WebUI/Schulkonsole. Melde Dich nun als Benutzer ``global-admin`` an und nutze das während des Setups festgelegte Kennwort.

.. figure:: media/newsetup/lmn-setup-gui-11.png
   :align: center
   :alt: WebUI: Login global-admin

Nach erfolgreicher Anmeldung gelangst Du zur Hauptseite der Schulkonsole.

.. figure:: media/newsetup/lmn-setup-gui-12.png
   :align: center
   :alt: WebUI: Hauptseite

Berechtigungen der Log-Dateien anpassen
=======================================

Nach dem erfolgreichen Set-up verbindest Du Dich via ssh auf den Server. 

Zum Abschluss sind noch die Dateiberechtigung für die linuxmuster Log-Dateien anzupassen.

Setze die Berechtigungen nun mit folgendem Befehl als Benutzer ``root``:

.. code::

  chmod 600 /var/log/linuxmuster/setup.*.log 

Lasse Dir den Inhalt des Verzeichnisses danach ausgeben und kontrollieren, ob Besitzer und Gruppe root sind und diese lesen und schreiben dürfen. 

.. code::

   ls -alh /var/log/linuxmuster/

Der Inhalt des Verzeichnisses sollte sich wie folgt darstellen:

.. figure:: media/newsetup/lmn-setup-permissions-log-files.png
   :align: center
   :alt: directory listing log files

Setze die Ersteinrichtung fort, indem Du :ref:`add-user-accounts-label` und :ref:`masterclient-template-label` aufrufst.
