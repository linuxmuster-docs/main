.. _setup-console-label:

=================
Setup im Terminal
=================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
           `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

Alternativ zur Schulkonsole kann die Erstkonfiguration direkt am Server über die Konsole ausgeführt werden. Melde dich als ``root`` mit Passwort ``Muster!`` auf dem Server an.

Das Setup wird über den Befehl ``linuxmuster-setup`` gestartet. Es *müssen* folgende Setup-Werte als Kommandozeilenparameter übergeben werden (in einer Zeile):

.. code-block:: console

   linuxmuster-setup --location="Bad Hönningen" --schoolname="Beispiel-Gesamtschule" --country=de --state=RLP

Weitere Parameter *können* auf der Kommandozeile angegeben werden und werden in einem Dialogsystem weiter abgefragt. Alternativ kann eine
Konfigurationsdatei mit dem Parameter ``--config`` mit folgendem Inhalt übergeben werden.

.. code-block:: console
	
   [setup]
   servername = server
   domainname = gshoennigen.linuxmuster.lan
   dhcprange = 10.0.0.100 10.0.0.200
   schoolname = Beispiel-Gesamtschule
   location = Bad Hönningen
   country = de
   state = Rheinland Pfalz
   skipfw = False



.. hint::
  
   ergänzen - Hinweise zu den Namen und FQDN unbedingt hinzufügen !

Zum Ende des Setups muss der Webservice neu gestartet werden (oder der Server wird rebootet):

.. code-block:: console

   # systemctl restart linuxmuster-webui.service




Login an der Schulkonsole als global-admin
==========================================

Öffne die URL ``https://server.linuxmuster.lan`` mit dem Admin-PC und
akzeptiere beim ersten Aufruf die Ausnahme für das selbst-signierte
Zertifikat.

.. figure:: media/server-postsetup-login-cert.png
   :align: center
   :alt: Accept self-signed certificate 

Melde dich mit dem Benutzer ``global-admin`` und dem konfigurierten
Passwort an.

.. figure:: media/login-global-admin.png
   :align: center
   :alt: Login as global-admin

Herzlichen Glückwunsch. Die Erstkonfiguration ist nun abgeschlossen.
