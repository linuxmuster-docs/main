.. _install-linux-clients-label:

=============
Linux Clients
=============

.. sectionauthor:: `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_

In dieser Anleitung wird beschrieben, wie man Linux auf einer
Musterarbeitsstation installiert.  Ein fertig vorkonfiguriertes Abbild
liegt zum Download bei linuxmuster.net bereit und kann sofort auf alle
Arbeitsstationen verteilt werden.

Arbeitsstationen ("Clients") werden in der linuxmuster.net über die
Software LINBO ("GNU/Linux Network Boot") installiert.

Alle Arbeitsschritte, die Änderungen am Server benötigen,
werden an einer Serverkonsole erledigt.

.. _download-default-cloop:

Herunterladen des Standard-Linuxclients
=======================================

.. hint::

   Die vorliegende Dokumentation wird aus der `Entwicklerdokumentation
   <https://github.com/linuxmuster/linuxmuster-client-adsso>`_
   genommen und ab und zu aktualisiert und eventuell finden sich dort
   neuere Informationen.


Lade auf dem Server folgendes Cloop herunter, entpacke es in das
Verzeichnis `/srv/linbo` und starte den Bittorrent-Dienst neu:

* https://download.linuxmuster.net/client-cloops/v7/ubuntu1804basisClient.tbz mit 2.9GB, MD5: 15b2c4ac88b45ac37b35ba445b27e029

.. code-block:: console

   # wget https://download.linuxmuster.net/client-cloops/v7/ubuntu1804basisClient.tbz
   # tar -xjf ubuntu1804basisClient.tbz -C /srv/linbo
   # systemctl restart linbo-bittorrent.service

Standardmäßig wird eine start-Konfiguration für die Rechnergruppe
"linux" entpackt in der das entpackte Cloop verwendet wird. Jetzt kann
man einen ersten Arbeitsplatzrechner in diese Rechnergruppe aufnehmen
oder eine eigene Rechnergruppe mit dem Cloop konfigurieren.

.. 
  Rufen Sie die Liste aller verfügbaren Clientabbilder auf:
  
  .. code-block:: console
     
     server ~ # linuxmuster-client -a list-available
     Hole Liste der verfügbaren cloops...OK
     
     Imagename                 Info
     -----------------------------------------------
     xenial-qgm                          Ubuntu 16.04 LTS 64Bit
     trusty714                          Ubuntu 14.04 LTS 64Bit
     xenial916                          Ubuntu 16.04 LTS 64Bit
     -----------------------------------------------
  
  Laden Sie das Abbild Ihrer Wahl (hier: `xenial916`) herunter mit
  
  .. code-block:: console
  
     server ~ # linuxmuster-client -a auto -c xenial916 -H xenial
  
  Es wird die Rechnergruppe (Hardwareklasse) `xenial` angelegt und mehrere Dateien werden erzeugt. Die wichtigsten sind
  
  .. code-block:: bash
  
     /var/linbo/start.conf.xenial
     /var/linbo/xenial916.cloop
     /var/linbo/xenial916.cloop.postsync
     /var/linbo/linuxmuster-client/xenial/...
  
  Nun kann man Clientrechner in die Rechnergruppe `xenial` aufnehmen. 
  
  .. note::
  
     Wenn eine Datei bereits existiert, bricht das Programm zunächst
     ab. Mit der Option ``-f`` wird ein angebrochener Download
     fortgesetzt und bestehende Dateien werden überschrieben, dabei
     werden von `/var/linbo/start.conf.xenial` und
     `/var/linbo/linuxmuster-client/xenial` jeweils automatisch Backups
     erstellt.
  
  Abbild zur Synchronisation einrichten
  -------------------------------------
  
  Der folgende Befehl erzeugt alle nötigen Konfigurationen, so dass das Abbild `xenial` im lokalen Netz einsatzfähig wird:
  
  .. code-block:: console
  
     server ~ # linuxmuster-client -a configure -h ubuntuclient -p ubuntu1404 -c ubuntuclient.cloop
  
  
  Nun kann man Clientrechner in die Rechnergruppe `ubuntuclient` aufnehmen.

Computer aufnehmen
==================

Der Zielrechner wird in der Schulkonsole aufgenommen
(z.B. `r100-pc01`) und im Menüpunkt LINBO der richtigen Gruppe
(z.B. `linux`) zugewiesen, siehe :ref:`add-computer-label`.
     
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

Internetverbindung ohne Proxy
-----------------------------

Zunächst muss der Masterclient ohne Proxy-Authentifizierung ins
Internet kommen. Die empfohlene Vorgehensweise ist, die IP-Adresse des
Masterclients (temporär) in die "No-Proxy" Zugriffsliste auf der
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
und man meldet sich mit ``linuxadmin`` und dem Passwort ``Muster!``
an. 

Masterclient in die Domäne aufnehmen
------------------------------------

Dann startet man in einem Terminal zunächst ein dist-upgrade und
führt dann einmalig ein Setup aus.

.. code-block:: console

   # sudo linuxmuster-distupgrade
   # sudo linuxmuster-client-adsso-setup
   # reboot

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

- :ref:`using-linbo-label`
- Development Dokumentation im Supportforum: https://ask.linuxmuster.net/t/linuxclient-v7-mit-profil-zum-testen
- Development Dokumentation: https://github.com/linuxmuster/linuxmuster-client-adsso/wiki
- Howto: Standardclient updaten
- Todo: are there pages in the Anwenderwiki
- Todo: are there howtos under docs.linuxmuster.net
