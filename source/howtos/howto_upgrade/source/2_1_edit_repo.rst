Paketquellen anpassen
=====================

Zum Upgrade auf linuxmuster.net 6.2 (Codename Babo62) muss das entsprechende neue **babo62**-Repositorium eingebunden werden. 

In der Datei ``/etc/apt/sources.list.d/linuxmuster-net.list`` sind folgende Paketquellen anzugeben:

.. code:: bash
   
   deb http://pkg.linuxmuster.net/ babo/
   deb-src http://pkg.linuxmuster.net/ babo/
   deb http://pkg.linuxmuster.net/ babo62/
   deb-src http://pkg.linuxmuster.net/ babo62/

.. attention:: Paketquellen überprüfen

   Stellen Sie sicher, dass keine weitere Datei im Verzeichnis ``/etc/apt/sources.list.d/`` oder die Datei ``/etc/apt/sources.list`` Repositorien von ``pkg.linuxmuster.net`` enthält.

