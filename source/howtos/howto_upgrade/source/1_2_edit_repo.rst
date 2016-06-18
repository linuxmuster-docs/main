Paketquellen anpassen
=====================

Zum Upgrade auf linuxmuster.net 6.1 (Codename Babo) muss das entsprechende Repositorium eingebunden werden. 

Dies sollte in einer Datei erfolgen:

.. code:: bash

    /etc/apt/sources.list.d/linuxmuster.net.list

In dieser Datei sind folgende Paketquellen anzugeben:

.. code:: bash

    deb http://pkg.linuxmuster.net/ babo/
    deb-src http://pkg.linuxmuster.net/ babo/

Bestehende Zeilen, die auf das precise-Repositorium verweisen, ebenso alte Quellendateien, die auf precise-Repositorien verweisen, sollten auskommentiert oder gelöscht bzw. verschoben werden.

.. code:: bash

    # deb http://pkg.linuxmuster.net/ precise/
    # deb-src http://pkg.linuxmuster.net/ precise/ 


