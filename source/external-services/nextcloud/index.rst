=============================
Nextcloud für linuxmuster.net 
=============================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_

In diesem Teil der Dokumentation siehst du, wie du auf einem Dockerhost Nextcloud einrichtet, wie du das Active Directory (AD) der linuxmuster.net 7 als Authentifizierungsinstanz nutzt und was du einstellen musst, damit deine Benutzer über die Nextcloud direkt auf ihre Daten zugreifen können.

Eine detailierte Anleitung zur Installation eines Docker-Hosts findest du `hier <https://github.com/linuxmuster-ext-docker/create-docker-host>`_.

Vorüberlegungen zum Standort des Nextcloud-Services
===================================================

.. image:: media/index-01.png
   :align: center

In der Grafik ist der Nextcloud-Service auf dem Dockerhost der Schule. 

Greift ein Gerät in der Schule, z.B. ein Tablett oder ein Handy, über die Nextcloud auf Daten auf dem Schulserver zu, müssen die Daten nicht über das Internet. Hier ist der Datenzugriff schnell.

Greift ein Gerät außerhalb der Schule über die Nextcloud auf Daten auf dem Schulserver zu, müssen die Daten vom Dockerhost über das Internet zum Gerät. Hier hängt die Geschwindigkeit von der Internetanbindung der Schule ab.
   
.. image:: media/index-02.png
   :align: center

In der Grafik ist ein, beispielsweise gemieteter Nextcloud-Service außerhalb der Schule.

Greift ein Gerät in der Schule über die Nextcloud auf Daten auf dem Schulserver zu, müssen die Daten vom Schulserver über das Internet zum Nextcloud-Service und wieder zurück zum Schulserver. Hier ist der Datenzugriff erheblich langsamer als oben.

Greift ein Gerät außerhalb der Schule über die Nextcloud auf Daten auf dem Schulserver zu, müssen die Daten vom Schulserver über das Internet zum Nextcloud-Service und dann zum Gerät. Der Datenzugriff ist hier nicht schneller als oben.

Je nach Schulserver ist die externe Nextcloud, was die Rechenleistung angeht, performanter als die Lösung die hier vorgestellt wird. Allerdings glaube ich, dass der Flaschenhals die Internetanbindung der Schule ist.

Falls du bereits einen Nextcloud-Service hast, kannst du das erste Kapitel überspringen.


Inhalt:

.. toctree::
   :maxdepth: 2

   install-nextcloud
   authentication
   smb-shares
   collabora

