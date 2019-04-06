
Radius-Server installieren
==========================

In den Paketquellen von Linuxmuster.net gibt es das Paket ``linuxmuster-freeradius``. Installieren Sie das Paket mit

.. code-block:: console

   $ apt-get install linuxmuster-freeradius


Firewall konfigurieren
----------------------

Nun muss die Firewall konfiguriert werden, damit die Anfragen auch auf dem Server ankommen (UDP, Port 1182). Dazu bearbeitet man die Datei ``/etc/linuxmuster/allowed_ports`` und fügt in der Zeile "udp" den entsprechenden Port hinzu.

.. code-block:: console

   ...
   udp domain, ... , 1812

Damit die Änderungen auf der Firewall (IPFire) wirksam werden, geben Sie bitte folgenden Befehl ein:

.. code-block:: console

   $ service linuxmuster-base restart

Falls Sie eine andere Firewall als die empfohlene Firewalllösung (IPFire) verwenden, müssen Sie die entsprechende Firewallregel selbst einrichten!


Radius-Servers testen
---------------------

In der Datei ``/etc/freeradius/users`` in der folgenden Zeile das Kommentarzeichen (``#``) entfernen.

.. code-block:: console

   steve  Cleartext-Password := "testing"

Als nächstes überprüft man, ob ``localhost`` in der Datei ``/etc/freeradius/clients`` eingetragen ist. Dieser Eintrag kann nach dem Test wieder entfernt werden.

.. code-block:: console

   client localhost {
      ipaddr = 127.0.0.1
      secret = testing123
   }

Nun kann man, nach einem Neustart des Radius-Servers, die Authentifizierung für diesen User testen.

.. code-block:: console

   $ service freeradius restart
   $ radtest steve testing 127.0.0.1:1812 10 testing123

Als Ausgabe sollte man folgendes erhalten:

.. code-block:: console

   $ radtest steve testing 127.0.0.1:1812 10 testing123
   Sending Access-Request of id 34 to 127.0.0.1 port 1812
          User-Name = "steve"
          User-Password = "testing"
          NAS-IP-Address = 127.0.0.1
          NAS-Port = 0
  rad_recv: Access-Accept packet from host 127.0.0.1 port 1812, id=34, length=20

Wenn man eine ähnliche Ausgabe erhält, kann nun der Zugriff auf das LDAP-Verzeichnis eingerichtet werden, damit man sich mit seinem Benutzernamen und Passwort der linuxmuster.net anmelden kann. Dazu muss der Client (Access Point, Captive Portal Server, Wireless Controller) in die Datei ``/etc/freeradius/clients`` eingetragen werden. Bitte passen Sie den Client Namen, die IP-Adresse und das Passwort entsprechend an.

.. code-block:: console

   client captivePortal {
      ipaddr = 10.16.1.254
      secret = geheim
   }

Radius-Server konfigurieren
---------------------------

Für die Authentifizierung mit einem Radius-Server gibt es verschiedene Protokolle, welche festlegen, wie die Übertragung und Authentifizierung abläuft. Dieses kann man in der Datei ``/etc/freeradius/eap.conf`` festlegen. Überprüfen Sie folgende Einstellungen und entfernen Sie, falls notwendig, die Kommentarzeichen.

.. code-block:: console

   eap {
      ...
      default_eap_type = peap
      ...
   }

   ...
   peap {
      ...
      default_eap_type = mschapv2
      ...
   }

MD5 kommt als Protokoll nicht in Frage, da die Passwörter nicht als MD5 im LDAP gespeichert sind!

Überprüfen Sie weiterhin den Parameter ``auto_header`` in der Datei ``/etc/freeradius/radiusd.conf``.

.. code-block:: console

   pap {
      auto_header = yes
   }

LDAP konfigurieren
==================

LDAP Zugriff einrichten
-----------------------

Bei der Installation von Linuxmuster.net wurde bereits die notwendige Konfiguration in der Datei ``/etc/freeradius/radiusd.conf`` vorgenommen. Suchen Sie in der Datei den Abschnitt, der den LDAP betrifft und überprüfen sie folgende Angaben:

.. code-block:: console

   ...
   ldap {
      ...
      server = "localhost"
      identity = "cn=admin,dc=linuxmuster-net,dc=lokal"
      password = geheim
      basedn = "ou=accounts,dc=linuxmuster-net,dc=lokal"
      filter = "(uid=%u)"
      ...
   }
   ...

Das benötige Passwort kann mit folgendem Befehl angezeigt werden:

.. code-block:: console

   $ cat /etc/ldap/slapd.conf | grep rootpw

Aktivieren Sie nun in der Datei ``/etc/freeradius/sites-available/default`` **UND** ``/etc/freeradius/sites-available/inner-tunnel`` die LDAP-Authentifizierung, d.h. entfernen Sie bei den jeweiligen Zeilen zu LDAP die Kommentarzeichen.

.. code-block:: console

   ...
   authorize {
      ...
      ldap
      ...
   }
   ...
   authenticate {
      ...
      Auth-Type LDAP {
         ldap
      }
      ...
   }

Am Ende starten Sie die Radius-Server neu:

.. code-block:: console

   $ service freeradius restart


LDAP-Authentifizierung testen
-----------------------------

Geben Sie folgenden Befehl ein (Benutzernamen und Passwort anpassen!):

.. code-block:: console

   $ radtest user password localhost 10 testing123
   ....
   rad_recv: Access-Accept Packet from ...

Falls Sie ein *Access-Accept Packet* erhalten haben, war die Authentifizierung erfolgreich!

Weitere Einstellungen
=====================

Zugriffsbeschränkung aktivieren
-------------------------------

Wenn man den Radius-Server zur Authentifizierung im WLAN benutzt und nur bestimmte Nutzer Zugriff erhalten sollen (z.B. alle Mitglieder der Gruppe ``p_wifi``), so muss man in der Datei ``/etc/freeradius/users`` folgende Änderung vornehmen bzw. hinzufügen:

.. code-block:: console

   ...
   DEFAULT Group != p_wifi
   DEFAULT Auth-Type := Reject
      Reply-Message = "Your are not allowed to access the WLAN!"
   ...

Alternativ kann man auch die entsprechende LDAP-Gruppe direkt abfragen.

.. code-block:: console

   ...
   DEFAULT Ldap-Group == "cn=p_wifi,ou=groups,dc=linuxmuster-net,dc=lokal"
   DEFAULT Auth-Type := Reject
      Reply-Message = "Your are not allowed to access the WLAN!"
   ...

Im Abschnitt ``ldap {...}`` in der Datei ``/etc/freeradius/radiusd.conf`` muss noch der entsprechende Filter aktiviert werden:

.. code-block:: console

   ...
   groupmembership_filter = (&(objectClass=posixGroup)(memberUid=%u))
   ...

Logging aktivieren
------------------

In der Datei ``/etc/freeradius/radiusd.conf`` kann das Logging von Authentifizierungs-Anfragen eingeschaltet werden. Die Log-Datei ist: ``/var/log/freeradius/radius.log``. Vergessen Sie nicht den Neustart des Radius-Servers!

.. code-block:: console

   log {
      ...
      auth = yes
      ...
   }
