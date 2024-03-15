.. include:: ../../../guided-inst.subst

.. _hardware-category-label:

=======================================
Hardwareklasse (HWK) / Gruppe erstellen
=======================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix (pics) <https://ask.linuxmuster.net/u/MachtDochNix>`_

Melde Dich als Benutzer ``global-admin`` an der Web-UI an.

.. figure:: media/01-webui-login.png
   :align: center
   :alt: WebUI login
   :width: 80%
   
   Anmeldung als Benutzer global-admin

Erstelle nun die Konfiguration für die neue Hardwareklasse. Klicke links im Menü auf den Eintrag ``Geräteverwaltung --> Linbo4``.

.. figure:: media/02-webui-menue-linbo.png
   :align: center
   :alt: WebUI menue linbo
   
   Menü LINBO4

Nun klickst Du unten links auf ``+ERSTELLEN``.

Es öffnet sich ein Kontextmenü. Du kannst entweder ein leere ``start.conf`` nutzen, oder ein bereits vordefiniertes Template für Dein gewünschtes Betriebssystem auswählen. Hierbei kannst Du Templates für ein oder mehrere Betriebssysteme mit oder ohne UEFI-BIOS auswählen und diese ggf. nach Deinen Vorstellungen anpassen.

.. figure:: media/03-webui-menue-linbo-create-start-template.png
   :align: center
   :alt: WebUI menue linbo create start template
   
   Template für die start.conf auswählen

Es öffnet sich ein Fenster, in dem Du die Namen der neuen Hardwareklasse angibst. Diesen wirst Du später benötigen, um Geräte dieser Hardwareklasse zuzuweisen.

.. figure:: media/04-webui-menue-linbo-name-for-start-conf.png
   :align: center
   :alt: WebUI menue linbo hwc group name
   :width: 80%
   
   Namen für die neue Hardwareklasse festlegen

Die Liste der angelegten Hardwareklassen kann dann - z.B. wie nachstehend dargestellt - aussehen (andere Namen für die HWK verwendet):

.. figure:: media/04a-webui-menue-linbo-list-of-hwc.png
   :align: center
   :alt: WebUI menue linbo hwc list
   :width: 80%
   
   Übersicht der Hardwareklassen / Gruppen

Du rufst nun die Einstellungen der zuvor angelegten Hardwareklasse auf, indem Du das ``Stift-Symbol`` rechts daneben aufrufst.

Es erscheint ein Fenster mit den Einstellungen der Hardwareklasse. Dort gibt es die Reiterkarten ``Allgemein`` und  ``Partitionen``.

Unter ``Allgemein`` legst Du die IP des Servers fest, gibst das Startverhalten und ggf. Kernel-Optionen (Linux) für den Boot bei besonderer Hardware an.

.. figure:: media/05-webui-linbo-edit-new-group.png
   :align: center
   :alt: WebUI linbo edit new hwc group
   :width: 80%
   
   Allgemeine Einstellungen für die Hardwareklasse

Unter ``Partitionen`` legst Du fest, welche Partitionen auf der Festplatte vorgesehen werden sollen.

.. figure:: media/06-webui-linbo-edit-new-group-partition-scheme.png
   :align: center
   :alt: WebUI linbo edit new hwc group - partition scheme
   :width: 80%
   
   Partitionen festlegen

Löschst Du dort z.B. die Partitionen ``swap`` und ``data`` so sieht Deine Partitionierung wie folgt aus:

.. figure:: media/07-webui-linbo-edit-new-group-partition-scheme-edited.png
   :align: center
   :alt: WebUI linbo edit new hwc group - partition scheme edited
   :width: 80%
   
   Partitionen anpassen

Um Einstellungen für das jeweilige Betriebssystem vorzunehmen, klickst Du auf das Stift-Icon neben dem angegebenen Betriebssystem. Es öffnet sich ein weiteres Fenster, um Einstellungen für das Betriebssystem vorzunehmen.

.. figure:: media/08-webui-linbo-edit-new-group-os-infos-edited.png
   :align: center
   :alt: WebUI linbo edit new hwc group - os edited
   :width: 80%
   
   Einstellungen des Betriebssystems anpassen

Unter der Reiterkarte ``OS`` legst Du für das Betriebssystem (OS) die gewünschten Icons, die Start-Optionen und u.a. auch den Namen für das Basisimage fest. 

Um ein neues Image festzulegen, klickst Du auf das ``+`` - Zeichen und trägst einen neuen Namen für das Image ein. Achte darauf, dass die Dateiendung ``.qcow2`` lautet. Um nun das neue Image zu erstellen, startest Du den Client neu. Es wird das bestehende Image, das unter Basisimage angelegt bzw. ausgewählt wurde - hier das noch nicht existierende Image ``pop_os_mim.qcow2`` - überschrieben. 

Auf dem linuxmuster.net Server werden die start.conf-Dateien im Verzeichnis ``/srv/linbo`` abgelegt. Jede Hardwareklasse hat eine eigene start.conf-Datei. Für die neu angelegte Hardwareklasse des Muster-Clients wurde dort nun eine Datei ``start.conf.<name-der-hwk>`` erstellt (z.B. start.conf.ubu20efi).

Diese Datei muss normalerweise nicht händisch editiert werden, da sich alle nötigen Einstellungen in der WebUI vornehmen lassen. Das folgende Beispiel dient nur dazu, zu zeigen, was "unter der Decke" passiert.

Folgende Konfiguration zeigt ein mögliches Beispiel für die ``Hardwareklasse ubu20efi`` (hier als Linux-Client). Diese würde sich in der Datei ``/srv/linbo/start.conf.ubu20efi`` befinden. Hierbei wird von einem UEFI-BIOS und Linux als Betriebssystem ausgegangen:

.. code::

  [LINBO]
   Server = 10.0.0.1
   Group = ubu20efi            #Hardwareklasse
   Cache = /dev/sda3
   RootTimeout = 600
   AutoPartition = no
   AutoFormat = no
   AutoInitCache = no
   GuiDisabled = no                    # disable gui <yes|no>
   UseMinimalLayout = no               # gui layout style <yes|no>
   Locale = de-DE                      # gui locale <de-de|en-gb|fr-fr|es-es>
   DownloadType = torrent
   SystemType = efi64                  # UEFI-BIOS
   KernelOptions = quiet splash        # hier muessen bei spezieller Hardware ggf. Kernel-Parameter angegeben werden wie nomodeset
  
   [Partition]
   Dev = /dev/sda1
   Label = efi
   Size = 200M
   Id = ef
   FSType = vfat
   Bootable = yes

   [Partition]
   Dev = /dev/sda2
   Label = ubuntu
   Size = 12G
   Id = 83
   FSType = ext4
   Bootable = no
  
   [Partition]
   Dev = /dev/sda3
   Label = cache
   Size = 12G
   Id = 83
   FSType = ext4
   Bootable = no

   [Partition]
   Dev = /dev/sda4
   Label = swap
   Size = 2G
   Id = 82
   FSType = swap
   Bootable = no

   [Partition]
   Dev = /dev/sda5
   Label = data
   Size =            # verbleibender Plattenplatz wird der Partition zugewiesen
   Id = 83
   FSType = ext4
   Bootable = no
   
   [OS]
   Name = Ubuntu
   Version = 20.04 LTS
   Description = Ubuntu 20.04
   IconName = ubuntu.svg
   Image =
   BaseImage = ubuntu.qcow2 # Name des neu angelegten Images in obiger Abb. ist dies: pop_os_mlm.qcow2
   Boot = /dev/sda2
   Root = /dev/sda2
   Kernel = /boot/vmlinuz
   Initrd = /boot/initrd.img
   Append = ro splash
   StartEnabled = yes
   SyncEnabled = yes
   NewEnabled = yes
   Autostart = no
   AutostartTimeout = 5
   DefaultAction = sync
   RestoreOpsiState = no
   ForceOpsiSetup =
   Hidden = yes

.. hint::

  Sollte der Client beim Boot-Vorgang Probleme haben (z.B. initializing hardware ...), dann müssen zur Behebung Kernel-Parameter für den Linux-Client in der Conf-Datei eingetragen werden. Dies kann insbesondere bei neueren Grafik- und Netzwerkkarten der Fall sein, so dass hier weitere Optionen anzugeben sind. Oftmals führt bereits folgende Zeile zum Erfolg: 

  ``KernelOptions = quiet splash nomodeset``

  Hilfreich können auch KernelOptions sein wie z.B.: 

  ``modprobe.blacklist=radeon``  oder   ``i915.alpha_support=1``
  
  Wenn bei neueren Realtek-Netzwerkkarten mit r8169-Chip in linbo >=4.1.26 sehr niedrige Download-Raten auftreten, können die Kerneloptionen ``pcie_aspm=off`` und  ``loadmodules=r8168``  Besserung bringen.


  
