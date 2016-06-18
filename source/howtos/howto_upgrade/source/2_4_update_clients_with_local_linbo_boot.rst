Clients mit lokalem Linbo-Boot aktualisieren
============================================

Sollten sich in Ihrem Netzwerk neben den Clients, die via PXE-Netwerk-Boot starten, auch solche befinden, die Linbo nur lokal starten, müssen Sie nachstehende Schritte ausführen, um für diese Clients das lokale Linbo zu aktualisieren.

1. Schalten Sie die betreffenden Rechner ein und lassen Sie diese mit LAN-Verbindung in die Linbo-
   Oberfläche booten.

2. Setzen Sie dann auf der Serverkonsole den linbo-remote-Befehl zur Cache-Initialisierung ab:

.. code:: bash

   # linbo-remote -p initcache,reboot [-i <hostname>|-g <group>|-r <room>]

   Der Befehlt wird nach dem nächsten Einschalten der Clients ausgeführt.

3. **Alternativ: Wake-on-Lan**: Sind die Client für Wake-on-Lan konfiguriert, so kann der gesamte 
   Vorgang mit nur einem Befehl umgesetzt werden:

.. code:: bash

   # linbo-remote -w0 -p initcache,reboot [-i <hostname>|-g <group>|-r <room>]

4. Nach dem Neustart steht das nun aktualisierte Linbo lokal auf den Clients zur Verfügung.
