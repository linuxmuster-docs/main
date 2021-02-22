.. include:: /guided-inst.subst

.. _install-linux-clients-label:

===============
 Linux Clients
===============

.. sectionauthor:: `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_

In dieser Anleitung wird beschrieben, wie man Linux auf einer Musterarbeitsstation installiert. Ein fertig vorkonfiguriertes Abbild liegt zum Download bei linuxmuster.net bereit und kann sofort auf alle Arbeitsstationen verteilt werden.

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

Die wichtigsten Dateien, die angelegt werden sind

.. code-block:: bash

   /srv/linbo/start.conf.lmn-bionic-200507
   /srv/linbo/lmn-bionic-200507.cloop
   /srv/linbo/lmn-bionic-200507.cloop.postsync
   /srv/linbo/linuxmuster-client/lmn-bionic-200507/common/postsync.d/*
   
Ändern des Passworts des Vorlagenbenutzers
------------------------------------------

Lädt man die Vorlagen herunter so heißt der Vorlagenbenutzer ``linuxadmin``. Dem Nutzer wurde in der Vorlage das Kennwort ``Muster!`` zugewiesen. Hiermit können Sie sich nach dem Startvorgang am Linux-Client lokal anmelden und Anpassungen vornehmen bzw. ebenfalls das Kennwort ändern.

Sie können das Kennwort das Vorlagenbenutzers aber auch direkt vom Server aus ändern. Mit folgendem Befehl legt man das Passwort des Vorlagenbenutzers im später gestarteten Linuxclient fest.

.. code-block:: console
   
   server ~ # linuxmuster-client -p <pw> -l <localname> setpw

``<pw>`` - hier können Sie ein Kennwort angebene, dann wird dieses für den Vorlagenbenutzer direkt gesetzt.

``<localname>`` - dies entspricht der Patchklasse für Linbo - also hier z.B. lmn-bionic-200507

Das Kennwort für den Vorlagenbenutzer wird in der Patchklasse hier abgelegt:

``/srv/linbo/linuxmuster-client/lmn-bionic-200507/common/passwords``

Masterclient aufnehmen
======================

Der erste Arbeitsplatzrechner (hier: Masterclient genannt) kann jetzt in die Rechnergruppe "lmn-bionic-200507" aufgenommen werden.

Der Zielrechner wird in der Schulkonsole aufgenommen (z.B. `r10001`) und im Menüpunkt LINBO der richtigen Gruppe (z.B. `lmn-bionic-200507`) zugewiesen, siehe :ref:`add-computer-label`.

.. hint::

   In der start.conf.lmn-bionic-200507 finden Sie die Paritionsgrößen. In der vorgefertigsten start.conf wird davon ausgegangen, dass Sie eine Festplatte mit mind. 70 GB einsetzen. Wünschen Sie andere Größen, passe diese in der Datei zuvor an und führen den nachstehenden Befehl zum Import des Gerätes aus.
     
Internetverbindung ohne Proxy
-----------------------------

Zunächst muss der Masterclient ohne Proxy-Authentifizierung ins Internet kommen. Die empfohlene Vorgehensweise ist, die IP-Adresse des Masterclients (temporär) in die "NoProxy" Zugriffsliste auf der Firewall aufzunehmen.

Masterclient als neues Device
-----------------------------

Sie müssen nun einem Gerät in Ihrem Netz die neue Hardwareklasse ``lmn-bionic-200507`` zuweisen, so dass das Gerät mit der neuen Vorlage startet, Sie Anpassungen vornehmen können abschließend das Geräte in die Domäne aufnehmen und eine neue cloop-Datei erstellen, die Sie an alle gewünschten Geräte verteilen.

Editieren Sie hierzu die Datei ``/etc/linuxmuster/sophomorix/default-school/devices.csv``.

Tragen Sie das Gerät mit der neuen Hardwareklasse wie folgt ein:

.. code-block:: bash

   r100;r10001;lmn-bionic-200507;AA:AA:BB:12:34:56;10.2.100.1;;;;classroom-studentcomputer;;1;;;;;

Speichern Sie die Änderungen ab und importieren Sie das neue Gerät mit:

.. code-block:: console

   server # linuxmuster-import-devices


Masterclient synchronisieren
----------------------------

Um den Client `r10001` erstmalig zu partitionieren, formatieren, synchronisieren und zu starten, führen Sie auf dem Server folgenden Befehl aus 

.. code-block:: console

   # linbo-remote -i r10001 -p partition,format,initcache:torrent,sync:1,start:1

Starten Sie nun den Client und verfolgen Sie die vollautomatische Einrichtung. 

Sollte der PC nicht starten, so sind die Wake-on-LAN Funktionen nicht korrekt konfiguriert. Dann müssen Sie den PC von Hand booten. Der PC bootet in die Linbo-Umgebung, dort müssen Sie diesen dann partitionieren, den Cache befüllen und den Linux-Client synchronisiert starten.

Nachdem der Linux-Client gestaretet wurde, melden Sie sich mit ``linuxadmin`` und dem Vorlagenkennwort am Client an.

Sollten Sie sich mit dem Vorlagenbenutzer nicht anmelden können, so führen Sie auf dem Server o.g. Befehl zur Vergabe eines neuen Kennworts für den Vorlagenbenutzer mit Ihrem gewünschten Kennwort aus. Danach starten Sie den Client erneut, so dass der Vorlagenbenutzer ``linuxadmin`` sich danach mit dem neu vergebenen Kennwort anmelden kann.

Masterclient erstmalig aufnehmen
--------------------------------

Man startet in einem Terminal (oder über ssh vom Server aus) auf dem Linux-Client den Befehl ``sudo linuxmuster-cloop-turnkey``, der das System aktualisiert und einmalig die Domänenaufnahme vornimmt.

.. code-block:: console

   # sudo linuxmuster-cloop-turnkey

.. hint:: Erhalten Sie einen Hinweis, dass der Vorgang abgeschlossen wurde, starten Sie den PC neu und **wählen Sie nach dem Reboot in Linbo die Reiterkarte ``Imageing``**.

Neues Image erstellen
---------------------

Erstellen Sie nun ein neues Image, indem Sie auf ``Image erstellen`` klicken, eine Beschreibung zum Image angeben und dann den Vorgang mit ``erstellen+hochladen`` ausführen.

Wurde das Image erfolgreich erstellt, so wurde die cloop-Datei auf dem Server neu erstellt und die bisherige cloop-Datei findet sich mit Angabe eines Zeitstempels im Dateinamen weiterhin auf dem Server unter 
``/srv/linbo/``. Hier finden Sie aich eine Datei mit dem Namen ``lml-bionic-200507.cloop.macc``. Ist diese Datei vorhanden so wurde dieses Cloop / der PC in die Domäne aufgenommen.

Starten Sie den Client nun erneut synchronisiert, so können Sie sich nun am System anmelden.

Die cloop-Vorlage beinhaltet schon eine Reihe an Anpassungen und vorinstallierten Programmen, die Sie mithilfe des Vorlagenbenutzers ``linuxadmin`` an ihre Bedürfnisse anpassen können. Mach den erfolgten Anpassungen erstellen Sie erneut ein neues Image / eine neue cloop-Datei.

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
