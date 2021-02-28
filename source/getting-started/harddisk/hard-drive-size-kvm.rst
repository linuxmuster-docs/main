.. include:: /guided-inst.subst

.. _hard_drive-size_kvm-label:

===============================
Vorbereiten der KVM Festplatten
===============================

.. sectionauthor:: `@morbweb <https://ask.linuxmuster.net/u/morpweb>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,
		   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

.. hint::

   Achtung: Dies ist noch eine Platzhalterseite, die noch mit Inhalt gefüllt wird.
   Bitte vorerst mit dem Setup der Installation folgen.

.. todo:: Inhalt ergänzen
          ...
          Wenn fertig hint und todo entfernen

Festplatten in das Host-LVM importieren
=======================================

Die virtuellen Maschinen werden in Produktivsystemen auf einem LVM liegen. Dafür muss die Festplattengröße ermittelt, ein `logical volume` erstellt, das Abbild nochmals kopiert und die Konfiguration editiert. Der Bus wird auf `virtio` gestellt, dann heißt die Schnittstelle auch `vda`.

.. code::

   # qemu-img info /var/lib/libvirt/images/lmn7-opnsense-*disk001.raw | grep virtual\ size
   virtual size: 10G (10737418240 bytes)
   # lvcreate -L 10737418240b -n opnsense host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-opnsense-*disk001.raw /dev/host-vg/opnsense
   # virsh edit lmn7-opnsense
   ...
   <disk type='block' device='disk'>
      <driver name='qemu' type='raw'/>
      <source dev='/dev/host-vg/opnsense'/>
      <target dev='vda' bus='virtio'/>
      <address .../>           <---- delete this line, will be autocreated correctly
   ...

Jetzt kann das Abbild in ``/var/lib/libvirt/images`` gelöscht werden.

.. code::

   # rm /var/lib/libvirt/images/lmn7-opnsense-*disk001.raw

.. todo:: Müsste in den Bereich Festplatten-Anpassung

Festplattengrößen für den Server anpassen
-----------------------------------------
   
An dieser Stelle muss man die Festplattengrößen für den Produktiveinsatz an seine eigenen Bedürfnisse anpassen. Für einen Testbetrieb kann die Erweiterung ausfallen und man kann gleich mit dem Import in ein LVM fortsetzen.

Beispielhaft wird die zweite Festplatte und das darin befindliche server-LVM vergrößert, so dass ``/dev/vg_srv/linbo`` und ``/dev/vg_srv/default-school`` auf jeweils 175G vergrößert werden.

Zunächst wird der Container entsprechend (auf 10+10+175+175 GB) vergrößert, dann der mit Hilfe von `kpartx` aufgeschlossen.

.. code::

   # qemu-img resize -f raw /var/lib/libvirt/images/lmn7-server-*disk002.raw 370G
   Image resized.
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk002.raw | grep virtual\ size
   virtual size: 370G (397284474880 bytes)
   # kpartx -av /var/lib/libvirt/images/lmn7-server-*disk002.raw
   # vgdisplay -s vg_srv
   "vg_srv" <100,00 GiB [<100,00 GiB used / 0,00 GiB free]

Durch kpartx wurde der Container über ein so genanntes loop-device geöffnet und das darin liegende LVM wurde auf dem Serverhost hinzugefügt. Daher kann jetzt sowohl das loop-device als `physical volume` vergrößert als auch die `logical volumes` vergrößert werden. Zu letzt muss noch das Dateisystem geprüft und erweitert werden.

.. code::

   # pvresize /dev/loop0 
   Physical volume "/dev/loop0" changed
   1 physical volume(s) resized / 0 physical volume(s) not resized
   # vgdisplay -s vg_srv
   "vg_srv" <370,00 GiB [<100,00 GiB used / 270,00 GiB free]

   # lvresize /dev/vg_srv/default-school -L 175G
   Size of logical volume vg_srv/default-school changed from 40,00 GiB (10240 extents) to 175,00 GiB (44800 extents).
   Logical volume vg_srv/default-school successfully resized.
   # e2fsck -f /dev/vg_srv/default-school
   ...
   linbo: 1010/2621440 Dateien (0.6% nicht zusammenhängend), 263136/10485760 Blöcke
   # resize2fs /dev/vg_srv/default-school
   ...
   Das Dateisystem auf /dev/vg_srv/default-school is nun 45875200 (4k) Blöcke lang.

   # lvresize /dev/vg_srv/linbo -L 175G
     Insufficient free space: 34560 extents needed, but only 34559 available
   # lvresize /dev/vg_srv/linbo -l +34559     
   Size of logical volume vg_srv/linbo changed from <40,00 GiB (10239 extents) to <175,00 GiB (44799 extents).
   Logical volume vg_srv/linbo successfully resized.
   # e2fsck -f /dev/vg_srv/linbo
   ...
   default-school: 13/2621440 Dateien (0.0% nicht zusammenhängend), 242386/10484736 Blöcke
   # resize2fs /dev/vg_srv/linbo
   ...
   Das Dateisystem auf /dev/vg_srv/linbo is nun 45874176 (4k) Blöcke lang.

Um den Container wieder ordentlich zu schließen, muss man die `volume group` abmelden und mit `kpartx` abschließen, ein letztes `vgdisplay -s` überprüft, ob nur noch das Host-LVM übrig geblieben ist.

.. code::

   # vgchange -a n vg_srv
   0 logical volume(s) in volume group "vg_srv" now active
   # kpartx -dv /var/lib/libvirt/images/lmn7-server-*disk002.raw 
   loop deleted : /dev/loop0
   # vgdisplay -s
   "host-vg" < GiB [xxx GiB used / yyy free]
   
Festplatten in das Host-LVM importieren
---------------------------------------

Auch hier wird als Speichermedium auf dem Host LVM verwendet, wofür die selben Anpassung wie bei der Firewall nötig sind, ebenso werden die Schnittstellen mit dem Bussystem wieder umbenannt (`vda`, `vdb`, `virtio`).

.. code::

   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk001.raw | grep virtual\ size
   virtual size: 25G (26843545600 bytes)
   # lvcreate -L 26843545600b -n serverroot host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-*disk001.raw /dev/host-vg/serverroot
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      ...
      <source dev='/dev/host-vg/serverroot'/>
      <target dev='vda' bus='virtio'/>
      <address ...           <- zeile löschen
   ...
   # qemu-img info /var/lib/libvirt/images/lmn7-server-*disk002.raw | grep virtual\ size
   virtual size: 370G (397284474880 bytes)
   # lvcreate -L 397284474880b -n serverdata host-vg
   # qemu-img convert -O raw /var/lib/libvirt/images/lmn7-server-*disk002.raw /dev/host-vg/serverdata
   # virsh edit lmn7-server
   ...
   <disk type='block' device='disk'>
      ...
      <source dev='/dev/host-vg/serverdata'/>
      <target dev='vdb' bus='virtio'/>      
      <address ...           <- zeile löschen
   ...

Die ursprünglichen Abbilder in ``/var/lib/libvirt/images`` können gelöscht werden. Eventuell kann man damit warten, ob man die Abbilder als Recoveryabbilder behält, bis ein Backupsystem eingerichtet ist.

.. code::

   # rm /var/lib/libvirt/images/lmn7-server-*.raw

+--------------------------------------------------------------------+-------------------------------------------+
| VM Größe anpassen                                                  | |follow_me2vm-hd|                         |
+--------------------------------------------------------------------+-------------------------------------------+

Template für den Inhalt einer noch leeren Seite
-----------------------------------------------

Sicherlich ist der Inhalt dieser Seite nicht das was du gesucht und erwartest hast. Dieser Part der Dokumentation ist leider noch nicht mit Informationen gefüllt.

Eventuell kannst du uns helfen dieses zu ändern. Es gibt verschiedene Möglichkeiten uns zu unterstützen:

* Du weißt, was hier stehen müsste und könntest uns Text und/oder Screenshots liefern.

    Schicke deinen unformatierten Text oder die Bilder an dokumentation(et)linuxmuster.net oder einfach in unser Forum `<https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_.

* Du hast schon Erfahrung mit der vereinfachten Auszeichnugssprache RST (reStructuredText) oder willst sie erlernen.

    Unsere :ref:`guidelines-label` zeigen dir welche Absprachen wir diesbezüglich getroffen haben. Schicke uns deinen Inhalt für diese Seite an eine der zuvor genannten Adressen.

* Hast du eventuell schon einen git-hub-Account oder wolltest dich schon immer mit git befassen.
 
    Wir nutzen für die Organisation unserer Dokumentation git. Aus dem in github gehosteten RST-Files werden automatisch via ReadTheDocs (Sqhinx) diese Seiten hier erzeugt. 
 
    So hättest du direkt die Möglichkeit unsere Dokumentation zu verbessern. Dafür gibt es den Button der sich immer oben rechts auf den Seiten befindet: **Edit on GitHub**. Eine Beschreibung findest du hier: :ref:`edit-on-github-label`

* Du willst git auf deinem Rechner einsetzen um dort lokal arbeiten zu können.

    Auch dafür stehen wir dir hilfreich zur Seite, wie das geht haben wir hier :ref:`new-label` beschrieben.
  
Also wir würden uns freuen, wenn du uns unterstützen würdest. 

Wie immer bei linuxmuster.net niemand ist bei uns allein.
Für Fragen einfach einen Post an die im ersten Punkt genannten Adressen. (E-Mail oder Forum) 

Muster für Tabelle:

====== ===== ===== =======
\          XOR
--------------------------
\      Input       Output
------ ----------- -------
Lfd-Nr A     B     A xor B     
====== ===== ===== =======
1      0     0     0
2      0     1     1
3      1     0     1
4      1     1     0
====== ===== ===== =======
