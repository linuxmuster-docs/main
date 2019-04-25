.. _configuration-after-installation-label:

=====================================
 Konfiguration nach der Installation
=====================================

.. sectionauthor:: `@MachDochNix <https://ask.linuxmuster.net/u/machdochnix>`_

(Frei nach der Anleitung von netzint)

Konfiguration IPFire
--------------------

Im XCP-ng Center wähle die Konsole des IPFire.

Gebe als Benutzername `root` ein und bestätige mit `Enter`.
Ebenso verfahre mit dem Passwort `muster`.

Anschließend gebe den Befehl `setup` ein und bestätige mit `Enter`.

.. figure:: media/01_ipfire-conf_console-setup.png
   :align: center
   :alt: Starten des IPFire-Setup auf der Konsole

Wähle `Networking` und bestätige mit `Enter`.

.. figure:: media/02_ipfire-conf_select-menu.png
   :align: center
   :alt: Netzwerk auswählen

Wähle `Drivers and card assigments` und bestätigen mit `Enter`.

.. figure:: media/03_ipfire-conf_network-configuration-menu.png
   :align: center
   :alt: Treiber und Netzwerkkarte zuweisen

Wähle `GREEN` und bestätige mit `Enter`.

.. figure:: media/04_ipfire-conf_assigned-cards.png
   :align: center
   :alt: Netzwerk dem "grünen"-Netzwerk zuweisen

Wähle die zugehörige Netzwerkkarte aus und bestätige mit `Enter`.

.. figure:: media/05_ipfire-conf_extended-networkmenu.png
   :align: center
   :alt: Auswählen der Netzwerkkarte

INFO: Du findest die Passende Netzwerkkarte anhand der MAC-Adresse heraus. Diese kannst du hier abgleichen:

.. figure:: media/06_ipfire-conf_xcp-ng-center-networking.png
   :align: center
   :alt: Kontrolle mittels XCP-ng-Center

In der Standardkonfiguration stimmt die Reihenfolge der NICs meist, es muss dann nur der Reihe nach ausgewählt werden.

Wiederhole den Vorgang für das Interface `RED` und `BLUE`. Wähle im Anschluss `Done` und bestätigen mit `Enter`.

.. figure:: media/07_ipfire-conf_assigned-cards.png
   :align: center
   :alt: Alle Netzwerkkarten zugewiesen

Bestätige deine Eingaben mit ``Done``.

.. figure:: media/08_ipfire-conf_network-configuration-menu.png
   :align: center
   :alt: Übernahme der Konfiguration mittles ``Done``

Wähle `'root' password` und bestätige mit `Enter`.

.. figure:: media/09_ipfire-conf_select-menu.png
   :align: center
   :alt: Wähle "root' password"

Gebe ein neues Passwort für den Account root ein und bestätigen mit `Ok`.

.. figure:: media/10_ipfire-conf_root-password.png
   :align: center
   :alt: Eingabe eines neuen Passwortes für root

Wiederhole den Vorgang für den Benutzer `admin`. Mit diesem Benutzer / Passwort meldest du dich später an der Weboberfläche der Firewall an.

Verlasse das Setup mit der Schaltfläche `Quit`.

.. figure:: media/11_ipfire-conf_select-menu.png
   :align: center
   :alt: Verlassen des Setup mittels "Quit"

Führe ggf. mit dem Befehl ``reboot`` einen Neustart durch.

Konfiguration Linuxmuster.net-Server
------------------------------------

Gebe als Benutzername `root` ein und als Passwort `muster`. Anschließend gebe den Befehl ``aptitude update && aptitude upgrade && aptitude dist-upgrade`` ein und bestätigen mit `Enter`.

.. figure:: media/12_lmn-server-conf_update.png
   :align: center
   :alt: Updates des Server auf der Konsole

INFO: Mit diesem Befehl aktualisierst du den Server auf den neusten Stand. Du musst ggf. mit der Eingabe `Y` das Update bestätigen.

Gebe den Befehl ``passwd`` ein um das root-passwort zu ändern.

.. figure:: media/13_lmn-server-conf_passwd.png
   :align: center
   :alt: Neues root-Passwort vergeben

Gebe den Befehl ``linuxmuster-setup`` --first ein und bestätige mit `Enter`.

.. figure:: media/14_lmn-server-conf_linuxmuster-setup-first.png
   :align: center
   :alt: Aufruf des linuxmuster-setup 

Überprüfe ob dir alle in der Meldung genannten Informationen vorliegen. Wenn dem so ist betätige die Schaltfläche `Ok`.

.. figure:: media/15_lmn-server-conf_installation-instructions.png
   :align: center
   :alt: Hinweise zur Installation

Gebe das Länderkürzel ein bzw. bestätigen "DE" mit `Enter`.

.. figure:: media/16_lmn-server-conf_country-code.png
   :align: center
   :alt:  Kürzel des Staats

Gebe hier dein Bundesland ein bzw. bestätige "BW" mit `Enter`.

.. figure:: media/17_lmn-server-conf_abbreviation-state.png
   :align: center
   :alt: Kürzel des Bundeslandes

Gebe den Schulstandort ein (Stadt).

.. figure:: media/18_lmn-server-conf_school-location.png
   :align: center
   :alt: Schulort

Gebe den Schulnamen Ihrer Schule an.

.. figure:: media/19_lmn-server-conf_school-name.png
   :align: center
   :alt: Schulnamen

Gebe den Domänennamen ein den du verwenden möchtest. Im Beispiel "SCHULE"

.. figure:: media/20_lmn-server-conf_domain-name.png
   :align: center
   :alt: Samba-Domäne

Geben den Servernamen ein. Es ist zu empfehlen den Server "server" zu nennen.

.. figure:: media/21_lmn-server-conf_server-name.png
   :align: center
   :alt: Servername

Gebe den Internetdomänennamen des Schulnetzes an den du verwenden möchtest.
Beispielsweise "schule.lokal"

.. figure:: media/22_lmn-server-conf_internet-domain-name.png
   :align: center
   :alt: Internet-Domänenname der Schule

Wählen den gewünschten IP-Adressbereich aus der verwendet werden soll.

.. figure:: media/23_lmn-server-conf_ip-address-range.png
   :align: center
   :alt: Interner IP-Adressbereich

Gebei den externen Domänennamen an auf dem der Server im Internet erreichbar ist.
Sofern keine externe Kommunikation vorgesehen ist kannst du das Feld auch leer lassen.

.. figure:: media/24_lmn-server-conf_fqdn.png
   :align: center
   :alt: Externer Name des Servers

Gebe an welche Firewall du verwendest. In der lmn-VM wird der ipfire verwendet.

.. figure:: media/25_lmn-server-conf_firewall-type.png
   :align: center
   :alt: Typ der Firewall

Trage für die Emailfunktion einen SMTP-Host ein mit dem der Server kommunizieren kann. Beispielsweise mbox1.belwue.de

.. figure:: media/26_lmn-server-conf_smtp-relay.png
   :align: center
   :alt: SMTP-Relay

Sofern du Subnetting nutzen möchtest, kannst du dies hier aktivieren.

.. figure:: media/27_lmn-server-conf_subnetting.png
   :align: center
   :alt: Subnetting

Wähle für die administrativen Domänenbenutzer ein Passwort.

.. figure:: media/28_lmn-server-conf_administrator_password.png
   :align: center
   :alt: Administrator-Passwort

Gebe das root-Passwort der Firewall ein, das du im Schritt "Konfiguration IPFire" vergeben haben.

.. figure:: media/29_lmn-server-conf_ipfire-root-password.png
   :align: center
   :alt: root-Password des IPFire

Wähle die Netzwerkkarte aus, die mit dem Schulnetz (GREEN) verbunden ist. Sofern du keine zusätzlichen Adapter installiert hast, bestätige die Auswahl mit `Enter`.

.. figure:: media/30_lmn-server-conf_assignment-nic.png
   :align: center
   :alt: Zuordnung der Netzwerkkarte

Installation Netzint-lmntoolbox
-------------------------------

Um das LVM auf der VM Server zu vergrößern steht in der Netzint lmn-toolbox ein Skript bereit. Dieses Tool wird später in der Anleitung verwendet, daher sollte die Toolbox installiert werden.

Es gibt aber auch weitere nützliche Tools um beispielsweise den LDAP zu editieren, Linbo anzupassen, unifi zu steuern, oder das Netzint-Multitool.


.. figure:: media/31_ni-multitool_screen.png
   :align: center
   :alt: multitool der Firma netzint

Erstelle und bearbeite eine Repository-Liste in dem du folgenden Befehl auf dem Server eingibst: ``nano /etc/apt/sources.list.d/netzint.list``

.. figure:: media/32_ni-multitool_source-list.png
   :align: center
   :alt: Erstellen netzint-Source-List

Schreibe in die Datei folgende Zeile: ``deb http://pkg.netzint.de/ precise main``

.. figure:: media/33_ni-multitool_edit-source-list.png
   :align: center
   :alt: Bearbeiten der netzint-Source-List

Verlasse den Editor in dem du `Strg` + `x` drückst. Du wirst gefragt, ob du die Änderungen speichern willst. Drücke `Y` und bestätigen den Speicherort/Dateinamen mit `Enter`.

Schreibe folgende Befehle in die Konsole und bestätige sie jeweils mit `Enter`:

.. code-block:: console

   wget http://pkg.netzint.de/netzint.pub.key
   apt-key add netzint.pub.key

.. figure:: media/34_ni-multitool_add-netzint-key.png
   :align: center
   :alt: Installieren des netzint-Public-Key

Schreibe den Befehl ``apt-get update`` in die Konsole und drücken `Enter`.

.. figure:: media/35_ni-multitool_update-package-list.png
   :align: center
   :alt: Aktualisieren der Paketliste

Schreibe den Befehl ``apt-get install netzint-lmntoolbox`` in die Konsole und drücken `Enter`.
Bestätige die Abfrage mit `Y`.

.. figure:: media/36_ni-multitool_install-lmntoolbox.png
   :align: center
   :alt: Installieren der netzint-lmn-Toolbox

Erstelle die Grundkonfigurationsdateien mit dem Befehl: ``/usr/share/netzint/tools/createdefaults.sh``

.. figure:: media/37_ni-multitool_create-basic-conf.png
   :align: center
   :alt: Erstellung der Grundkonfigurationsdateien

Mit dem Befehl ``nano /usr/share/netzint/etc/main.cfg`` kannst du die Grundeinstellungen für einige Tools bearbeiten.

.. figure:: media/38_ni-multitool_edit-main-cfg.png
   :align: center
   :alt: Grundeinstellungen bearbeiten

Anpassen der Systemressourcen
-----------------------------

CPU und Arbeitsspeicher
_______________________

Klicke mit der rechten Maustaste auf den lmn-Server und wähle `Herunterfahren`.
Wechsel auf den Reiter `General` und klicke auf `Properties`.

.. figure:: media/39_xcp-ng_properties.png
   :align: center
   :alt: Einstellen der Eingenschaften der Server
   
Wähle auf der linken Seite `CPU` und trage die gewünschte Anzahl virtueller Kerne ein und bestätige die Einstellung mit `Ok`.

.. figure:: media/40_xcp-ng_cpu.png
   :align: center
   :alt: Anzahl der Prozessorenkerne

Wechsel auf den Reiter `Memory` und klicke auf die Schaltfläche `Edit...`.

.. figure:: media/41_xcp-ng_memory.png
   :align: center
   :alt: Arbeitsspeicher

Trage die gewünschte Größe des Arbeitsspeichers ein und bestätige die Einstellung mit `Ok`.

.. figure:: media/42_xcp-ng_desired-size-ram.png
   :align: center
   :alt: Gewünschte Größe des Arbeitsspeicher

Wiederhole die Schritte für die Anpassung für CPU und Memory für die anderen Virtuellen Maschinen in deinem Pool.

Größe der virtuellen Festplatten
________________________________

Wähle aus der Bestandsliste links den Server und wechsele auf den Reiter `Storage`.
Doppelklicke die Festplatte `..._home` bzw. wählen diese aus und klicke auf `Properties`.

.. figure:: media/43_xcp-ng_storage.png
   :align: center
   :alt: Festplattengröße

Trage im Feld `Size` die gewünschte Festplattengröße ein und bestätige die Eingabe mit `Ok`.

.. figure:: media/44_xcp-ng_desired-hard-disk-size.png
   :align: center
   :alt: Gewünschte Größe der Festplatten

Info: Hier werden später die Homeverzeichnisse der Schüler und Lehrer sowie die Tauschverzeichnisse abgelegt.

Wiederhole den Schritt mit der Festplatte `..._var`. Hier werden später die Images der Schulnetzrechner abgelegt.

Wechsel auf dem XCP-ng Server auf die Konsole mit dem Benutzer root.

.. figure:: media/45_xcp-ng_host-console-login.png
   :align: center
   :alt: XCP-ng Host Konsolen Login

Gebe den Befehl ``xe vm-disk-list vm=lmn62.server`` ein und bestätige mit `Enter`.

.. figure:: media/46_xcp-ng_listing-disks.png
   :align: center
   :alt: Auflisten der Festplatten

INFO: Mit der Taste "TAB" kannst du die Autovervollständigung nutzen. Sobald du die ersten Buchstaben eines Befehls oder des Namens der VM eingegeben hast, wird durch TAB der Befehl bzw. der Name vervollständigt.

Es werden dir nun alle Virtuellen Festplatten der Servers "lmn62.server" aufgelistet. Du musst in der Ausgabe die Virtual Disk (VDI) suchen deren name-label mit "..._var" endet.

Notiere die ersten Zeichen der UUID.

.. figure:: media/47_xcp-ng_uuids.png
   :align: center
   :alt: Auflistung der Festplatten-IDs

Gebe den Befehl ``xe vdi-resize uuid=<UUID> disk-size=XXXGiB`` ein und bestätigen mit `Enter`.

.. figure:: media/48_xcp-ng_resize-hard-disk.png
   :align: center
   :alt: Vergrößern der Festplatte

INFO: Nutze die Autovervollständigung! Gebe bei der UUID die ersten Zeichen ein und drücken dann "TAB" um die UUID einzutragen.

Wiederhole den Vorgang für die VDI "..._home".

Starte nun die VM mit dem Befehl ``xe vm-start vm=lmn62.server``.

.. figure:: media/49_xcp-ng_start-server.png
   :align: center
   :alt: Starte den Server

Expandieren der LVMs auf dem Server
___________________________________

Trage in der Konsole des Servers folgende Befehle nacheinander ein und bestätige jeweils mit `Enter`:

.. code-block:: console

   /usr/share/netzint/tools/resize.sh --home
   /usr/share/netzint/tools/resize.sh --var

.. figure:: media/50_lmn-server_resize-lvm.png
   :align: center
   :alt: Expandieren der Festplatten auf dem Server

Mit dem Befehl ``df –lh`` kannst du nun die Speichergröße überprüfen:

.. figure:: media/51_lmn-server_check-disk-size.png
   :align: center
   :alt: Überprüfen der Festplattengröße

Es bieten sich an, auch die Festplatte für den IPFire zu vergrößern. Im Prinzig das gleiche Vorgehen wie auch beim lmn-Server. Allerdings stehen dir auf dem IPFire nicht die netzint-multitools zur Verfügung.

1. Vergrößern der Festplatte wie oben beschrieben im XCP-ng Center.
2. Auf der Konsole des IPFire im XCP-ng Center anmelden.
3. Wechsel in den Runlevel 1 (Single User Mode) mit ``init 1``
4. Filesystem erweitern mit ``resize2fs /dev/xdc``
5. Kontrolle mit ``df -h``
6. Neustart ``reboot`` 

Abschluss der Grundinstallation
-------------------------------

Deine Umgebung ist nun für den regulären Einsatz von linuxmuster.net vorbereitet.

Für die meisten Aufgaben der Administration kannst du nun die Schulkonsole verwenden.
Diese öffnest du im Schulnetz mit einem Webbrowser unter https://server:242

Beachte, dass du die Schulkonsole sowie den Server (via ssh) nur von Rechnern aus nutzen kannst, die dem System bekannt sind.

Siehe dazu das Unterkapitel "Computer im Netzwerk aufnehmen" im nächste Kapitel "Linux Clients".
