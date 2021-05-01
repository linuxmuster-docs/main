.. include:: /guided-inst.subst

.. _add-computer-label:

==================================
Muster-Clients und Rechneraufnahme
==================================

Muster-Client vorbereiten
=========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`__

In der linuxmuster.net 7 ist es für Clients erforderlich, denen alle pädagogischen Funktionen im Netz zur Verfügung stehen sollen, dass diese im Active Directory (AD) des Servers (samba 4) einen sog. ``Domänenbeitritt`` ausführen. Hierbei werden Schlüssel erzeugt und ausgetauscht. Diese stellen sicher, dass der Client als berechtigtes Gerät eindeutig identifiziert und als Domänenmitglied erkannt wird.

Ziel ist es, dass alle PCs mit einem vordefinierten ``Muster-Image`` für Linux oder Windows genutzt werden, so dass nach Möglichkeit, nur ein Image oder wenige raumbezogene Images gepflegt werden, die mit Linbo allen PCs zur Vefügung gestellt werden. Hierzu ist zunächst ein Rechner mit dem gewünschten Client-Betriebssystem und den gewünschten Programmen zu installieren und vorzukonfigurieren. Dieser ``Muster-Rechner`` muss dann mit dem jeweiligen Betriebssystem einen Domänenbeitritt ausführen. Erst danach, kann dieses Image für alle anderen PCs ebenfalls genutzt werden.

Vorgehen
--------

Prinzipiell kann jeder PC genutzt werden, um für das jeweilige Betriebssystem als Muster-PC vorbereitet zu werden. Besonder flexibel ist es, den Muster-Client vorab als virtuelle Maschine (VM) für jedes Betriebssystem aufzubauen und für die weiteren Aktualisierungen zu nutzen.

Sollten verschiedene Betriebssysteme pro Rechner gestartet werden können, so wird jeweils ein anderes Image genutzt. Für jedes Image muss ein eigener Domänen-Beitritt ausgeführt worden sein. Startet man die verschiedenen Betriebssysteme auf dem Client im Wechsel, so würde der Domänenbeitritt falsch erkannt, wenn nicht jedes Betriebssystem mit einem eigenen Rechner und Muster-Image angelegt und gepflegt werden würde.

Es wird daher empfohlen, pro genutzem Client-Betriebssystem einen eigenen Muster-Client (ggf. als VM) anzulegen, gewünschte Anpassungen vorzunehmen, den Domänenbeitritt auszuführen und das Image für das jeweilige Betriebssystem unter Linbo zu erstellen und für alle anderen PCs bereitzustellen. Diese VMs dürfen nicht aus der Liste Geräte entfernt werden. Dies ist wichtig, damit für die Clients eine Domänenanmeldung weiterhin funktioniert.

Entsprechend wird nachstehend das Vorgehen zur Vorbereitung und Aufnahme des Muster-Clients dargestellt und die Schritte zum Aufbau eines Muster-Images beschrieben. An einigen Stellen werden ergänzende Hinweise zum Aufbau des Muster-Clients als VM gegeben, da je nach Virtualisierungsumgebung ein paar Besonderheiten zu beachten sind.

Die Schritte sind wie folgt:

1.  PC im Netz anschließen / VM anlegen und geeignete Netzwerkverbindung definieren
2.  Hardwareklasse für den PC/die VM konfigurieren
3.  PC/VM als Rechner aufnehmen
4.  PC/VM via PXE mit Linbo starten
5.  Festplatte mit Linbo partitionieren/formatieren
6.  PC/VM vom ISO-Image booten
7.  Client OS installieren
8.  Erstimage erstellen
9.  Domänenbeitritt ausführen
10. Image erstellen

Für beide Client-Betriebssysteme sind die Schritte 1-6 identisch. Diese sind nachstehend beschrieben. Die Besonderheiten zur Einbindung der Clients je Betriebssystem werden anschliessend in den Kapiteln ``Linux-Clients`` und ``Windows-Clients`` beschrieben.


PC anschließen / VM anlegen
----------------------------

Der PC, der als Hardware zum Aufbau des Muster-Clients genutzt werden soll, ist via Kabel im Netzwerk anzuschliessen.

Alternativ kann für den Aufbau des Muster-Clients eine VM für das Client-Betriebssystems im jeweiligen Virtualisierer angelegt werden.

Nachstehende Angaben stellen ein Beispiel für die Rahmendaten einer solchen VM dar:

 * 4 GB vRAM
 * mind. 1 vCPU mit 2 Kernen
 * VGA mit 16GB Speicher
 * 1x vNIC (ggf. im "richtigen" VLAN)
 * PXE-Boot einstellen
 * Boot Firmware: BIOS oder UEFI (je nach später genutzten PCs) - Achtung: start.conf von linbo ggf. anpassen -> siehe Hinweise bei den Client-Systemen
 * 50GB HDD (20GB OS + 20GB Cache + ggf. SWAP oder andere Partitionen)

HWK / start.conf erstellen
--------------------------

Melde dich als Benutzer ``global-admin`` an der Web-UI an.

.. figure:: media/01-webui-login.png
   :align: center
   :alt: WebUI login

Du erstellst nun die Konfiguration für die Hardwareklasse (HWK), die du vorher für das Gerät zugeordnet hast. Um die Hardwareklasse nun in der WebUI anzulegen, klickst du links im Menü den Eintrag ``Geräteverwaltung --> Linbo``.

.. figure:: media/02-webui-menue-linbo.png
   :align: center
   :alt: WebUI menue linbo

Um für den Muster-Client eine neue Hardwaregruppe für Linbo mit Startvorgaben zu erstellen, klickst du unten links auf ``+ERSTELLEN``.

Es öffnet sich ein Kontextmenü und du kannst entweder ein leere start.conf hierfür nutzen, oder eine bereits vordefinierte für dein gewünschtes Betriebssystem auswählen und anpassen.

.. figure:: media/03-webui-menue-linbo-create-start-template.png
   :align: center
   :alt: WebUI menue linbo create start template

Es öffnet sich ein Fenster, in dem du die Namen der Hardwareklasse angibst, den du bereits beim Hinzufügen des Geräts festgelegt hattest.

.. figure:: media/04-webui-menue-linbo-name-for-start-conf.png
   :align: center
   :alt: WebUI menue linbo hwc group name

Danach gelangst du zu den Einstellungen der Hardwareklasse. Du kannst die Reiterkarten ``Allgmein`` und  ``Partitionen`` oben auswählen.

Unter ``Allgemein`` legst du die IP des Servers fest und gibst das Startverhalten und ggf. Kernel-Optionen für den Boot bei besonderer Hardware an.

.. figure:: media/05-webui-linbo-edit-new-group.png
   :align: center
   :alt: WebUI linbo edit new hwc group

Unter ``Partitionen`` legst du fest, welche Partitionen auf der Festplatte für welche Betriebssysteme oder zu welchem Zweck vorgesehen werden sollen.

.. figure:: media/06-webui-linbo-edit-new-group-partition-scheme.png
   :align: center
   :alt: WebUI linbo edit new hwc group - partition scheme

Löscht du dort z.B. die Partitionen ``swap`` und ``data`` so sieht deine Partitionierung wie folgt aus:

.. figure:: media/07-webui-linbo-edit-new-group-partition-scheme-edited.png
   :align: center
   :alt: WebUI linbo edit new hwc group - partition scheme edited

Um Einstellungen für das Betriebssystem vorzunehmen, klickst du auf das Stift-Icon (hier für ubuntu) und es öffnet sich ein weiteres Fenster, um Einstellungen für das Betriebssyystem vorzunehmen.

.. figure:: media/08-webui-linbo-edit-new-group-os-infos-edited.png
   :align: center
   :alt: WebUI linbo edit new hwc group - os edited

Unter der Reiterkarte ``OS`` legst du für das Betriebssystem (OS) die gewünschten Icons, die Start-Optionen und u.a. auch den Namen für das Basisimage fest. Zu Beginn bleibt hier der Eintrag ``None`` noch stehen, da du erst das Image für den Muster-Client erstellen willst.

Auf dem linuxmuster.net Server werden die start.conf-Dateien im Verzeichnis ``/srv/linbo`` abgelegt. Jede Hardwareklasse hat eine eigene start.conf-Datei. Für die neu angelegte Hardware-Klasse des Muster-Clients wurde dort nun eine Datei ``start.conf.<name-der-hwk>`` erstellt.

Nachstehende Konfiguration gibt ein mögliches Beispiel für die Konsolenausgabe einer ``start.conf.20210426_focalfossa_base`` einer Hardwareklasse 20210426_focalfossa_base (hier als Linux-Client) wieder. Hierbei wird von einem Legacy-BIOS und Linux als Betriebssystem ausgegangen:

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


PC / VM als Rechner aufnehmen
-----------------------------

Nachdem du nun die Eintragungen für die Hardwareklasse vorgenommen hast, musst du noch den PC / die VM mit der MAC-Adresse via Web-UI als Gerät hinzufügen, dieses der erstellten Hardwareklasse hinzufügen und im Feld PXE den Eintrag auf die Synchronisation mit Linbo setzen. Das Vorgehen dazu wird nachstehend beschrieben.

Rechneraufnahme mit der Schulkonsole
====================================

Um einen Rechner mit der Schulkonsole aufzunehmen gehst du wie folgt vor: 

Wähle nach der Anmeldung links im Menü unter ``Geräteverwaltung --> Geräte``.

.. figure:: media/09-webui-menue-devices.png
   :align: center
   :alt: WebUI menue devices
 
Du siehst nun rechts im Hauptfenster die Eintragungen für die Geräte.

Als Spaltenköpfe siehst du u.a. den Raum, den Hostnamen, ..., PXE.

.. figure:: media/10-webui-devices-header.png
   :align: center
   :alt: WebUI devices column header

Die konfigurierten Geräte werden dir hier alle angezeigt. Nachstehend sind die bereits konfigurierten Server in der Liste mit der Rolle ``Server`` eingetragen.

.. figure:: media/11-webui-devices-rows.png
   :align: center
   :alt: WebUI devices indicated - examples

Um neue Geräte hinzuzufügen, klicke unten links auf den Eintrag ``Gerät hinzufügen``.

.. figure:: media/12-webui-add-new-device.png
   :align: center
   :alt: WebUI menue item add devices

Es wird eine neue Leerzeile hinzugefügt.

.. figure:: media/13-webui-new-device.png
   :align: center
   :alt: WebUI add devices

In die sich öffnende Zeile gibst du unter Raum den Namen des Raumes (hier ``server``) ein. Entsprechend verfährst du mit den Spalten Hostname, Gruppe, MAC, IP und Sophomorix-Rolle. Im Feld ``PXE`` wählst du aus, ob der Rechner beim Start mit Linbo synchronisiert werden soll.

Die Schaltfläche ``SPEICHERN`` überprüft die Eingabe. Mit ``SPEICHERN & IMPORTIEREN`` werden die neuen Geräte imporiert.

.. figure:: media/14-webui-save-and-add-devices.png
   :align: center
   :alt: WebUI add devices

Danach erscheinen einige Log-Meldungen und - wenn der Import erfolgreich war - ``Import abgeschlossen``

.. figure:: media/15-webui-add-devices-log.png
   :align: center
   :alt: WebUI add devices

Hinweise zur VM
---------------

.. attention::

   Die nachstehenden Hinweise sind nur in Ausnahmefällen bei Nutzung einer VM anzugeben. Durch diese Änderungen werden zudem Anpassungen in der Boot-Loader Konfiguration von Linbo für die Hardwareklasse nicht mehr bei einem ``linuxmuster-import-devices`` angewendet. 

Sollte der Muster-Client als VM aufgebaut werden, so ist je nach eingesetzter Virtualisierungssoftware darauf zu achten, dass die VGA-Einstellungen eine geringe Auflösung und eine geringe Farbteife aufweisen.

**VGA anpassen**

.. attention::

   Nachstehende Hinweise gelten nur für eine VM unter XCP-ng.

Unter XCP-ng 8.2 sind nachstehende Anpassungen erforderlich, da sonst während des Linbo Boot-Vorgangs ein Hinweis erscheint, dass die Farbtiefe nicht dargestellt werden kann. Rufe auf dem Server die Datei ``/srv/linbo/boot/grub/20210426_focalfossa_base.cfg`` auf.

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

Die Kommentarzeile ``# ### managed by linuxmuster.net ###`` muss entfernt werden, damit beim nächsten ``linuxmuster-import-devices`` diese CFG-Datei nicht überschrieben wird.

Gerät importieren
-----------------

Hast du alle Einstellungen für die Geräte bzw. erneute Änderungen hier vorgenommen, klickst du in der WebUI unter ``Geräteverwaltung --> Geräte`` erneut ``Speichern & Importieren``, damit diese Einstellungen angewendet werden.

Alternativ kann auf dem Server in der Konsole als Benutzer ``root`` der Befehl ``linuxmuster-import-devices`` angegeben werden.

PC / VM starten
---------------

Mit o.g. Einstellungen startest du nun den PC / die VM. Während des Boot-Vorgangs erhält der PC / die VM via PXE eine IP-Adresse und es wird Linbo geladen.

Der Boot-Vorgang sieht wie folgt aus:

.. figure:: media/16-linbo-start-screen.png
   :align: center
   :alt: Linbo start screen

Wurde in der start.conf kein ``Autostart`` gewählt, dann startet Linbo mit der Linbo-Webui in folgenden Start-Bildschirm:

.. figure:: media/17-linbo-webui-start-screen.png
   :align: center
   :alt: Linbo WebUI start screen

Klicke nun rechts auf das Icon für Einstellungen / Tools. Es erscheint ein neuer Bildschirm und du wirst aufgefordert das Kennwort für den Benutzer ``root`` anzugeben, um zu den weiteren Einstellungen zu gelangen.

.. figure:: media/18-linbo-webui-root-login.png
   :align: center
   :alt: Linbo WebUI root login

Gebe das Kennwort an. Die eingegebenen Ziffern werden hierbei nicht angezeigt. Klicke dann auf ``anmelden``.

Danach erscheint der Bildschirm für die Linbo - Einstellungen:

.. figure:: media/19-linbo-webui-settings.png
   :align: center
   :alt: Linbo WebUI settings

Klicke nun auf den Menüeintrag ``Festplatte partitionieren``. Es öffnet sich ein neues Fenster mit der Rückfrage, ob wirklich partitioniert werden soll.

.. figure:: media/20-linbo-webui-partitioning.png
   :align: center
   :alt: Linbo WebUI paritioning

Bestätige die Paritionierung und Formatierung mit: ``ja``

Fahre danach den PC / die VM über das Icon ``Herunterfahren`` (unten rechts) herunter.

Setze die Installation des Muster-Client je nach gewünschtem Betriebssystem für Linux oder Windows durch Auswahl einer der nachstehnden Links entsprechend fort.

+--------------------------------------------------------------------+-------------------------------------------+
| Installation von Linux-Clients                                     | |follow_me2linux-clients_a|               |
+--------------------------------------------------------------------+-------------------------------------------+
| Installation von Windows-Clients                                   | |follow_me2windows-clients_a|             |
+--------------------------------------------------------------------+-------------------------------------------+
