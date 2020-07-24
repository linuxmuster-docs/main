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

Sollte der Nextloud-Server extern betrieben werden, so muss die OPNsense-Firewall so konfiguriert werden, dass Anfragen 
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

   sambaccountname

Funktionstests
==============

In dem Konfigurationsmenü von Nextcloud können pro Tab / Reiterkarte die Einstellungem schrittweise getestet werden. 
Führe diese Tests jeweils bei dein einzelnen Konfigurationsschritten aus, um so sukzessive die Fehler zu beheben.











