.. include:: /guided-inst.subst

.. _install-linux-clients-former-method-label:

===================
(old) Linux-Clients
===================

.. sectionauthor:: `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_

.. attention::

  Das hier beschriebene Verfahren basiert auf der Bereitstellung eines vorkonfigurierten Linux-Clients und dessen Einbindung in die Domäne mithilfe eines nicht weiter gepflegten Linux-Pakets für Ubuntu. Es gibt hierzu keine Unterstützung durch die Entwickler und es wurden immer wieder Probleme mit dem Domänenbeitritt berichtet. Es wird empfohlen, auf das aktuelle Verfahren zu wechseln.

In dieser Anleitung wird beschrieben, wie du Linux auf einer Musterarbeitsstation installiert. Ein fertig vorkonfiguriertes Abbild liegt zum Download bei linuxmuster.net bereit und kann sofort auf alle Arbeitsstationen verteilt werden.

Arbeitsstationen ("Clients") werden in der linuxmuster.net über die Software LINBO ("GNU/Linux Network Boot") installiert.

Alle Arbeitsschritte, die Änderungen am Server benötigen, werden an einer Serverkonsole erledigt.

.. _download-default-cloop:

Einrichten eines Linuxclients
=============================

Mit dem Befehl ``linuxmuster-client`` aus dem Paket ``linuxmuster-client-servertools`` wird von linuxmuster.net ein Paket heruntergeladen, das eine Image-Datei (``cloop-Datei``) und weitere dazugehörige Daten enthält. 

Rufe die Liste aller verfügbaren Clientabbilder auf:
  
.. code-block:: console
   
   server ~ # linuxmuster-client list
   Hole Liste der verfügbaren cloops...OK
   +++ Auflistung +++
   
   Imagename                 Info
   -----------------------------------------------------
   ubuntu_vanilla            Ubuntu 18.04.4, ssh enabled, login linuxadmin (Muster!)
   lmn-bionic-200507         Ubuntu 18.04..4 LTS default
   ------------------------------------------------------

Lade das Abbild deiner Wahl (hier: `lmn-bionic-200507`) herunter und lasse alle benötigten Dateien einrichten (z.B. Patchklasse für die Hardwareklasse, das Postsync-Script etc.):

.. code-block:: console

   server ~ # linuxmuster-client -r lmn-bionic-200507 auto

Es wird geprüft, ob Dateien mit diesem Namen schon existieren, weil selbst schon eine Rechnergruppe mit dem Namen angelegt wurde, oder man dieses Image zum wiederholten Mal herunterlädt. 

Liegt das Image schon vor, ist ein Download nicht mehr erfordelich, so dass dann nur noch die Integrität der cloop-Datei geprüft wird und alle Dateien entpackt werden.

Ist ein Überschreiben der cloop-Datei oder der Dateien der Patchklasse für Linbo erforderlich oder gewünscht, so ist mit o.g. Befehl die Option -f (force) anzugeben.

Die wichtigsten Dateien, die angelegt werden sind:

.. code-block:: bash

   /srv/linbo/start.conf.lmn-bionic-200507
   /srv/linbo/lmn-bionic-200507.cloop
   /srv/linbo/lmn-bionic-200507.cloop.postsync
   /srv/linbo/linuxmuster-client/lmn-bionic-200507/common/postsync.d/*
   
Ändern des Passworts des Vorlagenbenutzers
------------------------------------------

Lädt man die Vorlagen herunter so heißt der Vorlagenbenutzer ``linuxadmin``. Dem Nutzer wurde in der Vorlage das Kennwort ``Muster!`` zugewiesen. Hiermit kannst du dich nach dem Startvorgang am Linux-Client lokal anmelden und Anpassungen vornehmen bzw. ebenfalls das Kennwort ändern.

Du kannst das Kennwort das Vorlagenbenutzers aber auch direkt vom Server aus ändern. Mit folgendem Befehl legt man das Passwort des Vorlagenbenutzers im später gestarteten Linuxclient fest.

.. code-block:: console
   
   server ~ # linuxmuster-client -p <pw> -l <localname> setpw

``<pw>`` - hier musst du das neuen Kennwort angeben, das wird dann für den Vorlagenbenutzer direkt gesetzt.

``<localname>`` - dies entspricht der Patchklasse für Linbo - also hier z.B. lmn-bionic-200507

Das Kennwort für den Vorlagenbenutzer wird in der Patchklasse hier abgelegt:

``/srv/linbo/linuxmuster-client/lmn-bionic-200507/common/passwords``

Masterclient aufnehmen
======================

Der erste Arbeitsplatzrechner (hier: Masterclient genannt) kann jetzt in die Rechnergruppe "lmn-bionic-200507" aufgenommen werden.

Der Zielrechner wird in der Schulkonsole aufgenommen (z.B. `r10001`) und im Menüpunkt LINBO der richtigen Gruppe (z.B. `lmn-bionic-200507`) zugewiesen, siehe :ref:`add-computer-label`.

.. hint::

   In der start.conf.lmn-bionic-200507 findst du die Paritionsgrößen. In der vorgefertigsten start.conf wird davon ausgegangen, dass du eine Festplatte mit mind. 70 GB einsetzt. Wünschst du eine andere Größe, passe diese in der Datei zuvor an und führen den nachstehenden Befehl zum Import des Gerätes aus.
     
Internetverbindung ohne Proxy
-----------------------------

Zunächst muss der Masterclient ohne Proxy-Authentifizierung ins Internet kommen. Die empfohlene Vorgehensweise ist, die IP-Adresse des Masterclients (temporär) in die "NoProxy" Zugriffsliste auf der Firewall aufzunehmen.

.. todo:: Sollte dieses näher beschrieben werden? (Bzw. ref)

Masterclient als neues Device
-----------------------------

Du musst nun einem Gerät in deinem Netz die neue Hardwareklasse ``lmn-bionic-200507`` zuweisen, so dass das Gerät mit der neuen Vorlage startet. Du kannst dann Anpassungen vornehmen, das Geräte in die Domäne aufnehmen und eine neue cloop-Datei erstellen. Diese kannst du an alle gewünschten Geräte verteilen.

Editiere hierzu die Datei ``/etc/linuxmuster/sophomorix/default-school/devices.csv``.

Tragen das Gerät mit der neuen Hardwareklasse wie folgt ein:

.. code-block:: bash

   r100;r10001;lmn-bionic-200507;AA:AA:BB:12:34:56;10.2.100.1;;;;classroom-studentcomputer;;1;;;;;

Speichere die Änderungen ab und importiere das neue Gerät mit:

.. code-block:: console

   server # linuxmuster-import-devices


Masterclient synchronisieren
----------------------------

Um den Client `r10001` erstmalig zu partitionieren, formatieren, synchronisieren und zu starten, führe auf dem Server folgenden Befehl aus 

.. code-block:: console

   # linbo-remote -i r10001 -p partition,format,initcache:torrent,sync:1,start:1

Starte nun den Client und verfolge die vollautomatische Einrichtung. 

.. todo:: Nächsten Absatz (Sätze 1 und 2) überarbeiten. Ist das zielführend im Zusammenhang mit dem zuvor genannten -p ohne -w?

Sollte der PC nicht starten, so sind die Wake-on-LAN Funktionen nicht korrekt konfiguriert. Dann musst du den PC von Hand booten. Der PC bootet in die Linbo-Umgebung, dort musst du diesen dann partitionieren, den Cache befüllen und den Linux-Client synchronisiert starten.

Nachdem der Linux-Client gestartet wurde, melde dich mit ``linuxadmin`` und dem Vorlagenkennwort am Client an.

Solltest du dich mit dem Vorlagenbenutzer nicht anmelden können, so führe auf dem Server o.g. Befehl zur Vergabe eines neuen Kennworts für den Vorlagenbenutzer mit deinem gewünschten Kennwort aus. Danach starte den Client erneut, so dass der Vorlagenbenutzer ``linuxadmin`` sich danach mit dem neu vergebenen Kennwort anmelden kann.

Masterclient erstmalig aufnehmen
--------------------------------

Starte in einem Terminal (oder über ssh vom Server aus) auf dem Linux-Client den Befehl ``sudo linuxmuster-cloop-turnkey``, der das System aktualisiert und einmalig die Domänenaufnahme vornimmt.

.. code-block:: console

   # sudo linuxmuster-cloop-turnkey

.. hint:: Erhalten Sie einen Hinweis, dass der Vorgang abgeschlossen wurde, starten Sie den PC neu und **wählen Sie nach dem Reboot in Linbo die Reiterkarte ``Imaging``**.

.. attention:: Der so in die Domäne aufgenomme Client muss momentan immer in der device.csv vorhanden bleiben! Darf also weder umbenannt oder gelöscht werden! 

   Hintergrund: Aufgrund eines Problems mit den ausgestellten Kerberos-Tickets verlieren alle Clients, die das gleiche Image verwenden wie der gerade aufgenommene, die Vertrauensstellung mit der Domäne. Das Problem ist bekannt und wird bearbeitet.

Neues Image erstellen
---------------------

Erstelle nun ein neues Image, indem du auf ``Image erstellen`` klickst. Gebe eine Beschreibung zum Image ein und starte die Image-Erstellung mit ``erstellen+hochladen``.

Wurde das Image erfolgreich erstellt, so wurde die cloop-Datei auf dem Server neu erstellt und die bisherige cloop-Datei findet sich mit Angabe eines Zeitstempels im Dateinamen weiterhin auf dem Server unter 
``/srv/linbo/``. Hier findst du auch eine Datei mit dem Namen ``lml-bionic-200507.cloop.macc``. Ist diese Datei vorhanden so wurde dieses Cloop / der PC in die Domäne aufgenommen.

Reboote den Client und starte ihn synchronisiert. Du kannst dich jetzt mit deinen User-Account am System anmelden.

Die cloop-Vorlage beinhaltet schon eine Reihe an Anpassungen und vorinstallierten Programmen, die du mithilfe des Vorlagenbenutzers ``linuxadmin`` an die Bedürfnisse deiner Schule anpassen kannst. Nach den erfolgten Anpassungen erstelle erneut ein neues Image du erhälst dadurch eine neue cloop-Datei. Die vorherige Version wird mit einem Zeitstempel versehen und verbleibt im System bis sie von dir gelöscht wird.

.. hint:: Bevor du mit der Anpassung für ein neues Images beginnst, solltest du immer mit einer zuvor frisch synchroniserten Version des bestehenden Abbildes arbeiten. So vermeidest du, dass vorherige Veränderungen an dem System, die eventuell nicht von dir gewollt sind, in der neuen Version landen. 

Weiterführende Dokumentation
============================

- `Entwicklerdokumentation  <https://github.com/linuxmuster/linuxmuster-client-adsso>`_
- `Supportforum: <https://ask.linuxmuster.net/t/linuxclient-v7-mit-profil-zum-testen>`_
- :ref:`using-linbo-label`
- `Hinweise im Anwenderwiki <https://wiki.linuxmuster.net/community/>`_


.. hint:: Falls du zu dieser Seite von der Beschreibung einer Installation gekommen bist, dann folgende dem Pfeil!

+--------------------------------------------------------------------+-------------------------------------------+
| Installation eines Windows-Clients                                 | |follow_me2windows-clients_b|             |
+--------------------------------------------------------------------+-------------------------------------------+
| Abschluss der Installation                                         | |follow_me2finish-install|                |
+--------------------------------------------------------------------+-------------------------------------------+
