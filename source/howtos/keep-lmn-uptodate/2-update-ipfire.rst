Aktualisierung der Firewall IPFire 
==================================
   
Um die Firewall von linuxmuster.net IPFire zu aktualisieren, beachten Sie bitte nachstehendes Vorgehen bzw. Hinweise.

Führen Sie Updates bitte regelmäßig durch.

Zur Aktualisierung gibt es zwei Verfahren. Das erste Verfahren nutze ein Skript auf dem linuxmuster.net Server, das die Aktualisierung initiiert und zugleich prüft, ob die zu installierende Version bereits unter linuxmuster.net erfolgreich getestet wurde. Das zweite Verfahren wird auf der Firewall selbst ausgeführt, so dass IPFire mithilfe des eigenen Paketsystes **pakfire** Aktualisierungen herunterlädt und installiert.

Skriptgesteuerte Aktualisierung vom Server aus
----------------------------------------------

Es wird regelmäßig getestet, ob die neueren IPFire Versionen vollständig mit linuxmuster.net kompatibel sind. Um zu verhindern, dass vorschnell neue IPFire Versionen direkt nach Erscheinen installiert und so ggf. Inkompatibilitäten in Kauf genommen werden, kann das Update des IPFire auch vom Server aus mithilfe eines Skriptes angestossen werden:

.. code-block:: console

   # linuxmuster-ipfire --upgrade

   ###################################
   # linuxmuster.net: IPFire upgrade #
   ###################################
   
   Passwordless ssh connection to Firewall is available.
   
   IPFire 2.17 core 99 detected
   
   Your current IPFire core update level is higher than the supported level (95)!


Welche Version von IPFire erfolgreich getestet wurde steht in der
Datei ``/var/lib/linuxmuster-ipfire/maxcore`` Diese Zahl wird von dem
Skript zur Aktualisierung von IPFire ausgelesen und geprüft.

Der Vorgang stellt sich dann wie folgt dar:

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

Hierbei kann es sein, dass der Befehl ggf. auch zweimal aufgerufen werden muss, nachdem ein Zwischenupdate von IPFire installiert und hierbei ein größerer Versionssprung durchgeführt wurde.
Nach dem Reboot von IPFire ist das Script erneut aufzurufen.

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



Manuelle Aktualisierung über das Paketsystem von IPFire
-------------------------------------------------------

IPFire kann mithilfe von ``Boardmitteln`` vom Administrator aktualisiert werden.

.. attention::

    Aktuell ist linuxmuster.net voll kompatibel mit IPFire Core 102

Melden Sie sich auf der Startseite des Webinterfaces https://ipfire:444 bzw. https://10.16.1.254:444 an. Dort werden Hinweise auf vorliegende IPFire-Updates aausgegeben.

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

