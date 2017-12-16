
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
  "ssh-server" gewählt werden.\\ **Achtung:** Mit der 64bit Version
  funktioniert das Setup wahrscheinlich nicht.\\ Mit Ubuntu-Server
  14.04.4 32bit funktionierte die Installation - bisher ohne erkennbare
  Probleme.



Das Captive Portal als virtuelle Maschine herunterladen
=======================================================

Lade zunächst 

Die im Torrent {{:torrentfiles:coovachilli-ova.torrent|}} enthaltene
OVA-Datei enthält eine virtuelle Appliance, auf der die komplette
linuxmuster-chilli Umgebung bereits vorinstalliert ist.

Inbetriebnahme
--------------

Auspacken der Appliance
~~~~~~~~~~~~~~~~~~~~~~~

Die Appliance kann problemlos mit Virtualbox geöffnet werden. Der
neuralgische Punkt ist die Konfiguration der Netzwerkkarten für die
virtuelle Maschine.

Konfiguration
~~~~~~~~~~~~~

Die Anmeldedaten für die Appliance sind

::

    Benutzer: coovaadmin
    Passwort: muster

Nach der ersten Anmeldung muss der Befehl

::

    linuxmuster-chilli-turnkey

ausgeführt werden. Dabei wird das Passwort des administrativen Benutzers
*coovaadmin* geändert und ein neues SSL Zertifikat für den apache
Webserver erzeugt. Anschließend wird CoovaChilli interaktiv für die
Arbeit in der linuxmuster.net-Umgebung konfiguriert. `Details hierzu
finden sich in der konfigurationsanleitung für
linuxmuster-chilli <.chillispot.konfiguration>`__.

CoovaChilli mit der Paketverwaltung installieren
------------------------------------------------

Auf dem Chilli-Server muss der Repo-Schlüssel importiert werden:

# wget -q http://pkg.linuxmuster.net/linuxmuster.net.key -O - \| apt-key
add -

Eine neue Datei anlegen
**''/etc/apt/sources.list.d/linuxmuster-chilli.list''** und die folgende
Zeile eintragen:

::

       # linuxmuster-chilli Pakete
       deb http://pkg.linuxmuster.net/ precise-chilli/

Aktualisieren der Paketliste mit

# apt-get update

Installation/update des Hotspot Pakets mit

# apt-get install linuxmuster-chilli

Jetzt gehts dann weiter mit der -> `Konfiguration von
linuxmuster-chilli <chillispot.konfiguration>`__

Einen Beitrag hierzu findet man im Forum von linuxmuster.net unter ->
http://www.linuxmuster.net/forum/forum.php?req=thread&id=232

--------------

Alternative ohne Paketverwaltung: linuxmuster-chilli direkt installieren
------------------------------------------------------------------------

Zuerst sollte man die Paketabhängigkeiten für die späteren Pakete
installieren:

::

    apt-get install apache2 freeradius freeradius-ldap pwgen dnsmasq ipcalc haserl ssl-cert ffproxy

Nun muss das
{{:linuxmusternet:downloads:iso:linuxmuster-chilli_0.1.18_i386.deb|linuxmuster-chilli-Paket}}
heruntergeladen und entpackt werden:

wget
http://www.linuxmuster.net/_media/linuxmusternet:downloads:iso:linuxmuster-chilli_0.1.18_i386.deb
-O linuxmuster-chilli_0.1.18_i386.deb dpkg --unpack
linuxmuster-chilli_0.1.18_i386.deb

Jetzt muss das (durch das Entpacken von linuxmuster-chilli auf das
System kopierte) CoovaChilli Paket installiert werden:

dpkg -i /var/lib/linuxmuster-chilli/src/coova-chilli_1.3.0_i386.deb

Die Konfiguration wird durch den Befehl

::

    dpkg --configure linuxmuster-chilli

angestoßen. Genauere Erklärungen finde sich auf der Seite ->
`Konfiguration von linuxmuster-chilli <chillispot.konfiguration>`__


Netzwerkkonfiguration auf dem Coovachilli-Server
------------------------------------------------

FIXME: Diese Zeilen gehören zur Konfigurationsseite

Wenn der Coovachilli Server (was sinnvoll ist) der einzige Rechner im
blauen Netz ist, kann man die Schnittstellenkonfiguration problemlos dem
DHCP Server überlassen. Die Datei `/etc/network/interfaces` auf dem
coovachilli Server sieht dann folgendermaßen aus:

::

    # This file describes the network ...
    # and how to activate them. For more information, see interfaces(5).
    #

    # The loopback network 
    auto lo
    iface lo inet loopback

    # These interfaces are brought up automatically
    auto eth0
    iface eth0 inet dhcp

