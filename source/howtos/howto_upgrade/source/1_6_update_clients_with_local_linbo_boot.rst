Clients mit lokalem Linbo-Boot aktualisieren
============================================

Sollten sich in Ihrem Netzwerk neben den Clients, die via PXE-Netwerk-Boot starten, auch solche befinden, die Linbo nur lokal starten, müssen Sie nachstehende Schritte ausführen, um für diese Clients das lokale Linbo zu aktualisieren.

1. Schalten Sie die betreffenden Rechner ein und lassen Sie sie mit LAN-Verbindung in die Linbo-
   Oberfläche booten.

2. Schicken Sie dann auf der Serverkonsole den linbo-remote-Befehl zur Cache-Initialisierung ab:

.. code:: bash

    # linbo-remote -c initcache,reboot -g <rechnergruppe>

3. Nach dem Neustart steht das nun aktualisierte Linbo lokal auf den Clients zur Verfügung.
