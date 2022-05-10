Einführung
==========

.. hint:: **Diese Dokumentation befindet sich momentan noch im Aufbau!**
  
  Bitte beachte: Sie stellt nicht den aktuellen Entwicklungsstatus der neuen linuxmuster.net Version 7.1 dar. Basierend auf der Doku der vorhergehenden Version, die als Vorlage dient, sind noch nicht alle Bestandteile aktualisiert. Dies gilt für Teile die Benutzerverwaltung, die pädagogischen Funktionen sowie die Systemadministration. Alle anderen Kapitel wurden bereits überarbeitet. Bei Unterkapiteln finden sich ggf. Hinweise, falls diese noch anzupassen sind.

Herzlich Willkommen zur Dokumentation von linuxmuster.net v7.1!

Diese beschreibt alle wichtigen Schritte ...

  | ... von der Installation,
  | ... der Einrichtung von Windows- und Linux-Rechnern als Clients,
  | ... der Systemadministration,
  | ... der Verwaltung von Nutzern,
  | ... bis hin zu individuellen Anpassungen.

Wie es bei einem Projekt ist, dessen Entwicklungsgeschichte mittlerweile auf das Jahr 1999 zurückblickt, ist dein Einstieg in die Beschreibung unseres Systems sicherlich verschieden gelagert.

Kennst Du linuxmuster.net noch nicht,
-------------------------------------

dann empfehlen wir dir das Kapitel

  :ref:`what-is-linuxmuster.net-label`

Hattest Du schon Kontakt mit einer Installation von
---------------------------------------------------

  | linuxmuster.net Version 7?

Dann ist das Kapitel :ref:`what-is-new-label` für dich von Interesse.

Mit der Version 7.1 gibt es einige Neuerungen. Das zuvor genannte Kapitel :ref:`what-is-linuxmuster.net-label` geht auf diese Neuerungen detailliert ein. Ein Blick lohnt sich daher auf alle Fälle.

Installation from Scratch
-------------------------

Diese Dokumentation führt dich durch die Vorbereitung der Virtualisierungslösungen Proxmox, um linuxmuster.net 7.1 installieren zu können. Hierzu gehört die spezifische Einrichtung des Netzwerks sowie die Vorbereitung der Virtuellen Maschinen.

.. todo:: Verweis auf die Hypervisoren im Wiki einfügen.

Weitere Hilfe
-------------

Neben dieser Dokumentation steht dir unsere Community in unserem Hilfeforum und unser kostenfreier Telefon-Support helfend zur Seite.

Das Forum findest Du unter `<https://ask.linuxmuster.net>`_.

Informationen zum Telefon-Support gibt es auf unser Projektseite `<https://www.linuxmuster.net/de/support-de/>`_.


.. hint::

   Suchst Du die Dokumentation zur Version linuxmuster.net 6.2 oder die Möglichkeit unsere Dokumentation herunterzuladen?

Dann schaue an das untere Ende der Menüleiste.

.. figure:: media/01_intro_read-the-docs-closed.png
   :align: center
   :alt: Read The Docs Menu - closed

Nach einem Klick eröffnen sich dir dort noch weitere Möglichkeiten:

.. figure:: media/02_intro_read-the-docs-opened.png
   :align: center
   :alt: Read The Docs Menu - opened

.. todo:: Auskommentiere Zeilen im toctree entfernen, wenn defenitiv getestet das überflüssig.

.. toctree::
  :maxdepth: 2
  :caption: Über
  :hidden:

  about/about
  about/what-is-new-in-7-1

.. toctree::
  :maxdepth: 2
  :caption: Installation
  :hidden:

  installation/overview
  installation/prerequisites
  installation/proxmox/index
  installation/install-from-scratch/index
  installation/network/preliminarysettings/index
 
.. toctree::
  :maxdepth: 4
  :caption: Ersteinrichtung
  :hidden:

  setup/setup
  setup/setup-gui
  setup/setup-console
  setup/add-user-accounts
  clients/client_templates/index

..  setup/add-devices

.. toctree::
  :maxdepth: 2
  :caption: Upgrade
  :hidden:

  migration/upgrade
  migration/linbo-migration-to-4

.. toctree::
  :maxdepth: 2
  :caption: Migration
  :hidden:

  migration/index
  migration/linbo-migration-to-4
  migration/linux-client-migration

.. toctree::
  :maxdepth: 4
  :caption: Clientverwaltung
  :hidden:

  clients/index
  clients/client_templates/index
  clients/use_linbo4/index
  clients/postsync/index
  clients/leoclient2/index

..  clients/linbo/index
..  clients/windows10clients/index
..  clients/linux-clients/index

.. toctree::
  :maxdepth: 2
  :caption: Benutzerverwaltung
  :hidden:

  user-management/change-own-password
  user-management/student-management
  user-management/manage-users/index
  user-management/change-teacher-passwords/index
  user-management/manage-quota/index
  user-management/preparation-newterm/index

.. toctree::
  :maxdepth: 2
  :caption: Pädagogische Funktionen
  :hidden:

  classroom/webui-basics/index
  classroom/exam-and-transfer
  classroom/access-control
  classroom/check-own-quota/index

.. toctree::
  :maxdepth: 2
  :caption: Systemadministration
  :hidden:

  systemadministration/maintenance/keep-lmn-uptodate
  systemadministration/network/default-access-rules
  systemadministration/harddisk/index
  systemadministration/network/radius/index
  systemadministration/network/networksegmentation/index
  systemadministration/printer/index
  systemadministration/schoolconsole/index
  systemadministration/gpo/gpo
  systemadministration/sw-remote-gpo/sw-remote-gpo
  systemadministration/openvpn/index

.. toctree::
  :maxdepth: 2
  :caption: Externe Dienste
  :hidden:

  external-services/dockerhost/index
  external-services/moodle/index
  external-services/nextcloud/index
  external-services/rocketchat/index
  external-services/unifiwlan/index

.. toctree::
  :maxdepth: 1
  :caption: linuxmuster.net helfen
  :hidden:
  
  appendix/contribute/index
