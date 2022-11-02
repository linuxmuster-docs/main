.. include:: ../../guided-inst.subst

.. _basis_opnsense:

=====================================
Anlegen und Installieren der Firewall
=====================================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

.. note:: 

   Bist Du zuvor der Anleitung "Proxmox vorbereiten" gefolgt, dann kannst Du fortfahren mit `Erster Start der Firewall`_

Installation der OPNsense |reg|
===============================

Lade Dir die ISO-Datei der OPNsense |reg| von der Seite https://opnsense.org/download/ herunter.

.. hint::

   Die zuletzt freigegeben OPNsense Version für das Setup von linuxmuster.net v7.1 ist die Version 22.1. 
   https://mirror.informatik.hs-fulda.de/opnsense/releases/mirror/OPNsense-22.1-OpenSSL-dvd-amd64.iso.bz2

Nutze als Architektur ``amd64`` und als "image type" ``dvd`` und einen Mirror, der in Deiner Nähe ist.
Du erhältst dann ein mit bz2 komprimiertes ISO-Image. Entpacke die heruntergeladene Datei.

Unter Windows kannst Du dies z.B. mit 7-ZIP durchführen.

Unter Linux gibst Du auf der Eingabekonsole folgenden Befehl an, der Dir die Datei im gleichen Ordner entpackt:

.. code::

   tar -xjf <opnsense-dateiname>.iso.bz2
   tar -xjf OPNsense-22.1-OpenSSL-dvd-amd64.iso.bz2

   Alternativ:

   bunzip OPNsense-22.1-OpenSSL-dvd-amd64.iso.bz2


Brenne die entpackte ISO-Datei auf eine DVD oder fertige davon einen bootbaren USB-Stick an. In einer Virtualisierungsumgebung lädst Du die ISO-Datei auf den ISP-Speicher.

.. hint:: 

   Willst Du in einer VM installieren, so musst Du für die neue VM folgende Mindesteinstellungen angeben:
   
   - template - other install media, installation from ISO library,
   - Boot-Mode - UEFI (Achtung: xcp-ng: Boot/MBR),
   - 1 vCPU
   - 2 GiB RAM
   - storage 10 GiB
   - 2 NIC mit Zuordnung zu vSwitch red, green.
   
   Achtung, unter XCP-ng bricht die Installation mit o.g. Einstellungen beim Punkt ``guided installation`` ab,
   wenn UEFI als Boot-Mode angegeben wurde. Es ist als Boot-Mode in der VM Boot/MBR auszuwählen. Bei der weiteren Installation 
   kann dann hingegen GPT/UEFI mode angegeben werden.
   
   Vgl. hierzu auch: https://xcp-ng.org/docs/guides.html#pfsense-opnsense-vm

Erster Start der Firewall
=========================

Starte dann OPNsense |reg| auf dem Rechner oder in der neu angelegten VM von Deinem Installationsmedium. Je nach Virtualisierungsumgebung hast Du ggf. die ISO-Datei bereits auf den ISO-Datenspeicher des Hypervisors abgelegt. Boote dann die VM hierüber.

.. attention:: Solltest Du unserer Anleitung gefolgt sein und PROXMOX nutzen, dann muss Du für die Installation die Konsole ``noVNC`` nutzen.

Am Ende des Boot-Vorgangs der OPNsense |reg| gelangst Du zu folgendem Bildschirm:

.. figure:: media/basis_opnsense_001.png
   :align: center
   :alt: OPNsense: First boot

Melde Dich als Benutzer ``installer`` mit dem Passwort ``opnsense`` an.

Du gelangst direkt zum Installer und kannst das Layout der Tastatur festlegen.

.. figure:: media/basis_opnsense_002.png
   :align: center
   :alt: OPNsense: Installer keymap

Standardmäßig ist ein amerikanisches Tastaturlayout voreingestellt.
Gehe mit den Pfeiltasten auf den Eintrag ``( ) German (no accent keys)``. Wählen diesen mit ``<Select>`` aus.

Teste danach das Tastaturlayout:

.. figure:: media/basis_opnsense_003.png
   :align: center
   :alt: OPNsense: Test keymap

Bei der deutschen Tastatur werden die Umlaute im Test noch nicht korrekt wiedergegeben.

Wähle trotzdem die eingestellte deutsche Tastatur aus:

.. figure:: media/basis_opnsense_004.png
   :align: center
   :alt: OPNsense: continue with keymap

Wähle ``<Select>``.

Installiere nun OPNsense |reg| via ``Install (UFS)``.

.. figure:: media/basis_opnsense_005.png
   :align: center
   :alt: OPNsense: Install (UFS)

Bestätige die Festplatte und wähle ``Install (UFS) UFS GPT/UEFI Hybrid``. 

Jetzt wird OPNsense |reg| auf der Festplatte installiert. Zuvor musst Du diese noch auswählen.

.. figure:: media/basis_opnsense_006.png
   :align: center
   :alt: OPNsense: UFS Configuration

Mit ``OK`` übernimmst Du Deine Auswahl.

.. figure:: media/basis_opnsense_007a.png
   :align: center
   :alt: OPNsense: Swap file

Sollte Dir dieses Fenster angezeigt werden, dann akzeptiere die Frage nach der empfohlenen Auslagerungsdatei.

Danach erfolgt die Rückfrage, ob die Festplatte wirklich überschrieben werden soll.

.. figure:: media/basis_opnsense_007.png
   :align: center
   :alt: OPNsense: Last change to abort vs. start installation
   
Bestätige diesen Vorgang, um die Installation zu starten.

Warte jetzt, bis die Installation abgeschlossen ist.

.. figure:: media/basis_opnsense_008.png
   :align: center
   :alt: OPNsense: Installation progress

Zum Abschluss der Konfiguration musst Du das Kennwort für den Benutzer ``root`` neu setzen.

.. figure:: media/basis_opnsense_009.png
   :align: center
   :alt: OPNsense: Root Password

.. attention:: 
   
   An dieser Stelle muss als root-Passwort ``Muster!`` eingegeben werden, da später der lmn-Server beim Einrichten der Firewall davon ausgeht, dass das root-Passwort ``Muster!`` ist! Sollte dieses anders lauten, wird die komplette weitere Installation scheitern!

Gib das neue Passwort für root ein.

.. figure:: media/basis_opnsense_010.png
   :align: center
   :alt: OPNsense: Type new root password

Gib dieses Kennwort erneut ein.

.. figure:: media/basis_opnsense_011.png
   :align: center
   :alt: OPNsense: Retype new root password

Setze es mit ``OK``

.. figure:: media/basis_opnsense_012.png
   :align: center
   :alt: OPNsense: Type new root password

Wähle danach die Option ``Exit and reboot`` aus.

.. hint::

   Solltest Du nicht zum Entfernen, das Installationsmedium aufgefordert werden, fahre Deine neue Firewall herunter (schalte sie aus). Ansonsten gerätst Du eventuell in eine erneute Installation. Starte sie neu, nachdem Du das Installationsmedium ausgeworfen hast und fahre mit der Installation fort.

Der Boot-Vorgang kann dann eine Weile dauern. Vor allem, wenn der Router kein DHCP anbieten sollte.

Wenn alles geklappt hat, ist Folgendes zu sehen:

.. figure:: media/basis_opnsense_013.png
   :align: center
   :alt: OPNsense: Final Configuration

.. hint::

   Die dargestellte IPs und Netze können bei Deiner OPNsense |reg| andere sein.

Basis-Konfiguration der OPNsense |reg|
======================================

Melde Dich als ``root`` mit dem Passwort ``Muster!`` an der OPNsense |reg| an.

#####

Tastaturbelegung
----------------

.. figure:: media/basis_opnsense_014.png
   :align: center
   :alt: OPNsense: Final Configuration

Zuerst überprüfe, ob die Tastaturbelegung richtig ist. Dazu wähle den Punkt ``8) Shell`` aus. Auf der Konsole kannst Du dann die Umlaute und Sonderzeichen der deutschen Tastaturbelegung testen. Sollte sie korrekt sein, verlässt Du mit ``exit`` die Konsole und bist wieder im Auswahl-Bildschirm. Fahre mit `Überprüfung der Zuordnung der Netzwerkkarten`_ fort, ansonsten |...|

.. hint::

   Solltest Du feststellen, dass nach dem Neustart in der Konsole der OPNsense |reg| die Tastaturbelegung immer noch falsch ist, stelle diese dauerhaft wie nachstehend beschrieben um:

   .. code::

     cd /usr/share/syscons/keymaps    # Für den Buchstaben "z" musst Du die Taste "y" drücken ;-)

     ls german.iso.kbd                # listet das deutsche Tastaturlayout auf, sofern vorhanden
    
     kbdcontrol -l german.iso.kbd     # (-l = Language; "-" zu finden unter "?" ;-) stelle temporär auf das neue Layout um
                                      # - teste, ob es dem gewünschten Layout entspricht
     
     echo "keymap='de'">>/etc/rc.conf # die Wahl des Tastaturlayouts dauerhaft hinzufügen  
     
     cat /etc/rc.conf                 # kontrolliere, ob der Eintrag vorhanden ist

     exit                             # Konsole verlassen

#####

Überprüfung der Zuordnung der Netzwerkkarten
--------------------------------------------

.. figure:: media/basis_opnsense_013.png
   :align: center
   :alt: OPNsense: Final Configuration

Die erste Netzwerkkarte (LAN) ist mit dem pädagogischen Netz verbunden. Allerdings noch mit den falschen Netzwerkeinstellungen, da die Installationsroutine der OPNsense |reg| immer die IP 192.168.1.1/24 zuweist. Diese gilt es noch zu ändern.

Die zweite Netzwerkkarte (WAN) ist mit dem Router verbunden. Die IP hängt davon ab, welche IPs via DHCP von Deinem DSL_Router verteilt werden.

In einer Schulumgebung kann es sein, dass der Router keinen DHCP-Service anbieten. In diesem Fall musst Du dafür sorgen, dass sich sowohl das Interface (WAN) der OPNsense |reg| als auch der Router im gleichen Netzwerk befinden. 

Hier in unserem Beispiel hat die Zuordnung der Netzwerkkarten nicht geklappt, der Router sollte 192.168.21.212 der OPNsense |reg| zuweisen.

Sollte bei dem WAN Interface keine, eine IP-Adresse nach dem Muster 0.0.0.0/8 oder eine andere als die von Dir erwartete erscheinen, dann muss die Zuordnung der Netzwerkkarte überprüft werden. Hier beispielhaft anhand unserer Proxmox-Umgebung.

#####

Anpassung der Zuordnung der Netzwerkkarten
------------------------------------------

Rufe dazu den Menüeintrag ``1) Assign interfaces`` auf. Die Nachfragen bezüglich LAGGs und VLAN verneinst du.

.. figure:: media/basis_opnsense_015.png
   :align: center
   :alt: OPNsense: GUI - LAGGs an VLANs no 

Dann gilt es die MAC-Adressen zwischen denen der virtuellen Maschine, hier vtnet0 und vtnet1

.. figure:: media/basis_opnsense_016.png
   :align: center
   :alt: OPNsense: GUI - Valid Interfaces 

und denen der Netzwerkbrücken vmbr0 und vmbr1 zu überprüfen: 

.. figure:: media/basis_opnsense_017.png
   :align: center
   :alt: Proxmox: GUI -s Network Devices 

``hv01`` --> ``VM100`` --> ``Hardware`` --> ``Network Device (net.)`` 

Unter ``hv01`` unter ``Network`` kannst Du Dir jetzt mittels des Kommentarfeldes wieder die Zuordnung ins Gedächtnis rufen.

=========  ======  =================  ===  ==================  ==========  ===
Bridge des Visualisierers             <->  Virtuelle Maschine
------------------------------------  ---  -----------------------------------
Kommentar  Brücke  MAC                     MAC                 Interfaces  Typ
=========  ======  =================  ===  ==================  ==========  ===
red        vmbr0   0E:76:8B:51:85:15  <->  0e:76:8b:51:85:15   vtnet0      WAN
green      vmbr1   DA:97:1B:E1:35:9C  <->  da:97:1b:E1:35:9c   vtnet1      LAN
=========  ======  =================  ===  ==================  ==========  ===

Aus diesem Wissen und dem Vergleich erkennst Du |...|

.. figure:: media/basis_opnsense_018.png
   :align: center
   :alt: OPNsense: GUI - WAN connect to vtnet0 

|...| das WAN zum Interface vtnet0 zugeordnet gehört.

.. figure:: media/basis_opnsense_019.png
   :align: center
   :alt: OPNsense: GUI - 

|...| das LAN zum Interface vtnet1 gehört.

.. figure:: media/basis_opnsense_020.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces 

Hast Du kein weiteres Interface, dann ``Enter``

.. figure:: media/basis_opnsense_021.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces 

Diese Zuordnung ist nun richtig, also weiter mit ``y`` |...|

.. figure:: media/basis_opnsense_022.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces 

|...| welches dann die Konfiguration startet.

.. figure:: media/basis_opnsense_023.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces 

Die Zuordnung des WAN-Interfaces ist nun richtig. Das erkennst Du daran, das dessen IP-Adresse dem Adress-Pool des Routers entnommen ist.

#####

WAN Zugang testen
^^^^^^^^^^^^^^^^^

Um zwei erste Tests durchzuführen, wechsel mit ``8) Shell`` auf die Kommandozeile und gib dort folgende Befehle ein.

.. hint:: 

   Sollte einer der Tests scheitern, dann verlasse die Konsole mittels ``exit`` und nutze den Auswahlpunkt ``11) reload all Services``.

.. code::

   ping -c 3 8.8.8.8

Die Ausgabe sollte wie folgt aussehen:

.. figure:: media/basis_opnsense_024.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces 

.. code::

   ping -c 3 linuxmuster.net

.. figure:: media/basis_opnsense_025.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces 

``exit`` um wieder zum Dashboard zurückzukommen.

.. figure:: media/basis_opnsense_023.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces 

.. hint:: 

   Sollte einer der Test auch nach ``11) Reload all services`` nicht erfolgreich verlaufen, dann stimmt etwas mit der Netzwerkkartenzuordnung nicht. Überprüfe Deine vorherige Netzwerk-Konfiguration auf Fehler.

#####

IP-Adressen zuweisen
--------------------

Solltest Du in Deiner Netzwerkkonfiguration von unserem Muster abweichen, musst Du bei nachfolgenden Schritten Deiner Festlegung folgen.

.. figure:: media/basis_opnsense_026.png
   :align: center
   :alt: OPNsense: GUI - Set interfaces IP address 

Wähle an der Konsole der OPNsense |reg| den Eintrag ``2) Set interface IP address`` aus.

.. figure:: media/basis_opnsense_027.png
   :align: center
   :alt: OPNsense: GUI - LAN auswählen

Wähle ``1 - LAN (`` |...| ``)`` für die nächsten Schritte.

.. figure:: media/basis_opnsense_028.png
   :align: center
   :alt: OPNsense: GUI - Nicht via DHCP zuweisen lassen

Bestätige die Nachfrage mit ``N`` und ``ENTER``. (Alternativ wäre auch nur ``ENTER`` möglich, da der großgeschriebene Buchstabe in der Auswahlmöglichkeit darauf hinweist, was die Standard-Einstellung ist.)

 .. figure:: media/basis_opnsense_029.png
   :align: center
   :alt: OPNsense: GUI - Eingabe der IP

Gib die IPv4 Adresse ``10.0.0.254`` ein, unter der die OPNsense |reg| im lokalen Netz zu erreichen sein wird.

.. figure:: media/basis_opnsense_030.png
   :align: center
   :alt: OPNsense: GUI - Eingabe der Netzwerkmaske in CIDR

Gib ``16`` für die Netzwerkmaske ein

.. figure:: media/basis_opnsense_031.png
   :align: center
   :alt: OPNsense: GUI - Keine Eingabe nötig, also Enter

Da keine Eingabe eines Upstream-Gateways nötig ist, einfach ``ENTER``

.. figure:: media/basis_opnsense_032.png
   :align: center
   :alt: OPNsense: GUI - keine IPv6 via WAN tracking nötig

.. attention:: Gib ein ``n`` ein.

.. figure:: media/basis_opnsense_033.png
   :align: center
   :alt: OPNsense: GUI - keine IPv6 Adresse via DHCP6 

Gib ein ``N`` ein.

.. figure:: media/basis_opnsense_034.png
   :align: center
   :alt: OPNsense: GUI - keine manuelle IPv6 

Da keine IPv6-Adresse benötigt wird: ``ENTER``

.. figure:: media/basis_opnsense_035.png
   :align: center
   :alt: OPNsense: GUI - keine Aktivierung eines DHCP-Servers auf LAN

Diese und die nächsten drei Fragen ebenfalls jeweils ``N`` und ``ENTER`` bzw. nur ``ENTER`` beantworten. 

.. figure:: media/basis_opnsense_036.png
   :align: center
   :alt: OPNsense: GUI - ändern von Protokolls von https auf http verneinen

.. figure:: media/basis_opnsense_037.png
   :align: center
   :alt: OPNsense: GUI - Erstellung eines neuen Zertifikates für die GUI verneinen

.. figure:: media/basis_opnsense_038.png
   :align: center
   :alt: OPNsense: GUI - Wiederherstellung der GUI Zutrittsberechtigungen

Nach der letzten Eingabe startet die Übernahme in das System.

.. figure:: media/basis_opnsense_039.png
   :align: center
   :alt: OPNsense: GUI IP

Nach erfolgreicher Übernahme erhältst Du den Hinweis, dass Du Dich mit der LAN IP auf die GUI der OPNsense |reg| aufschalten könntest.

.. figure:: media/basis_opnsense_040.png
   :align: center
   :alt: OPNsense: GUI IP

Bevor Du das aber machst, erfolgt ein letzter Test:

#####

Aktualisierung der OPNsense |reg|
---------------------------------

Aktualisiere die OPNsense |reg| in der Konsole, indem Du den Punkt ``12) Update from console`` aufrufst und die Rückfrage mit ``y`` bestätigst.

.. hint:: 

   Sollte hierbei keine Verbindung zu den externen Update-Servern möglich sein, dann stimmt etwas mit der Netzwerkkartenzuordnung nicht.

   Als Erstes probiere es mit dem Neustart aller Netzwerk-Dienste. Dazu wählst Du den Punkt ``11) Reload all services``. Danach wiederholst Du das Upgrade nochmals mit dem Punkt ``12) Update from console``.

   Sollte die Aktualisierung immer noch nicht erfolgreich durchgeführt werden, dann überprüfe Deine vorherige Netzwerk-Konfiguration auf Fehler.

Klappt das Update, startet die OPNsense |reg| neu.

.. figure:: media/basis_opnsense_023.png
   :align: center
   :alt: OPNsense: GUI - Assign interfaces


Konfiguration der OPNsense |reg|
================================

Für die nachfolgende Konfiguration der OPNsense |reg| brauchst Du einen Rechner mit Webbrowser im LAN-Bereich der OPNsense |reg|. Das kann ein Laptop mit einem beliebigen Betriebssystem sein. Wichtig ist nur, dass er mit dem LAN-Adapter der OPNsense |reg| verbunden ist und sich im gleichen Netzwerk wie die OPNsense |reg| befindet. In unserer Beschreibung gehen wir davon aus, dass seine manuell zugewiesene IP-Adresse 10.0.0.10 ist.

Nachdem der Browser gestartet ist, gib folgende URL für den Zugriff auf die GUI der OPNsense |reg| ein:

``https://10.0.0.254``

Du erhältst zunächst eine Zertifikatswarnung, da OPNsense |reg| ja ganz frisch installiert ist und ein selbst erstelltes Zertifikat nutzt. 

.. figure:: media/basis_opnsense_041.png

``Erweitert`` und anschließend ``Risiko akzeptieren und fortfahren`` bringt Dich auf die Log-in-Seite.

.. figure:: media/basis_opnsense_042-01.png

Melde Dich mit ``root`` und dem Passwort ``Muster!`` an. Beim ersten Start erhältst folgende Information:

.. figure:: media/basis_opnsense_042-02.png

Gefolgt von folgender Aufforderung:

.. figure:: media/basis_opnsense_042-03.png

Starte den General Setup Wizard mit dem ``Next``-Knopf. "Er" wird Dich durch die Konfiguration führen, wobei schon einiges richtig durch die zuvor erfolgte Basis-Konfiguration eingerichtet wurde.  

#####

System: Assistent: Allgemeine Information
-----------------------------------------

.. attention::

   Die Länge des ersten Teils der Domäne darf maximal 15 Zeichen betragen. Die Domäne "muster-gymnasium.de" überschreitet diese Grenze um ein Zeichen, da "muster-gymnasium" 16 Zeichen lang ist.

   Eine gute Wahl ist beispielsweise ``linuxmuster.lan``. Beim späteren Setup von linuxmuster.net wird diese ggf. für alle Server-Dienste angepasst.

.. figure:: media/basis_opnsense_043.png

Gib als ``Primary DNS``, die neue IP des Upstream Gateway der externen WAN-Schnittstelle an und deaktiviere die Checkbox ``Override DNS``.

Weiter geht es mit ``Next``

#####

System: Assistent: Zeitserverinformation
-----------------------------------------

.. figure:: media/basis_opnsense_044.png

Die Angaben zum Time Server übernimmst Du mit ``Next``.

#####

System: Assistent: Konfiguriere WAN-Schnittstelle
-------------------------------------------------

Danach kommst Du zu den Einstellungen für die WAN-Schnittstelle.
Nutzt Du hier DHCP z.B. eines vorgelagerten DSL-Routers, so gibst Du hier DHCP an, ansonsten ändere diese bitte auf ``Static``.

.. figure:: media/basis_opnsense_045.png

Falls Deine Firewall eine statische IP-Adresse hat, die nicht über DHCP erteilt wird, trägst Du sie hier ein.

.. figure:: media/basis_opnsense_046.png

Falls Dein Router eine private IP hat, musst Du den Haken bei ``Private RFC1918-Netzwerke blockieren`` entfernen. Diesen Eintrag findest Du ganz unten auf der Seite, nachdem Du runtergescrollt hast.

Mit ``Weiter`` übernimmst Du die von Dir gemachten Einstellungen

#####

System: Assistent: Konfiguriere LAN-Schnittstelle
-------------------------------------------------

.. figure:: media/basis_opnsense_047.png

Die IP-Adresse und die Subnetzmaske des Schulnetzes sollte hier eingetragen sein. Sollte dies nicht der Fall sein, ändere das nun.

#####

System: Assistent: Setze Root-Passwort 
--------------------------------------

.. figure:: media/basis_opnsense_048.png

.. hint:: 

   An dieser Stelle muss als root-Passwort ``Muster!`` eingegeben werden, da später der lmn-Server beim Einrichten der Firewall davon ausgeht, dass das root-Passwort ``Muster!`` ist!

#####

System: Assistent: Konfiguration neu laden
------------------------------------------

.. figure:: media/basis_opnsense_049.png

Nachdem Du die Einstellungen übernommen hast, können sich auch die Einstellungen des LAN-Netzwerks geändert haben. Dann wirst Du nicht wie im nächsten Bild zu sehen über die erfolgreiche Konfiguration informiert.

.. figure:: media/basis_opnsense_050.png

Sollte das bei Dir der Fall sein, musst Du Deinem Admin PC die passende IP-Adresse 10.0.0.10/16, DNS: 10.0.0.254und das Gateway: 10.0.0.254 manuell geben. (hier exemplarisch für unseren Standard-LAN-Bereich)

Gehe dann mit einem Webbrowser auf ``https://10.0.0.254``.

.. hint:: 

   Falls Du Dich für das Netz der linuxmuster.net v6.2 entschieden hast, solltest Du die IP-Adresse 10.16.0.10/12, DNS: 10.16.1.254 und das Gateway 10.16.1.254 verwenden.
  
   Du solltest dann auch mit einem Webbrowser auf https://10.16.1.254 gehen.

Du erhältst eventuell wieder eine Zertifikatswarnung. Akzeptiere diese und fahre fort.

Melde Dich wieder mit ``root`` und dem Passwort ``Muster!`` an.

#####

DHCP abschalten
---------------
Jetzt musst Du den DHCP-Service der Firewall abschalten. Der wird ja später vom Server übernommen. 

.. figure:: media/basis_opnsense_051.png

Gehe auf ``Dienste -> DHCPv4 -> [LAN]`` und lösche den Haken bei ``Aktivieren``, wenn gesetzt. ``Speichern`` lässt Dich Deine Einstellungen unten auf der Seite.

#####

Zusätzliche Netzwerkkarte hinzufügen (Optional)
-----------------------------------------------

Die linuxmuster.net v7 läuft bereits mit zwei Netzwerkkarten. Möchtest Du allerdings ein WLAN oder in einer DMZ einen Webserver betreiben, brauchst Du noch weitere Netzwerkkarten.

Wie das geht, siehst Du im Folgenden:

.. figure:: media/basis_opnsense_052.png

Bei ``Schnittstellen -> Zuweisungen`` drückst Du ``+``, um die dritte Schnittstelle Deinem System hinzuzufügen. Diese dritte Schnittstelle ist dann als ``OPT1`` im System bekannt. OPT1 muss nur noch aktiviert und es muss ihr noch eine IP-Adresse zugewiesen werden. 

.. figure:: media/basis_opnsense_053.png

Unter ``Schnittstellen -> [OPT1]`` kannst Du diese Einstellungen vornehmen. Der Screenshot zeigt ein Beispiel. Für weitere Netzwerkkarten verfährst Du entsprechend. OPT1 wird dann hochgezählt zu OPT2 etc.

#####

ssh erlauben
------------

.. attention:: Damit der Server für das weitere Setup Zugriff auf die OPNsense |reg| hat, musst Du den ssh-Zugriff erlauben. Gehe dafür auf ``System -> Einstellungen -> Verwaltung``.

.. figure:: media/basis_opnsense_054.png

Setze jeweils den Haken bei ``Aktiviere Secure Shell``, ``Erlaube Anmeldung mit dem root-Benutzer`` und ``Anmeldung mit Passwort erlauben``.

Bei dem Punkt ``Sekundäre Konsole`` wähle die Serial-Konsole aus. Mit dieser Auswahl wird die Nutzbarmachung der xterm.js-Konsole innerhalb von Proxmox abgeschlossen. (Zur Erinnerung: :ref:`xterm-label`)

Diese Einstellungen wieder ``Speichern``.

#####

Update der OPNsense |reg|
-------------------------

Aktualisiere nun die OPNsense |reg|, indem Du unter 

.. figure:: media/basis_opnsense_055.png

``System`` ``->`` ``Firmware`` ``-->`` ``Aktualisierungen`` ``--->`` ``Status`` ``----> `` ``Auf Aktualisierungen prüfen`` klickst.

Wenn keine Aktualisierungen verfügbar sind, erhältst Du folgende Meldung |...|

.. figure:: media/basis_opnsense_056.png


|...| und kannst zum abschließenden Schritt `Logout`_ gehen.

Sollten Dir wie in nachstehender Abbildung unter dem Reiter ``Aktualisierungen`` zu aktualisierenden Pakete angezeigt werden |...|

.. figure:: media/basis_opnsense_057.png

.. hint::

   Falls Du nicht ins Internet kommst, kann es an der Gateway-Einstellung liegen. Gehe auf ``System`` --> ``Gateways`` --> ``Einzeln`` und editiere Dein Gateway (WANGW).

   Setze einen Haken bei ``Deaktiviere Gatewayüberwachung``, speichere die Einstellung und übernimm die Änderung. Jetzt ist Dein Gateway online und Du kommst ins Internet. Erstaunlicherweise kannst Du die Gatewayüberwachung wieder aktivieren, ohne dass das Gateway offline geht.

|...| dann klicke in o.g. Fenster ``Jetzt aktualisieren``. 

Je nach gefundenen Aktualisierungen, kann ein Neustart erforderlich sein. Dies wird vor dem Update abgefragt und ist zu bestätigen.

.. figure:: media/basis_opnsense_058.png

Danach werden die Aktualisierungen heruntergeladen und angewendet.

.. figure:: media/basis_opnsense_059.png

Zum Abschluss erfolgt der Neustart automatisch.

.. figure:: media/basis_opnsense_060.png

Nach dem Neustart ist die OPNsense |reg| soweit vorbereitet.

#####

Logout
------

.. figure:: media/basis_opnsense_061.png

