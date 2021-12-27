.. _setup-gui-label:

======================
Setup via Schulkonsole
======================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
           `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_,
            `@WildXI <https://ask.linuxmuster.net/u/wildxi>`_,
		   `@TLeibbrand <https://ask.linuxmuster.net/u/tleibbrand>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,
		   `@RolandB <https://ask.linuxmuster.net/u/rolandb>`_


Erstkonfiguration über die Schulkonsole
=======================================

Die Weboberfläche (WebUI/Schulkonsole) erreicht man über einen Browser eines Gerätes (im folgenden Admin-PC genannt) im Servernetzwerk. Dafür
konfiguriert man den Admin-PC mit der festen IP-Adresse ``10.0.0.10`` (entsprechend ``x.x.x.10`` in jeder anderen Netzwerkkonfiguration) der
Netzwerkmaske ``255.255.0.0``, dem Gateway ``10.0.0.254`` und dem DNS-Eintrag ``10.0.0.1``.

Öffne auf dem Admin-PC mit einem Webbrowser die URL ``http://10.0.0.1``. Melde dich hier einmalig mit dem Benutzer ``root`` und dem Passwort ``Muster!`` an.
    
.. figure:: media/newsetup/lmn-setup-gui-setup-00.png
   :align: center
   :alt: WebUI Setup: Root login
    
.. hint::

   Achte darauf, dass vor dem Setup die Verbindung zur Schulkonsole via URL nocht unverschlüsselt mit HTTP erfolgt.

Es erscheint der Hinweis, dass du das Webinterface nicht als Benutzer root benutzen sollst, es sei denn, du verwendest dieses das erste Mal.

.. figure:: media/newsetup/lmn-setup-gui-setup-01.png
   :align: center
   :alt: WebUI Setup: Root login - hint

Rufe das Setup via Button auf dieser Seite auf.

Es erscheint der Einrichtungsassistent, in dem du zunächst die gewünschte Sprache auswählen musst. Zudem musst du die GNU Lizenzbedingungen akzeptieren, indem du bei ``I accept the licence terms`` einen Haken setzt.
    
.. figure:: media/newsetup/lmn-setup-gui-setup-02.png
   :align: center
   :alt: WebUI Setup: Wizard - accept license
    
Danach klickst du auf ``Weiter``.
    
Im nächsten Dialog musst du den Schulnamen, die Stadt, das Bundesland und das Landeskürzel eintragen bzw. auswählen.  Zudem trägst du einen Hostnamen für den Server ein. Der ``Domain name`` spielt eine besondere Rolle, insbesondere, wenn eine Adresse verwendet werden soll, die intern und extern identisch sein soll, so dass mit dem FQDN intern und extern gearbeitet wird.

.. hint:: 

   schule.de oder linuxmuster.lan stellen den Domainnamen mit der sog. Top Lebel Domain (TLD) dar. Die TLD lan wird nicht extern verwendet, sondern ist nur für den  internen Gebrauch sinnvoll. Die TLD de wird extern genutzt. Hat deine Schule die De-Domain meineschule.de registriert, dann musst du hier eine Subdomain angeben, die zugleich die sog. Samba-Domain darstellt. Für den Namen dieser Sub-/Samba-Domain gibt es Einschränkungen, die unbedingt beachtet werden müssen: Es werden nur englische Kleinbuchstaben a bis z akzeptiert. Sonst keinerlei Zeichen. Es dürfen zudem maximal 15 Zeichen verwendet werden. **Richtig**: gshoenningen (12 Zeichen, keine Umlaute und Satzzeichen etc.), **Falsch**: GSO-Heinrich-Böll-Hönningen (26 Zeichen, Großbuchstaben, Umlaute, Bindestriche)

.. figure:: media/newsetup/lmn-setup-gui-setup-03.png
   :align: center
   :alt: WebUI Setup: Wizard - school information

Danach klickst du auf ``Weiter/Next``.

Der nächste Dialog legt das Passwort des globalen Administrators ``global-admin`` und das von ``root`` fest. Die Einschränkungen zur Passwortsicherheit sind dem Hilfetext zu entnehmen.

.. figure:: media/newsetup/lmn-setup-gui-setup-04.png
   :align: center
   :alt: WebUI Setup: Wizard - account information

.. important::

   Nach dem erfolgreichen Abschluss der Erstkonfiguration gilt für ``root`` das neu gesetzte Passwort.

Danach klickst du auf ``Weiter/Next``. Es wird nochnmals die Zusammenfassung der vorgenommenen Einstellungen in der Übersicht dargestellt. Du kannst die getroffenen Einstellungen auch noch prüfen lassen. Danach wird dir wie in der Abb. die geprüfte Zusammenfassung angezeigt

.. figure:: media/newsetup/lmn-setup-gui-setup-05.png
   :align: center
   :alt: WebUI Setup: Wizard - summary with checkes values

In o.g. Abb. wird beim FQDN ein rotes X dargestelt. Dies ist der Hinweis, dass dieser nicht extern erreichbar ist. Solltest du einen FQDN nutzen, der auch extern erreichbar ist, so sollte hier kein x mehr dargestellt werden.

.. hint::

   Sollte die Installation anhalten oder fehlschlagen, sollte man alle
   Appliances auf den Zustand vor dem Setup zurücksetzen.

Starte nun die Installation, in dem Du auf ``Start Provisioning`` klickst.

Es erscheint ein Installationsfenster, in dem die verschiedenen Installationsschritte angezeigt werden. Dieser Vorgang dauert eine ganze Weile.
Ist die INstallation abgeschlossen gelangst du zu folgendem Fenster:

.. figure:: media/newsetup/lmn-setup-gui-setup-06.png
   :align: center
   :alt: WebUI Setup: Wizard - setup finished

Zum Abschluss siehst du den Eintrag 

.. code::

   ### linuxmuster-setup finished at ... ###

Schliesse das Setup nun mit ``Finish`` ab. Es erscheint eine Statusmeldung, dass das Setup abgeschlossen ist und du dich danach mit dem Benutzer ``globa-admin`` anmelden sollst.

.. figure:: media/newsetup/lmn-setup-gui-setup-07.png
   :align: center
   :alt: WebUI Setup: Wizard - setup complete

Bestätigst du dies mit ``Close`` started das Setup nun die Schulkonsole neu und leitet dich auf die verschlüsselte Seite der Webui mit der URL ``https://10.0.0.1`` um. Es wurde beim Setup ein self-signed certificate erstellt, so dass du dieses beim erstmaligen Aufruf mit dem Browser akzetieren musst.

.. figure:: media/newsetup/lmn-setup-gui-setup-08.png
   :align: center
   :alt: WebUI: First ssl access

Der Browser zeigt dir den warnhinweis an. Klicke auf ``Erweitert...``.

.. figure:: media/newsetup/lmn-setup-gui-setup-09.png
   :align: center
   :alt: WebUI: Accept certificate

Es erscheint auf der gleichen Seite unten ein weiterer Eintrag. Bestätige diesen, indem du den Button ``Risiko akzeptieren und fortfahren`` auswählst.

Danach kommst du zur Anmeldeseite der WebUI/Schulkonsole. Melde dich nun als Benutzer ``global-admin`` an und nutze das während des Setups festgelegte Kennwort.

.. figure:: media/newsetup/lmn-setup-gui-setup-10.png
   :align: center
   :alt: WebUI: Login global-admin

Nach erfolgreicher Anmeldung gelangst du zur Hauptseite der Schulkonsole.

.. figure:: media/newsetup/lmn-setup-gui-setup-11.png
   :align: center
   :alt: WebUI: Hauptseite







.. figure:: media/webui7.png
   :align: center
   :alt: Installation Successfull

