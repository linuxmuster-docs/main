
Konfiguration von linuxmuster-chilli
====================================

Unabhängig davon, ob man den CoovaChilli-Server selbst auf einer
Ubuntu-Basis installiert hat oder die virtuelle Appliance für Virtualbox
nutzt, kann man mit dem Befehl

.. code-block:: console

   # dpkg-reconfigure linuxmuster-chilli

das Paket für die eigenen Bedürfnisse konfigurieren. Dieser Vorgang
wird auch durch den Befehl linuxmuster-chilli-turnkey` ausgelöst, der
die virtuelle Appliance personalisiert.

Nachfolgend werden die Schritte der Konfiguration erklärt.

Schrittweise Konfiguration
--------------------------

Adresse des LDAP-Servers
~~~~~~~~~~~~~~~~~~~~~~~~

ZUnächst muss die Adresse des LDAP-Servers angegeben werden. Der genaue
Wert hängt davon ab, welches der Szenarien für den Einsatz des Captive
Portals zur Anwendung kommt:

-  Zugang zum grünen Netz: Interne IP-Adresse des Servers

-  Zugang zum blauen Netz: Interne IP-Adresse des Servers. -> `Hinweise
   zur IPFire Konfiguration <chillispot.chilliipfireconfigblau>`__

- Zugang zum roten Netz bzw. direkt ins Internet: Adresse oder
   DynDNS-Name der roten Schnittstelle des IPFire, Portweiterleitung
   für LDAPs (Port 636) von Rot nach Server-IP Grün muss aktiviert
   sein.

{{ .:chillispot-root_linuxmuster-chilli_060.png \|}}

LDAP Suchbasis
~~~~~~~~~~~~~~

Hier muss die LDAP Suchbasis des Schulservers angegeben werden. Diese
kann auf dem Schulserver durch den Befehl ''grep basedn
/var/lib/linuxmuster/network.settings'' ermittelt werden.

{{ .:chillispot-root_linuxmuster-chilli_061.png \|}}

Passwort für den LDAP Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hier muss das Passwort zur Abfrage des LDAP Servers eingegeben werden.
Dieses kann auf dem Schulserver durch den Befehl ''grep rootpw
/etc/ldap/slapd.conf'' ermittelt werden.

{{ .:chillispot-root_linuxmuster-chilli_062.png \|}}

Netzwerkbereich/Netzmaske für die Clientseite des Hotspot-Servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hier muss ein privates Netzwerksegment angegeben werden. Wenn das dem
Internet zugewandte Interface des Hotspot-Servers sich nicht in einem
192.168.x.x Netzwerk befindet, kann die Vorgabe einfach übernommen
werden.

{{ .:chillispot-root_linuxmuster-chilli_063.png \|}}

Die Netzmaske für das Clientnetzwerk. Der Standard stellt 255x255
Adressen für Clients zur Verfügung das sollte reichen.

{{ .:chillispot-root_linuxmuster-chilli_064.png \|}}

Nameserver
~~~~~~~~~~

Hier sollten wenn möglich zwei Nameserver angegeben werden, die vom
Hotspot-Server zur Adressauflösung verwendet werden. Die Werte hängen
vom Anwendungsfall für den Hotspot ab.\\ Man kann hier auch die Blaue IP
des IPCop eintragen (z.B. 172.16.32.254). Ggf. muss aber in der Firewall
noch zusätzlich eine Durchlassen-Regel zum DNS-Port 53 erstellt werden.

{{ .:chillispot-coovaadmin_linuxmuster-chilli_082.png \|}}

Zugangsgruppen
~~~~~~~~~~~~~~

Nur die Mitglieder dieser Systemgruppen auf den Schulserver erhalten
Zugang zum Internet. Mehrere Gruppen werden durch ein Leerzeichen
gtrennt.

{{ .:chillispot-root_linuxmuster-chilli_067.png \|}}

Autologout
~~~~~~~~~~

Nach welcher Zeit in Sekunden soll ein Client bei *Untätigkeit*
automatisch abgemeldet werden?((Dieser Wert wird in die
Konfigurationsoption HS_DEFIDLETIMEOUT von SoovaChilli übernommen. Ein
harter Logout, unabhängig von der Nutzeraktivität, der durch den
Parameter HS_DEFSESSIONTIMEOUT festgelegt wird, wird durch die
Konfiguration von linuxmuster-chilli nicht gesetzt, dies kann bei Bedarf
manuell an anderer Stelle erfolgen.))

{{ .:chillispot-coovaadmin_linuxmuster-chilli_083.png \|}}

Logging
~~~~~~~

Sollen alle Seitenaufrufe con der Clientseite aus für 30 Tage mitgeloggt
werden? Auswahl *ja* oder *nein*. Der Datenschutz ist zu beachten.
Werden die Adressen geloggt, müssen die Nutzer darüber informiert werden
und dem zustimmen.

{{ .:chillispot-root_linuxmuster-chilli_081.png \|}}

Freie Domains
~~~~~~~~~~~~~

Diese Domains können ohne Anmeldung angesurft werden. Mehrere Domains
durch Komma trennen.

{{ .:chillispot-root_linuxmuster-chilli_068.png \|}}

Überschrift der Anmeldeseite
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

{{ .:chillispot-root_linuxmuster-chilli_069.png \|}}

SSL Zertifikat
~~~~~~~~~~~~~~

Hier gibt man den Hostnamen ein, den der Server bei der Installation des
Grundsystems erhalten hat.

{{ .:chillispot-root_linuxmuster-chilli_066.png \|}}

Konfigurationsänderung
----------------------

Die Konfiguration kann jederzeit durch Aufruf des Befehls

::

    dpkg-reconfigure linuxmuster-chilli 

geändert werden, dabei werden die oben mit Screenshots beschriebenen
Schritte erneut durchlaufen, die zuletzt vorgenommenen
Konfigurationseinträge werden dabei als Vorgaben verwendet((Man fängt
also stets bei seiner letzten Konfiguration an)).

Logging
-------

Der Hotspot loggt alle Anmeldungen und Seitenaufrufe in den Dateien:

::

    /var/log/linuxmuster-chilli/coova-chilli.log  # Anmeldungen und chilli-bezogene Meldungen  
    /var/log/linuxmuster-chilli/ffproxy.log       # Seitenaufrufe

Die Logs werden täglich rotiert, Logs werden 30 Tage aufbewahrt und dann
gelöscht.

Erweiterte Optionen für CoovaChilli
-----------------------------------

In der Datei ''/etc/chilli/userconf'' können eigene Optionen für
CoovaChilli festgelegt werden. Die dort definierten Werte überschreiben
bzw. ergänzen diejenigen aus der Paketkonfiguration von
*linuxmuster-chilli*

Beispiel: Eine Datei ''/etc/chilli/userconf'' mit dem folgenden Inhalt,
würde eine Clientsession unabhängig von der Aktivität des Benutzers nach
900 Sekunden beenden, so dass sich der Nutzer neu anmelden muss:

# Wenn im Radius kein Session Timeout definiert wurde, wann fliegt der
Hotspot User wieder raus HS_DEFSESSIONTIMEOUT=900 # In Sekunden

Der Hotspot loggt alle Anmeldungen und Seitenaufrufe in den Dateien:

::

    /var/log/linuxmuster-chilli/coova-chilli.log  # Anmeldungen und chilli-bezogene Meldungen  
    /var/log/linuxmuster-chilli/ffproxy.log       # Seitenaufrufe

Die Logs werden täglich rotiert, Logs werden 30 Tage aufbewahrt und dann
gelöscht.

