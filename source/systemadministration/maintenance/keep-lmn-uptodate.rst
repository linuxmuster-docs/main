linuxmuster.net aktuell halten
==============================

.. sectionauthor:: `@toheine <https://ask.linuxmuster.net/u/toheine>`_

Update des Ubuntu Servers von linuxmuster.net 
---------------------------------------------

Um die linuxmuster.net 7.x zugrunde liegende Ubuntu Version (Ubuntu Server 22.04.x LTS 64bit) zu aktualisieren, beachte bitte nachstehende Hinweise.

.. attention::

   Für ein sicheres System muss regelmäßig ein Update durchgeführt werden!

Keine automatischen Updates
---------------------------

Es wird ausdrücklich davon abgeraten den Linuxmuster.net-Server die Option ``Automatische Updates`` zu aktivieren, so dass Paketaktualisierungen automatisch von den Ubuntu-Update-Servern heruntergeladen und installiert werden.

Automatische Updates sind in der Datei ``/etc/apt/apt.conf.d/20auto-upgrades`` konfiguriert. Sofern darin der Eintrag ``APT::Periodic::Unattended-Upgrade "1";`` existiert, muss die ``"1"`` in eine ``"0"`` geändert werden.

Melde Dich zusätzlich bei der entsprechenden `Mailingliste <https://lists.ubuntu.com/mailman/listinfo/ubuntu-security-announce>`_ an oder abonniere den entsprechenden `RSS-Feed <http://www.ubuntu.com/usn/rss.xml>`_. Alle Hinweise zu Sicherheitsupdates von Ubuntu erhält man unter http://www.ubuntu.com/usn/


Aktualisierungen einspielen
---------------------------

Um die Server-Installation auf den aktuellen Paketstand zu bringen, gehe folgendermaßen vor:

1. Logge Dich als Benutzer root auf einer Serverkonsole ein.

2. Aktualisiere die Paketlisten:

   .. code-block:: console

      # apt update

3. Installiere nun Aktualisierungen und weitere Software-Pakete über das Internet:

   .. code-block:: console

      # apt dist-upgrade  

4. Es wird aufgelistet, welche Pakete aktualisiert werden. 
   Bestätige die Aktualisierung mit der Eingabe von **Y**

5. Während des Aktualisierungsverlaufs fragen manchmal Pakete nach, ob eine neue Konfigurationsdatei 
   installiert werden soll. Gib hier **N** oder **ENTER** für "Beibehalten" an.
   
   .. image:: media/01-dist-upgrade.png
        :alt: Keep Config
        :align: center

6. Insbesondere bei einem ersten Update innerhalb eines Ubuntu-Server-Releases, können Dienste 
   die Nachfrage stellen, ob die jeweilige Konfigurationsdatei automatisch erstellen sollen. hier
   lautet die Antwort grundsätzlich "nein" (z. B. Samba)

   .. image:: media/02-dist-upgrade.png
         :alt: Say NO for autoconfig
         :align: center

7. Zudem kann die Frage auftauchen, ob bei Bedarf Dienste neu gestartet werden dürfen. Sofern das Update
   eher zu Zeiten geringer Last ausgeführt werden sollten, kann diese Frage mit **y** beantwortet werden:

   .. image:: media/03-dist-upgrade.png
        :alt: Restart Services
        :align: center
		
Aktualisierung der Firewall OPNsense®
-------------------------------------

Um die Firewall OPNsense® zu aktualisieren, beachte bitte Hinweise.

.. attention::

   Führe Updates bitte regelmäßig manuell durch.

Bei linuxmuster.net 7.2 ist die Firewall relativ unabhängig vom eigentlichen Server zu warten. Dementsprechend werden die Updates über die Weboberfläche der Firewall eingespielt.

Verbinde Dich hierzu mit der Firewall über einen Browser. Nach der Anmeldung erscheint das Dashboard (unter Lobby). Darin befindet sich ein Link um direkt Updates einzuspielen.
    
    .. image:: media/04-opnsense-update.png
        :alt: OPNsense® aktualisieren
        :align: center

Eine etwas ausführlichere Übersicht ist unter ``System -> Firmware -> Aktualisierungen`` zu finden. 

    .. image:: media/05-opnsense-update.png
        :alt: OPNsense® aktualisieren
        :align: center

Normale Minor-Releases können so direkt eingespielt werden. Sobald allerdings das Patch-Level erhöht wird, muss hier zuerst 
das `Upgrade` entsperrt werden.

    .. image:: media/06-opnsense-update.png
        :alt: OPNsense® aktualisieren
        :align: center

Es ist zu empfehlen solche Upgrades außerhalb der regulären Einsatzzeiten der Schule zu betreiben. Bei einem Upgrade startet die Firewall mehrfach neu und unterbricht damit alle Verbindungen nach außen. Zudem kann es zu Problemen mit einzelnen Modulen kommen.  Vor dem Update sollte also im Hypervisor (Proxmox, XenServer, ...) unbedingt ein Snapshot erstellt werden, so dass die Maschine im Fehlerfall wieder in den Ausgangszustand zurückgesetzt werden kann.

