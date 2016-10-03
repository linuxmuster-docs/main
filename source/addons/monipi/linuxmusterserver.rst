Einrichtung auf dem linuxmuster.net Server
==========================================

Auf dem Server muss der check_mk-Client installiert werden, der dem Monitoring-Server auf Nachfrage die Performance-Daten übermittelt.

Melden Sie sich auf der Serverkonsole als administrativer Benutzer an und installieren Sie die Pakete ``check-mk-agent`` und ``xinetd``:

.. code-block:: console

   $ apt-get install check-mk-agent xinetd

Anschließend muss der xinetd konfiguriert werden, so dass eine Abfrage der Monitoring-Daten möglich wird. Editieren Sie dazu die Datei ``/etc/xinetd.d/check_mk`` wie folgt:

.. code-block:: console

    service check_mk
    {
            type           = UNLISTED
            port           = 6556
            socket_type    = stream
            protocol       = tcp
            wait           = no
            user           = root
            server         = /usr/bin/check_mk_agent

            # If you use fully redundant monitoring and poll the client
            # from more then one monitoring servers in parallel you might
            # want to use the agent cache wrapper:
            #server         = /usr/bin/check_mk_caching_agent

            # configure the IP address(es) of your Nagios server here:
            # EDIT: KANN GEAENDERT WERDEN
            # Wenn der MoniPi eine feste IP-Adresse hat, ist es sinnvoll,
            # das Kommentarzeichen an der nächsten Zeile zu entfernen und dort
            # die IP-Adresse des Monitoring Servers einzutragen
            #only_from      = 127.0.0.1 10.17.1.3

            # Don't be too verbose. Don't log every check. This might be
            # commented out for debugging. If this option is commented out
            # the default options will be used for this service.
            log_on_success =

            # EDIT: MUSS GEAENDERT WERDEN von "yes" auf "no"
            disable        = no
    }


Die Beschränkung des Zugriffs auf bestimmte IP-Adressen ist aus Sicherheitsgründen sinnvoll, kann aber erst dann erfolgen, wenn der Monitoring-Server (MoniPi) eine dauerhafte IP-Adresse hat.

Starten Sie den xinetd nach den Anpassungen neu:

.. code-block:: console

   $ service xinetd restart

Um zu überprüfen, ob die Einrichtung erfolgreich war, können Sie den Befehl

.. code-block:: console

   $ telnet localhost 6556

ausführen [#f1]_, dabei sollte eine längere Ausgabe von Performancedaten die Folge sein:

.. figure:: media/linuxmusternetserver01.png
   :alt: Exemplarische Ausgabe des Befehls "telnet localhost 6556"


.. rubric:: Fußnoten

.. [#f1] Möglicherweise muss man den telnet-Befehl ebenfalls noch nachinstallieren: ``apt-get install telnet``




