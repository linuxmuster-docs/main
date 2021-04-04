.. _linuxmuster-external-services-nextcloud-label:

=====================================
Externe Authentifizierung - Nextcloud
=====================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_ , `@rettich <https://ask.linuxmuster.net/u/rettich>`_
                   
Eine Nextcloud-Instanz kann extern oder intern betrieben werden. Hierbei kann diese so konfiguriert werden, dass
das Active Directory (AD) der linuxmuster.net 7 als zentrale Authentifizierungsinstanz genutzt wird. 

Nachstehende Konfigurationsschritte sind auf der Nextcloud-Instanz auszuführen.

Einstellungen: Server
=====================

Sollte der Nextloud-Server extern betrieben werden, so muss die OPNsense®-Firewall so konfiguriert werden, dass Anfragen 
über den ``LDAPs-Port 636`` an den Server weitergeleitet werden. Siehe :ref:`Firewallregeln <nextcloud-firewall-label>`. 

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

Als ``Base-DN`` trägst du ``OU=default-school,OU=SCHOOLS,`` gefolgt von deiner Domain (z.B. DC=schule,DC=meineschule,DC=de) ein.

Einstellungen: Benutzer
=======================

Wenn du mit einem Tool wie Apache Directory Studio die Attribute eines Lehrer-Accounts anschaust, siehst du, dass du sie an zwei Attributen erkennst:
``objectClass=person`` und ``sophomorixRole=teacher``.

Bei Schüler-Accounts ist ``sophomorixRole=student``.

Daraus ergibt sich die Filterregel:

.. image:: media/FR01.png
   :alt: Benutzer - Einstellungen
   :align: center

Trage also unter Benutzer in die LDAP-Abfrage folgendes ein:

.. code::

   (&(objectClass=person)(|(sophomorixRole=teacher)(sophomorixRole=student)))

Um den Zugriff auf die Nextcloud auf Lehrer zu begrenzen, ist unter ``Benutzer`` diese LDAP-Abfrage einzutragen.

.. code::

   (&(objectClass=person)(sophomorixRole=teacher))

.. image:: media/image_2.png
   :alt: Benutzer (Lehrer) - Einstellungen
   :align: center

Anmelde-Attribute
=================

Bei der Anmeldung suchen wir den Eintrag, bei dem zusätzlich ``samaccountname=%uid`` gilt. In dem Fall ist ``%uid`` der Benutzername, den wir bei der Anmeldung eingeben.

Nehme folgende Einstellungen vor:

.. image:: media/image_3.png
   :alt: Anmelde-Attribute
   :align: center

.. code::

   (&(objectClass=person)(sAMAccountName=%uid))

Einstellungen: Gruppe
==============================

Wir wollen nicht die Gruppen ``attic`` und ``wificlass``. Aber wir wollen Schüler, Lehrer, Projekte und alle Untergruppen der Gruppe ``students``.

.. image:: media/FR02.png
   :alt: Filterregel Gruppe
   :align: center

Nehme folgende Einstellungen vor:

.. image:: media/image_4.png
   :alt: Einstellungen Gruppe Lehrer
   :align: center

.. code::

  (&(objectclass=group)(!(|(cn=attic)(cn=wificlass)))(|(cn=teachers)(cn=role-student)(memberof=CN=students,OU=Students,OU=default-school,OU=SCHOOLS,DC=linuxmuster,DC=lan)(sophomorixType=project)))

Die nachstehende Abfrage liefert nur die Gruppe der Lehrer:

.. code::

   (&(objectclass=group)(cn=teachers))

Einstellungen Experte
=====================

Klicke in dem Einstellungsmenü oben rechts auf den Eintrag ``Experte`` und trage nachstehende Werte ein:

.. image:: media/image_5.png
   :alt: Einstellungen Experte
   :align: center

Trage dort folgenden Wert ein:

.. code::

   samaccountname

Einstellungen Fortgeschritten
=============================

.. image:: media/image_6.png
   :alt: Verbindungseinstellungen
   :align: center

Setze eine Häkchen bei ``Konfiguartion aktiv`` und, falls dein Server mit einem selbstsigniertem Zertifikat arbeitet, auch bei ``Schalten Sie die SSL-Zertifikatsprüfung aus``.

.. image:: media/image_7.png
   :alt: Ordnereinstellungen
   :align: center

In ``Benutzersucheigenschaften`` gibst du ``sn`` und ``givenName`` ein. So können Benutzer über ihren Vor- und Nachnamen gefunden werden.

.. image:: media/image_8.png
   :alt: Spezielle Eigenschaften
   :align: center

Im Feld ``Standard-Kontingent`` wird festgelegt, wie viel Speicher dem Benutzer auf der Nextcloud zur Verfügung steht. Da die Benutzer ihre Daten eigentlich auf dem Schulserver und nicht auf der Nextcloud speichern sollen, hälst du diesen Wert eher klein. 

Das ``"$home"Platzhalter-Feld`` brauchst du, wenn du die Home-Verzeichnisse auch in der Nextcloud zur Verfügung stellen möchtest.

So, das war's. Sicherheitshalber gehst du nochmal auf den Reiter ``Experte`` und klicks auf  ``Lösche LDAP-Benutzernamenzuordung`` und ``Lösche LDAP-Gruppennamenzuordung``.

