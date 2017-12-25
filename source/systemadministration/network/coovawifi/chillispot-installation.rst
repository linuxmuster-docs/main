
Installation des Captive Portal Servers
=======================================

Voraussetzungen
---------------

- Für das Captive Portal wird ein PC oder eine virtuelle Maschine mit
  zwei Netzwerkkarten benötigt:

   -  **eth0** muss die Netzwerkkarte sein, die mit dem Internet
      verbunden ist, je nach Einsatzszenario also z.B. grünem oder
      blauem Interface. Bei Virtualisierung empfiehlt sich die
      Einrichtung einer virtuellen Netzwerkbrücke, die man an keinen
      physikalischen Port binden muss (-> IPFire).
   -  **eth1** wird nicht konfiguriert und mit dem Netzwerksegment
      verbunden, an dem die Clients sich später verbinden werden.
      Konfiguration und DHCP werden beim Start des chilli-Diensts von
      CoovaChilli vorgenommen.

- Für eine manuelle Installation, muss ein Ubuntu-Server
  14.04.4 *32bit* auf dem späteren Captive-Portal-Server installiert
  werden. Als einziges Zusatzpaket sollte bei der Softwareauswahl
  "ssh-server" gewählt werden.

.. important:: 

   **Achtung:** Mit der 64bit Version funktioniert das Setup nicht.

.. _chillispot-vbox-label:

Das Captive Portal als virtuelle Maschine herunterladen
-------------------------------------------------------

Lade zunächst die virtuelle Maschine herunter:

https://www.linuxmuster.net/downloads/ova/linuxmuster-chilli.ova

Die OVA-Datei enthält eine virtuelle Appliance, auf der die komplette
linuxmuster-chilli Umgebung bereits vorinstalliert ist.

Auspacken der Appliance
-----------------------

Die Appliance kann problemlos mit Virtualbox geöffnet werden. Der
neuralgische Punkt ist die Konfiguration der Netzwerkkarten für die
virtuelle Maschine.

Bereitstellen
-------------

Die Anmeldedaten für die Appliance sind

::

    Benutzer: coovaadmin
    Passwort: muster

Nach der ersten Anmeldung muss der Befehl

.. code-block:: console

   # linuxmuster-chilli-turnkey

ausgeführt werden. Dabei wird das Passwort des administrativen Benutzers
*coovaadmin* geändert und ein neues SSL Zertifikat für den apache
Webserver erzeugt. Anschließend wird CoovaChilli interaktiv für die
Arbeit in der linuxmuster.net-Umgebung konfiguriert. Details hierzu
finden sich in der :doc:`Konfigurationsanleitung für
linuxmuster-chilli <chillispot-configuration>`.

CoovaChilli mit der Paketverwaltung installieren
------------------------------------------------

Auf dem Chilli-Server muss der Repo-Schlüssel importiert werden:

.. code-block:: console

   # wget -q http://pkg.linuxmuster.net/linuxmuster.net.key -O - | apt-key add -

Eine neue Datei ``/etc/apt/sources.list.d/linuxmuster-chilli.list``
anlegen und die folgende Zeile eintragen:

.. code-block:: console

   # linuxmuster-chilli Pakete
   deb http://pkg.linuxmuster.net/ precise-chilli/

Aktualisieren der Paketliste mit

.. code-block:: console

   # apt-get update

Installation bzw. Update des Paketes mit

.. code-block:: console

   # apt-get install linuxmuster-chilli

Jetzt geht es dann weiter mit der :doc:`Konfiguration von
linuxmuster-chilli <chillispot-configuration>`.


Netzwerkkonfiguration auf dem CoovaChilli-Server
------------------------------------------------

Wenn der CoovaChilli-Server der einzige Rechner im blauen Netz ist,
kann man die Schnittstellenkonfiguration problemlos dem DHCP Server
überlassen. Die Datei ``/etc/network/interfaces`` auf dem coovachilli
Server sieht dann folgendermaßen aus:

.. code-block:: console

   # This file describes the network ...
   # and how to activate them. For more information, see interfaces(5).
   #
   
   # The loopback network 
   auto lo
   iface lo inet loopback
   
   # These interfaces are brought up automatically
   auto eth0
   iface eth0 inet dhcp

Ebenso kann man, sofern man den :ref:`DHCP-Adressbereich
<chillispot-dhcp-server-label>` geändert hat, kann man dem
CoovaChilli-Server auch eine statische IP-Adresse geben, z.B.

.. code-block:: console

   # This file describes the network ...
   # and how to activate them. For more information, see interfaces(5).
   #
   
   # The loopback network 
   auto lo
   iface lo inet loopback
   
   auto eth0
   iface eth0 inet static
   address 172.16.16.1
   netmask 255.255.255.0
   network 172.16.16.0
   broadcast 172.16.16.255
   gateway 172.16.16.254
   dns-nameservers 172.16.16.254
   dns-search linuxmuster-net.lokal



