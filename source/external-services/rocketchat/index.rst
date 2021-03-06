.. _linuxmuster-external-services-rocketchat-label:

=======================================
Externe Authentifizierung - Rocket Chat
=======================================

.. sectionauthor:: `@dorian <https://ask.linuxmuster.net/u/dorian>`_, Ergänzungen `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

Die Open-Source Kommunikationsplattform `rocket.chat <https://rocket.chat/de/>`_ bietet u.a. die Möglichkeit, einen flexiblen, datenschutzkonformen Sofort-Nachrichten-Dienst anzubieten.

Für die Installation eines eigenen rocket.chat Servers werden verschiende Möglichkeiten angeboten.
Die Dokumentation zur Installation des Servers unter Ubuntu findet sich hier: `Rocket.Chat in Ubuntu <https://docs.rocket.chat/installation/manual-installation/ubuntu>`_

Zur Nutzung stehen sowohl `Desktop Apps als auch Mobile-Apps <https://rocket.chat/de/install/>`_ für Linux/Android, Windows und Apple Geräte / OS zur Verfügung.

Voraussetzungen
===============

Diese Dokumentation setzt voraus, dass rocket.chat als Server intern oder extern installiert und funktionsfähig ist. Dies schließt auch ggf. die Anpassung der Firewall ein, so dass prinzipiell eine Verbindung zum linuxmuster.net Server möglich ist.

LDAP-Anbindung
==============

Verbindungseinstellungen
------------------------

.. hier fehlen noch Erklärungen

1.  Enable: JA
2.  Login Fallback: JA
3.  Find user after login: NEIN!!
4.  Host: server.linuxmuster.lan -> eigene URL eintragen
5.  Port: 636
6.  Reconnect: JA
7.  Encryption: SSL/LDAPS
8.  CA Cert: Inhalt der Datei /etc/linuxmuster/ssl/cacert.pem
9.  Reject Unauthorized: JA (Kann zum Testen aber auf nein gesetzt werden)
10. Base DN: DC=linuxmuster,DC=lan

Authentication
--------------

1.  Enable: JA
2.  User DN: CN=global-binduser,OU=Management,OU=GLOBAL,DC=linuxmuster,DC=lan
3.  Password: steht in /etc/linuxmuster/.secret/global-binduser

Danach oben auf „Test Connection“ clicken. Wenn eine Fehlermeldung erscheint, Einstellungen und Verbindung zum Server testen.

Sync / Import
-------------

1.  Username Fiels: sAMAccountName
2.  Unique Identifier Field: sAMAccountName
3.  Default Domain: leer
4.  Merge Existing Users: JA
5.  Sync User Data: JA
6.  User Data Field Map: {"displayName":"name", "mail":"email"}
7.  Sync LDAP Groups: JA
8.  Auto Remove User Roles: JA
9.   User Group Filter:

.. code::

    (&(sAMAccountName=#{username})(|(memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=Projects,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)(memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)(memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=#{groupName},OU=Students,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)))


10. LDAP Group BaseDN: DC=linuxmuster,DC=lan -> eigener BaseDN ist einzutragen
11. User data Group Map:
    Hier kann man LDAP Gruppen Rocket.Chat Rollen zuordnen. Diese Rollen müssen vorher unter „Permissions“ angelegt werden. Zum Beispiel um den global admins Adminrechte zu geben, Lehrern die Rolle „lehrer“ und Schülern die Rolle „schueler“ zurodnen:

.. code::

  {
    "role-student": "schueler",
    "role-teacher": "lehrer",
    "role-globaladministrator": "admin"
  }

Auch Klassen und Projekte können hier verwendet werden:

.. code::

  {
    "role-student": "schueler",
    "role-teacher": "lehrer",
    "role-globaladministrator": "admin",
    "p_nwt": "nwt",
    "5a": "klasse5",
    "5b": "klasse5"
  }

12. Auto Sync LDAP Groups to Channels: JA
13. Channel Admin: rocket.cat
14. LDAP Group Channel Map:
    Hier kann man LDAP Gruppen Channels zuordnen. Dadurch werden alle Mitglieder der LDAP Gruppen automtisch den Channels hinzugefügt. Die Channels werden auch automatisch erstellt, falls sie noch nicht existieren.

.. code::

  {
    "role-globaladministrator": "admintalk",
    "role-student": [
      "info",
      "news"
    ]
  }

Hierdurch werden alle Schüler den Channels „info“ und „news“ hinzugefügt.

.. hint::
   Es ist möglich, Channels so einzustellen, dass sie nur lesbar sind. Man kann so einen Channel erstellen, in dem nur Lehrer schreiben können, indem man der entsprechenden Rocket.Chat Rolle, die man role-teacher zuordnet, in den Berechtigungseinstellungen von Rocket.Chat die Berechtigung erteilt, in schreibgeschützte Channels zu schreiben. Man kann so auch einfach Channels für bestimmte Stufen erstellen, indem man alle Klassen der Stufe diesem Channel zuordnet

15. Auto remove user from channels: JA
16. Sync user avatar: NEIN
17. Background Sync: JA
18. Background Sync Interval: Beliebig
19. Background Sync Import New Users: JA
20. Background Sync Update Existing Users: JA

.. attention::

   Jetzt noch NICHT auf „Execute Synchonization Now“ klicken, das geht schief!

21. Timeouts: Standardwerte
22. User Search:
23. Filter: Damit Schüler und Lehrer sich anmelden können:

.. code::

    |(memberof=CN=role-student,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)(memberof=CN=role-teacher,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)(memberof=CN=role-globaladministrator,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)

Damit sich nur Lehrer anmelden können:

.. code::

   |(memberof=CN=role-teacher,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)(memberof=CN=role-globaladministrator,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)

``Global Admins`` können sich immer anmelden.

24. Scope: sub
25. Search Field: sAMAccountName
26. Rest: Standardwerte
27. User Search (Group Validation):
28. Enable LDAP User Group Filter: NEIN
29. Rest: leer lassen

.. important::

   Jetzt kann gespeichert werden.


Im Anschluss unter **Sync / Import** auf ``Execute Synchronization Now`` clicken und damit den Sync starten.


User Group Filter
=================

.. code::

  (&
    (sAMAccountName=#{username})
    (|
      (memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=Projects,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)
    (memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan)
    (memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=#{groupName},OU=Students,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)
  )
  )

Die Implementierung der Nutzergruppenzuordnung von Rocket.Chat ist schwer nachzuvollziehen.
Bei der Zuordnung von Usern zu Gruppen "durchläuft" Rocket.chat jeden Nutzer:
1. Für jeden Nutzer wird pro Gruppe einmal eine LDAP Suche mit obigem Filter ausgeführt.
2. Dabei wird #{username} durch den Nutzernamen und #{groupName} durch den Gruppennamen ersetzt.
3. Wenn es bei der Suche mehr als null Ergebnisse gibt, geht Rocket.Chat davon aus, dass der Nutzer aus (1) Mitglied der Gruppe aus (1.1) ist.
4. Für die nächste Gruppe geht es wieder bei (1.1) weiter. Sind alle Gruppen geprüft, geht es bei (1) mit dem nächsten Nutzer weiter.

Erklärung des Filters
---------------------

1. (sAMAccountName=#{username}) → Stellt sicher, dass kein falscher Nutzer beachtet wird
2. (memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=Projects,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan) → Für Mitgliedschaften in Projekten
3. (memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan) → Für Rollen
4. (memberOf:1.2.840.113556.1.4.1941:=CN=#{groupName},OU=#{groupName},OU=Students,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan) → Für Klassen

Der „Kauderwelsch“ 1.2.840.113556.1.4.1941 sorgt dafür, dass auch Untergruppen berücksichtigt werden. Zum Beispiel, wenn eine ganze Klasse Teil eines Projektes ist.
