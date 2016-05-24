Kommandozeilenbefehl
==================================

Das Paket installiert den Kommandozeilenbefehl
``linuxmuster-community-feedback``. Der Befehl kennt vier Optionen, die mit
Ausnahme der Hilfe beliebig kombiniert werden können: 

.. code:: bash

    # linuxmuster-community-feedback -h
        Usage: /usr/bin/linuxmuster-community-feedback [-v] [-u] [-s]

        -v : Show stats file
        -u : Upload stats to linuxmuster.net server
        -s : Show cronjob status
        -h : Print this help and exit

Die Option ``-v`` zeigt Informationen über das Statusfile an - sowohl wie dieses
heißt, als auch welchen Inhalt es hat. Das Statusfile ist die Datei, die
letztlich beim übermitteln der Informationen an den Projektserver
übertragen wird.

Die Option ``-u`` stößt eine Übertragung an.

Die Option ``-s`` zeigt Informationen zum Cronjob an, der vom Paket in der
Datei ``/etc/cron.d/linuxmuster-community-feedback`` eingerichtet wird:

.. code:: bash

    # linuxmuster-community-feedback -s      
    Cronjob enabled in file:
      /etc/cron.d/linuxmuster-community-feedback
    --------------------------------
    
    # Diese Datei wird automatisch erstellt.
    # Manuelle Aenderungen werden ueberschrieben!
    58 4 * * 0   root /usr/bin/linuxmuster-community-feedback -u > /dev/null 2>&1
    
    --------------------------------

Hier zeigt die Ausgabe, dass jeden Sonntag um 04:58 Uhr eine aktualisierte
Version der Statistik zum Projektserver übertragen wird.
