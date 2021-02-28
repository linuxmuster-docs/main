.. include:: /guided-inst.subst

.. _setup:

===================
 Erstkonfiguration
===================

.. sectionauthor:: `@WildXI <https://ask.linuxmuster.net/u/wildxi>`_,
		   `@TLeibbrand <https://ask.linuxmuster.net/u/tleibbrand>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,
		   `@RolandB <https://ask.linuxmuster.net/u/rolandb>`_
		   `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

.. hint::

   Alle linuxmuster 6.x Systeme können statt einer Neuinstallation
   über eine :ref:`migration-label` umgezogen werden, dennoch ist die
   Erstkonfiguration hier eine notwendige Voraussetzung.
   
.. hint::
   
   Es gibt 2 Möglichkeiten die Erstkonfiguration durchzuführen: 
   1.: `Erstkonfiguration über die Schulkonsole`_ (Webui)
   2.: `Erstkonfiguration im Terminal`_
   Lies zunächst alle wichtigen Hinweise am Beginn dieses Kapitels und mache dann entweder auf der Schulkonsole oder im Terminal weiter!
   

Wichtige Hinweise
=================

* Nach Abschluss dieses Setups sind die Domäne und andere Details des
  Netzwerks permanent festgelegt und nur durch Neuinstallation
  änderbar. Es ist daher sinnvoll, zu diesem Zeitpunkt ein
  Snapshot/Backup von Server, Firewall und bei Benutzung von
  Dockerhost und OPSI-Host anzufertigen. Bei einem Fehlschlag müssen
  alle diese Maschinen zurückgesetzt werden.
* Beim Domänennamen ist zu beachten, dass der **erste** Teil der
  Domäne nicht länger als 15 Zeichen haben darf. Der Rechnername ist
  damit nicht gemeint. Im Beispiel ``server.linuxmuster.lan`` ist
  ``server`` der Rechner-Kurzname und ``linuxmuster.lan`` die
  Domäne. Dann darf ``linuxmuster`` nicht länger als 15 Zeichen sein.
* Will man eine andere (z.B. auch extern auflösbare) Domäne haben,
  muss man eventuell eine Subdomäne verwenden,
  bspw. ``linuxmuster.magical-animal-school.edu`` statt
  ``magical-animal-school.edu``. Der erste Part ``LINUXMUSTER`` wird
  in diesem Beispiel dann als SAMBA-Domäne verwendet. Der voll Name
  (FQHN) des Servers ist dann
  ``server.linuxmuster.magical-animal-school.edu``.
* Alle Hosts die im Setup konfiguriert werden sollen (docker(mail),
  OPSI) müssen bereits laufen.
* Systeme, die mit Hilfe der Migration auf linuxmuster.net 7.0
  migriert werden, können hier eine neue (oder die alte)
  konfigurieren.


Anpassung des Netzbereiches
===========================

Die Standardkonfiguration wie sie über die Appliances mitgeliefert
wird, sieht vor, dass das Schulnetz die lokale Domäne
``linuxmuster.lan`` bekommt und Geräte im Netzbereich ``10.0.0.0/16``
stehen. Wenn ein anderer Netzbereich (z.B. der bisher beliebte
Netzbereich ``10.16.0.0/12``) verwendet werden soll, *muss* an dieser
Stelle eine Anpassung vorgenommen werden.

Systeme, die mit Hilfe der Migration auf linuxmuster.net 7.0 migriert
werden, sollten den bisherigen Netzbereich behalten. Für die Beibehaltung
des bisherigen Standards der v6.2 mit einem ``10.16.0.0./12`` Netz gibt
es den Begriff ``do-it-like-babo``.

.. hint::

   Die Anpassungen zur Netzkonfiguration sind vor der Ausführung der 
   Erstkonfiguration durchzuführen. Zur Durchführung der Anpassungen
   folge bitte dem Kapitel :ref:`modify-net-label`.

Erstkonfiguration über die Schulkonsole
=======================================

Die Weboberfläche (WebUI/Schulkonsole) erreicht man über einen Browser
eines Gerätes (im folgenden Admin-PC genannt) im Servernetzwerk. Dafür
konfiguriert man den Admin-PC mit der festen IP-Adresse ``10.0.0.10``
(entsprechend ``x.x.x.10`` in jeder anderen Netzwerkkonfiguration) der
Netzwerkmaske ``255.255.0.0``, dem Gateway ``10.0.0.254`` und dem DNS
``10.0.0.1``.

Öffne auf dem Admin-PC mit einem Webbrowser die URL
``http://10.0.0.1``. Melde dich hier einmalig mit dem Benutzer
`root` und dem Passwort `Muster!` an.
    
.. figure:: media/root-login.png
   :align: center
   :alt: root login
    
Es erscheint automatisch der Einrichtungsassistent. Die Sprache kann
ausgewählt werden und die EULA muss akzeptiert werden.
    
.. figure:: media/disclaimer-beta.png
   :align: center
   :alt: Disclaimer dialog
    
   Disclaimer Dialog muss akzeptiert werden
    
Im nächsten Dialog müssen Schulnamen, Stadt, Bundesland und
Landeskürzel eingetragen bzw. ausgewählt werden.  Ebenso wird hier der
Servername und die Domäne für das gesamte Schulnetzwerk
festgelegt.
    
.. figure:: media/school-information-domain.png
   :align: center
   :alt: School information dialog

Der nächste Dialog legt das Passwort des globalen Administrators 
``global-admin`` und das von ``root`` fest. Die Einschränkungen zur
Passwortsicherheit sind dem Hilfetext zu entnehmen.

.. figure:: media/global-password.png
   :align: center
   :alt: School information dialog

.. important::

   Nach dem erfolgreichen Abschluss der Erstkonfiguration gilt für ``root`` das neu
   gesetzte Passwort.

Der letzte Dialog fragt nach den offiziell unterstützenden externen
Diensten, die vorbereitet werden sollen. Darunter sind die Dienste
OPSI, Docker und der (interne) Mailserver, wobei die konventionellen
IP-Adressen hinterlegt sind.  Für den Mailserver sollte ein SMTP-Relay
mit Benutzername und Passwort angegeben werden.

.. attention::

   Wenn die Diensteserver ausgewählt werden, müssen sie auch während
   der dann angestoßenen Installation erreichbar sein, also bei der 
   Vorbereitung importiert bzw. installiert worden sein.

.. figure:: media/external-services.png
   :align: center
   :alt: External services dialog

Vor der tatsächlichen Installation (Provisionierung) wird die
Zusammenfassung angezeigt.

.. figure:: media/summary.png
   :align: center
   :alt: Summary

.. hint::

   Sollte die Installation anhalten oder fehlschlagen, sollte man alle
   Appliances auf den Zustand vor dem Setup zurücksetzen.

Zuletzt weist das Setup darauf hin, dass man sich ab sofort unter der
URL ``https://server.linuxmuster.lan`` mit dem Benutzer
``global-admin`` und dem konfigurierten Passwort anmelden muss.
Allerdings wird ein selbstsigniertes Zertifikat verwendet, das
zuerst akzeptiert werden muss.

.. figure:: media/webui7.png
   :align: center
   :alt: Installation Successfull
	 
Erstkonfiguration im Terminal
=============================

Alternativ zur Schulkonsole kann die Erstkonfiguration direkt am
Server über die Konsole ausgeführt werden. Melde dich als `root` mit
Passwort `Muster!` auf dem Server an.

Das Setup wird über den Befehl ``linuxmuster-setup`` gestartet. Es
*müssen* folgende Setup-Werte als Kommandozeilenparameter übergeben
werden (in einer Zeile):

.. code-block:: console

   linuxmuster-setup --location=Musterstadt --schoolname="Beispiel-Gesamtschule" --country=de --state=MV

weitere Parameter *können* auf der Kommandozeile angegeben werden und
werden in einem Dialogsystem weiter abgefragt. Alternativ kann eine
Konfigurationsdatei mit dem Parameter ``--config`` mit folgendem
Inhalt übergeben werden.

.. code-block:: console
	
   [setup]
   servername = server
   domainname = linuxmuster.lan
   opsiip = 10.0.0.2
   dockerip = 10.0.0.3
   mailip = 10.0.0.3
   dhcprange = 10.0.0.100 10.0.0.200
   smtprelay = mbox1.belwue.de
   smtpuser = smtpadmin
   smtppw = Muster!pw
   adminpw = Muster!pw
   schoolname = Beispiel-Gesamtschule
   location = Musterstadt
   country = de
   state = Mecklenburg-Vorpommern
   skipfw = False


Es gelten die gleichen Hinweise und Warnungen wie bei der grafischen
Installation.

Zum Ende des Setups muss der Webservice neu gestartet werden (oder der
Server wird rebootet):

.. code-block:: console

   # systemctl restart linuxmuster-webui.service

.. _login-dselma-global-admin:

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

Herzlichen Glückwunsch. Die Erstkonfiguration ist nun abgeschlossen. Nun musst du dich entscheiden:

============================================================== =========================
Weiter mit der Benutzer-Aufnahme                               |follow_me2user-creation|
Weiter mit der Migration von einer linuxmuster.net Version 6.2 |follow_me2migration|
============================================================== =========================
