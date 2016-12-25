.. _download-default-cloop:

Herunterladen des Standard-Linuxclients
=======================================

Installieren Sie auf dem Server das Paket ``linuxmuster-client-servertools``.

.. code-block:: console

   server ~ # apt-get install linuxmuster-client-servertools
   Reading package lists... Done
   Building dependency tree       
   Reading state information... Done
   The following extra packages will be installed:
     libcrypt-openssl-random-perl makepasswd
   The following NEW packages will be installed:
     libcrypt-openssl-random-perl linuxmuster-client-servertools makepasswd
   0 upgraded, 3 newly installed, 0 to remove and 4 not upgraded.
   Need to get 31.8 kB of archives.
   After this operation, 239 kB of additional disk space will be used.
   Do you want to continue [Y/n]? Y

Rufen Sie die Liste aller verfügbaren Clientabbilder auf:

.. code-block:: console
   
   server ~ # linuxmuster-client -a list-available
   Hole Liste der verfügbaren cloops...OK
   
   Imagename                 Info
   -----------------------------------------------
   trusty714                          Ubuntu 14.04 LTS 64Bit
   xenial916                          Ubuntu 16.04 LTS 64Bit
   -----------------------------------------------

Laden Sie das Abbild Ihrer Wahl (hier: `xenial916`) herunter mit

.. code-block:: console

   server ~ # linuxmuster-client -a auto -c xenial916 -H xenial

Es wird die Rechnergruppe `xenial` angelegt und mehrere Dateien werden erzeugt. Die wichtigsten sind

.. code-block:: bash

   /var/linbo/start.conf.xenial
   /var/linbo/xenial.cloop
   /var/linbo/xenial.cloop.postsync


Nun kann man Clientrechner in die Rechnergruppe `xenial` aufnehmen. 

.. note::

   Es werden keine Dateien überschrieben. Wenn eine Datei bereits
   existiert bricht das Programm mit einer entsprechenden Meldung ab,
   das Problem muss dann zunächst händisch gelöst werden.


.. 
  Abbild zur Synchronisation einrichten
  -------------------------------------
  
  Der folgende Befehl erzeugt alle nötigen Konfigurationen, so dass das Abbild `xenial` im lokalen Netz einsatzfähig wird:
  
  .. code-block:: console
  
     server ~ # linuxmuster-client -a configure -h ubuntuclient -p ubuntu1404 -c ubuntuclient.cloop
  
  
  Nun kann man Clientrechner in die Rechnergruppe `ubuntuclient` aufnehmen.

