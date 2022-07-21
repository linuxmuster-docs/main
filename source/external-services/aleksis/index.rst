.. _linuxmuster-external-services-aleksis-label:

===================================
Externe Authentifizierung - Aleksis
===================================

.. sectionauthor:: `@supergramer <https://ask.linuxmuster.net/u/Supergamer>`_

Aleksis ist eine Schulische Informationsplattform, die als Open-Source Software entwickelt wurde. `aleksis.org <https://aleksis.org/de/>`_

.. todo::

   Funktionen / Besonderheiten kurz beschreiben

Voraussetzungen
===============

Diese Dokumentation setzt voraus, dass ...

.. todo::

  still to be written

LDAP-Anbindung
==============

Verbindungseinstellungen
------------------------


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

.. todo::

  still to be written

