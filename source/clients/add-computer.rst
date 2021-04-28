.. include:: /guided-inst.subst

.. _add-computer-label:

===================================
 Rechneraufnahme und Muster-Clients
===================================

Rechneraufnahme mit der Schulkonsole
====================================

.. sectionauthor:: `@Alois <https://ask.linuxmuster.net/u/Alois>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_

Um einen Rechner mit der Schulkonsole aufzunehmen geht man wie folgt vor: Melde dich an der Web-UI an.

Im Menüpunkt ``GERÄTEVERWALTUNG/Geräte`` kann man nun `+ Gerät hinzufügen` anklicken. Standardmäßig sind die konfigurierten Server schon in der Liste mit der Rolle `Server` eingetragen.

.. image:: media/computer-add-add.png

In die sich öffnende Zeile gibt man unter Raum den Namen des Raumes (hier `server`) ein. Entsprechend verfährt man mit den Spalten `Hostname`, `Gruppe`, `MAC`, `IP` und `Sophomorix-Rolle`. Im Feld `PXE` wählt man aus, ob der Rechner mit Linbo synchronisiert werden soll. 

Die Schaltfläche `SPEICHERN` überprüft die Eingabe. mit `SPEICHERN & IMPORTIEREN` werden die neuen Geräte imporiert.

.. image:: media/Webui5.png

Im folgenden erscheinen einige Log-Meldungen und - wenn der Import erfolgreich war - "Import abgeschlossen"

.. image:: media/Webui6.png

Aufnahme der Muster-Clients
===========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`__

In der linuxmuster.net 7 ist es für Clients erforderlich, denen alle pädagogischen Funktionen im Netz zur Verfügung stehen sollen, dass diese im Active Directory (AD) des Servers (samba 4) einen sog. ``Domänenbeitritt`` ausführen. Hierbei werden Schlüssel erzeugt und ausgetauscht. Diese stellen sicher, dass der Client als berechtigtes Gerät eindeutig identifiziert und als Domänenmitglied erkannt wird.

Ziel ist es, dass alle PCs mit einem vordefinierten ``Muster-Image`` für Linux oder Windows genutzt werden, so dass nach Möglichkeit, nur ein Image oder wenige raumbezogene Images gepflegt werden, die mit Linbo allen PCs zur Vefügung gestellt werden. Hierzu ist zunächst ein Rechner mit dem gewünschten Client-Betriebssystem und den gewünschten Programmen zu installieren und vorzukonfigurieren. Dieser ``Muster-Rechner`` muss dann mit dem jeweiligen Betriebssystem einen Domänenbeitritt ausführen. Erst danach, kann dieses Image für alle anderen PCs ebenfalls genutzt werden.

.. attention::

  Der Eintrag für den Muster-PC, der das Image pro Betriebssystem inkl. Domänenbeitritt erstellt hat, darf niemals aus der Liste der Geräte gelöscht werden.

Empfehlung
----------

Es wird daher empfohlen, dass diese Muster-PCs vorab als virtuelle Maschinen (VM) für jedes Betriebssystem aufgebaut und für die weiteren Aktualisierungen genutzt werden. So wird sichergestellt, dass auch bei Austausch vorhandener Hardware der Muster-PC bestehen bleibt und somit für alle PCs die Anmeldung an der Domäne weiterhin korrekt funktioniert.

Sollten verschiedene Betriebssysteme pro Rechner gestartet werden können, so wird jeweils ein anderes Image genutzt. Für jedes Image muss ein eigener Domänen-Beitritt ausgeführt worden sein. Startet man die verschiedenen Betriebssysteme auf dem Client im Wechsel, so würde der Domänenbeitritt falsch erkannt, wenn nicht jedes Betriebssystem mit einem eigenen Rechner und Muster-Image angelegt und gepflegt werden würde.

Es wird daher empfohlen, pro genutzem Client-Betriebssystem eine eigene VM anzulegen, gewünschte Anpassungen vorzunehmen, den Domänenbeitritt auszuführen und das Image für das jeweilige Betriebssystem unter Linbo zu erstellen und für alle anderen PCs bereitzustellen. Diese VMs dürfen nicht aus der Liste Geräte entfernt werden. Dies ist wichtig, damit für die clients eine Domänenanmeldung weiterhin funktioniert. Alternativ könnten diese Images auch auch "echjter" Hardware erstellt werden, es darf dann allerdings kein alternativer Startvorgang eines anderen, in die Domäne eingebundenen, Betriebssystems erfolgen.

Entsprechend wird nachstehend das Vorgehen zur Aufnahme des Muster-Clients als VM dargestellt und die Schritte zum Aufbau eines Muster-Images.

Die Schritte sind wie folgt:

1. VM anlegen
2. VM als Rechner aufnehmen
3. VM starten
4. Client OS installieren
5. Erstimage erstellen
6. Domänenbeitritt ausführen
7. Image erstellen

Da für beide Client-Betriebssysteme die ersten Schritte identisch sind, werden diese für beide nachstehend beschrieben. Die Besonderheiten zur Einbindung der Clients je Betriebssystem werden anschliessend in den jeweiligen Kapiteln ``Linux-Clients`` und ``Windows-Clients`` beschrieben.


VM anlegen
----------

Für die Muster-VM des Client Betriebssystems ist im jeweiligen Virtualisierer eine VM Maschine mit bsp. folgenden Rahmendaten anzulegen:

 * 4GB vRAM
 * mind. 1 vCPU mit 2 Kernen
 * VGA mit 16GB Speicher
 * 1x vNIC (ggf. im "richtigen" VLAN)
 * PXE-Boot einstellen
 * Boot firmware: BIOS oder UEFI (je nach später genutzten PCs) - Achtung: start.conf von linbo anpassen -> siehe Hinweise bei den Client-Systemen
 * 50GB HDD (20GB OS + 20GB Cache + ggf. SWAP oder andere Partitionen)


VM als Rechner aufnehmen
------------------------

Wie zuvor für PCs beschrieben, ist die VM mit der MAC-Adresse via Web-UI als Gerät hinzuzufügen.

Dies kann auf dem Server auch alternativ via Konsole erfolgen. Hierzu ist die Datei ``/etc/linuxmuster/sophomorix/default-school/devices.csv`` anzupassen, so dass die VM mit der Hardwareklasse, MAC-Adresse und IP-Adresse und dem Linbo-Boot festgelegt werden.

Dies kann z.B. wie nachstehend angegeben, erfolgen:

.. code::

  client;vmubumuster;20210426_focalfossa_base;30:00:11:22:33:33;10.0.0.30;---;---;1;classroom-studentcomputer;---;1;;;;;1
 

Danach ist noch der Befehl ``linuxmuster-import-devices`` auszuführen. Jetzt fehlen für diese neue Hardware-Klasse (20210426_focalfossa_base) noch die Anpassungen in der Konfigurationsdatei ``start.conf.20210426_focalfossa_base``. Zudem sollten für die VM die VGA-Einstellungen sehr gering eingestellt werden, da die Anzeige in der Virtualisierungsumgebung sonst ggf. Probleme bereiten könnte.

**VGA anpassen**

Rufe auf dem Server die Datei ``/srv/linbo/boot/grub# vi 20210426_focalfossa_base.cfg`` auf.

Ersetze dort den Eintrag

.. code::

  # if you don't want this file being overwritten by import_workstations remove the following line:
  # ### managed by linuxmuster.net ###
  
  set gfxmode=auto
  set gfxpayload=keep

durch die Angabe für die Bildschirmauflösung und Farbtiefe:

.. code::

  # if you don't want this file being overwritten by import_workstations remove the following line:
  
  set gfxmode=800x600x16
  set gfxpayload=keep

Die Kommentarzeile ``  # ### managed by linuxmuster.net ###`` muss entfernt werden, damit beim nächsten linuxmuster-import-devices diese CFG-Datei nicht überschrieben wird.


**start.conf erstellen**

Für die Hardwareklasse (hier: 20210426_focalfossa_base) ist nun die Konfigurationsdatei ``/srv/linbo/start.conf.20210426_focalfossa_base`` anzupassen. Beispiele für die Linbo-Konfiguration für die gewünschten Clients finden sich ebenfalls auf dem Server unter ``/srv/linbo/examples``.

Nachstehende Konfiguration gibt ein mögliches Beispiel für eine Linux-VM zur Vorbereitung des Muster-Clients an. Hierbei wird von einem Legacy-BIOS und BIOS als Betriebssystem ausgegangen:

.. code::

  [LINBO]
  Server = 10.0.0.1
  Group = 20210426_focalfossa_base            #Hardwareklasse
  Cache = /dev/sda2
  RootTimeout = 600
  AutoPartition = no
  AutoFormat = no
  AutoInitCache = no
  DownloadType = torrent
  GuiDisabled = no                    # disable gui <yes|no>
  UseMinimalLayout = no               # gui layout style <yes|no>
  Locale = de-de                      # gui locale <de-de|en-gb|fr-fr|es-es>
  BackgroundColor = 394f5e            # hex code for gui background color
  BackgroundFontColor = white         # font color of status section (default: white)
  ConsoleFontColorStdout = lightgreen # console font color (default: white)
  ConsoleFontColorStderr = orange     # console error font color (default: red)
  SystemType = bios64
  KernelOptions = quiet splash
  
  [Partition]
  Dev = /dev/sda1
  Label = ubuntu
  Size = 30G
  Id = 83
  FSType = ext4
  Bootable = yes
  
  [Partition]
  Dev = /dev/sda2
  Label = cache
  Size = 20G
  Id = 83
  FSType = ext4
  Bootable = yes
  
  [Partition]
  Dev = /dev/sda3
  Label = swap
  Size = 4G
  Id = 82
  FSType = swap
  Bootable = no

  [Partition]
  Label = data
  Dev = /dev/sda4
  Size =
  Id = 83
  FSType = ext4
  Bootable = no
  
  [OS]
  Name = Ubuntu 20.04 LTS
  Version = 20
  Description = Ubuntu 20.04
  IconName = ubuntu.png
  Image =
  BaseImage = 20210426_focalfossa_base.cloop
  Boot = /dev/sda1
  Root = /dev/sda1
  Kernel = /boot/vmlinuz
  Initrd = /boot/initrd.img
  Append = ro splash
  StartEnabled = yes
  SyncEnabled = yes
  NewEnabled = yes
  Autostart = no
  AutostartTimeout = 4
  DefaultAction = sync
  RestoreOpsiState = no
  ForceOpsiSetup =
  Hidden = yes

Danach ist wieder der Befehl ``linuxmuster-import-devices`` anzugeben.

VM starten
----------

Mit o.g. Einstellungen wird die VM gestartet. Während des Boot-Vorgangs erhält die VM via PXE eine IP-Adresse und es wird Linbo geladen. Nachdem Linbo gestartet wurde melde dich als Root-Benutzer an und paritioniere und formatiert die Festplatte mit dem Button ``Imaging -> Partitionieren``. Danach beende die VM wieder.

Client OS installieren
----------------------

Gebe in der VM nun an, dass von dem gewünschten ISO-Image gestartet werden soll, um das zu installierende Betriebssystem (OS) zu booten und zu installieren. Hierbei ist darauf zu achten, dass die Boot-Reihenfolge so geändert wird, dass zuerst von dem ISO-Image gestartet wird.

Die VM ist mit den neuen Einstellungen nun zu starten und danach ist die Installation des Betriebssystems wie gewünscht durchzuführen.

Image erstellen
---------------

Danach ist die VM herunterzufahren, die Boot Reihenfolge ist wieder zu ändern, so dass via PXE Linbo gebootet wird. Abschließend wird die VM neu gebootet und unter Linbo wird für das installierte Betriebssystem ein erstes Image erstellt.


.. hint::

   Je nach Virtualisierungsumgebung kann es erforderlich sein Linbo-Booteinstellungen in der start.conf bzw. in der CFG-Datei anzupassen. Wichtig ist, dass die VM neu gestartet und via PXE gebootet wird. Hierbei wird dieser eine IP zugeordnet und danach wird Linbo gestartet. Unter Linbo wird dann die Festplatte partitioniert, formatiert und danach wird erneut von dem ISO-Image gebootet, um das Betriebssystem zu installieren. Um ein Linbo-Image für den Client zu erstellen, muss die VM zuvor immer mit Linbo formatiert worden sein.

.. hint:: Falls du zu dieser Seite von der Beschreibung einer Installation gekommen bist, dann folgende dem Pfeil!

Setze die Installation des Muster-Client je nach gewünschtem Betriebssystem für Linux oder Windows durch Auswahl einer der nachstehnden Links entsprechend fort.

+--------------------------------------------------------------------+-------------------------------------------+
| Installation von Linux-Clients                                     | |follow_me2linux-clients_a|               |
+--------------------------------------------------------------------+-------------------------------------------+
| Installation von Windows-Clients                                   | |follow_me2windows-clients_a|             |
+--------------------------------------------------------------------+-------------------------------------------+
