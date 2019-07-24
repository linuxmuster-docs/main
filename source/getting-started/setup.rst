.. _setup-using-selma-label:

===================
 Erstkonfiguration
===================

.. sectionauthor:: `@WildXI <https://ask.linuxmuster.net/u/wildxi>`_,
		   `@TLeibbrand <https://ask.linuxmuster.net/u/tleibbrand>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,
		   `@RolandB <https://ask.linuxmuster.net/u/rolandb>`_

.. hint::

   Alle linuxmuster 6.x Systeme können statt einer Neuinstallation
   über eine :ref:`migration-label` umgezogen werden, dennoch ist die
   Erstkonfiguration hier eine notwendige Voraussetzung.

.. attention::

   Es ist sinnvoll, zu diesem Zeitpunkt ein Snapshot/Backup der
   virtuellen Maschinen anzufertigen, so dass bei einem
   fehlgeschlagenen Setup die Maschinen einfach zurückgesetzt werden
   können.
   
Anpassung des Netzbereiches
===========================

Die Standardkonfiguration wie sie über die Appliances mitgeliefert
wird, sieht vor, dass das Schulnetz die lokale Domäne
``linuxmuster.lan`` bekommt und Geräte im Netzbereich ``10.0.0.0/16``
stehen.

An dieser Stelle *muss* eine Anpassung vorgenommen werden, wenn ein
anderer Netzbereich (z.B. der bisher beliebte Netzbereich
``10.16.0.0/12``) verwendet werden soll.

Systeme, die mit Hilfe der Migration auf linuxmuster.net 7.0 migriert
werden, behalten die bisherige Domäne und den bisherigen
Netzbereich. Dies kann nur durch einen Neuinstallation geändert
werden.

Hilfe findet man in der `Entwicklerdokumentation
<https://github.com/linuxmuster/linuxmuster-base7/wiki/Ersteinrichtung-der-Appliances#serveropsidocker>`_
oder im Forum.


Erstkonfiguration über d'SELMA
==============================

Die Weboberfläche (d'SELMA) erreicht man über einen Browser eines
Gerätes (im folgenden Admin-PC genannt) im Servernetzwerk. Dafür
konfiguriert man den Admin-PC mit der festen IP-Adresse ``10.0.0.10``
(entsprechend ``x.x.x.10`` in jeder anderen Netzwerkkonfiguration) der
Netzwerkmaske ``255.255.0.0``, dem Gateway ``10.0.0.254`` und dem DNS
``10.0.0.1``.

Öffne auf dem Admin-PC mit einem Webbrowser die URL
``http://10.0.0.1:8000``. Melde dich hier einmalig mit dem Benutzer
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
    
.. attention::

   Nach Abschluss des Setups ist die die Domäne des Netzwerks
   permanent festgelegt und nur durch Neuinstallation änderbar.

.. figure:: media/school-information-domain.png
   :align: center
   :alt: School information dialog

Der nächste Dialog legt das Passwort des globalen Administrators
``global-admin`` fest. Die Einschränkungen zur Passwortsicherheit sind
dem Hilfetext zu entnehmen.

.. figure:: media/global-password.png
   :align: center
   :alt: School information dialog

Der letzte Dialog fragt nach den offiziell unterstützenden externen
Diensten, die vorbereitet werden sollen. Darunter sind die Dienste
OPSI, Docker und der (interne) Mailserver, wobei die konventionellen
IP-Adressen hinterlegt sind.  Für den Mailserver sollte ein SMTP-Relay
mit Benutzername und Passwort angegeben werden.

.. figure:: media/external-services.png
   :align: center
   :alt: External services dialog

Vor der tatsächlichen Installation (Provisionierung) wird die
Zusammenfassung angezeigt.

.. figure:: media/summary.png
   :align: center
   :alt: External services dialog

.. attention::

   Wenn die Diensteserver ausgewählt werden, müssen sie auch während
   der dann angestoßenen Installation erreichbar sein.

.. hint::

   Sollte die Installation anhalten oder fehlschlagen, sollte man alle
   Appliances auf den Zustand vor dem Setup zurücksetzen.

Zuletzt weist das Setup darauf hin, dass man sich ab sofort unter der
URL ``https://server.linuxmuster.lan:8000`` mit dem Benutzer
``global-admin`` und dem konfigurierten Passwort anmelden muss.
Allerdings wird ein selbstsigniertes Zertifikat verwendet, das
zuerst akzeptiert werden muss.

	 
Erstkonfiguration am Server
===========================

Alternativ kann die Erstkonfiguration direkt am Server über die
Konsole ausgeführt werden.
	     
Melde dich als `root` mit Passwort `Muster!` auf dem Server an. Das
Setup wird über den Befehl ``linuxmuster-setup --schoolname=Beispielschule --location=Musterstadt --state=Mecklenburg-Vorpommern --country=de`` gestartet. Es
können sämtliche Setup-Werte als Kommandozeilenparameter übergeben
werden oder mit dem Parameter ``--config`` wird eine `ini`-Datei mit
Setupwerten übergeben. Folgendes Beispiel zeigt die wichtigsten
Einstellungen:

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

Ohne Argumente konfiguriert das Skript die entsprechenden Eingaben
über ein Konsolendialog. Es gelten die gleichen Hinweise und Warnungen
wie bei der grafischen Installation.

.. _login-dselma-global-admin:

Login an d'SELMA als global-admin
=================================

Öffne die URL ``https://server.linuxmuster.lan:8000`` mit dem Admin-PC
und akzeptiere beim ersten Aufruf die Ausnahme für das
selbst-signierte Zertifikat.

.. figure:: media/server-postsetup-login-cert.png
   :align: center
   :alt: Accept self-signed certificate 

Melde dich mit dem Benutzer ``global-admin`` mit dem konfigurierten Passwort an.

.. figure:: media/login-global-admin.png
   :align: center
   :alt: Login as global-admin
