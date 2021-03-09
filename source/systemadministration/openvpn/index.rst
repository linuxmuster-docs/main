.. _linuxmuster-openvpn-label:

=====================
OpenVPN konfigurieren
=====================

.. sectionauthor:: `@dorian <https://ask.linuxmuster.net/u/dorian>`_, Ergänzungen `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

Um Schülern und Lehrern die Möglichkeit zu geben, sich via VPN in das Schulnet "einzuwählen" beschreibt diese Dokumentation die Einrichtung des OpenVPN-Dienstes auf der Firewall OPNsense®.

.. Für die Konfiguration finden sich für die OPNsense® Leitfäden, die ggf. ergänzende Hilfestellung liefern können.    
   So wird auf `OVPN <https://www.ovpn.com/de/guides/opnsense>`_ für die Einrichtung des OpenVPn-Dienstes auf der 
   OPNsense® die verschiedenen Schritte aufgelistet. Achtung dies stellt aber nur die Anbindung an den VPN - Dienst 
   OVPN mit der OPNSense dar !

Voraussetzungen
===============

Die Firewall OPNsense® wurde erfolgreich in Verbindung mit dem linuxmuster.net Server v7 eingerichtet.

.. hier fehlen noch Konfigurationshinweise 


LDAP-Anbindung
==============

Um die LDAP-Anbindung auf der OPNsense® für Schüler und Lehrer einzurichten, durchläufst du folgende Schritte:

Server hinzufügen
-----------------

Unter System > Zugang > Server einen Server hinzufügen (oben rechts). Es sind folgende Einträge vorzunehmen:

1. Beschreibender Name: Linuxmuster VPN Zugang
2. Typ: LDAP
3. Hostname oder IP-Adresse: server.linuxmuster.lan
4. Port-Wert: 636
5. Transport: SSL - Verschlüsselt
6. Protokollversion: 3
7. Bind-Zugangsdaten:
      
.. code::

   Benutzer DN: CN=global-binduser,OU=Management,OU=GLOBAL,DC=linuxmuster,DC=lan
   Suchbereich: Kompletter Unterbaum
   Basis-DN: DC=linuxmuster,DC=lan
   Authentifizierungscontainer: DC=linuxmuster,DC=lan
  
8.1 Erweiterte Abfrage: Schüler und Lehrer: 

.. code::

   |(memberof=CN=role-student,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)(memberof=CN=role-teacher,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)

8.1 Erweiterte Abfrage: Nur Lehrer: 

.. code::

  (memberof=CN=role-teacher,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)
  
9. Benutzerbennenungsattribut: sAMAccountName
  
Danach dem Authentifizierungsserver den angelegten Linuxmuster VPN.Zugang auswählen und den Login mit beliebigen Nutzern testen. Dies erfolgt unter ``System > Zugang > Prüfer``.

Zertifikate erstellen
---------------------

Der OpenVPN Server braucht eine CA um das Serverzertifikat zu erstellen. Man kann entweder eine neue CA generieren oder die vom linuxmuster-setup erzeugte verwenden. In dieser Dokumentation wird die Erstellung einer CA dargestellt.

CA erstellen
^^^^^^^^^^^^
Unter ``System > Zugang > Sicherheit > Aussteller`` ist ein Aussteller hinzuzufügen (oben rechts). Es sind folgende Eingaben zu treffen:

1.  Beschreibender Name: Linuxmuster VPN CA
2.  Vorgehen: Erstelle eine interne Zertifizierungsstelle
3.  Key Type: RSA
4.  Schlüssellänge: 4096
5.  Hash-Algorithmus: SHA512
6.  Lebenszeit (Tage): frei wählbar!
7.  Bedeutender Name: <dein bedeutender Name für die CA>


Zertifikat hinzufügen
^^^^^^^^^^^^^^^^^^^^^

Danach ist unter Unter ``System > Zugang > Sicherheit > Zertifikate`` ein Zertifikat hinzuzufügen (oben rechts). Folgende Eingaben sind zu treffen:

1.  Vorgehen: Erstelle ein neues internes Zertifikat
2.  Beschreibender Name: Linuxmuster VPN Server
3.  Zertifizierungsstelle: Linuxmuster VPN CA
4.  Type: Serverzertifikate
5.  Key Type: RSA
6.  Schlüssellänge: 4096
7.  Hash-Algorithmus: SHA512
8.  Lebenszeit (Tage): frei wählbar!
9.  Private Key Location: Save on this firewall
10. Bedeutender Name: <dein bedeutender Name für das Zertifikat>

OpenVPN-Server erstellen
------------------------

Unter ``VPN > OpenVPN > Server`` ist ein OpenVPN-Server zu erstellen (oben rechts). Es sind folgende Eingaben sind zu treffen:

1.   Beschreibender Name: Linuxmuster VPN
2.   Servermodus: Remotezugriff (Benutzerauthentifizierung)
3.   Backend Authentifizierung: Linuxmuster VPN Zugang
4.   Lokale Gruppe erzwingen (keiner)
5.   Protokoll: UDP
6.   Gerätemodus: tun
7.   Schnittstelle: WAN
8.   Lokaler Port: (frei wählbar) 25008
9.   TLS Authentifikation: Beides angehakt lassen
10.  Peer-Zertifizierungsstelle: Linuxmuster VPN CA
11.  Peerzertifikatsrückrufliste: Keine
12.  Serverzertifikate: Linuxmuster VPN Server
13.  DH Parameterlänge: 4096
14.  Verschlüsselungsalgorithmus: AES-256-CBC (256-bit key, 128-bit block)
15.  Authentifizierungs-Digestalgorithmus: SHA512 (512-bit)
16.  Hardwarekryptografie: No Hardware Crypto Acceleration
17.  Zertifikatstiefe: Eins (Client+Server)
18.  IPv4 Tunnelnetzwerk: Ein Netzbereich in dem die VPN Clients ihre IP bekommen z.B. 172.18.1.0/24
19.  IPv6 Tunnelnetzwerk:
20.  Weiterleitungs Gateway:
21.  Lokales IPv4-Netzwerk: 10.0.0.0/16 --> hier das beim setup gewählte linuxmuster Netz anzugeben
22.  Lokales IPv6-Netzwerk:
23.  Fernes IPv4-Netzwerk:
24.  Fernes IPv6-Netzwerk:
25.  Konkurrierende Verbindungen:
26.  Komprimierung: Aktiviert mit adaptiver Kompression
27.  Typ des Dienstes:
28.  Inter-Client-Kommunikation:
29.  Doppelte Verbindungen:
30.  IPv6 deaktivieren:
31.  Für den Rest: Standardwerte!

Firewall Regeln
---------------

Unter ``Firewall > Regeln > WAN`` eine neue Regel anlegen (oben rechts). Folgende Eingaben sind zu treffen:

1.  Protokoll: UDP
2.  Ziel: Diese Firewall
3.  Zielportbereich: von: 25008 bis: 25008 (ggf. anpassen an eigene Portwahl)
4.  Für den Rest: Standardwerte!

Danach unter ``Firewall > Regeln > OpenVPN`` eine neue Regel anlegen (oben rechts). Es sind folgende Eingaben vorzunehmenn:

1.  Quelle: 172.18.1.0/24 -> das VPN-Netz, das Du für den OpenVPN-Server eingerichtet hast.
2.  Für den Rest: Standardwerte!

Änderungen übernehmen (rechts im blauen Kasten)


Konfiguration exportieren
-------------------------

Für die Verbidnung mit den Clients muss nun ein Export des Profils für den Benutzer erfolgen. Dazu gehst Du zu ``VPN > OpenVPN > Clientexport``. Dort gibst du Folgerndes an:

1.  Ferner Zugriffsserver: Linuxmuster VPN UDP:25008
2.  Export type: Nur Datei
3.  Hostname: Hostname unter dem die Firewall erreichbar ist, z.B: vpn.meineschule.de
4.  Port: 25008 (ggf. anpassen an eigene Portwahl)
5.  Für den Rest: Standardwerte!
  
Danach drückst du unter ``Accounts / certificates`` bei Linuxmuster VPN Server ganz rechts auf das Downloadsymbol.

mit VPN verbinden
=================

Die heruntergeladene Datei muss nun auf das Endgerät heruntergeladen und dort in die App OpenVPN Connect (für alle Plattformen) importiert werden. Nach dem Import kann durch Eingabe von Benutzername und Passwort eine VPN-Verbindung hergestellt werden.
