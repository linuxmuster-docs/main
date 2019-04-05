Linuxmuster.net aktuell halten
==============================

Update des Ubuntu Servers von linuxmuster.net 
---------------------------------------------

[Derzeit in Bearbeitung von toheine]

Um die linuxmuster.net 6.x zugrunde liegende Ubuntu Version (Ubuntu Server 12.04.5 LTS 64bit) zu aktualisieren, beachten Sie bitte nachstehendes Vorgehen bzw. Hinweise.

.. attention::

   Führen Sie Updates bitte regelmäßig manuell durch.

Keine automatischen Updates
---------------------------

Es wird ausdrücklich davon abgeraten in Ubuntu die Option
``Automatische Updates`` zu aktivieren, so dass
Paketaktualisierungen automatisch von dem Ubuntu-Server
heruntergeladen und installiert werden.

Ob Sie automatische Updates aktiviert haben, überprüfen Sie, in dem
Sie auf dem Server in der Datei ``/etc/apt/apt.conf.d/10periodic``
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

      # aptitude update

3. Installieren Sie nun Aktualisierungen und weitere Software-Pakete über das Internet:

   .. code-block:: console

      # aptitude dist-upgrade  

4. Es wird aufgelistet, welche Pakete aktualisiert werden. 
   Bestätigen Sie die Aktualisierung mit der Eingabe von **Y**

   Dieses Vorgehen stellt sich in der Konsole wie folgt dar:

   .. image:: media/1-update-ubuntu-server/1-einrichtung-sicherheitsupdates.png
	      :alt: Upgrade Ubuntu Server
	      :align: center


5. Während des Aktualisierungsverlaufs fragen manchmal Pakete nach, ob eine neue Konfigurationsdatei 
   installiert werden soll. Geben Sie ``N`` oder ENTER für "Beibehalten" an.
   
   .. code-block:: console

      Konfigurationsdatei »/etc/sudoers«
       ==> Geändert (von Ihnen oder von einem Skript) seit der Installation.
       ==> Paketverteiler hat eine aktualisierte Version herausgegeben.
         Wie möchten Sie vorgehen? Ihre Wahlmöglichkeiten sind:
	  Y oder I : Die Version des Paket-Betreuers installieren
	  N oder O : Die momentan installierte Version beibehalten
             D     : Die Unterschiede zwischen den Versionen anzeigen
	     Z     : Eine Shell starten, um die Situation zu begutachten
       Der Standardweg ist das Beibehalten der momentanen Version.
      *** sudoers (Y/I/N/O/D/Z) [Vorgabe=N] ? N


Hinweise
--------

Ubuntu bietet ein Upgrade an
````````````````````````````

Haben Sie sich an der Konsole des linuxmuster.net Servers angemeldet, so erhalten Sie Hinweise auf neue verfügbare Upgrades, also neue Versionen des Ubuntu-Servers.


Diese stellen sich bsp. wie folgt dar:

.. code:: bash

    New release '14.04.1 LTS' available.
    Run 'do-release-upgrade' to upgrade to it.


.. caution:: **Niemals ein Release-Upgrade durchführen**

    Folgen Sie nicht der Empfehlung, denn linuxmuster.net ist auf die Version 12.04 LTS 64 bit 
    angepasst, deren Support bis 2017 gewährleistet ist. Neue Versionen (ab linuxmuster.net 7)
    werden über ein solches Release-Upgrade bereits verfügen (Version 16.04 LTS 64 bit)

Meldung: Hardware Enablement Stack
``````````````````````````````````
Ebenso wie beim „upgrade“ wird beim Anmelden über die Kommandozeile manchmal ein nicht mehr unterstützter Kernel gemeldet:

.. code:: bash
	  
    Your current Hardware Enablement Stack (HWE) is no longer supported
    since 2014-08-07.  Security updates for critical parts (kernel
    and graphics stack) of your system are no longer available.
        
    For more information, please see:
    http://wiki.ubuntu.com/1204_HWE_EOL
    
    To upgrade to a supported (or longer supported) configuration:
     
    * Upgrade from Ubuntu 12.04 LTS to Ubuntu 14.04 LTS by running:
     sudo do-release-upgrade 
     
    OR
    
    * Install a newer HWE version by running:
    sudo apt-get install <kernel-version>


.. attention:: 

    Führen Sie kein upgrade auf 14.04 LTS durch. Support wird von Ubuntu für 12.04, 12.04.1 und 12.04.5 
    (Stand: August 2014) geleistet, das bedeutet ein mit 12.04.2 installiertes System muss einen neuen 
    Kernel bekommen. (https://wiki.ubuntu.com/1204_HWE_EOL)


Aktualisierung des Linux-Kernels
````````````````````````````````

Um Ubuntu 12.04 LTS Server (Codename Trusty) auf einen neueren Kernel zu aktualisieren, kann das Paket **linux-hwe-generic** genutzt werden:

.. code-block:: console

    # apt-get install linux-hwe-generic
    Paketlisten werden gelesen...Fertig
    Abhängigkeitsbaum wird aufgebaut       
    Statusinformationen werden eingelesen...Fertig
    Die folgenden zusätzlichen Pakete werden installiert:
    linux-headers-3.13.0-34 linux-headers-3.13.0-34-generic linux-headers-generic-lts-trusty 
    linux-image-3.13.0-34-generic linux-image-generic-lts-trusty linux-image-hwe-generic
    Vorgeschlagene Pakete:
    fdutils linux-lts-trusty-doc-3.13.0 linux-lts-trusty-source-3.13.0 linux-lts-trusty-tools
    Die folgenden NEUEN Pakete werden installiert:
    linux-headers-3.13.0-34 linux-headers-3.13.0-34-generic linux-headers-generic-lts-trusty 
    linux-hwe-generic linux-image-3.13.0-34-generic
    linux-image-generic-lts-trusty linux-image-hwe-generic

Nach Ausführen des Befehls ist der Server neu zu starten

.. code-block:: console

   # reboot

Sollte aus irgendeinem Grund der neue Kernel nicht booten oder funktionieren, kann der „alte“ Kernel über das Grub-Bootmenü ausgewählt werden, solange dieser nicht deinstalliert wurde.

Sollte nach dem Neustart des Servers mit dem neu installierten Kernel dennoch die HWE-Meldung erscheinen, sollte nachstehender Befehl 

.. code-block:: console

   # hwe-support-status --show-all-unsupported

ausgeführt werden. Die dort genannten Pakete müssen dann deinstalliert
werden. Danach o.g. Befehl noch einmal abgesetzen, um sicherzugehen,
dass keine weiteren Pakete den HWE-Status blockieren.

Die Datei ``/var/lib/update-notifier/hwe-eol`` kann auch notfalls gelöscht werden.

Aktualisierung der Firewall IPFire
==================================

Um die Firewall von linuxmuster.net IPFire zu aktualisieren, beachten Sie bitte nachstehendes Vorgehen bzw. Hinweise.

.. attention::

   Führen Sie Updates bitte regelmäßig manuell durch.

.. Zur Aktualisierung gibt es zwei Verfahren. Das erste Verfahren nutze ein Skript auf dem linuxmuster.net Server, das die Aktualisierung initiiert und zugleich prüft, ob die zu installierende Version bereits unter linuxmuster.net erfolgreich getestet wurde. Das zweite Verfahren wird auf der Firewall selbst ausgeführt, so dass IPFire mithilfe des eigenen Paketsystes **pakfire** Aktualisierungen herunterlädt und installiert.


Skriptgesteuerte Aktualisierung vom Server aus
----------------------------------------------

Es wird regelmäßig getestet, ob die neueren IPFire Versionen
vollständig mit linuxmuster.net kompatibel sind. Um zu verhindern,
dass vorschnell neue IPFire Versionen direkt nach Erscheinen
installiert und so ggf. Inkompatibilitäten in Kauf genommen werden,
wird das Update des IPFire vom Server aus mithilfe eines Skriptes
angestossen.

Welche Version von linuxmuster.net positiv getestet wurde erfahren Sie im 
Support Forum in der Kategorie Server - Firewall ``https://ask.linuxmuster.net/c/server/firewall``

Damit das Update mithilfe des angesprochem Skiptes ausgeführt wird, müssen Sie die Datei ``/var/lib/linuxmuster-ipfire/maxcore`` an der Server-Konsole editieren. Nach dem Speichern der Datei kann das Update gestartet werden.

.. Welche Version von IPFire erfolgreich getestet wurde steht in der
   Datei ``/var/lib/linuxmuster-ipfire/maxcore`` Diese Zahl wird von dem
   Skript zur Aktualisierung von IPFire ausgelesen und geprüft.

Ein erfolgreicher Upgrade-Vorgang stellt sich dann so dar:

.. code-block:: console

   # linuxmuster-ipfire --upgrade

   ###################################
   # linuxmuster.net: IPFire upgrade #
   ###################################

   Passwordless ssh connection to Firewall is available.

   IPFire 2.17 core 99 detected

   downloading package lists ...
   ...package lists are up-to-date

   upgrading IPFire ...

   Core-update 2.19
   Release: 100 -> 102

   [screen is terminating]
   Connection to 10.16.1.254 closed.
   ...upgrade was successful

   Rebooting IPfire ...

Wenn ein Zwischenupdate von IPFire installert wird und hierbei ein
größerer Versionssprung durchgeführt wird, ist nach dem Reboot von
IPFire der Befehl erneut aufzurufen.  Ebenso empfiehlt sich ein
erneuter Aufruf, wenn das Upgrade nicht erfolgreich beendet wurde.

Ist das Update abgeschlossen, finden Sie nachstehende Konsolenausgabe:

.. code-block:: console

   # linuxmuster-ipfire --upgrade

   ###################################
   # linuxmuster.net: IPFire upgrade #
   ###################################

   Passwordless ssh connection to Firewall is available.

   IPFire 2.19 core 102 detected

   downloading package lists ...
   ...package lists are up-to-date

   your IPFire is up-to-date


..
  Manuelle Aktualisierung über das Paketsystem von IPFire
  -------------------------------------------------------

  IPFire kann mithilfe von ``Boardmitteln`` vom Administrator aktualisiert werden.

  .. attention::

     Aktuell ist linuxmuster.net voll kompatibel mit IPFire Core 102

  Melden Sie sich auf der Startseite des Webinterfaces https://ipfire:444 bzw. https://10.16.1.254:444 an. Dort werden Hinweise auf vorliegende IPFire-Updates ausgegeben.

  Vorrausetzungen damit Updates angezeigt werden:

  1. Um die Update-Server zu kontaktieren, muss ein ping nach extern möglich sein

  2. Außerdem muss Port 11371 (hkp) offen sein um pgp-Keys herunterzuladen (einmalig reicht)

  Sehen Sie nahstehende Abbildung, dann sind o.g. Voraussetzungen erfüllt.

  .. image:: media/2-update-ipfire/2-update-ipfire-gui-hint.png
     :alt: Upgrade Hinweis in IPFire GUI
     :align: center

  Zur Installation der Updates wechselt man über den Reiter ipfire in den Pakfire-Bereich. Die zur Installation vorgesehenen Core-Updates werden hier aufgelistet:

  .. image:: media/2-update-ipfire/3-update-ipfire-gui-pakfire.png
     :alt: Upgrade Ipfire GU-Menü
     :align: center

  Die Installation startet man einfach durch Betätigen der Schaltfläche unterhalb der Updates-Liste:

  .. image:: media/2-update-ipfire/4-update-ipfire-gui-running-pakfire.png
     :alt: Upgrade IPFire in der GUI
     :align: center

  Nach erfolgter Installation wird im System-Status-Bereich der aktuelle Core-Update-Level angezeigt:

  .. image:: media/2-update-ipfire/5-update-ipfire-gui-pakfire-corelevel.png
     :alt: Upgrade IPFire Anzeige Corelevel
     :align: center

  Ipfire muss danach neu gestartet werden.

Weitere Hinweise
================

Konfiguration des IPFire vom Server aus neu setzen
--------------------------------------------------

Mit folgendem Befehl am Server konfiguriert man den IPFire neu. Es sollte zuvor aber ein Backup der IPFire-Einstellungen durchgeführt werden:

.. code-block:: console

   # linuxmuster-ipfire --backup
   # dpkg-reconfigure linuxmuster-ipfire

.. attention::

    Nur im Ausnahmefall anwenden. Es gehen alle eigenen Konfigurationseinstellungen des IPFire verloren.


Aktualisierung des IPFire via Konsole
-------------------------------------

Haben Sie eine SSH-Verbindung zum IPFire aufgebaut, können die diesen auch auf der Konsole des IPFire mithilfe der Paketverwaltung ``Pakfire`` des IPFire durchführen.

Hierzu geben Sie nachstehende Konsolenbefehle an:

.. code-block:: console

   # pakfire update
   # pakfire upgrade

Danach ist der IPFire neu zu starten.

.. attention::

   Prüfen Sie vorher, ob die zu installierende Version des IPFire vollständig kompatibel zu linuxmuster.net ist. Im Forum oder über die Mailing-Liste erhalten Sie entsprechende Hinweise.

