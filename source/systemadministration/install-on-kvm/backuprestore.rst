Backup und Restore
==================

Als Erstes kümmern wir uns um ein Notfall-Backup des KVM-Servers selbst. Dieses sollte immer dann erstellt/erneuert werden, wenn es größere Veränderungen am Server gegeben hat. Also genau jetzt! ;-)

In unserem Beispiel ist die Backup-Platte direkt am Server angeschlossen. Für die Praxis ist sicherlich eine externe USB3 HDD zu empfehlen, die direkt an den KVM-Server angeschlossen wird.

.. image:: media/kvmserver/kvmserver-image02.png

Notfallbackup des KVM-Servers
-----------------------------

Das Backup wird mit Hilfe von `CloneZilla <http://clonezilla.org/>`_ erstellt. Hier nutzen wir die Funktionalität, ganze Platten in ein Image zu schreiben. Das ISO-Image wird auf einen USB-Stick geschrieben, der auch als Bootmedium genutzt wird (z.B. mittels :ref:`dd<preface-usb-stick-label>` ). 

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/r3R525eHhV4?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>

..

Im nächsten Schritt bereiten wir die Backup-HDD vor, indem wir diese Partitionieren und Formatieren.

.. hint::
	**ACHTUNG** Dabei gehen alle vorhandenen Daten auf der Platte verloren!

.. code-block:: console

	Partitionieren
	# fdisk /dev/sdX

	Formatieren
	# mkfs.ext4 /dev/sdX1

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/01VfI0YrBkE?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>

..

Alle Vorbeitungen sind getroffen und das Backup kann erstellt werden.

.. hint::
	Der Screencast erstellt das Backup noch ohne die *ipfire* und *server* VM-LVMs. Sind Diese vorhanden, dauert der ganze Vorgang natürlich entsprechend länger.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/nPQSm1O4yd8?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Notfallrestore des KVM-Servers
------------------------------

Im Falle eines Totalverlustes des KVM-Servers kann Dieser einfach neu installiert werden. Schneller geht es aber mit dem gerade erstellten Backup. Dieses wird die komplette HDD inklusive Bootsektor und LVM wiederherstellen.

.. hint::
	**ACHTUNG** Dabei gehen alle vorhandenen Daten auf der Platte verloren!

.. raw:: html
	
	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/JViy8qV14UA?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Backup der VMs ipfire und server
--------------------------------

Die virtuellen Maschinen werden als Ganzes gesichert. Ein Backup besteht dabei aus Kopien der virtuellen Festplatten und der Konfigurationsbeschreibung. Erstellt wird das Backup im laufenden Betrieb mit Hilfe eines LVM-Snapshots. Damit das auch funktioniert, sollten immer noch 10-20 % Platzreserve in der Volumen-Group vorhanden sein.

.. hint::
	Niemals den gesamten Platz virtuellen Festplatten zuweisen.

Das Backup sollte jedes Wochenende ausgeführt werden, da es je nach Größe der virtuellen Festplatten länger dauern kann.

Die Kopien der virtuellen HDDs werden mit der *lzop* Kompression gesichert. Damit sollte eine Platzersparnis von bis zu einem Viertel der Originalgröße zu erreichen sein ohne die Backupzeit zu sehr zu verlängern. 

In unserem Fall wird die Backup-Platte direkt an den Server angeschlossen. Weitere Möglichkeiten sind USB3-Platten oder NFS-Dateifreigaben auf einem NAS. 

Als Backup-Tool verwenden wir `virt-backup <http://gitweb.firewall-services.com/?p=virt-backup;a=summary>`_ .

**Installation der Backupsoftware**

Paketabhängigkeiten:

.. code-block:: console

	# apt-get install libxml-simple-perl libsys-virt-perl lzop


Installation z.B. nach: ``/usr/local``

.. code-block:: console

	Entpacken des Archivs
	# cd /usr/local
	# tar -xzvf virtbackup-xxx.tar.gz
	# ln -s virt-backup virt-backup-xxx
	# cd virt-backup
	# chmod ugo+x virt-backup

	Erstellen eines Aliases
	# cd /usr/local/bin
	# ln -s /usr/local/virt-backup/virt-backup

	Erstellen eines Backup-Ordners
	# mkdir /media/virt-backup

	Mounte Backup-HDD
	# mount /dev/sdx1 /media/virt-backup

	Erstelle Ordner fuer VMs
	# mkdir /media/virt-backup/VMs

	Unmounte Backup-HDD
	# umount /media/virt-backup

.. raw:: html

	<p>
    <iframe width="696" height="392" src="https://www.youtube.com/embed/0FlqgsgKvdI?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..


**Optional: Testen des Backups von Hand**

.. code-block:: console

	Mounte Backup-HDD
	# mount /dev/sdx1 /media/virt-backup

	Test Backup ipfire
	# virt-backup --vm=ipfire --debug --no-offline --compress=lzop --blocksize=4M --backupdir=/media/virt-backup/VMs/

	Test Backup server
	# virt-backup --vm=server --debug --no-offline --compress=lzop --blocksize=4M --backupdir=/media/virt-backup/VMs/
    

	Loesche Backup ipfire
	# virt-backup --vm=ipfire --debug --cleanup --backupdir=/media/virt-backup/VMs/

	Loesche Backup server
	# virt-backup --vm=server --debug --cleanup --backupdir=/media/virt-backup/VMs/

	Unmounte Backup-HDD
	# umount /media/virt-backup

**Erstellen eines Backup-Skriptes**

.. code-block:: console
	
	Erstellen der Datei z.B. mittels vi
	# vi /root/virt-backup.sh

.. code-block:: bash

	#!/bin/bash

	source /root/.profile

	# Mounte Backup-HDD
	mount /dev/sdx1 /media/virt-backup

	# Loesche altes Backup ipfire
	/usr/local/bin/virt-backup --vm=ipfire --debug --cleanup --backupdir=/media/virt-backup/VMs/

	# Backup ipfire
	/usr/local/bin/virt-backup --vm=ipfire --debug --no-offline --compress=lzop --blocksize=4M --backupdir=/media/virt-backup/VMs/

	# Loesche altes Backup server
	/usr/local/bin/virt-backup --vm=server --debug --cleanup --backupdir=/media/virt-backup/VMs/

	# Backup server
	/usr/local/bin/virt-backup --vm=server --debug --no-offline --compress=lzop --blocksize=4M --backupdir=/media/virt-backup/VMs/

	# Unmounte Backup-HDD
	umount /media/virt-backup


.. code-block:: console
	
	Skript ausführbar machen
	# chmod ugo+x /root/virt-backup.sh


**Erstellen eine Crontab-Jobs**

.. code-block:: console

	# crontab -e

	# VM Backup Samstags 20 Uhr
	0 20 * * 6 /root/virt-backup.sh > /root/virt-backup.log 2>&1

.. hint::
	Wichtig ist es, eine Leerzeile nach Definition des Jobs einzufügen. Ansonsten wird der Auftrag nicht ausgeführt.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/RQWsOPxKcr8?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Naürlich muss die Swap-Partition des *servers* nicht gesichert werden. Also einfach im Backup-Skript *ausklammern*! Kleine Hausaufgabe [#f1]_ ... ;-)


Ein Log des Backups ist unter ``/root/virt-backup.log`` zu finden.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/ecepkE_DUJU?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>

..

Restore der VMs ipfire und server
---------------------------------

Jedes Backup ist nur ein Backup, wenn Du sicher sein kannst, dass auch ein Restore funktioniert. Exemplarisch werden wir ein Restore bei der Firewall *ipfire* durchführen, sowohl der gesamten VM als auch einzelner Dateien der virtuellen Festplatte.

.. hint::
	Es ist sinnvoll, dass Zurückspielen der virtuellen HDDs einer VM in einer Screen-Session durchzuführen. Da der Vorgang u.U. sehr lange dauert, kann die Sitzung verlassen werden, ohne das es zum Abbruch des Befehles kommt (Gleiches Prinzip wie bei linbo-remote ...).

Die wichtigsten Dinge dabei sind(KVM-Server):

.. code-block:: console

	Installation notwendiger Pakete
	# apt-get install kpartx pv

	Optional: Anlegen eines Restore-Verzeichnisses 
	# mkdir /media/virt-restore

	Mounten der Backup-HDD
	# mount /dev/sd1X /media/virt-restore

Beim Restore ist es wichtig, dass die betroffene VM heruntergefahren ist. **DES WEITEREN GEHEN ALLE VORHANDENEN DATEN VERLOREN!**

**Restore der virtuellen HDD am Beispiel der Firewall**

.. code-block:: console

	Aufruf Screen
	# screen

	Starten des Restores
	# lzop -dc /media/virt-restore/VMs/ipfire/ipfire_vda.img.lzo |pv -s 50G |dd of=/dev/kvm-vg/ipfire bs=4M

	Allgemein
	# lzop -dc <Quelle> |pv -s <Groesse der HDD> |dd of=<Ziel> bs=4M


Die Screen-Sitzung kann mit *STRG+A+D* beendet werden. Gestartet wird die Sitzung mit:

.. code-block:: console

	Finden der ID
	# screen -ls

	Öffnen der Sitzung
	# screen -r <ID>

.. hint::
	Im Screencast wird die komplette VM gelöscht. Dies ist nicht notwendig! Man kann aber ... ;-)

Nachdem die HDD wiederhergestellt wurde, muss, nur falls nicht mehr vorhanden, die Definition der VM auch wiederherstellt werden.

.. code-block:: console

	Wiederherstellen der VM-Definition
	# virsh define /media/virt-restore/VMs/ipfire/ipfire.xml

	Allgemein
	# virsh define <Name>.xml

.. hint::

	Falls die VM neben einer vorhanden VM wiederhergestellt werden soll, muss in der XML-Datei der *Name* geändert werden, sowie die vorhanden *MAC-Adressen* der Netzwerkkarten und die *UUID* gelöscht werden. Die MAC-Adressen und die UUID werden dann beim Import neu generiert. Wenn Du ganz sicher gehen willst, kannst Du zusätzlich im *Virt-Manager* die Netzwerkkarten auch noch deaktivieren.

.. code-block:: console

	---snip---
	
	# Ändern
	<name>ipfire</name>
	
	# Löschen
	<uuid>0fa619e6-32e7-44e4-be31-920696bab268</uuid>

	<mac address='52:54:00:49:20:91'/>




**Lokales Einbinden der VM HDDs auf dem KVM-Server**

Um einzelne Dateien wiederherzustellen, ist es möglich, die virtuellen Festplatten lokal auf dem KVM-Server zu mounten (Die HDD darf natürlich nicht aktiv sein).

.. code-block:: console

	# lvscan

	Sichtbar machen der Partitionen
	# kpartx -a /dev/mapper/kvm--vg-ipfire

	Allgemein
	# kpartx -a <HDD> oder auch <RAW Image>

	Optional: Anlegen eines Verzeichnisses
	# mkdir /media/HDD-restore

	Mounten einer Partition
	# mount /dev/mapper/kvm--vg-ipfire1 /media/HDD-restore

	Unmounten einer Partition
	# umount /media/HDD-restore

	Freigeben der Partitionen der HDD
	# kpartx -d /dev/mapper/kvm--vg-ipfire

	Allgemein
	# kpartx -d <HDD> oder auch <RAW Image>

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/W91Jc3C5Li4?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>


.. [#f1] /usr/local/bin/virt-backup --vm=server --debug --no-offline --compress=lzop --blocksize=4M --exclude=vdb --backupdir=/media/virt-backup/VMs/