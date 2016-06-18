Tausch- und Vorlagenordner umstellen
====================================

Die Tausch- und Vorlagenordner der Klassen/Projekte und des aktuellen Raums müssen ab linuxmuster.net 6.1 von den bisherigen sog. bind-mounts auf verlinkte shares umgestellt werden. 

Homeverzeichnisse bereinigen
----------------------------

Dazu ist es zunächst erforderlich die Verzeichnisse 

.. code:: bash

   __tauschen
   __vorlagen 

in jedem Benutzerverzeichnis zu entfernen. 

Dies kann man mit folgenden Befehlen für alle Benutzer oder gezielt für einzelne Benutzer erledigt werden: 

.. code:: bash

   # sophomorix-repair --repairhome
   # sophomorix-repair --repairhome -u user

.. attention:: Achtung

   Es ist notwendig, dass die Benutzer nicht am System angemeldet sind, sonst können die in Benutzung 
   befindlichen Links nicht entfernt werden. 

Bind-mounts abschalten
----------------------

Die Verwendung der bind-mounts auf dem Server sind händisch abzuschalten. Dies wurde so vorgesehen, damit ein Parallelbetrieb als Übergang genutzt werden kann. 

Dazu in den Dateien

.. code:: bash

    /etc/linuxmuster/samba/root-preexec.d/sophomorix-root-preexec
    /etc/linuxmuster/samba/root-postexec.d/sophomorix-root-postexec 

die Einträge **sophomorix-bind** durch voranstellen eines **#** auskommentieren. 

Damit werden die bind-mounts bei der Benutzeran- bzw. abmeldung nicht mehr angelegt bzw. entfernt.

Da es möglich ist, dass zum Umstellungszeitpunkt Bind-mounts gesetzt waren, sollten diese entfernt werde mit:

.. code:: bash

    # sophomorix-bind --cron



