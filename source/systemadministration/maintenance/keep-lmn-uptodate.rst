Linuxmuster.net aktuell halten
==============================

.. sectionauthor:: `@toheine <https://ask.linuxmuster.net/u/toheine>`_

Update des Ubuntu Servers von linuxmuster.net 
---------------------------------------------

Um die linuxmuster.net 7.x zugrunde liegende Ubuntu Version (Ubuntu Server 18.04.x LTS 64bit) zu aktualisieren, beachten Sie 
bitte nachstehendes Vorgehen bzw. Hinweise.

.. attention::

   Führen Sie Updates bitte regelmäßig manuell durch.

Keine automatischen Updates
---------------------------

Es wird ausdrücklich davon abgeraten in Ubuntu die Option
``Automatische Updates`` zu aktivieren, so dass
Paketaktualisierungen automatisch von dem Ubuntu-Server
heruntergeladen und installiert werden.

Ob Sie automatische Updates aktiviert haben, überprüfen Sie, in dem
Sie auf dem Server in der Datei ``/etc/apt/apt.conf.d/20auto-upgrades``
überprüfen, ob die Option ``APT::Periodic::Unattended-Upgrade "1";``
existiert. In diesem Fall, ändern Sie die ``"1"`` in eine ``"0"``.

Melden Sie sich stattdessen besser bei der entsprechenden
`Mailingliste
<https://lists.ubuntu.com/mailman/listinfo/ubuntu-security-announce>`_
an oder abonnieren Sie entsprechenden `RSS-Feed
<http://www.ubuntu.com/usn/rss.xml>`_. Alle Hinweise zu
Sicherheitsupdates von Ubuntu erhalten Sie unter http://www.ubuntu.com/usn/


Aktualisierungen einspielen
---------------------------

Um die Server-Installation auf den aktuellen Paketstand zu bringen, gehen Sie folgendermaßen vor:

1. Loggen Sie sich als User root auf einer Serverkonsole ein.

2. Aktualisieren Sie die Paketlisten:

   .. code-block:: console

      # apt update

3. Installieren Sie nun Aktualisierungen und weitere Software-Pakete über das Internet:

   .. code-block:: console

      # apt dist-upgrade  

4. Es wird aufgelistet, welche Pakete aktualisiert werden. 
   Bestätigen Sie die Aktualisierung mit der Eingabe von **Y**

5. Während des Aktualisierungsverlaufs fragen manchmal Pakete nach, ob eine neue Konfigurationsdatei 
   installiert werden soll. Geben Sie ``N`` oder ENTER für "Beibehalten" an.
   
   .. image:: media/1-dist-upgrade.png
        :alt: Keep Config
        :align: center

6. Zudem kann die Frage auftauchen, ob bei Bedarf Dienste neu gestartet werden dürfen. Sofern das Update
   eher zu Zeiten geringer Last ausgeführt werden sollten, kann diese Frage mit ``y`` beantwortet werden:

   .. image:: media/2-dist-upgrade.png
        :alt: Restart Services
        :align: center


Aktualisierung der Firewall OPNsense
------------------------------------

Um die Firewall OPNsense zu aktualisieren, beachten Sie bitte nachstehendes Vorgehen bzw. Hinweise.

.. attention::

   Führen Sie Updates bitte regelmäßig manuell durch.

Im Gegensatz zur bisherigen Firewall-Implementierung unter Linuxmuster 6.2 ist in der neuen Linuxmuster 7.x die Firewall relativ
unabhängig vom eigentlichen Server zu warten. Dementsprechend werden die Updates über die Weboberfläche der Firewall eingespielt.

Verbinden Sie sich hierzu mit der Firewall über Ihren Browser. Nach der Anmeldung landen Sie auf dem Dashboard (unter Lobby). Sie 
finden dort einen Link um direkt Updates einzuspielen.
    
    .. image:: media/3-opnsense-update.png
        :alt: OPNsense aktulaisieren
        :align: center

Eine etwas ausführlichere Übersicht finden Sie unter ``System -> Firmware -> Aktualisierungen``. 

    .. image:: media/4-opnsense-update.png
        :alt: OPNsense aktualisieren
        :align: center