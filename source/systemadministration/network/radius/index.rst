.. _linuxmuster-freeradius-label:

=========================================
Netzwerkzugriff über Radius (help wanted)
=========================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

RADIUS (Remote Authentification Dial-In User Service) ist ein Client-Server Protokoll, das zur Authentifizierung, Autorisierung und 
für das Accounting (Triple A) von Benutzern in einem Netzwerk dient.

Der RADIUS-Server dient als zentraler Authentifizierungsserver, an den sich verschiedene IT-Dienste für die Authentifizierung wenden 
können. RADIUS bietet sich an, um in grossen Netzen sicherzustellen, dass ausschließlich berechtigte Nutzer Zugriff haben. 
Der Zugriff kann zudem auch auf bestimmte Endgeräte beschränkt werden. 
Um die Authentifizierungsdaten zu übertragen, wird oftmals das Protokoll EAP (Extensible Authentification Protocol) genutzt.

Viele Geräte und Anwendungen, wie z.B. Access Points, Captive Portals oder Wireless Controller bieten neben einer einfachen 
Benutzerauthentifizierung auch eine Überprüfung mit Hilfe eines RADIUS-Servers an (WPA-Enterprise, 802.1X). 
Werden die Geräte so konfiguriert, dass diese zur Authentifizierung den RADIUS-Server nutzen, so kann sichergestellt werden, 
dass nur berechtigte Benutzer Zugriff auf z.B. das WLAN haben.

FreeRADIUS: Einsatz in linuxmuster.net
======================================

FreeRadius ist ein Open-Source RADIUS-Server, der in der linuxmuster.net v7 eingesetzt werden kann.

Dieser RADIUS-Server kann auf der OPNsense® oder auf dem (optionalen) Docker-Host (eigene VM) genutzt werden. 
Die Benutzerauthentifizierung erfolgt anhand der Daten im ActiveDirectory (AD) des linuxmuster.net Servers, die vom 
RADIUS-Server via LDAP oder direkt abgefragt werden.

.. hint::

   Es wird grundsätzlich empfohlen, zusätzliche Dienste **nicht** auf dem lmn-Server zu installieren.
 
Einsatz auf der OPNSense®
-------------------------

Derzeit unterstützt das OPNsense® - Plugin die ``Radius <-- --> AD`` Kommunikation mithilfe von ``auth_ntlm`` N I C H T. 
Eine Dokumentation zur Einrichtung von Freeradius auf der OPNsense® kann daher derzeit nicht erstellt werden.

Einsatz auf dem Docker-Host
---------------------------

linuxmuster.net stellt einen (optionalen) Docker-Host bereit. Dieser ist vorab zu installieren, wenn Freeradius dann als Docker-Container auf dem Docker-Host genutzt werden soll.
Analog zur Nutzung des Mail-Containers als Docker-Container ist hierzu ein FreeRADIUS-Container zu installieren.

.. hint::

   Diesen FreeRADIUS - Container gibt es derzeit leider noch nicht.
   
.. attention::
   
   Wenn du mithelfen möchtest diesen Docker-Container zu erstellen und zu betreuen, würden wir uns freuen, wenn du dir in unserem Forum einen Zugang einrichtest und 
   deine Mithilfe anbietest: https://ask.linuxmuster.net
   



