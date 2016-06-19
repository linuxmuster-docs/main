Clients mit neuem Linbo booten
==============================

Um sicherzustellen, dass das neue LINBO-System auch lokal auf den
Clients installiert wird, erzwingt man eine Aktualisierung des Caches
und einen Reboot.

Setzen Sie auf der Serverkonsole den linbo-remote-Befehl zur Cache-Initialisierung ab:

.. code:: bash

   linbo-remote -p initcache,reboot [-i <hostname>|-g <group>|-r <room>]

Der Befehl wird nach dem nächsten Einschalten der Clients ausgeführt.

..
   2. **Alternativ: Wake-on-Lan**: Sind die Client für Wake-on-Lan konfiguriert, so kann der gesamte 
      Vorgang mit nur einem Befehl umgesetzt werden:

      .. code:: bash

	 linbo-remote -w0 -p initcache,reboot [-i <hostname>|-g <group>|-r <room>]

Sollten sich in Ihrem Netzwerk neben den Clients, die via
PXE-Netwerk-Boot starten, auch solche befinden, die Linbo nur lokal
starten, schalten Sie die betreffenden Rechner ein und lassen Sie
diese mit LAN-Verbindung in die Linbo-Oberfläche booten.

.. note:: Nach dem Upgrade sollten alle Clients wie gewohnt weiter
   funktionieren. Die Bildschirmausgabe beim Bootvorgang ist leicht
   verändert und vor dem Betriebssystemstart aus der Linbo-Oberfläche
   heraus wird nun immer ein Neustart initiiert (Der sogenannte
   *reboot-Workaround* wird nun immer verwendet.)
