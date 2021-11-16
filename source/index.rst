Einführung
==========

Herzlich Willkommen zur Dokumentation von linuxmuster.net v7! 

Diese beschreibt alle wichtigen Schritte ...

  | ... von der Installation,
  | ... der Einrichtung von Windows- und Linux-Rechnern als Clients,
  | ... der Systemadministration,
  | ... der Verwaltung von Nutzern,
  | ... bis hin zu individuellen Anpassungen.

Wie es bei einem Projekt ist, dessen Entwicklungsgeschichte mittlerweile auf das Jahr 1999 zurückblickt, ist dein Einstieg in die Beschreibung unseres Systems sicherlich verschieden gelagert.

Kennst du linuxmuster.net noch nicht,
-------------------------------------

dann empfehlen wir dir das Kapitel

  :ref:`what-is-linuxmuster.net-label`

Hattest du schon Kontakt mit einer Installation von
---------------------------------------------------

  | "Linux-Muster für Schulnetze",
  | openML ( bzw. paedML-Linux) oder
  | linuxmuster.net Version 6?

Dann ist das Kapitel :ref:`what-is-new-label` für dich von Interesse.

Mit der Version 7 sich vieles grundlegend geändert. Das zuvor genannte Kapitel :ref:`what-is-linuxmuster.net-label` geht auf diese Neuerungen detailliert ein. Ein Blick lohnt sich daher auf alle Fälle.

Du hast schon eine Installation der Version 7 durchgeführt.
-----------------------------------------------------------

Du weißt, was du machen musst und benötigst nur die aktuellen Virtuellen Maschinen für weitere Installation!
Hier kannst du sie direkt herunterladen:

  | OVAs: `<https://download.linuxmuster.net/ova/v7/latest/>`_
  | 
  | XVAs: `<https://download.linuxmuster.net/xcp-ng/v7/latest/>`_

Weitere Hilfe
-------------

Neben dieser Dokumentation steht dir unsere Community in unserem Hilfeforum und unser kostenfreier Telefon-Support helfend zur Seite.

    Das Forum findest du unter `<https://ask.linuxmuster.net>`_.
    
    Informationen zum Telefon-Support gibt es auf unser Projektseite `<https://www.linuxmuster.net/de/support-de/>`_.


.. hint::

   Suchst du die Dokumentation zur Version linuxmuster.net 6.2 oder die Möglichkeit unsere Dokumentation herunterzuladen?

Dann schaue an das untere Ende der Menüleiste.

.. figure:: media/01_intro_read-the-docs-closed.png
   :align: center
   :alt: Read The Docs Menu - closed

Nach einem Klick eröffnen sich dir dort noch weitere Möglichkeiten:

.. figure:: media/02_intro_read-the-docs-opened.png
   :align: center
   :alt: Read The Docs Menu - opened



.. toctree::
  :maxdepth: 2
  :caption: Über
  :hidden:

  about/about
  about/what-is-new-in-7-0
  about/release-info-and-bugfixes

.. toctree::
  :maxdepth: 2
  :caption: Installation
  :hidden:

  getting-started/overview
  getting-started/prerequisites
  getting-started/installoptions/index
  getting-started/harddisk/index
  getting-started/network/preliminarysettings/index
  getting-started/network/networksegmentation/index   
  getting-started/migration/index
  getting-started/setup
  getting-started/add-user-accounts
  getting-started/devices/index
  
.. toctree::
  :maxdepth: 2
  :caption: Clientverwaltung
  :hidden:

  clients/add-computer
  clients/linux-clients/index
  clients/windows10clients/index
  clients/leoclient2/index
  clients/linbo/index
  clients/postsync/index

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
  systemadministration/network/radius/index
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
