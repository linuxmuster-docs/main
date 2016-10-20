LDAP
----

LDAP Zugriff einrichten
~~~~~~~~~~~~~~~~~~~~~~~

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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Geben Sie folgenden Befehl ein (Benutzernamen und Passwort anpassen!):

.. code-block:: console

   $ radtest user password localhost 10 testing123
   ....
   rad_recv: Access-Accept Packet from ...

Falls Sie ein *Access-Accept Packet* erhalten haben, war die Authentifizierung erfolgreich!

Weitere Einstellungen
---------------------

Zugriffsbeschränkung aktivieren
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
~~~~~~~~~~~~~~~~~~

In der Datei ``/etc/freeradius/radiusd.conf`` kann das Logging von Authentifizierungs-Anfragen eingeschaltet werden. Die Log-Datei ist: ``/var/log/freeradius/radius.log``. Vergessen Sie nicht den Neustart des Radius-Servers!

.. code-block:: console

   log {
      ...
      auth = yes
      ...
   }