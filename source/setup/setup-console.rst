.. _setup-console-label:

=================
Setup im Terminal
=================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

Setup via Terminal
==================

Alternativ zur Schulkonsole kann die Erstkonfiguration direkt am Server über die Konsole ausgeführt werden. Melde dich via SSH als Benutzer ``root`` mit dem Passwort ``Muster!`` auf dem Server an.

Im Terminal wirst du mit dem Erstbildschirm von linuxmuster.net v7.1 begrüsst.

.. figure:: media/newsetup/lmn-setup-terminal-01.png
   :align: center
   :alt: Terminal after login

Das Setup wird über den Befehl ``linuxmuster-setup`` gestartet. Es *müssen* folgende Setup-Parameter als Kommandozeilenparameter übergeben werden (in einer Zeile) - die angegebene Werte sind nur Beispielwerte:

.. code:: console

   linuxmuster-setup --location="Bad Hönningen" --schoolname="Berthold-Brecht-Gesamtschule" --country=de --state=RLP

Weitere Parameter *können* auf der Kommandozeile angegeben werden und werden in einem Dialogsystem weiter abgefragt. 
Alternativ kann eine Konfigurationsdatei mit dem Parameter ``--config`` mit folgendem Inhalt (Achtung: Beispielwerte - bitte anpassen) übergeben werden:

.. code:: console
	
   [setup]
   servername = server
   domainname = gshoennigen.linuxmuster.lan
   dhcprange = 10.0.0.100 10.0.0.200
   schoolname = Berthold-Brecht-Gesamtschule
   location = Bad Hönningen
   country = de
   state = Rheinland Pfalz
   skipfw = False

Hast du eine Textdatei mit o.g. Einträgen unter ``/root/setup.txt`` erstellt, so kannst du das Setup mit folgendem Befehl aufrufen:

.. code::

   linuxmuster-setup --config =/root/config.txt

Hast du das Setup aufgerufen, erscheinen in der Konsole nach und nach nochmals relevante Parameter. Hattest du diese bereits festgelegt, so siehst du deine Werte, hast du diese nicht festgelegt, so siehst du die vorbelegten Werte. Prüfe alle Parameter und passe deren Werte ggf. an. Klicke jeweils auf ``< OK >``, um zum nächsten Schritt zu gelangen.

.. figure:: media/newsetup/lmn-setup-terminal-02.png
   :align: center
   :alt: Terminal Setup: Parameter 1

Danach gelangst du zur Angabe der sog. Domain. Beachte bei dessen Festlegung u.g. Hinweise zum FQDN.

.. figure:: media/newsetup/lmn-setup-terminal-03.png
   :align: center
   :alt: Terminal Setup: Parameter 2

.. hint::
  Der ``Domain name`` spielt eine besondere Rolle, insbesondere, wenn eine Adresse verwendet werden soll, die intern und extern identisch sein soll, so dass mit dem FQDN intern und extern gearbeitet wird. **schule.de** oder **linuxmuster.lan** stellen den Domainnamen mit der sog. Top Lebel Domain (TLD) dar. Die TLD lan wird nicht extern verwendet, sondern ist nur für den  internen Gebrauch sinnvoll. Die TLD de wird extern genutzt. Hat deine Schule die de-Domain meineschule.de registriert, dann musst du hier eine Subdomain angeben, die zugleich die sog. Samba-Domain darstellt. Für den Namen dieser Sub-/Samba-Domain gibt es Einschränkungen, die unbedingt beachtet werden müssen: Es werden nur englische Kleinbuchstaben a bis z akzeptiert. Sonst keinerlei Zeichen. Es dürfen zudem maximal 15 Zeichen verwendet werden. **Richtig**: gshoenningen (12 Zeichen, keine Umlaute und Satzzeichen etc.), **Falsch**: GSO-Heinrich-Böll-Hönningen (26 Zeichen, Großbuchstaben, Umlaute, Bindestriche)

Klicke auf ``< OK >``. Es erscheint der IP-Adressbereich, der für die Rechneraufnahme mit Linbo reserviert wird. In der Abb. ist dies der Bereich ``10.0.0.100`` bis ``10.0.0.200``.

.. figure:: media/newsetup/lmn-setup-terminal-04.png
   :align: center
   :alt: Terminal Setup: Parameter 3

Klicke auf ``< OK >``. Danach gelangst du zur Eingabe des neuen Administrator-Kennworts. Dieses ist zugleich das neue Kennwort des Benutzers ``gobal-admin`` in der Schulkonsole.

.. figure:: media/newsetup/lmn-setup-terminal-05.png
   :align: center
   :alt: Terminal Setup: Parameter 4

.. hint::

   * Das beim Setup eingegebene Adminpasswort wird für folgende administrativen User gesetzt:
      * root auf dem Server
      * root auf der Firewall
      * global-admin (AD)
      * pgmadmin (AD)
      * linbo (/etc/rsyncd.secrets)
   * Es sollten die Passwörter der o.g. User nach dem Setup geändert werden, sodass jeder User ein eigenes Password hat.


Gebe das kennwort ein und klicke auf ``< OK >``.

.. figure:: media/newsetup/lmn-setup-terminal-06.png
   :align: center
   :alt: Terminal Setup: Parameter 5

Bestätige dieses Kennwort und klicke auf ``< OK >``.

Danach wird das Setup gestartet. Es dauert eine Zeit bis alle erforderlichen Dienste und die OPNsense eingerichtet wurden.

.. figure:: media/newsetup/lmn-setup-terminal-07.png
   :align: center
   :alt: Terminal Setup: Services

Nach Abschluss des Setups siehst du im Terminal, dass das Setup beendet wurde.

.. figure:: media/newsetup/lmn-setup-terminal-08.png
   :align: center
   :alt: Terminal Setup finished

Danach muss noch der Dienst für die WebUI/Schulkonsole neu gestartet oder der Server neu gestartet werden:

.. code::

   # systemctl restart linuxmuster-webui.service

   alternativ

   # reboot


Nach abgeschlossenem Setup und Neustart des Servers kannst du dich nun mit einem PC, der im internen LAN eingebunden ist, dich via Browser an der Schulkonsole von linuxmuster.net v7.1 anmelden.

Anmeldung an der Schulkonsole als global-admin
==============================================

Öffne die URL ``https://10.0.0.1`` mit dem Admin-PC. Es wurde beim Setup ein self-signed certificate erstellt, so dass du dieses beim erstmaligen Aufruf mit dem Browser akzetieren musst.

.. figure:: media/newsetup/lmn-setup-gui-09.png
   :align: center
   :alt: WebUI: First ssl access

Der Browser zeigt dir den Warnhinweis an. Klicke auf ``Erweitert...``.

.. figure:: media/newsetup/lmn-setup-gui-10.png
   :align: center
   :alt: WebUI: Accept certificate

Es erscheint auf der gleichen Seite unten ein weiterer Eintrag. Bestätige diesen, indem du den Button ``Risiko akzeptieren und fortfahren`` auswählst.

Danach kommst du zur Anmeldeseite der WebUI/Schulkonsole. Melde dich nun als Benutzer ``global-admin`` an und nutze das während des Setups festgelegte Kennwort.

.. figure:: media/newsetup/lmn-setup-gui-11.png
   :align: center
   :alt: WebUI: Login global-admin

Nach erfolgreicher Anmeldung gelangst du zur Hauptseite der Schulkonsole.

.. figure:: media/newsetup/lmn-setup-gui-12.png
   :align: center
   :alt: WebUI: Hauptseite

Berechtigungen der Log-Dateien anpassen
=======================================

Nach dem erfolgreichen Setup verbindest du dich via ssh auf den Server. 

Zum Abschluss sind noch die Dateiberechtigung für die linuxmuster Log-Dateien anzupassen.

Setze die Berechtigungen nun mit folgendem Befehl als Benutzer ``root``:

.. code::

  chmod 600 /var/log/linuxmuster/setup.*.log 

Lasse dir den Inhalt des Verzeichnisses danach ausgeben und kontrollieren, ob Besitzer und Gruppe root sind und diese lesen und schreiben dürfen. 

.. code::

   ls -alh /var/log/linuxmuster/

Der Inhalt des Verzeichnisses sollte sich wie folgt darstellen:

.. figure:: media/newsetup/lmn-setup-permissions-log-files.png
   :align: center
   :alt: directory listing log files

.. todo: :ref:Ziel muss gesetzt werden, nächster Satz 

Setze die Ersteinrichtung fort, indem du :ref:`add-user-accounts-label` und ref:`add-devices-label` aufrufst.
