Hardwaretest mit mindi
``````````````````````

Mit Hilfe des Tools **mindi** erzeugt **mondoarchive** beim Backup ein bootbares Restore-CD-Image. Um zu testen, ob bei einem späteren Restore die Festplatten und Partitionen richtig erkannt werden, ist es empfehlenswert den Server einmal von einer mit **mindi** erzeugten CD zu booten.

Das mindi-CD-Image erstellen Sie einfach mit dem Befehl

.. code-block:: bash

	mindi

auf der Konsole. In der Folge müssen Sie zwei Fragen beantworten. Die Frage nach dem eigenen Kernel beantworten Sie mit **y**:

.. code-block:: bash

	Mindi Linux mini-distro generator v2.0.4-r2045
	Latest Mindi is available from http://www.mondorescue.org
	BusyBox sources are available from http://www.busybox.net
	------------------------------------------------------------------------------
	Mindi-BusyBox v1.2.1 (2008.10.20-18:41+0000) multi-call binary
	Do you want to use your own kernel to build the boot disk ([y]/n) ?

Danach wird das System analysiert und das ISO-Image erstellt. Die abschließende Frage nach dem bootbaren USB Image beantworten Sie mit **n**.

.. code-block:: console

   Analyzing dependency requirements       Done.         
   Making complete dependency list Done.         
   Analyzing your keyboard's configuration.
   Adding the following keyboard mapping tables:   Done.         
   Assembling dependency files...................................Done.         ..........
   Your mountlist will look like this:
   Analyzing LVM...
   DEVICE          MOUNTPOINT      FORMAT          SIZE (MB)       LABEL/UUID     
   /dev/sda6       lvm             lvm              140003                
   /dev/sda1       /               ext3               9554                
   /dev/mapper/vg_lml-home /home           ext3                lvm                
   /dev/mapper/vg_lml-var /var            ext3                lvm                
   /dev/mapper/vg_lml-var+spool+cups /var/spool/cups ext3                lvm                
   /dev/sda5       swap            swap               3067                
   Tarring and zipping the data content... Done.         
   Making 16384KB boot disk...............udev device manager found
   WARNING: No Hardware support for ST20V10
   You may ask your manufacturer to contribute to the mindi project
   ...11709 blocks
   ............    Done.         
   In the directory '/var/cache/mindi' you will find the images:-
   mindi-bootroot.16384.img  
   Created bootable ISO image at /var/cache/mindi/mindi.iso
   Shall I make a bootable USB image ? (y/[n]) 

Das mindi-CD-Image finden Sie unter ``/var/cache/mindi/mindi.iso``. Brennen Sie nun das ISO-Image auf einen CD-Rohling und booten Sie den Server damit.

Ist der Bootvorgang abgeschlossen, erscheint eine Konsole. Durch Eingabe des Befehls

.. code-block:: bash

	fdisk -l

verschaffen Sie sich einen Überblick über die gefundenen Festplattenpartitionen. Wenn die Partitionen (inkl. Backuppartition) nicht so angezeigt werden, wie auf dem laufenden linuxmuster.net-Server, wurde wahrscheinlich der Festplattenkontroller nicht erkannt. In dem Fall kann man durch Hinzufügen des entsprechenden Treibermoduls in der Konfigurationsdatei ``/etc/mindi/mindi.conf`` unter *SCSI_MODS* oder *IDE_MODS* den Fehler eventuell beheben. Ein Vergleich der Ausgabe von

.. code-block:: bash

	lsmod

des linuxmuster.net-Servers mit derjenigen unter **mindi** hilft gegebenenfalls bei der Suche nach fehlenden Modulen.

.. caution::
	**Wichtiger Hinweis**
	Ein Workaround, der evtl. hilft auf linuxmuster.net/openML-Systemen der Version 4.0.x Hardware-Probleme beim Restore zu vermeiden, besteht darin die Konfigurationsdatei ``/etc/mindi/mindi.conf`` zu entfernen, sodass **mindi** die Hardwarekonfiguration nach Standardeinstellungen ermittelt. Erstellen Sie, wie oben beschrieben, ein Mindi-ISO-Image, verschieben Sie jedoch zuvor die Konfigurationsdatei ``/etc/mindi/mindi.conf`` in ein anderes Verzeichnis, zum Beispiel:
	
	.. code-block:: bash
	
		mv /etc/mindi/mindi.conf /root


.. _Forum: http://forum.linuxmuster.net/forum.php?req=thread&id=307&unb661sess=8rf089df92msfnjl6i0adrp5j6

.. note::
	Im Forum_ findet sich dieser Hinweis auf die Konfiguration der ``/etc/mindi/mindi.conf``.
	
	Falls Mindi Fehler liefert, kann es nach folgender Anpassung funktionieren:
	
	In der Datei ``/etc/mindi/mindi.conf`` die Parameter anpassen:
	
	.. code-block:: bash
		
		#
		# Example of mindi configuration file
		#
		# $Id$
		#
		# FORCE_MODS="crc_ccitt crc_ccitt"
		#
		# EXTRA_SPACE=80152             # increase if you run out of ramdisk space
		# BOOT_SIZE=32768               # size of the boot disk
		# MINDI_ADDITIONAL_BOOT_PARAMS="devfs=nomount noresume selinux=0 barrier=off udevtimeout=10 acpi=off"
		EXTRA_SPACE=120000
		BOOT_SIZE=96000
