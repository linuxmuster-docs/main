Externe Firewall umstellen
==========================

Im Zuge der Aktualisierung wird die interne und externe Firewall auf IP-basierte Regeln umgestellt. Damit dies sicher und erfolgreich abgeschlossen werden kann, ist hier nochmal ein weiterer Eingriff nötig. Nachdem das Distributions-Upgrade durchgelaufen ist, setzen Sie die externe Firewall mit dem Befehl 

.. code:: bash

    # linuxmuster-ipfire --setup

einmal in den `Auslieferungszustand`_ zurück.

.. _Auslieferungszustand: 1_1_docu_fw_rules.html 

Starten Sie die Firewall neu und warten Sie, bis diese vollständig neu gestartet ist.

Beachten Sie, dass Sie eigene Regeln und Portweiterleitungen danach wieder einpflegen und aktivieren müssen.
