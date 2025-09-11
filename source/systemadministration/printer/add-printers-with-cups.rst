Drucker auf dem Server hinzufügen
=================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

Um die als Geräte bereits importieren Netzwerkdrucker einzurichten, sind diese auf dem linuxmuster.net Server mithilfe von CUPS einzurichten und bereitzustellen. Die gesamte Druckersteuerung erfolgt via Active Directory für alle Betriebssysteme, so dass diese zunächst auf dem Server bereitgestellt, den AD-Gruppen zugewiesen und ggf. Anpassungen pro Client Betriebssystem vorgenommen werden müssen.

Für die Nutzung von HP-Druckern ist es hilfreich, auf dem Server die Bibliothek ``HPLIP`` zu installieren und dann die Drucker einzurichten.

Zur Installation der HPLIP Bibliothek rufst Du unter Ubuntu 22.04 LTS Server folgenden Befehl auf dem Server auf:

.. code::

  sudo apt install hplip hplip-data hplip-gui hplip-doc

Starte auf einem Rechner einen Browser, um das sog. CUPS-Webinterface des Servers zur weiteren Einrichtung der Drucker aufzurufen. Hierzu füge nachstehende URL in der Adresszeile Deines Browsers ein:

.. code::

   https://10.0.0.1:631

Da meist nur ein selbst-signiertes Zertifikat auf dem Server installiert ist, ist es i.d.R. erforderlich, dem benutzten Browser die sichere Kommunikation ausnahmsweise zu erlauben (SSL-Zertifikat akzeptieren).

.. image:: media/add-printers-with-cups_01_cups-startseite.png
   :alt: Access CUPS
   :align: center


Drucker hinzufügen
------------------

Nach der Anmeldung an CUPS wähle den Menüpunkt ``Verwaltung`` aus.

Es erscheint die Login-Aufforderung von CUPS auf dem Server:

.. image:: media/add-printers-with-cups_02_cups-login.png
   :alt: CUPS: Login
   :align: center

Melde Dich als ``root`` dort an. Nach erfolgreicher Anmeldung siehst Du folgende Einträge:

.. image:: media/add-printers-with-cups_03_add-printer.png
   :alt: CUPS: add printer
   :align: center

Rufe den Untermenüpunkt ``Drucker hinzufügen`` aus. Es erscheint nachstehende Maske. Wähle als Netzwerkdrucker i.d.R. LPD/LPR-Host aus und klicke auf ``weiter``.

.. image:: media/add-printers-with-cups_04_add-printer.png
   :alt: add printer 1/5
   :align: center

Gib als Verbindung die IP-Adresse und den Port des LPD-Druckers wie in der Abb. an:

.. image:: media/add-printers-with-cups_05_add-printer.png
   :alt: add printer 2/5
   :align: center

Klicke auf ``weiter``. Wähle nun den geeigneten Druckertreiber für Deinen Drucker aus:

.. image:: media/add-printers-with-cups_06_add-printer.png
   :alt: add printer 3/5
   :align: center

.. attention:

   Der einzutragende Name des Druckers muss hier in CUPS in identischer Schreibweise eingetragen werden, wie zuvor in Schulkonsole bzw. in der Datei devices.csv.

Wähle den Hersteller aus, dann erscheint eine Liste mit den verfügbaren Druckertreibern. Wähle in der Liste den korrekten Drucker aus. Sollte dieser in der Liste nicht enthalten sein, so klicke auf ``PPD-Datei bereitstellen -> Durchsuchen``. Wähle nun die PPD-Datei mit dem korrekten Druckertreiber aus, den Du zuvor von der Website des Herstellers heruntergeladen hast.

.. image:: media/add-printers-with-cups_07_add-printer.png
   :alt: add printer 4/5
   :align: center

Drucker konfigurieren
---------------------

Danach erscheinen die Standardeinstellungen für den hinzugefügten Drucker. Wähle hier die gewünschten Einstellungen aus und speichere diese als ``Standardeinstellungen festlegen``. Gib unter  ``Fehlerbehandlung``  **abort-job** an, um sicherzustellen, dass CUPS im Fehlerfall den Druckjob löscht.

.. image:: media/add-printers-with-cups_08_define-standard-printing-options.png
   :alt: add printer 5/5
   :align: center

Damit der Drucker nur von berechtigten Nutzern verwendet werden kann, muss noch der Kreis der erlaubten Benutzer festgelegt werden: Gib unter ``Erlaubte Benutzer festlegen`` die Gruppe ``@printing`` an. Lehrer sind standardmäßig in der Gruppe. Bei Schülern wird die Zugehörigkeit über die Spalte **Drucken** in der Schulkonsole gesteuert.

.. image:: media/add-printers-with-cups_09_define-allowed-users.png
   :alt: printer: allowed user
   :align: center

Danach findet sich der neue Drucker in der Druckerliste in CUPS.

.. image:: media/add-printers-with-cups_10_added-printers-list.png
   :alt: printer added
   :align: center

Nun wird Dein Netzwerkdrucker vom Server den Clients bereitgestellt.

Angesprochen wird obiger Drucker über folgende URL:


.. code::

   http://10.0.0.1:631/printers/r200-HP-LJ-P2055DN



