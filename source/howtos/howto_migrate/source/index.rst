Migration von paedML/openML/linuxmuster.net
===========================================

Um von einer älteren installierten paedML, einer openML oder einer linuxmuster.net 6.0 (Codename ObenBleiben) Installation auf das aktuelle linuxmuster.net 6.2 (Codename Babo62) zu migrieren, ist eine Migration mithilfe der Migrationsskripte `linuxmuster-migration` durchzuführen. 

Hierbei werden alle benötigten Daten/Dateien der aktuell genutzen Version gesichert, ein neues System mit der gewünschten Version installiert und dann die gesicherten Daten zurückgespielt (restore). 

Inhalt:

.. toctree::
   :maxdepth: 2

   summary
   install_paket
   config_migration_script
   run_config_script
   install_new_linuxmuster
   restore_via_migration_script
