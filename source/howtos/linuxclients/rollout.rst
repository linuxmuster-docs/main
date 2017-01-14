Clients synchronisieren
=======================

Um den Client erstmalig zu partitionieren, formatieren,
synchronisieren und zu starten, führen Sie auf dem Server folgenden
Befehl aus

.. code-block:: console

   server ~ # linbo-remote -i r100-pc01 -p partition,format,initcache:torrent,sync:1,start:1

(Re-)booten Sie nun den Client und verfolgen Sie die vollautomatische
Einrichtung oder trinken Sie eine Tasse Ihres Lieblingsgetränks.

Der Ubuntu-Client startet und aufgenommene Benutzer können sich nun am System anmelden.

Weitere Clients können unter Kenntnis der jeweiligen MAC-Adressen mit
derselben Methode direkt in die Datei
``/etc/linuxmuster/workstations`` aufgenommen werden.

Alternativ kann jeder aufzunehmende Rechner in LINBO gestartet werden
und über die grafische Oberfläche von LINBO registriert werden. Dabei
werden die relevanten Werte automatisch inkrementiert. Lesen Sie dazu
:ref:`registration-linbo-label`.


Weiterführende Dokumentation
============================

- Howto: Patchklassen, Rechnergruppe, postsync skript
- Howto: Linbo
- Howto: Standardclient updaten


