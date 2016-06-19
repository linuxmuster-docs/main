Import der Workstations durchführen
===================================

Beim durchgeführten Upgrade wurde auch eine neue Version des Pakets linuxmuster-linbo eingespielt. Diese neue Version von Linbo erfordert es, dass zur Aktivierung zu Beginn ein einmaliger Import der Workstations ausgeführt wird. Auf diese Weise werden die notwendigen Konfigurationsdateien erstellt.

Führen Sie hierzu folgenden Befehl aus:

.. code:: bash

   import_workstations

Das Skript prüft die angegebenen Eintragungen in der Datei ``/etc/linuxmuster/workstations``. Sind diese korrekt wird der Import ausgeführt. Wurde das Skript erfolgreich abgearbeitet, wird dies mit einem entsprechenden Hinweis quittiert.
