.. _using-linbo-label:

LINBO4 nutzen
=============

LINBO steht für GNU/\ **Li**\ nux **N**\ etwork **Bo**\ ot. Es wurde ursprünglich im Auftrag des Landesmedienzentrums Baden-Württemberg von der Firma
KNOPPER.NET in Zusammenarbeit mit den damaligen paedML-Linux- und heutigen linuxmuster.net-Entwicklern realisiert. Der Sourcecode ist unter GNU General Public License Version 2 veröffentlicht.

LINBO bietet

* vollautomatisches Ausrollen von Client-Installationen im Netzwerk
* Verwaltung mehrerer Betriebssystem-Installationen auf einem Client (Multiboot)
* minutenschnelle automatische Reparatur des Betriebssystems (SheilA-Prinzip)
* konfigurierbarer Autostart
* grafische Client-Oberfläche zur einfachen Bedienung durch Anwender und Netzwerkbetreuer
* vollständige Integration in die linuxmuster.net

Linbo4, das von linuxmuster.net entwickelt wurde, weist einige Neuerungen auf:

* Für neue Images wird nur noch das Format qcow2 unterstützt. Der Name des Basis-Images muss daher in der übernommenen start.conf angepasst werden (z.B. image.qcow2).
* Die Bennenung der zusätzlichen Image-Dateien postsync, prestart and reg ändert sich, so dass diese nur noch ohne dem Image-Format angegeben werden (z.B. image.postsync, image.prestart and image.reg, früher: image.cloop.postsync etc.).
* qemu-img wird nun genutzt, um die Erstellung und Wiederherstellung der qcow2 Images durchzuführen.
* Es wird nur noch 64 Bit Client-Hardware unterstützt.
* linuxmuster.net <=6.2 wird nicht mehr unterstützt.
* Es gibt derzeit keine differentiellen Images mehr. Differentielle Images werden voraussichtlich erst wieder ab Linbo v4.1 unterstützt.
* Bisherige Images im cloop Format sind direkt in das neue qcow2 Format zu konvertieren.

Dieses Kapitel führt dich in die Nutzung von linbo4 ein und erklärt die wesentlichen Schritte zur Imageverwaltung.

Der LINBO Startbildschirm
-------------------------

Wird der Arbeitsplatzrechner (Client-PC) über das Netzwerk gebootet, startet LINBO und zeigt folgenden Bildschirm, wenn der PC noch nicht aufgenommen / registriert wurde.

.. figure:: media/linbo-mainscreen/linbo-mainscreen-unregistered.png
   :align: center
   :alt: Linbo Startbildschirm eines nicht aufgenommenen Client

Sobald der Client registriert wurde, zeigt der Startbildschirm weitere Optionen an.

.. figure:: media/linbo-mainscreen/linbo-mainscreen-registered.png
   :align: center
   :alt: Linbo Startbildschirm eines aufgenommenen Clients

Informationen
^^^^^^^^^^^^^

Drückst du im Startbildschirm die Funktionstaste ``F1``, dann werden dir Informationen zum Client angezeigt.

.. figure:: media/linbo-mainscreen/linbo-mainscreen-infos-f1.png
   :align: center
   :alt: Linbo Infos zum Client - F1

Host
   Der festgelegte Hostname oder "pxeclient", wenn der Client nicht registriert ist.

Gruppe
   Die festgelegte Hardwareklasse

IP-Address
   Die festgelegte Netzwerkadresse oder "OFFLINE", wenn der Client ohne
   Netzwerkverbindung zum Server gestartet wurde.

Mac
   Die Hardware-Adresse des Clients.

HD, CPU, RAM
   Zeigt die entsprechend verbaute Hardware des Clients an:
   Festplattengröße, Prozessor und Hauptspeicherinformationen

Cache
   Zeigt die freie/gesamte Partitionsgröße der Cache-Partition an.


Reboot
^^^^^^

.. figure:: media/linbo-mainscreen/system-reboot.png
   :align: center
   :alt: Linbo Reboot Icon

Erzwingt einen Neustart.

Neustart
^^^^^^^^

.. figure:: ./media/linbo-mainscreen/system-shutdown.png
   :align: center
   :alt: Linbo Shutdown Icon

Lässt den Client herunterfahren.


Start-Reiter
^^^^^^^^^^^^

Pro festgelegter Partition (mit Betriebssystem oder ohne) erscheinen nach dem Start von Linbo ein großer Knopf und mehrere kleinere Knöpfe mit
folgenden Bedeutungen

.. figure:: media/linbo-mainscreen/sync+start.png
   :align: center
   :alt: Linbo Sync+Start Icon
	
   Sync+Start Knopf
	    
Synchronisiert das System mit dem letzten aktuellen Abbild (hir Ubuntu). Bei Windows-Systemen wird eine bereitgestellte Registry-Patch-Datei angewendet. Bei Linux-Systemen werden Hostname und Rootpartition gepatcht. Falls ein neueres Abbild auf dem Server liegt, wird dies zunächst heruntergeladen.

.. figure:: media/linbo-mainscreen/start.png
   :align: center
   :alt: Linbo Start Icon

   Start Knopf

Startet das System im aktuellen Zustand, unsynchronisiert. Es werden keine Patches angewandt.
	    
.. figure:: media/linbo-mainscreen/new-and-start.png
   :align: center
   :alt: Linbo New+Start Icon

   Neu+Start Knopf

   Formatiert die relevante Partition neu, synchronisiert das System von Grund auf mit dem aktuellen Image und startet das System wie bei "Sync+Start".

.. note::

   Die einzelnen Schaltflächen für die Startmechanismen können auch ausgegraut sein, wenn der Administrator den jeweiligen Mechanismus deaktiviert hat.


Tools-Reiter
^^^^^^^^^^^^

Um Abbilder (Images) zu verwalten, klickst du zunächst auf den Werkzeug Schaltfläche.

.. figure:: media/linbo-mainscreen/tools.png
   :align: center
   :alt: Linbo Tools Icon
  
   Werkzeug Schaltfläche - Tools Button

Der Bereich ist mit dem Passwort von "LINBO" abgesichert. Dies entspricht dem Linbo-Administrator Kennwort. Dies ist nach dem Setup zunächst identisch mit dem festgelegten root / global-admin Kennwort.

.. figure:: media/linbo-mainscreen/password-dialog.png
   :align: center
   :alt: Linbo Password Dialog


.. attention::

   Bei der Eingabe des LINBO-Passwortes werden keine Zeichen angezeigt, weder das Passwort selbst, noch Sterne.
 
Passwort für "LINBO" ändern
^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
Das Passwort steht im Klartext auf dem Server in der Datei ``/etc/rsyncd.secrets`` und kann einfach mit einem Editor geändert werden.

.. code::
 
   # modified by linuxmuster-setup
   # /etc/rsyncd.secrets

   linbo:MeinKewnnort

Nach einer Änderung wird das Passwort mit den nächsten Sync bzw. Netzwerkboot aktualisiert.


LINBO Imageverwaltung am Client
-------------------------------

Über den Tab ``Tools`` erhält der Administrator neue Funktionen.

.. figure:: media/linbo-imagingscreen/linbo-imagingscreen.png
   :align: center
   :alt: Linbo Tools - Imaging Functions

Für jedes definierte Betriebssystem gibt es Schaltflächen für die Funktionen

.. figure:: media/linbo-imagingscreen/image-os.png
   :align: center
   :alt: Linbo Create Image

   Image erstellen

Es öffnet sich ein neues Dialogfenster, über das man ein neues Abbild erstellen (und hochladen) kann.

.. figure:: media/linbo-imagingscreen/upload.png
   :align: center
   :alt: Linbo Upload Image

   Image hochladen

Es öffnet sich ein neues Dialogfenster, über das man das aktuelle Abbild auf den Server hochladen kann.

Daneben können gibt es Schaltflächen für folgende administrative Funktionen 

.. figure:: media/linbo-imagingscreen/console.png
   :align: center
   :alt: Linbo Console

   Console

Man kann eine (rudimentäre) Console öffnen, um Shell-Befehle abzusetzen und Fehler zu diagnostizieren.

.. figure:: media/linbo-imagingscreen/cache.png
   :align: center
   :alt: Linbo Cache

   Cache aktualisieren

Üblicherweise wird eine Partition auf dem Client als Cache festgelegt. Mit dieser Schaltfläche kann der Cache aktualisiert werden, d.h. alle für diesen Client nötigen Abbilder und postsync-Dateien werden gegebenenfalls heruntergeladen.

.. figure:: media/linbo-imagingscreen/partition.png
   :align: center
   :alt: Linbo Partitioning

   Partitionieren

Partitioniert die gesamte Festplatte gemäß der Vorgabe der Hardwareklasse.

.. figure:: media/linbo-imagingscreen/register.png
   :align: center
   :alt: Linbo Register

   Registrieren

Öffnet den Registrierungdialog zur erstmaligen Aufnahme dieses Rechners.

Rufe zur Imageerstellung o.g. Schaltfläche auf.


Dialog: Image erstellen
^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: ./media/linbo-imagingscreen/create-image-dialog.png
   :align: center
   :alt: Linbo Create Image Dialog

Zur Auswahl steht der momentane Name des Abbilds. Das aktuelle Abbild wird dann beim Erstellen überschrieben. Beim Hochladen des aktuellen Abbilds mit demselben Namen wird auf dem Server ein Backup des vorherigen Abbilds erstellt.

Wird ein neuer Dateiname gewählt, kann man Informationen zu dem neuen Image verfassen.

.. warning:: 

   Vergibt man einen neuen Dateinamen, sollte man sicher stellen, dass die Cache-Partition über ausreichend Platz verfügt, da das alte Image ebenfalls im Cache gespeichert bleibt. Ist nicht genügend Platz vorhanden, dann schlägt das Erstellen des Abbildes fehl.

Es gibt die beiden Optionen zum Abschluss der Aktion ``erstellen`` oder ``erstellen+hochladen`` den Computer neu zu starten oder
herunterzufahren.

Dialog: Image hochladen
^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: media/linbo-imagingscreen/upload-image-dialog.png
   :align: center
   :alt: Linbo Upload Image

Wie beim Image erstellen Dialog, kann hier explizit nur ein ausgewähltes Image hochgeladen werden und der Rechner zum Abschluss neu gestartet oder heruntergefahren werden. In der Drop-down Liste werden nur dann Images angezeigt, wenn diese bereits im Cache vorhanden sind.

Dialog: Console
^^^^^^^^^^^^^^^

.. figure:: media/linbo-imagingscreen/console-dialog.png
   :align: center
   :alt: Linbo Console Dialog

Der einfache Konsolendialog erlaubt die Eingabe einzelner Befehle in die untere Zeile.

Dialog: Cache aktualisieren
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: media/linbo-imagingscreen/update-cache-dialog.png
   :align: center
   :alt: Linbo Update cache

Der Cache wird aktualisiert. Es werden die drei Möglichkeiten der Synchronisation zur Auswahl gegeben: Rsync, Multicast oder Bittorrent.

Dialog: Partitionieren
^^^^^^^^^^^^^^^^^^^^^^

Es wird noch einmal gefragt, ob man wirklich alle Daten auf der Festplatte löschen will. Danach kann man mit "Cache aktualisieren"
aber auch wieder die Abbilder vom Server kopieren.

Dialog: Registrieren
^^^^^^^^^^^^^^^^^^^^

.. figure:: media/linbo-imagingscreen/register-dialog.png
   :align: center
   :alt: Linbo Register Dialog

Mit diesem Dialog kann ein erstmalig genutzer Rechner registriert werden. Dafür müssen alle Eingabefelder dem Vergabeschema entsprechend ausgefüllt werden.

.. note:: 

   Bitte trage für die Rechnergruppe einen Namen ohne Bindestriche `` - `` ein.


Boot-Bildschirme in LINBO
-------------------------

Beim Booten in LINBO sind folgende Bildschirme sichtbar:


Bootvorgang via Netzwerk
^^^^^^^^^^^^^^^^^^^^^^^^

.. figure:: media/linbo-bootscreen/linbo-tftp.png
   :align: center
   :alt: Initialmeldungen beim Bootvorgang via Netzwerk (PXE)

   Initialmeldungen beim Bootvorgang via Netzwerk (PXE)

Egal ob über die lokale Festplatte gebootet wurde oder nach dem Bootvorgang via Netzwerkkarte (PXE) wird mit der Gruppenkonfiguration der Kernel geladen.

.. figure:: media/linbo-bootscreen/linbo-group.png
   :align: center
   :alt: Bootbildschirm: Laden des Kernels

   Bootbildschirm: Laden des Kernels

Der gebootete LINBO-Kernel erscheint als ASCII-Art.

.. figure:: media/linbo-bootscreen/linbo-ascii.png
   :align: center
   :alt: LINBO-Kernelboot ASCII-Art

   LINBO-Kernelboot ASCII-Art

Die Grub-Konfiguration wird ggf aktualisiert, danach erscheint der reguläre ``LINBO Startbildschirm``.

Boot-Abbild für USB-Sticks und CD/DVD
-------------------------------------

Zum Brennen auf CD/DVD oder zum Kopieren auf einen USB-Stick lädst du zuerst das aktuelle linbo - Abbild als linbo.iso herunter.

Melde dich zuerst an der Schulkonsole an:

https://10.0.0.1/

Melde dich an der Schulkonsole als Benutzer ``global-admin`` an.

.. figure:: media/linbo-bootscreen/linbo-iso-login-school-console.png
   :align: center
   :alt: LINBO - Login School Console

Wähle dann links den Menüpunt ``linbo4`` aus.

.. figure:: media/linbo-bootscreen/linbo-iso-menue-linbo4.png
   :align: center
   :alt: LINBO4 Menue

Rechts im Fenster erscheinen ganz unten zwei Buttons. Klicke nun den Button ``Linbo Boot herunterladen``.

Es erscheint ein Fenster zum Download des ISO-Images.

.. figure:: media/linbo-bootscreen/linbo-iso-download.png
   :align: center
   :alt: Download linbo.iso

Das Booten eines Rechers mit einem Linbo-Stick oder einer Linbo-CD/DVD kann nötig werden, wenn - in seltenen Fällen - Linbo nicht per PXE installiert wird.

Bootet man einen Rechner vom Stick, oder von einer CD/DVD, dann sieht man folgendes Bild:

.. image:: media/linbo_screen1.png

Mit ``Enter`` wird der Client gebootet
 
.. image:: media/linbo_screen2.png

Mit der Auswahl durch die Pfeiltasten der Tastatur ``Ersteinrichtung + Neustart`` wird Linbo eingerichtet und der Rechner mit Linbo gestartet. Nach dem Neustart stehen alle Linbo-Funktionen zur Verfügung.


