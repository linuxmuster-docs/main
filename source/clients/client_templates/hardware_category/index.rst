.. |zB| unicode:: z. U+00A0 B. .. Zum Beispiel 
  
.. |ua| unicode:: u. U+00A0 a. .. und andere

.. |_| unicode:: U+202F
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. _hardware-category-label:

=======================================
Hardwareklasse (HWK) / Gruppe erstellen
=======================================

Melde dich als Benutzer ``global-admin`` an der Web-UI an.

.. figure:: media/01-webui-login.png
   :align: center
   :alt: WebUI login

Erstelle nun die Konfiguration für die neue Hardwareklasse. Dafür klickst du links im Menü den Eintrag ``Geräteverwaltung --> Linbo4``.

.. figure:: media/02-webui-menue-linbo.png
   :align: center
   :alt: WebUI menue linbo

Nun klickst du unten links auf ``+ERSTELLEN``.

Es öffnet sich ein Kontextmenü. Du kannst entweder ein leere start.conf nutzen, oder ein bereits vordefiniertes Template für dein gewünschtes Betriebssystem auswählen.

.. figure:: media/03-webui-menue-linbo-create-start-template.png
   :align: center
   :alt: WebUI menue linbo create start template

Es öffnet sich ein Fenster, in dem du die Namen der neuen Hardwareklasse angibst. Diesen wirst du später brauchen um Geräte dieser Hardwareklasse zuzuweisen.

.. figure:: media/04-webui-menue-linbo-name-for-start-conf.png
   :align: center
   :alt: WebUI menue linbo hwc group name

Danach gelangst du zu den Einstellungen der Hardwareklasse. Dort gibt es die Reiterkarten ``Allgmein`` und  ``Partitionen``.

Unter ``Allgemein`` legst du die IP des Servers fest, gibst das Startverhalten und ggf. Kernel-Optionen für den Boot bei besonderer Hardware an.

.. figure:: media/05-webui-linbo-edit-new-group.png
   :align: center
   :alt: WebUI linbo edit new hwc group

Unter ``Partitionen`` legst du fest, welche Partitionen auf der Festplatte vorgesehen werden sollen.

.. figure:: media/06-webui-linbo-edit-new-group-partition-scheme.png
   :align: center
   :alt: WebUI linbo edit new hwc group - partition scheme

Löschst du dort z.B. die Partitionen ``swap`` und ``data`` so sieht deine Partitionierung wie folgt aus:

.. figure:: media/07-webui-linbo-edit-new-group-partition-scheme-edited.png
   :align: center
   :alt: WebUI linbo edit new hwc group - partition scheme edited

Um Einstellungen für das Betriebssystem vorzunehmen, klickst du auf das Stift-Icon (hier für Ubuntu) und es öffnet sich ein weiteres Fenster, um Einstellungen für das Betriebssystem vorzunehmen.

.. figure:: media/08-webui-linbo-edit-new-group-os-infos-edited.png
   :align: center
   :alt: WebUI linbo edit new hwc group - os edited

Unter der Reiterkarte ``OS`` legst du für das Betriebssystem (OS) die gewünschten Icons, die Start-Optionen und u.a. auch den Namen für das Basisimage fest. Zu Beginn bleibt hier der Eintrag ``None`` noch stehen und auch bei ``Start Optionen`` muss ``Autostart`` deaktiviert bleiben, da du erst das Image für den Muster-Client erstellen musst.

Auf dem linuxmuster.net Server werden die start.conf-Dateien im Verzeichnis ``/srv/linbo`` abgelegt. Jede Hardwareklasse hat eine eigene start.conf-Datei. Für die neu angelegte Hardwareklasse des Muster-Clients wurde dort nun eine Datei ``start.conf.<name-der-hwk>`` erstellt.

Diese Datei muss normalerweise nicht händisch editiert werden, da sich alle nötigen Einstellungen in der WebUI vornehmen lassen. Das folgende Beispiel dient nur dazu, zu zeigen, was "unter der Decke" passiert.

Folgende Konfiguration zeigt ein mögliches Beispiel für die Hardwareklasse 20210426_focalfossa_base (hier als Linux-Client). Diese würde sich in der Datei ``/srv/linbo/start.conf.20210426_focalfossa_base`` befinden. Hierbei wird von einem Legacy-BIOS und Linux als Betriebssystem ausgegangen:

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
   Size =        # verbleibender Plattenplatz wird als Cache genutzt
   Id = 83
   FSType = ext4
   Bootable = yes
   
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
