Einrichtung des Raspberry Pi
============================

.. attention:: Es ist unbedingt erforderlich, einen **Raspberry Pi 2** oder einen **Raspberry Pi 3** [#f1]_ zu verwenden. Die älteren Raspberry Pi Rechner haben einen anderen Prozessor verbaut und sind zu schwach, um OMD zu betreiben!

.. hint:: Diese Anleitung geht davon aus, dass die folgenden Schritte auf einem Rechner mit Linux als Betriebssystem durchgeführt werden.

Das linuxmuster-monipi-Image herunterladen
-------------------------------------------

Laden Sie das vorbereitete gepackte Raspbian-Image `von dieser Seite <http://www.lehrer.uni-karlsruhe.de/~za3966/lmn/>`_ auf Ihren Rechner herunter. Entpacken Sie die  Datei mit dem Befehl

.. code-block:: console

   $ gunzip monipi_<version>.img.gz

Image auf eine SD-Karte schreiben
---------------------------------

Die verwendete SD-Karte muss mindestens eine Größe von 4GB haben.

- Legen Sie die SD-Karte in ein geeignetes Lesegerät ein.

- Öffnen Sie eine root-Shell.

- Geben Sie den Befehl

  .. code-block:: console

     $ fdisk -l

  ein und entnehmen Sie der Ausgabe des Befehls den Devicenamen der SD-Karte. Im Beispiel unten ist der Device-Name ``/dev/mmcblk0`` die weiteren Zeichen (``p1``,...) stehen für die Partitionen der Karte.

  .. code-block:: console

     Disk /dev/mmcblk0: 32.0 GB, 32010928128 bytes
     4 Köpfe, 16 Sektoren/Spur, 976896 Zylinder, zusammen 62521344 Sektoren
     Einheiten = Sektoren von 1 × 512 = 512 Bytes
     Sector size (logical/physical): 512 bytes / 512 bytes
     I/O size (minimum/optimal): 512 bytes / 512 bytes
     Festplattenidentifikation: 0xb3c5e39a

     Gerät  boot.     Anfang        Ende     Blöcke   Id  System
     /dev/mmcblk0p1            2048    62521343    31259648   83  Linux

- Die Imagedatei enthält bereits die nötigen Partitionen und die Partitionstabelle und muss darum direkt auf die Gerätedatei geschrieben werden und nicht in eine möglichwerweise bereits auf der Karte vorhandene Partition.

  Der folgende Befehl erledigt das, das Device der SD-Karte muss dabei möglicherweise angepasst werden:

  .. code-block:: console

     $ dd bs=4M if=monipi.img of=/dev/mmcblk0

- Legen Sie nach Beendigung des Vorgangs die SD-Karte in den Raspberry Pi ein und starten Sie diesen.

Ersteinrichtung des Raspberry Pi
--------------------------------

.. hint:: Die folgenden Schritte müssen an der Kommandozeile des Raspberry Pi durchgeführt werden.

Standardzugangsdaten: Übersicht
```````````````````````````````
Im Auslieferungszustand hat das MoniPi System die folgenden Zugangsdaten:

+---------------+----------------+-------------------------------------------------------+
| Benutzername  | Passwort       | Bemerkungen                                           |
+===============+================+=======================================================+
| pi            | muster         | Administrativer Benutzer für die Konsole.             |
+               +                +                                                       +
|               |                | Kann sich per ssh anmelden, root-Shell mit ``sudo -i``|
+---------------+----------------+-------------------------------------------------------+
| omdadmin      | omd            | Administrativer Benutzer für das ChecMK Webinterface  |
+               +                +                                                       +
|               |                | Erreichbar unter ``https://<monipi-IP>/default/``     |
+---------------+----------------+-------------------------------------------------------+

Turnkey
```````

Um das Raspbian-Image zu individualisieren, muss als erstes als root der Befehl ``monipi-turnkey`` ausgeführt werden. Dabei werden neue SSH-Host-Keys und ein neues "Snake-Oil" SSL-Zertifikat erzeugt sowie ein neues Passwort für den administrativen Benutzer ``pi`` gesetzt.

- Melden Sie sich am Raspberry an. Benutzername im Auslieferungszustand ist ``pi``, das Passwort ``muster``
- Werden Sie root durch Eingabe des Befehls ``sudo -i``
- Führen Sie den Befehl ``monipi-turnkey`` aus und folgen Sie den Anweisungen. Geben Sie zweimal ein gutes Passwort für den administrativen Benutzer ein, wenn Sie dazu aufgefordert werden.

  .. code-block:: console

     pi@raspberrypi:~ $ sudo -i
     root@raspberrypi:~# monipi-turnkey
     Generiere neue SSH Host-Keys...
     Creating SSH2 RSA key; this may take some time ...
     2048 4d:f7:1c:98:78:9b:05:0c:95:dd:b4:e4:c1:33:4f:62 /etc/ssh/ssh_host_rsa_key.pub (RSA)
     Creating SSH2 DSA key; this may take some time ...
     1024 a6:05:41:0e:02:7d:99:6f:58:0c:0a:ea:ce:54:e7:b9 /etc/ssh/ssh_host_dsa_key.pub (DSA)
     Creating SSH2 ECDSA key; this may take some time ...
     256 55:e6:b6:79:ca:47:59:4a:54:3c:1b:ee:2b:5e:0f:0a /etc/ssh/ssh_host_ecdsa_key.pub (ECDSA)
     Creating SSH2 ED25519 key; this may take some time ...
     256 28:95:7a:3d:81:38:6a:c6:6a:c7:09:58:8c:d8:e5:e6 /etc/ssh/ssh_host_ed25519_key.pub (ED25519)

     Geben Sie ein neues Passwort für den administrativen Benutzer (pi) ein
     Geben Sie ein neues UNIX-Passwort ein:
     Geben Sie das neue UNIX-Passwort erneut ein:
     passwd: Passwort erfolgreich geändert
     root@raspberrypi:~#

Raspi-Config
````````````

Für gewöhnlich sind die heute erhältlichen SD-Karten größer als 4GB, es empfiehlt sich die Systempartition des MoniPi entprechend der verwendeten SD-Karte zu vergrößern.

Starten Sie dazu auf der Kommandozeile als root den Befehl ``raspi-config``. Wählen Sie dann den ersten Eintrag, beenden Sie raspi-config mit "Finish"  und starten Sie den Raspberry Pi neu, wenn dies vorgeschlagen wird.

.. figure:: media/raspiconfig01.png
   :alt: raspi-config Vergrößern der Parrtition.


.. figure:: media/raspiconfig02.png
   :alt: raspi-config Neustart.

Nach dem Neustart sollte die Systempartition die gesamte SD-Kartengröße abzüglich des Platzes für die Boot-Partition umfassen. Im Beispiel unten mit einer 32GB Karte sieht die Ausgabe von ``df -h`` folgendermaßen aus:

.. code-block:: console

   pi@raspberrypi:~ $ df -h
   Dateisystem    Größe Benutzt Verf. Verw% Eingehängt auf
   /dev/root        30G    1,7G   27G    6% /
   devtmpfs        459M       0  459M    0% /dev
   tmpfs           463M       0  463M    0% /dev/shm
   tmpfs           463M    6,3M  457M    2% /run
   tmpfs           5,0M    4,0K  5,0M    1% /run/lock
   tmpfs           463M       0  463M    0% /sys/fs/cgroup
   /dev/mmcblk0p1   60M     20M   41M   34% /boot
   tmpfs           463M     88K  463M    1% /opt/omd/sites/default/tmp


.. rubric:: Fussnoten

.. [#f1] Bei Verwendung eines Raspberry Pi 3 muss darauf geachtet werden, dass man mindestenst die Version 1.1 des MoniPi Images zur Installation verwendet.
