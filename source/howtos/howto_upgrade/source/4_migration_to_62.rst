Migration auf linuxmuster.net 6.2 
=================================

Um linuxmuster.net 6.0 (Codename ObenBleiben) auf linuxmuster.net 6.1 (Codename Babo) zu aktualisieren, ist es ebenfalls möglich, anstelle eine schrittweise durchzuführenden Upgrades, eine Migration mithilfe der Migrationsskripte linuxmuster-migration-backup durchzuführen. Hierbei werden alle benötigten Daten/Dateien der aktuell genutzen Version gesichert, ein neues System mit der gewünschten Version installiert und dann die gesicherten Daten zurückgespielt (restore).   

Vorgehen
--------

1. Installation des Pakets linuxmuster-migration

2. Konfiguration des Migrationsskripts

3. Ausführen des Migrationsskripts

4. Neuinstallation linuxmuster.net

5. Wiederherstellung der Daten mit dem Migrationsskript


Schritte auswählen
------------------

.. toctree::
   :maxdepth: 2

   4_1_summary
   4_2_install_paket
   4_3_config_migration_script
   4_4_run_config_script
   4_5_install_new_linuxmuster
   4_6_restore_via_migration_script


