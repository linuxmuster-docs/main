Paketquellen anpassen
=====================

Zum Upgrade auf linuxmuster.net 6.2 (Codename Babo62) muss das entsprechende neue **babo62-repository** eingebunden werden. 

In der nachstehendeb Datei sollten die Eintragungen ergänzt werden:

.. code:: bash

    /etc/apt/sources.list.d/linuxmusternet.list

In dieser Datei sind folgende Paketquellen anzugeben:

.. code:: bash

    deb http://pkg.linuxmuster.net/ babo/
    deb-src http://pkg.linuxmuster.net/ babo/
    deb http://pkg.linuxmuster.net/ babo62/
    deb-src http://pkg.linuxmuster.net/ babo62/


