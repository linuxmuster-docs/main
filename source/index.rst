
============
 Einführung
============

Herzlich Willkommen zur Dokumentation von linuxmuster.net v7! 

Diese beschreibt alle wichtigen Schritte ...

  | ... von der Installation.
  | ... der Einrichtung von Windows- und Linux-Rechnern als Clients.
  | ... der Systemadministration mit.
  | ... der Verwaltung von Nutzern.
  | ... bis hin zu individuellen Anpassungen.

Wie es bei einem Projekt ist, dessen Entwicklungsgeschichte mittlerweile auf das Jahr 1999 zurückblickt, ist dein Einstieg in die Beschreibung unseres Systems sicherlich verschieden gelagert.

Kennst du linuxmuster.net noch nicht, dann empfehlen wir dir das Kapitel

  "Was ist linuxmuster.net?".

Hattest du schon Kontakt mit einer Installation von

  | "Linux-Muster für Schulnetze",
  | openML ( bzw. paedML-Linux) oder
  | linuxmuster.net Version 6?

Dann ist das Kapitel "Was ist neu in 7.0?" für dich von Interesse.

Wobei wir aber sagen müssen, dass mit der Version 7 sich vieles grundlegend geändert hat. Das zuvor genannte Kapitel "Was ist linuxmuster.net?" geht auf diese Neuerungen detailliert ein. Ein Blick lohnt auf alle Fälle.

Neben dieser Dokumentation steht dir unsere Community in unserem Hilfeforum und unser kostenfreier Telefon-Support helfend zur Seite.

    Das Forum findest du unter `<https://ask.linuxmuster.net>`_.
    
    Informationen zum Telefon-Support gibt es auf unser Projektseite `<https://www.linuxmuster.net/de/support-de/>`_.


.. hint::

   Suchst du die Dokumentation zur Version linuxmuster.net 6.2 oder die Möglichkeit unsere Dokumentation herunterzuladen?

Dann schaue an das untere Ende der Menuleiste.

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

.. toctree::
  :maxdepth: 2
  :caption: Installation
  :hidden:

  getting-started/overview
  getting-started/prerequisites
  getting-started/setup
  getting-started/add-user-accounts
  getting-started/add-computer
  getting-started/linuxclient

.. toctree::
  :maxdepth: 2
  :caption: Installationsoptionen
  :hidden:

  getting-started/installoptions/install-on-proxmox/index
  getting-started/installoptions/install-on-kvm/index
  getting-started/installoptions/install-on-xcp-ng/index
  getting-started/installoptions/install-from-scratch/index

.. toctree::
  :maxdepth: 2
  :caption: Systemadministration
  :hidden:

  systemadministration/maintenance/migration
  systemadministration/network/preliminarysettings/index
  systemadministration/network/networksegmentation/index
  systemadministration/maintenance/keep-lmn-uptodate
  systemadministration/maintenance/bugfixes-and-workarounds.rst
  systemadministration/network/default-access-rules
  systemadministration/network/radius/index
  systemadministration/printer/index
  systemadministration/schoolconsole/index

.. toctree::
  :maxdepth: 2
  :caption: Clientverwaltung
  :hidden:

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
  :caption: Externe Dienste
  :hidden:

  external-services/moodle/index

.. toctree::
  :maxdepth: 1
  :caption: Linuxmuster.net helfen
  :hidden:
  
  appendix/contribute/index
