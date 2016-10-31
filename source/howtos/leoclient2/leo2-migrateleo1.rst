Umzug von Leoclient1 nach Leoclient2
------------------------------------

Für den Umzug benötigen Sie die alte virtuelle Festplatte ``old.vdi``
und den alten Standard-Snapshot ``old-snapshot.vdi`` der
leoclient1-VM.


- Ermitteln Sie die Größe und UUID der alten Festplatte

  .. code-block:: console

     # vboxmanage showmediuminfo /media/old/old.vdi | grep -E 'UUID|MBytes'
     UUID:           22df228d-ecb2-44ba-a281-7c73a02d26bc
     Parent UUID:    base
     Capacity:       16384 MBytes
     Size on disk:   1921 MBytes
  
- Erzeugen Sie eine neue virtuelle Maschine nach :ref:`Anleitung
  <virtuelle-maschine-erzeugen>` (mindestens) mit der ermittelten
  Größe. Im Beispiel wird die neue VM "win-migrate" genannt. Auf die
  Installation des Betriebssystems kann verzichtet werden. Ändern Sie
  Typ und Version des Betriebssystem und schließen Sie VirtualBox.

- Ermitteln Sie die UUID der neuen Festplatte:

  .. code-block:: console

     # VBOX_USER_HOME=/var/virtual/win-migrate vboxmanage showmediuminfo /var/virtual/win-migrate/win-migrate.vdi  | grep ^UUID
     UUID:           1fbc6a0c-d9c9-48bf-ad1c-e94c4d7da406
  
- Kopieren Sie die alte virtuelle Festplatte auf die neue
  Festplatten-Datei 

  .. code-block:: console

     # cp /media/old/old.vdi /var/virtual/win-migrate/win-migrate.vdi

- Korrigieren Sie die UUID an den entsprechenden Stellen mit dem
  Schema ``sed -i "s@neue UUID@alte UUID@" Datei``

  .. code-block:: console

     # sed -i "s@1fbc6a0c-d9c9-48bf-ad1c-e94c4d7da406@22df228d-ecb2-44ba-a281-7c73a02d26bc@" /var/virtual/win-migrate/win-migrate.vbox
     # sed -i "s@1fbc6a0c-d9c9-48bf-ad1c-e94c4d7da406@22df228d-ecb2-44ba-a281-7c73a02d26bc@" /var/virtual/win-migrate/defaults/win-migrate.vbox

- Kopieren Sie den alten Standard-Snapshot in das Unterverzeichnis
  ``Snapshots`` unter Verwendung des bestehenden Dateinamens der
  Snapshot-Datei der neuen virtuellen Maschine (bestehende Datei
  ersetzen).

  .. code-block:: console

     # cp /media/old/old-snapshot.vdi /var/virtual/win-migrate/Snapshots/\{08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7\}.vdi

- Aus folgender Fehlermeldung kann man die UUIDs des alten
  (``ef8629ce-c7c1-424b-8089-0e1d526b0c2c``) und des neuen
  (``08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7``) Snapshots herauslesen

  .. code-block:: console

     # VBOX_USER_HOME=/var/virtual/win-migrate vboxmanage showmediuminfo /var/virtual/win-migrate/Snapshots/*.vdi | grep Error

     Access Error: UUID {ef8629ce-c7c1-424b-8089-0e1d526b0c2c} of the
     medium
     '/var/virtual/win-migrate/Snapshots/{08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7}.vdi'
     does not match the value {08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7}
     stored in the media registry
     ('/var/virtual/win-migrate/VirtualBox.xml')
		  
- Korrigieren Sie die UUID des Snapshots in den folgenden Dateien
  wiederum mit dem Schema ``sed -i "s@neue UUID@alte UUID@" Datei``

  .. code-block:: console

     # sed -i "s@08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7@ef8629ce-c7c1-424b-8089-0e1d526b0c2c@" /var/virtual/win-migrate/win-migrate.vbox
     # sed -i "s@08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7@ef8629ce-c7c1-424b-8089-0e1d526b0c2c@" /var/virtual/win-migrate/defaults/win-migrate.vbox

- Setzen Sie den Standard-Snapshot neu (Skript siehe :ref:`leoclient2-snapshot-neu`)

  .. code-block:: console

     # leoclient2-snapshot-create -m win-migrate
     adding: {08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7}.vdi (deflated 57%)
     OK: Snapshot {08b01eb0-2f5b-4091-acf7-cd5f8cbfcef7}.vdi wurde als standard gesetzt.
     
- Starten Sie ``leovirtstarter2`` mit normalen Benutzerrechten über
  die Konsole, eventuelle Fehlermeldungen können so gesehen werden.


Alte Dateien von leoclient1 entfernen
`````````````````````````````````````  

Die Pakete des alten Leoclient müssen von Hand entfernt werden:

.. code-block:: console

   # apt-get purge leoclient-leovirtstarter-client leoclient-leovirtstarter-common
   # apt-get purge leoclient-leovirtstarter-server leoclient-tools leoclient-virtualbox leoclient-vm-printer

Evtl. alte Daten von leoclient (Version 1) entfernen:

.. code-block:: console

   # rm -rf /etc/leoclient
