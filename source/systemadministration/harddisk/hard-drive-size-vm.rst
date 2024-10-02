.. include:: ../../guided-inst.subst

.. _hard_drive_size_vm-label:

==========================================
Aktualisieren der Server-Festplattengrößen
==========================================

.. sectionauthor:: `@toheine <https://ask.linuxmuster.net/u/toheine>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
.. hint::

   Achtung: Dies ist noch eine unvollständige Beschreibung. Findest Du Fehler oder kannst zur Verbesserung beitragen, dann wende Dich bitte an einen der Autoren des Abschnittes.

Überblick
---------

1. Starten der VM wie zuvor beschrieben ist erfolgt.
2. Prüfen, ob die neuen HDD-Größen an die VM durchgereicht werden.
3. Partitionsgrößen prüfen.
4. HDD1 anpassen.
5. HDD2 mit dem LVM anpassen.
6. Reboot
7. Tests durchführen.

3.1 Starten der VM
------------------

Starte die VM wie zuvor beschrieben.


3.2 HDD-Größen überprüfen
-------------------------

Auf der Konsole der Server-VM prüfst Du zuerst, welche Festplatten des Hypervisor auch
in der VM durchgereicht werden und welche Bezeichnung diese haben. 
Die im Hypervisor geänderten Größen werden hier bereits angezeigt, aber die Partitionen wurden noch nicht auf 
die neuen Größen angepasst.

Öffne die Konsole wie schon in einem vorherigen Abschnitt gezeigt, nachdem Du in der Übersicht links den Server `lmn-server` ausgewählt hast.

Für den Login benötigst Du folgende Informationen:

* Login: root
* Passwort: Muster!

.. hint:: Diese Daten dürfen bis zum Aufruf des Installationsskriptes nicht verändert werden!


In der geöffneten Konsole gib folgenden Befehl ein:

.. code::

  lsblk

Du solltest jetzt die geänderten Größen angezeigt bekommen.

.. code::

   root@server:~# lsblk
   NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   sr0                       11:0    1 1024M  0 rom  
   xvda                     202:0    0  155G  0 disk 
   ├─xvda1                  202:1    0    1M  0 part 
   └─xvda2                  202:2    0   24G  0 part /
   xvdb                     202:16   0 1000G  0 disk 
   ├─vg_srv-var             253:0    0  9,8G  0 lvm  /var
   ├─vg_srv-linbo           253:1    0   40G  0 lvm  /srv/linbo
   ├─vg_srv-global          253:2    0  9,8G  0 lvm  /srv/samba/global
   └─vg_srv-default--school 253:3    0   40G  0 lvm  /srv/samba/schools/default-school
   
In Abhängigkeit Deiner Virtualisierungs-Umgebung werden die Festplatten unterschiedlich benannt. Wir zeigen das hier an einem Beispiel mittels mit XCP-ng. Es kann also in Deiner Konfiguration Abweichungen in der Bezeichnung geben. Passe diese bei den folgenden Befehlen dementsprechend an.

Die Bezeichnung `xvda` steht in XCP-ng für die 1. Festplatte der VM, `xvdb` für die 2. Festplatte der VM.

* `xvda1` ist dann die 1. Partition auf der 1. Festplatte der VM
* `xvda2` die 2. Partition auf der 1. Festplatte 

`vg-*` steht für ein LVM auf der jeweils zugeordneten Festplatte. Im obigen Beispiel befindet sich das LVM auf der 2. Festplatte (xvdb).

.. hint::

   Unter Proxmox oder KVM werden in der VM hingegen die Festplattenbezeichnungen sda für die 1. HDD und sdb für die 2. HDD des Systems verwendet. 
   Die Nummerierung für die Partitionen bleibt erhalten. Die angeben sind je nach eingesetztem System ensprechend anzupassen.

3.3 Dateisystem prüfen
----------------------

Lasse Dir nun die aktuellen Größen des Dateisystems ausgeben.

.. code::

   df -h

.. code::

   root@server: ~# df
   Dateisystem                       Größe Benutzt Verf. Verw% Eingehängt auf
   udev                               5,9G       0  5,9G    0% /dev        
   tmpfs                              1,2G    7,7M  1,2G    1% /run
   /dev/xvda2                          25G    5,7G   18G   25% /
   tmpfs                              5,9G       0  5,9G    0% /dev/shm
   tmpfs                              5,0M       0  5,0M    0% /run/lock
   tmpfs                              5,9G       0  5,9G    0% /sys/fs/cgroup
   /dev/mapper/vg_srv-global          9,8G     37M  9,3G    1% /srv/samba/global
   /dev/mapper/vg_srv-linbo            40G    347M   37G    1% /srv/linbo
   /dev/mapper/vg_srv-default–school   40G     74M   38G    1% /srv/samba/schools/default-school
   /dev/mapper/vg_srv-var             9,8G    1,2G  8,1G   13% /var
   tmpfs                              1,2G       0  1,2G    0% /run/user/0
    
Hier werden noch die alten Partitionsgrößen angegeben.   

3.4 HDD1 anpassen
-----------------

Partitionen auf der 1. HDD prüfen:

.. code::

   fdisk /dev/xvda

Sollte eine derartige Meldung

.. code::
   
   Warning: GPT - PMBR Größenunterschied (52428799 != 304087039) wird durch write korrigiert.
   
durch den Befehl ausgegeben werden, dann fdisk wieder ohne Schreibvorgang verlassen mit `q`. 

Dieses Problem gilt es zunächst zu lösen.

Rufe dazu auf der Eingabekonsole das Programm `parted` auf.

.. code:: 

   parted /dev/xvda

Das Programm wartet dann auf eine Eingabe von dir.

.. code::

   root@server: ~# parted /dev/xvda
   GNU Parted 3.2
   /dev/sda wird verwendet
   Willkommen zu GNU Parted! Rufen Sie >>help<< auf, um eine Liste der verfügbaren Befehle zu erhalten.
   (parted)

Gib `print` ein.
   
Es wird dann ein Größenproblem für die 1. HDD angezeigt und parted bietet eine Auswahloption an, um dieses
Problem zu beheben. 

Anmerkung zu den Platzhaltern `xx`, diese stehen für die ausgewählten Vorgaben Deiner Installation.

.. code::

   Warnung: Nicht der gesamte verfügbare Platz von /dev/xvda scheint belegt zu sein. Sie können die GPT reparieren, damit der gesamte Platz verwendet wird (zusätzlich xxx Blöcke) oder Sie können mit den aktuellen Einstellungen fortfahren.
  Reparieren/Fix/Ignoiren/Ignore? 

Gib `Reparieren` ein, damit das Größenproblem gelöst wird und verlasse dann parted wieder
durch Angabe des Befehls `quit`.

Danach erneut `fdisk` aufrufen, die 2. Partition löschen und neu mit neuer Größe anlegen. Die angegebenen Befehle musst Du der Reihe nach abarbeiten.

.. code::

   fdisk /dev/xvda

.. code::    

   p 
   
`p` (print) zeigt Dir die vorhanden Partitionen an

.. code::

   d 
   
`d` bietet Dir die Auswahl der zu löschen Partitionen durch die Angabe einer Nummer an. Hier also die 2

.. code::

   2

Nun gilt es die Partition neu anzulegen, das erreichst Du mit `n`: 

.. code::
  
   n 
  
Die folgenden 3 Vorgaben kannst Du einfach mit `Enter` übernehmen.

.. code::

   Partionsnummer (2-128, Vorgabe 2): 2
   Erster Sektor (4096-xxx, Vorgabe 4096):
   Letzter Sektor, +Sektoren oder +Größe{K,M,G,T,P} (4096-xxx, Vorgabe xxx):

Dir wird darauf die folgende Frage gestellt:

.. code::

   Eine neue Partition 2 des Typs "Linux filesystem" und der Größe xxx GiB wurde erstellt
   Partition #2 enthält eine ext4-Signatur.

   Wollen Sie die Signatur entfernen? [J]a/[N]ein:

Gib ein `N` ein 

Zum Beenden von fdisk verwendest Du nun `w` damit Deine Änderungen auf die Festplatte geschrieben werden.

.. code::

   Wollen Sie die Signatur entfernen? [J]a/[N]ein:

   Befehl (m für Hilfe): w

   Die Partitionstabelle wurde verändert.
   Festplatten werden synchronisiert.
   
Nun muss die Partition noch auf die neue Größe erweitert werden. Gib in der Konsole nun an:

.. code::

   resize2fs /dev/xvda2
   
Ab nun wird die neue Größe für der 1. HDD genutzt.


3.5 HDD2 mit dem LVM anpassen
-----------------------------
 
In o.g. VM auf XCP-ng befindet sich auf der 2. HDD `/dev/xvdb` ein LVM.

Folgende Begriffe sind hierbei relevant:

a) Physical Volume (PV)
b) Volume Group (VG)
c) Logical Volume (LV)

a) Anpassen der PV - Größe auf die gesamte neue Festplattengröße

PV ermitteln

.. code::

   root@server:/srv/linbo# pvscan
   PV /dev/xvdb VG vg_srv lvm2 [<100,00 GiB / 0 free]

PV Größenanpassung testen

.. code::

   pvresize /dev/xvdb
   Physical volume „/dev/xvdb“ changed
   1 physical volume(s) resized / 0 physical volume(s) not resized

b) LV-Größen anpassen

Die Werte hinter dem ``+`` bitte wie gewünscht anpassen.

.. code:: 

   lvextend -L+100G /dev/mapper/vg_srv-var

Der Befehl liefert folgende Ausgabe:

.. code:: 

   lvextend -L+100G /dev/mapper/vg_srv-var
   Size of logical volume vg_srv/var changed from 10,00 Gib (2560 extents) to xx,xx GiB (xxxxx extents).
   Logical volume vg_srv/var successfully resized.

Diesen Befehl wiederholst Du für die anderen Logical Volumes

.. code::

   lvextend -L+200G /dev/mapper/vg_srv-linbo
   lvextend -L+100G /dev/mapper/vg_srv-global
   lvextend -l +100%FREE /dev/mapper/vg_srv-default-school

c) Dateisystem an die neuen Größen anpassen:

.. code::

   resize2fs /dev/mapper/vg_srv-var

Beispiel der Befehlsausgabe:

.. code::
   
   resize2fs 1.44.1 (24-Mar-2018)
   Dateisystem bei /dev/mapper/vg_srv-var ist auf /var eingehängt; Online-Größenänderung ist
   erforderlich
   old_desc_blocks = 2, new_desc_blocks = 14
   Das Dateisystem auf /dev/mapper/vg_srv-var is nun 28835840 (4k) Blöcke lang.

Wiederhole diesen Befehl für die anderen Logical Volumes.

.. code::
   
   resize2fs /dev/mapper/vg_srv-linbo
   resize2fs /dev/mapper/vg_srv-global
   resize2fs /dev/mapper/vg_srv-default--school


d) Ergebnis prüfen

.. code::

   root@server: ~# df -h

   Dateisystem                      Größe Benutzt Verf. Verw% Eingehängt auf
   udev                              5,9G       0  5,9G    0% /dev
   tmpfs                             1,2G    7,7M  1,2G    1% /run
   /dev/xvda2                         25G    5,7G   18G   25% /
   tmpfs                             5,9G       0  5,9G    0% /dev/shm
   tmpfs                             5,0M       0  5,0M    0% /run/lock
   tmpfs                             5,9G       0  5,9G    0% /sys/fs/cgroup
   /dev/mapper/vg_srv-global         207G     59M  199G    1% /srv/samba/global
   /dev/mapper/vg_srv-linbo          433G    368M  415G    1% /srv/linbo
   /dev/mapper/vg_srv-default–school 236G     85M  226G    1% /srv/samba/schools/default-school
   /dev/mapper/vg_srv-var            109G    1,2G  103G    2% /var
   tmpfs                             1,2G       0  1,2G    0% /run/user/0

3.6 Reboot
----------

Starte nun die Server-VM neu, um zu prüfen, ob die vorgenommenen Größenanpassungen funktionsfähig sind und der Reboot korrekt ausgeführt wird.

.. code::

   root@server: ~# reboot
   
3.7 Tests durchführen
---------------------

Nachdem die VM wieder gestartet ist, melde Dich an der Konsole an und prüfe mithilfe nachstehender Befehle, ob die Platten- und Partitionsgrößen
nun Deinen Wünschen tatsächlich entsprechen.

.. code::

   root@server:~# lsblk
   NAME                     MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
   sr0                       11:0    1 1024M  0 rom  
   xvda                     202:0    0  145G  0 disk 
   ├─xvda1                  202:1    0    1M  0 part 
   └─xvda2                  202:2    0  145G  0 part /
   xvdb                     202:16   0 1000G  0 disk 
   ├─vg_srv-var             253:0    0  110G  0 lvm  /var
   ├─vg_srv-linbo           253:1    0  440G  0 lvm  /srv/linbo
   ├─vg_srv-global          253:2    0  210G  0 lvm  /srv/samba/global
   └─vg_srv-default--school 253:3    0  240G  0 lvm  /srv/samba/schools/default-school

.. code::

   root@server:~# df -h
   Dateisystem                        Größe Benutzt Verf. Verw% Eingehängt auf
   udev                                5,9G       0  5,9G    0% /dev
   tmpfs                               1,2G    6,8M  1,2G    1% /run
   /dev/xvda2                          143G     13G  125G   10% /
   tmpfs                               5,9G       0  5,9G    0% /dev/shm
   tmpfs                               5,0M       0  5,0M    0% /run/lock
   tmpfs                               5,9G       0  5,9G    0% /sys/fs/cgroup
   /dev/mapper/vg_srv-global           207G     59M  199G    1% /srv/samba/global
   /dev/mapper/vg_srv-default--school  236G     43G  184G   19% /srv/samba/schools/default-school
   /dev/mapper/vg_srv-var              109G    3,5G  101G    4% /var
   /dev/mapper/vg_srv-linbo            433G     40G  376G   10% /srv/linbo
   tmpfs                               1,2G       0  1,2G    0% /run/user/0

.. hint::

   Dieses Vorgehen musst Du für die optionalen Server `docker` und `opsi` wiederholen, wenn Du auch deren Festplattengröße verändert hast!

Im Folgenden wirst Du die Festplatten der OPNsense® anpassen.

