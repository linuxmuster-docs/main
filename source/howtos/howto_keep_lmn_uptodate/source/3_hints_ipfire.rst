Hinweise
========
   
Konfiguration vom Server aus neu setzen
---------------------------------------

Mit folgendem Befehl am Server konfiguriert man den IPFire neu. Es sollte zuvor aber ein Backup der IPFire-Einstellungen durchgeführt werden:

.. code-block:: console

   # linuxmuster-ipfire --backup
   # dpkg-reconfigure linuxmuster-ipfire

.. attention::

    Nur im Ausnahmefall anwenden. Es gehen alle eigenen Konfigurationseinstellungen des IPFire verloren.

Aktualisierung des IPFire via Konsole
-------------------------------------

Haben Sie eine SSH-Verbindung zum IPFire aufgebaut, können die diesen auch auf der Konsole des IPFire mithilfe der Paketverwaltung ``Pakfire`` des Ipfire durchführen.

Hierzu geben Sie nachstehende Konsolenbefehle an:

.. code-block:: console

   # pakfire update
   # pakfire upgrade

Danach ist der IPFire neu zu starten.
