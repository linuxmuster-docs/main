
.. _modify-net-label:

====================
Netzbereich anpassen
====================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

.. hint::

   Die Anpassung des Netzbereichs ist vor Aufruf des eigentlichen Setups auszuführen. Dies erfolgt mit dem Paket ``lmn71-prepare``.

Vorgehen
========

Die OPNsense® ist im gewünschten Zielnetz einzurichten (z.B. 10.17.0.254/16). Diese muss für alle Server / Ubuntu-VMs als Gateway angegeben werden. Dies kann mithilfe des lmn71-prepare Skripts für den gewünschten neuen Netzbereich (z.B. 10.17.0.0/16) vorbereitet werden.

Gleiches gilt für die Vorbereitung der ``from-scratch`` installierten Server.

Das Skript lmn71-prepare
------------------------

Das Skript lmn71-prepare installiert für Dich das Paket linuxmuster-prepare mit all seinen Abhängigkeiten und es richtet die zweite Festplatte für den Serverbetrieb ein.

.. attention::
  
   Nachstehende Beschreibung muss für 7.1 noch überarbeitet werden !


* Vorbereitung: Lade das Skript hier herunter: ``wget https://raw.githubusercontent.com/linuxmuster/linuxmuster-prepare/master/lmn71-appliance``.
* Mach das Sktipt nun ausführbar: ``chmod +x lmn71-appliance`` ausführbar
* Starte das Skript als Benutzer ``root`` mit: ``./lmn71-appliance -p server -l /dev/sdb``. Hierbei wird auf dem angegebenen Device/ der HDD ein LVM eingerichtet.
* Für weitere Hinweise zum linuxmuster-prepare Skript siehe: https://github.com/linuxmuster/linuxmuster-prepare

Im Anschluss kann das Setup ausgeführt werden, das dann den Netzbereich ausliest und für die weitere Einrichtung verwendet.

Hinweise zum Skript
===================

Das Skript ``lmn71-appliance`` bereitet eine Applicance (VM) für die linuxmuster v7.1 vor:

* Es bringt das Betriebssystem auf den aktuellen Stand,
* installiert das Paket linuxmuster-prepare und
* startet dann das Vorbereitungsskript linuxmuster-prepare, das die für das jeweilige Appliance-Profil benötigten Pakete installiert,
  das Netzwerk konfiguriert, das root-Passwort auf Muster! setzt und im Falle des Serverprofils LVM einrichtet.

Das Skript kennt beim Aufruf folgende Übergabeparameter:

Optionen
--------

+----------+---------------------------------------+--------------------------------------------------+
| Parameter| Wert                                  | Bedeutung                                        |
+==========+=======================================+==================================================+
| -t,      | --hostname=<hostname>                 | Hostname der Appliance,                          |
|          |                                       | falls weggelassen wird der Profilname verwendet. |
+----------+---------------------------------------+--------------------------------------------------+
| -n,      | --ipnet= <ip/bitmask>                 | IP-Adresse und Bitmaske des Hosts (Standardwert  |
|          |                                       | ist 10.0.0.[1,2,3]/16, abhängig vom Profil).     |
+----------+---------------------------------------+--------------------------------------------------+
| -p,      | --profile=<server>                    | appliance-Profil, wurde -n nicht angegeben, wird |
|          |                                       | die IP-Adresse automatisch gesetzt:              |
|          |                                       | server 10.0.0.1                                  |
+----------+---------------------------------------+--------------------------------------------------+
| -l,      | --pvdevice=<device>                   | Pfad zum LVM-Device (nur bei Serverprofil).      |
+----------+---------------------------------------+--------------------------------------------------+
| -f,      | --firewall=<ip>                       | Firewall-/Gateway-/Nameserver-Adresse            |
|          |                                       | (Standard x.x.x 254).                            |
+----------+---------------------------------------+--------------------------------------------------+
| -d,      | --domain= <domain>                    | Domänenname (Standard: linuxmuster.lan).         |
+----------+---------------------------------------+--------------------------------------------------+
| -h,      | --help                                | Hilfe anzeigen.                                  |
+----------+---------------------------------------+--------------------------------------------------+

Profilvorgaben
--------------

**server:**

Paket linuxmuster-base7 (v7.1) mit allen seinen Abhängigkeiten wird installiert. Ist eine zweite Festplatte definiert und wird der Parameter ``-l, --pvdevice=<device>`` angegeben, wird diese wie folgt mit LVM eingerichtet (Werte beziehen sich auf eine Festplattengröße von 100G. Für das LV default-school wird immer der verbleibende Rest genommen. Festplattengröße muss daher mindestens 70G betragen.):

+---------------+----------------------------+---------------------------+-------+
| LV Name       | LV Pfad                    | Mountpoint                | Größe |
+===============+============================+===========================+=======+
|var            | /dev/vg_srv/var            | /var                      |  10G  |
+---------------+----------------------------+---------------------------+-------+
|linbo          | /dev/vg_srv/linbo          | /srv/linbo                |  40G  |
+---------------+----------------------------+---------------------------+-------+
|global         | /dev/vg_srv/global         | /srv/samba/global         |  10G  |
+---------------+----------------------------+---------------------------+-------+
|default-school | /dev/vg_srv/default-school | /srv/samba/default-school |  40G  |
+---------------+----------------------------+---------------------------+-------+

Beispiele
---------

.. code::

   ./lmn71-appliance -p server -l /dev/sdb

Richtet Serverprofil mit LVM auf 2. Festplatte mit Standardwerten ein:
 - Hostname server,
 - IP/Bitmask 10.0.0.1/16,
 - Domänenname linuxmuster.lan
 - Gateway/DNS 10.0.0.254


Server-Appliance vorbereiten
----------------------------

Appliance mit 2 Festplatten einrichten, zum Beispiel:
 - HD 1: 25G (Root-Dateisystem)
 - HD 2: 100G (LVM)
    
  * Ubuntu Server 18.04 Minimalinstallation durchführen.
  * System in eine Partition auf HD 1 installieren (keine Swap-Partition),
  * HD 2 unkonfiguriert lassen.
  * Nach dem ersten Boot als root einloggen und Prepare-Skript herunterladen:
  
.. code::

   # wget https://raw.githubusercontent.com/linuxmuster/linuxmuster-prepare/master/lmn71-appliance
    
   * Skript ausführbar machen

.. code::

   # chmod +x lmn71-appliance

   *  und starten:

.. code::

   ./lmn71-appliance -p server -l /dev/sdb

   * Appliance herunterfahren und Snapshot erstellen.


Anwendung auf die Appliances
============================

Zuerst ist die OPNsense® Firewall anzupassen.

OPNsense® Firewall
------------------

Nach dem ersten Start als Benutzer ``root`` mit dem Passwort ``Muster!`` anmelden. Danach erscheint nachstehendes Konsolenmenü der OPNsense®:

.. figure:: media/01_opnsense-menue.png
   :align: center
   :alt: OPNsense® Menue

Zunächst müssen die Netzwerk-Interfaces unter Mneüpunkt 1 neu zugordnet werden. Je nach Hypervisor werden unterschiedliche Namen für die Netzwerkinterfaces verwendet - z.B. em0 / vtnet0

 * emo/vtnet0 --> LAN
 * em1/vtnet1 --> WAN
 * em2/vtnet2 --> OPT1

Um nun die vorgegebene Netzwerkkonfiguration anzupassen, ist das Menü 2 zu wählen. In nachstehendem Beispiel wird das LAN-Interface auf die IP-Adresse 10.16.1.254/12 geändert.

.. figure:: media/02_opnsense-lan-interface.png
   :align: center
   :alt: OPNsense® LAN Interface

Der DHCP-Dient auf der OPNsense® sollte in jedem Fall ausgeschaltet bleiben. Sollte der Domänenname geändert werden, kann dies später via OPNsense®-GUI erfolgen. 

Anschließend muss die OPNsense® neu gestartet werden.

Im zweiten Schritt muss der Netzbereich der Server-Appliance angepasst werden.

Server-Applicance
-----------------

Nach dem ersten Start der Server-Appliance als ``root`` einloggen (Passwort: Muster!). Danach ist die Netzwerkverbindung für den gewünschten Bereich anzupassen. Das Netzwerkinterface des Server muss sich im gleichen Netzsegment wie die LAN-Schnittstelle der OPNsense® befinden.

.. code::

    # ip -4 -br -a addr show | grep -v ^lo

der o.g. Befehl gibt einen Überblick über alle gefundenen Interfaces.

Das entsprechende Interface ist unter Ubuntu 18.04 nun anzupassen.
Dies erfolgt in der Datei ``/etc/netplan/01-netcfg.yaml`` (z.B. ens33):

.. code::

        network:
          ethernets:
            ens33:
              ...

.. hint::

  ggf. kann die YAML-Datei auch einen anderen Namen nach der Erstinstallation aufweisen. Zu Beginn findet sich nur eine YAML-Datei in dem Verzeichnis.


Änderungen in der Datei speichern und danach wie folgt übernehmen:

.. code::

        # netplan apply

Mithilfe eines Ping-Test wird zuerst geprüft, ob der Server das Gateway erreicht. Im o.g. Beispiel müste dies wie folgt überprüft werden:

.. code::

   ping 10.0.0.254

Ist dies erfolgreich, muss die Appliance mit dem Skript ``lmn71-appliance`` für das Setup vorbereitet werden. Netzwerkadressen und Domänenname werden damit gesetzt. 

Eine eigene IP-/Netzwerkonfiguration übergibt man mit dem Parameter -n:

.. code::

   ./lmn71-appliance -n 192.168.0.1/16 oder
   ./lmn71-appliance -n 192.168.0.1/255.255.0.0

Einen eigenen Domänennamen übergibt man mit -d:

.. code::

   ./lmn71-appliance -d schule.lan

Eine abweichende Firewall-IP setzt man mit -f:

.. code::

   ./lmn71-appliance -f 192.168.0.10

Das alles kann **in einem Schritt** erfolgen:

.. code::

   ./lmn71-appliance -d schule.lan -n 192.168.0.1/16 -f 192.168.0.10

Minimaler Aufruf, wenn die Standard-Netzwerkeinstellungen (10.0.0.0/16) verwendet werden sollen:

.. code::

   ./lmn71-appliance --default -p <Profil>

Gesetzt wird damit:
 * Server: IP 10.0.0.1, Hostname server
 * Firewall-IP: 10.0.0.254, Hostname firewall
 * Domänename: linuxmuster.lan


Einen Überblick über alle Optionen erhält man mit dem Parameter -h.

.. hint::

   Das Default-Rootpasswort ``Muster!`` darf nicht geändert werden, da die Setuproutine dieses voraussetzt.
   Nach der Vorbereitung mit linuxmuster-prepare muss die Appliance neu gestartet werden.

Im letzten Vorbereitungsschritt muss die Appliance noch aktualisiert werden:

.. code::

    # apt update && apt -y dist-upgrade

Danach kann das Setup mit der WebUI oder auf der Konsole auf dem Server aufgerufen werden.
