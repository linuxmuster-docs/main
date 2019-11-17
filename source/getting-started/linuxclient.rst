.. _install-linux-clients-label:

===============
 Linux Clients
===============

.. sectionauthor:: `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_

In dieser Anleitung wird beschrieben, wie man Linux auf einer
Musterarbeitsstation installiert. Ein fertig vorkonfiguriertes Abbild
liegt zum Download bei linuxmuster.net bereit und kann sofort auf alle
Arbeitsstationen verteilt werden.

Arbeitsstationen ("Clients") werden in der linuxmuster.net über die
Software LINBO ("GNU/Linux Network Boot") installiert.

Alle Arbeitsschritte, die Änderungen am Server benötigen,
werden an einer Serverkonsole erledigt.

.. _download-default-cloop:

Einrichten eines Linuxclients
=============================

Mit dem Befehl ``linuxmuster-client`` aus dem Paket
``linuxmuster-client-servertools`` wird von linuxmuster.net ein Paket
heruntergeladen, das eine Image-Datei (``cloop-Datei``) und weitere
dazugehörige Daten enthält. 

Rufe die Liste aller verfügbaren Clientabbilder auf:
  
.. code-block:: console
   
   server ~ # linuxmuster-client list-available
   Hole Liste der verfügbaren cloops...OK
   
   Imagename                 Info
   -----------------------------------------------
   xenial-qgm                Ubuntu 16.04 LTS 64Bit
   xenial916                 Ubuntu 16.04 LTS 64Bit
   bionic (empfohlen)        Official Ubuntu 18.04 64bit
   bionic-qgm                Xubuntu 18.04 64bit (Quenstedt)
   -----------------------------------------------

Lade das Abbild deiner Wahl (hier: `bionic`) herunter mit

.. code-block:: console

   server ~ # linuxmuster-client download -c bionic

Es wird geprüft, ob Dateien mit diesem Namen schon existieren, weil
selbst schon eine Rechnergruppe mit dem Namen angelegt wurde, oder man
dieses Image zum wiederholten Mal herunterlädt. Dann hat man die
Möglichkeit die Dateien zu überschreiben oder abzubrechen.

Die wichtigsten Dateien, die angelegt werden sind

.. code-block:: bash

   /var/linbo/start.conf.bionic
   /var/linbo/bionic.cloop
   /var/linbo/bionic.cloop.postsync
   /var/linbo/linuxmuster-client/bionic/common/postsync.d/*
   
Ändern des Passworts des Vorlagenbenutzers
------------------------------------------

Der Vorlagenbenutzer heißt "linuxadmin". Mit folgendem Befehl legt man
das Passwort des Vorlagenbenutzers im später gestarteten Linuxclient
fest.

.. code-block:: console
   
   server ~ # linuxmuster-client setpassword -c bionic
   Setze das Passwort des Vorlagenbenutzers "linuxadmin"


Abbild zur Synchronisation einrichten
-------------------------------------

Der folgende Befehl erzeugt alle nötigen Konfigurationen, so dass das
Abbild `bionic` im lokalen Netz einsatzfähig wird:

.. code-block:: console

   server ~ # linuxmuster-client configure 
   ... kopieren der ssh-keys des servers ...
   ... anpassen einiger skripte? ...


.. 
  Neue Rechner werden durch direkten Eintrag in die Datei
  ``/etc/linuxmuster/workstations`` und anschließendem Aufruf von
  ``import_workstations`` aufgenommen.
  
  Ermitteln Sie die MAC-Adresse des ersten Clients, z.B. indem Sie den
  Client per PXE booten.
  
  .. image:: ../clients/windows10clients/media/registration/linbo-empty-startpage.jpg
  
  Lesen Sie die "MAC-Adresse" im LINBO-Startbildschirm ab.
  
  Öffnen Sie die Datei ``/etc/linuxmuster/workstations`` auf dem Server.
  
  .. code-block:: console
  
     server ~ # nano /etc/linuxmuster/workstations
  
  Tragen Sie dort den Rechner ein mit folgender Syntax
  
  .. code-block:: bash
  
     Raum;Rechnername;Gruppe;MAC;IP;;;;;;PXE-Flag;
  
  Raum
    Geben Sie hier den Namen des Raums (z.B. r100 oder g1r100)
    ein. Beachten Sie bitte, dass die Bezeichnung des Raumes oder auch
    des Gebäudes mit einem Kleinbuchstaben beginnen muss. Sonderzeichen
    sind nicht erlaubt.
  
  Rechnername 
    z.B. in der Form r100-pc01 (max. 15 Zeichen), (evtl. Gebäude
    berücksichtigen g21r100-pc01) eingeben. Beachten Sie bitte, dass als
    Zeichen nur Buchstaben und Zahlen erlaubt sind. Als Trennzeichen
    darf nur das Minus-Zeichen ``-`` verwendet werden. Leerzeichen,
    Unterstriche oder andere Sonderzeichen (wie z.B. Umlaute, ß oder
    Satzzeichen) dürfen Sie hier unter keinen Umständen verwenden.
  
  IP Adresse  
    Die IP-Adresse sollte zum Raum passen und **muss** außerhalb des
    Bereichs für die Rechneraufnahme liegen. Abhängig von Ihren
    Netzdaten z.B. 10.16.100.1 für diesen PC eingeben, üblicherweise
    **nicht** zwischen 10.16.1.100 und 10.16.1.200 (Bereich für die
    Rechneraufnahme).  
  
  Rechnergruppe 
    In der Rechnergruppe, bspw. `xenial` werden mehrere (idealerweise
    alle) ähnlichen Rechner zusammengefasst, die eine (nahezu)
    identische Konfiguration bekommen. 
  
  Beispielkonfiguration.
  
  .. code-block:: bash
  
     r100;r100-pc01;xenial;08:00:27:57:1D:C5;10.16.100.1;;;;;;1;
  
  Der registrierte Client wird nun mit dem Konsolenbefehl
  
  .. code-block:: console
  
     server ~# import_workstations
  
  ins System aufgenommen und der Rechnergruppe `xenial` zugewiesen. Wenn
  Sie mit dem zuvor heruntergeladenen Standard-Linuxclient eine
  Rechnergruppe `xenial` erstellt haben, kann nun der Rechner fertig
  eingerichtet werden.


Masterclient aufnehmen
======================

Der erste Arbeitsplatzrechner (hier: Masterclient genannt) kann
jetzt in die Rechnergruppe "bionic" aufgenommen werden.

Der Zielrechner wird in der Schulkonsole aufgenommen
(z.B. `r100-pc01`) und im Menüpunkt LINBO der richtigen Gruppe
(z.B. `bionic`) zugewiesen, siehe :ref:`add-computer-label`.
     
Internetverbindung ohne Proxy
-----------------------------

Zunächst muss der Masterclient ohne Proxy-Authentifizierung ins
Internet kommen. Die empfohlene Vorgehensweise ist, die IP-Adresse des
Masterclients (temporär) in die "NoProxy" Zugriffsliste auf der
Firewall aufzunehmen.

Masterclient synchronisieren
----------------------------

Um den Client `r100-pc01` erstmalig zu partitionieren, formatieren,
synchronisieren und zu starten, führe auf dem Server folgenden Befehl
aus

.. code-block:: console

   # linbo-remote -i r100-pc01 -p partition,format,initcache:torrent,sync:1,start:1

Reboote nun den Client und verfolge die vollautomatische
Einrichtung oder trinke eine Tasse deines Lieblingsgetränks.

Nach der Synchronisation und einem weiteren Reboot startet der Client
und man meldet sich mit ``linuxadmin`` und selbst gewählten Passwort an.

Ebenso ist eine Anmeldung per ssh vom Server aus möglich und sinnvoll:

.. code-block:: console

   server~# ssh r100-pc01
   ...
   root@r100-pc01~# 

Masterclient erstmalig aufnehmen
--------------------------------

Man startet in einem Terminal (oder über ssh vom Server aus) den
Befehl ``sudo linuxmuster-cloop-turnkey``, der das System aktualisiert
und einmalig die Domänenaufnahme vornimmt.

.. code-block:: console

   # sudo linuxmuster-cloop-turnkey

Neues Image erstellen
---------------------

Es ist nun notwendig, den Masterclient neu zu starten und von dessen
Installation ein neues Image zu erstellen.





..  
  Der Ubuntu-Client startet und aufgenommene Benutzer können sich nun am
  System anmelden.
  
  Weitere Clients können unter Kenntnis der jeweiligen MAC-Adressen mit
  derselben Methode direkt in die Datei
  ``/etc/linuxmuster/workstations`` aufgenommen werden.
  
  Alternativ kann jeder aufzunehmende Rechner in LINBO gestartet werden
  und über die grafische Oberfläche von LINBO registriert werden. Dabei
  werden die relevanten Werte automatisch inkrementiert. Lesen Sie dazu
  :ref:`registration-linbo-label`.


Weiterführende Dokumentation
============================

- `Entwicklerdokumentation  <https://github.com/linuxmuster/linuxmuster-client-adsso>`_
- Dokumentation im Supportforum: https://ask.linuxmuster.net/t/linuxclient-v7-mit-profil-zum-testen
- :ref:`using-linbo-label`
- Howto: Standardclient updaten
- Todo: are there pages in the Anwenderwiki
- Todo: are there howtos under docs.linuxmuster.net


