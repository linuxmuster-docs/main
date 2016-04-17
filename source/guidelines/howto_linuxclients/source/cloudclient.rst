.. _download-default-cloop:

Herunterladen des Standard-Linuxclients
=======================================

Installieren Sie auf dem Server das Paket ``linuxmuster-client-servertools``.

::

   15:51/0 server ~ # apt-get install linuxmuster-client-servertools
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

Anpassung
---------

In der Datei ``/etc/linuxmuster/client-servertools.conf`` muss das gewünschte Passwort für den späteren administrativen Benutzer des Clients `linuxadmin` angepasst werden.

::

   # Konfiguration für die Serverseitigen Skripte zur automatischen 
   # Einbindung eines Community gepflegten cloops
   
   # linuxadmin password
   CONF_LINUXADMIN_PW="geheim1415"
   
   # linbo-Hostgroup als Patchklasse verwenden?
   # default off -> 0
   CONF_HOSTGROUP_AS_PATCHCLASS=0
   # Default cloop Name 
   CONF_DEFAULT_CLOOP_NAME="trusty714.cloop"

Rufen Sie die Liste aller verfügbaren Clientabbilder auf:
::

   19:04/0 server ~ # linuxmuster-client -a list-available
   Hole Liste der verfügbaren cloops...OK
   
   Imagename                 Info
   -----------------------------------------------
   trusty714                 Ubuntu 14.04 LTS 64Bit
   ubuntu1204-hes-32         Ubuntu 12.04.5 LTS 32Bit mit HWE. (TESTEINTRAG, kein Image)
   -----------------------------------------------
   19:04/0 server ~ # 

Herunterladen
-------------

Das Abbild lädt man nun herunter mit ``linuxmuster-client -a get-cloop -c <Imagename>``. Im Beispiel lautet das aktuellste Abbild `trusty714`.
::

   16:47/1 server ~ # linuxmuster-client -a get-cloop -c trusty714

Wenn keine weiteren Optionen angegeben werden, wird dabei die Rechnergruppe `ubuntuclient` angelegt und die Dateien nach dem Schema 
::

   /var/linbo/start.conf.ubuntuclient
   /var/linbo/ubuntuclient.cloop
   /var/linbo/ubuntuclient.cloop.postsync
   [...]

erzeugt.

.. note::
   Es werden keine Dateien überschrieben. Wenn eine Datei bereits existiert bricht das Programm mit einer entsprechenden Meldung ab, das Problem muss dann zunächst händisch gelöst werden.

   .. todo::
      Entwicklerdokumentation zu linuxmuster-client


Abbild zur Synchronisation einrichten
-------------------------------------

Der folgende Befehl erzeugt alle nötigen Konfigurationen, so dass das Abbild `ubuntuclient` im lokalen Netz einsatzfähig wird:

::

   16:41/0 server ~ # linuxmuster-client -a configure -h ubuntuclient -p ubuntu1404 -c ubuntuclient.cloop


Nun kann man Clientrechner in die Rechnergruppe `ubuntuclient` aufnehmen.

