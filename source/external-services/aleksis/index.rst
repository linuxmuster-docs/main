.. _linuxmuster-external-services-aleksis-label:

===================================
Externe Authentifizierung - Aleksis
===================================

.. sectionauthor:: `@supergamer <https://ask.linuxmuster.net/u/Supergamer>`_

Aleksis ist eine Schulische Informationsplattform, die als Open-Source Software entwickelt wurde. `aleksis.org <https://aleksis.org/de/>`_

Folgende Funktionen bietet Aleksis an:

* Stundenplan Verwaltung

* Vertretunsplan

* Digitales Klassenbuch

* Sitzpläne

* Info Dashboard (z.B. für Bildschirme)

* Bücherei Verwaltung


Voraussetzungen
===============

Diese Dokumentation setzt voraus, dass eine Aleksis Instanz eingerichtet wurde mit der direkten Installationsmethode. 

Die Dokumentaion für die LDAP Anbidung der Docker Variante erfolgt noch.

Eine Installationsanleitung für Aleksis ist hier zu finden: `Installation Aleksis <https://aleksis.edugit.io/official/AlekSIS-Core/docs/html/admin/01_install.html>`_

Außerdem muss auf der Aleksis Instanz dieser Installationsbefehl ausgeführt werden um alle nötigen LDAP Pakete zu installieren.

.. code-block:: console

   # sudo apt install python3-ldap libldap2-dev libssl-dev libsasl2-dev python3-dev


LDAP-Anbindung
==============

Verbindungseinstellungen
------------------------

Sind die benötigten LDAP Pakete installiert muss die LDAP Konfiguration in der Aleksis Konfigurationsdatei angepasst / erstellt werden.

.. code-block:: console

   # nano /etc/aleksis/aleksis.toml

.. code::

  [ldap]
  uri = "ldap://server.linuxmuster.lan:389"
  bind = { dn = "cn=global-binduser,OU=Management,OU=GLOBAL,dc=linuxmuster,dc=lan", password = "GLOBAL-BINDUSER-PASSWORT" }
  
  [ldap.users]
  search = { base = "ou=default-school,ou=schools,dc=linuxmuster,dc=lan", filter = "(&(|(memberof=CN=role-student,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)(memberof=C>map = { first_name = "givenName", last_name = "sn", email = "mail", username="samaccountname" }
  
  [ldap.groups]
  search = { base = "OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan", filter="(&(|(memberOf=CN=students,OU=Students,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=>type = "groupOfNames"
  # Users in group "admins" are superusers
  #flags = { is_superuser = "cn=admins,ou=groups,dc=myschool,dc=edu" }

Die ``uri`` muss natürlich auf die jeweilige Schule mit dem entsprechenden Domain Namen angepasst werden ebenso bei ``search``

Sollte die Aleksis Instanz extern betrtrieben werden. Ist es dringend empfohlen den Port ``636`` für LDAPs zu verwenden außerdem bei ``uri`` 
statt ``ldap:`` ebenfalls ``ldaps`` einzutragen. 


Als nächstes wechselt man in die Aleksis Weboberfläche und wechselt auf der linken Seite auf ``Admin`` und dann auf ``LDAP``

Dort ändert man folgende Werte:

+------------------------------------------------------+------------------------------------------+
| LDAP-Synchronisation aktivieren                      | Haken setzen                             |
+------------------------------------------------------+------------------------------------------+
| Fehlende Personen für LDAP-Benutzer erstellen        | Haken setzen                             |
+------------------------------------------------------+------------------------------------------+
| LDAP-Benutzer bei der Anmeldung synchronisieren      | Haken setzen                             |
+------------------------------------------------------+------------------------------------------+
| LDAP-Synchronisation von Gruppen aktivieren          | Haken setzen                             |
+------------------------------------------------------+------------------------------------------+
| Feld für den Kurznamen der Gruppe                    | cn                                       |
+------------------------------------------------------+------------------------------------------+
| LDAP-Synchronisation für passende Felder durchführen | UID                                      |
+------------------------------------------------------+------------------------------------------+
| Abgleich-Modus für die LDAP-Synchronisation          | Alle Felder müssen passen                |
+------------------------------------------------------+------------------------------------------+
| LDAP-Passwort bei ALekSIS-Passwortänderung ändern    | Haken entfernen                          |
+------------------------------------------------------+------------------------------------------+
| Admin-Konto nutzen, um Passwörter zu ändern          | Haken entfernen                          |
+------------------------------------------------------+------------------------------------------+
| LDAP field for 'First name' on core.Person           | givenName                                |
+------------------------------------------------------+------------------------------------------+
| LDAP field for 'Last name' on core.Person            | sn                                       |
+------------------------------------------------------+------------------------------------------+
| LDAP sync matching fields                            | nur first_name & last_name auswählen     |
+------------------------------------------------------+------------------------------------------+

Alle anderen Felder sollten leer bleiben

Am Ende die Einstellungen mit ``EINSTELLUNGEN SPEICHERN`` bestätigen.

Jetzt sollte der Benutzer in der Lage sein sich anzumelden. Die LDAP Anbindung ist hiermit abgeschlossen.
