.. _linuxmuster-external-services-nextcloud-label:

=====================================
Externe Authentifizierung - Nextcloud
=====================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   
Eine Nextcloud-Instanz kann extern oder intern betrieben werden. Hierbei kann diese so konfiguriert werden, dass
das Active Directory (AD) der linuxmuster.net 7 als zentrale Authentifizierungsinstanz genutzt wird. 

Nachstehende Konfigurationsschritte sind auf der Nextcloud-Instanz auszuführen.

Einstellungen: Server
=====================

Sollte der Nextloud-Server extern betrieben werden, so muss die OPNsense®-Firewall so konfiguriert werden, dass Anfragen 
über den ``LDAPs-Port 636`` an den Server weitergeleitet werden. 

In der Konfigurationsoberfläche ist unter ``Firewall -> NAT -> Portweiterleitung``
eine entsprechende Regel anzulegen.


Trage auf dem Nextcloud-Server im Konfigurationsmenü folgende Werte ein:

.. image:: media/image_1.png
   :alt: Server - Einstellungen
   :align: center

Sollte der Nextcloud Server extern betrieben werden, so ist als URL für den LDAP-Server eine Adresse nach diesem Schema anzugeben: ``ldaps://hostename.subdomain.domain.topleveldomain`` - z.B. ldaps://nextcloud.schule.meineschule.de. 
Als ``Port`` ist dann ``636`` einzutragen, um eine gesicherte Verbindung aufzubauen. 

Für den ``binduser`` ist die Domäne anzupassen, so dass mit o.g. Beispiel die Eintragungen dort wie folgt aussehen könnten:

.. code::

   CN=global-binduser,OU=Management,OU=GLOBAL,DC=schule,DC=meineschule,DC=de

In der Zeile darunter ist das Kennwort des ``binduser`` einzutragen. Dieses Passwort findest du auf dem LMN-Server unter
``/etc/linuxmuster/.secret/global-binduser`` und trägst es hier ein.

Als ``Base-DN`` trägst du ``OU=SCHOOLS`` gefolgt von deiner Domain (z.B. DC=schule,DC=meineschule,DC=de) ein.

Einstellungen: Benutzer (Lehrer)
================================

Um den Zugriff auf die Nextcloud auf Lehrer zu begrenzen, ist unter ``Benutzer`` eine LDAP-Abfrage einzutragen.

.. image:: media/image_2.png
   :alt: Benutzer (Lehrer) - Einstellungen
   :align: center

Nachstende Abfrage muss auf die eigene Domain angepasst werden:

.. code::

   (&(|(objectclass=person))(|(|(memberof=CN=teachers,OU=Teachers,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)(primaryGroupID=1111))))

Anmelde-Attribute (Lehrer)
==========================

Nehme folgende Einstellungen vor:

.. image:: media/image_3.png
   :alt: Anmelde-Attribute
   :align: center

Die nachstehende Abfrage bezieht sich auf die Gruppe der Lehrer:

.. code::

   (&(&(|(objectclass=person))(|(|(memberof=CN=teachers,OU=Teachers,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)(primaryGroupID=1111))))(samaccountname=%uid))

Einstellungen: Gruppe (Lehrer)
==============================

Nehme folgende Einstellungen vor:

.. image:: media/image_4.png
   :alt: Einstellungen Gruppe Lehrer
   :align: center

Die nachstehende Abfrage bezieht sich auf die Gruppe der Lehrer:

.. code::

   (&(|(objectclass=group))(|(cn=teachers)))

Einstellungen Experte
=====================

Klicke in dem Einstellungsmenü oben rechts auf den Eintrag ``Experte`` und trage nachstehende Werte ein:

.. image:: media/image_5.png
   :alt: Einstellungen Gruppe Lehrer
   :align: center

Trage dort folgenden Wert ein:

.. code::

   samaccountname

Funktionstests
==============

In dem Konfigurationsmenü von Nextcloud können pro Tab / Reiterkarte die Einstellungem schrittweise getestet werden. 
Führe diese Tests jeweils bei dein einzelnen Konfigurationsschritten aus, um so sukzessive die Fehler zu beheben.

Nextcloud mit weiteren Gruppen
===============================

Soll Nextcloud nicht nur von Lehrern genutzt werden können, sondern auch von anderen Gruppen, so sind zwei Dinge erforderlich:

1. Aktivierung eingebundener Gruppen
2. LDAP-Gruppenfilter

Aktivierung eingebundener Gruppen
---------------------------------

Um eingebundene Gruppen zu aktivieren, gehe auf ``LDAP /AD Integration --> Fortgeschritten --> Ordnereinstellungen --> Eingebundene Gruppen`` und aktiviere diese Funktion.

.. hint::
  
   Dies ist dann erforderlich, wenn als Gruppenfilter ``cn=students`` angegeben wurde. ``cn=students`` beinhaltet nur Gruppen und 
   keine Benutzer!
   

LDAP-Gruppenfilter
------------------

Einstellungen: Gruppen
""""""""""""""""""""""

Unter ``LDAP / AD Integration --> Gruppen`` ist ein Gruppenfilter als LDAP-Abfrage, so zu definieren, dass die gewünschten Gruppen im AD gefunden werden.

Nachstehendes Beispiel stellt eine Abfrage dar, die es ermöglicht, Klassen, Projekt, Students und Teachers als Gruppen auszuwählen. Die Gruppen Wificlass und Attic werden hierbei ausgeschlossen:

.. code::

   (&(|(objectclass=group))(!(|(cn=attic)(cn=wificlass)))(|(cn=teachers)(cn=role-student)(|(memberof=CN=students,OU=Students,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)(|(sophomorixType=project)))))

.. hint::

   ``cn=role-student`` wählt die Gruppe mit Schülern aus, die sich im AD im GLOBAL Teil befindet. Sollte ein Mehr-Schulen-Betrieb erfolgen, ist dies
   anzupassen.


Einstellungen: Benutzer
"""""""""""""""""""""""

Um Lehrer und Schüler zu erhalten, ist bei der LDAP-AD Integration unter Benutzer ein angepasster LDAP-Filter einzutragen. Nachstehender Filter liefert alle Lehrer und Schüler:

.. code::

  (&(|(objectclass=group))(|(|(memberof=CN=teachers,OU=Teachers,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)(primaryGroupID=1111))(|(memberof=CN=role-student,OU=Groups,OU=GLOBAL,DC=linuxmuster,DC=lan))))

Einstellungen: Fortgeschritten
""""""""""""""""""""""""""""""

Bei der LDAP / AD Integration ist im Menüpuntk ``Forgeschritten`` (oben rechts) anzugeben, wie die Verbindung zwischen Gruppen und Benutzern zu behandeln ist. Zur Orientierung findest du nachstehend geeignete Einstellungen.


.. image:: media/image_6.png
   :alt: Fortgeschritten - Verbindungseinstellungen
   :align: center

.. image:: media/image_7.png
   :alt: Fortgeschritten - Ordnereinstellungen
   :align: center

.. hint::

   Sollte die Gruppe der Schüler ``cn=role-student`` in den Filtereinstellungen genutzt werden, dann ist in Nextcloud 
   bei den LDAP-Einstellungen -> Fortgeschritten als Basis-Gruppenbaum ``OU=GLOBAL,DC=linuxmuster,DC=lan``
   einzutragen.

.. image:: media/image_8.png
   :alt: Fortgeschritten - spezielle Eigenschaften
   :align: center

 













