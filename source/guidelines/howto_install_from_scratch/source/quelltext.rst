Quelltext
=========

Beispiel
--------

Nach der Synchronisation mit einem bestimmten Image ein zweites System sychronisieren.

.. code:: bash

    echo "##### POSTSYNC BEGIN #####"
     
    # Name des Basisimages das zusaetzlich synchronisert werden soll (muss angepasst werden)
    mybaseimage=maverick.cloop
     
    # Name des Rsyncimages, ggf. eintragen
    myrsyncimage=""
     
    # Zielpartition auf die gesynct werden werden soll, muss angepasst werden
    myrootpartition=/dev/sda2
     
    # Ab hier muss nichts mehr veraendert werden.
     
    # IP des LINBO-Servers, wird automatisch aus dhcp.log ermittelt
    myserverip="$(grep ^linbo_server /tmp/dhcp.log | tail -1 | awk -F\' '{ print $2 }')"
     
    # Ausgabe der Parameter auf der LINBO-Konsole
    echo "cachepartition:  $1"
    echo "myserverip:      $myserverip"
    echo "mybaseimage:     $mybaseimage"
    echo "myrsyncimage:    $myrsyncimage"
    echo "myrootpartition: $myrootpartition"
     
    # Befehl zur Synchronisation der zweiten Partition
    /usr/bin/linbo_cmd synconly "$myserverip" "$1" "$mybaseimage" "$myrsyncimage" "" "$myrootpartition"
     
    # Syntax fuer linbo_cmd synconly:
    # /usr/bin/linbo_cmd synconly "<LINBO-Server-IP>" "<Cachepartition>" "<Basisimage>" "<Rsyncimage>"
    #  "<Bootpartition>" "<Rootpartition>"
    # Cachepartition steht in der Variablen $1 zur Verfuegung.
    # Bootpartition ist optional, falls leer muessen Anfuehrungszeichen gesetzt werden.
     
    echo "##### POSTSYNC END #####"

Das wars!
