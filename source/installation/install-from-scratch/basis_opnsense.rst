.. |zB| unicode:: z. U+00A0 B. .. Zum Beispiel 
  
.. |ua| unicode:: u. U+00A0 a. .. und andere

.. |_| unicode:: U+202F .. geschütztes Leerzeichen
   :trim:

.. |...| unicode:: U+2026 .. Auslassungszeichen
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. include:: /guided-inst.subst

.. basis_opnsense:

=====================================
Anlegen und Installieren der Firewall
=====================================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

Bist du zuvor der Anleitung "Proxmox vorbereiten" gefolgt, dann kannst du fortfahren mit `Erster Start der Firewall`_

Installation der OPNsense |reg|
===============================

Lade dir die ISO-Datei der OPNsense |reg| von der Seite https://opnsense.org/download/ herunter.

.. hint::

   Die zuletzt freigegeben OPNsense Version für das Setup von linuxmuster.net v7.1 ist die Version 22.1. 
   https://mirror.informatik.hs-fulda.de/opnsense/releases/mirror/OPNsense-22.1-OpenSSL-dvd-amd64.iso.bz2

Nutze als Architektur ``amd64`` und als "image type" ``dvd`` und einen Mirror, der in deiner Nähe ist.
Du erhälst dann ein mit bz2 komprimiertes ISO-Image. Entpacke die heruntergeladene Datei.

Unter Windows kannst du dies z.B. mit 7-Zip durchführen.

Unter Linux gibst du auf der Eingabekonsole folgenden Befehl an, der dir die Datei im gleichen Ordner entpackt:

.. code::

   tar -xjf <opnsense-dateiname>.iso.bz2
   tar -xjf OPNsense-22.1-OpenSSL-dvd-amd64.iso.bz2

   Alternativ:

   bunzip OPNsense-22.1-OpenSSL-dvd-amd64.iso.bz2


Brenne die entpackte ISO-Datei auf eine DVD oder fertige davon einen bootbaren USB-Stick an. In einer Virtualisierungsumgebung lädst du die ISO-Datei auf den ISP-Speicher.

.. hint:: 

   Willst du in einer VM installieren, so musst du für die neue VM folgende Mindesteinstellungen angeben:
   
   - template - other install media, installation from ISO library,
   - Boot-Mode - UEFI (Achtung: xcp-ng: Boot/MBR),
   - 1 vCPU
   - 2 GiB RAM
   - storage 10 GiB
   - 2 NIC mit Zuordnung zu vSwitch red, green.
   
   Achtung, unter XCP-ng bricht die Installation mit o.g. Einstellungen beim Punkt ``guided installation`` ab,
   wenn UEFI als Boot-Mode angegeben wurde. Es ist als Boot-Mode in der VM Boot/MBR auszuwählen. Bei der weiteren Installation 
   kann dann hingegen GPT/UEFI mode angegeben werden.
   
   vgl. hierzu auch: https://xcp-ng.org/docs/guides.html#pfsense-opnsense-vm

Erster Start der Firewall
=========================

Starte dann OPNsense |reg| auf dem Rechner oder in der neu angelegten VM von deinem Installationsmedium. Je nach Virtualisierungsumgebung hast du ggf. die ISO-Datei bereits auf den ISO-Datenspeicher des Hypervisors abgelegt. Boote dann die VM hierüber.

Am Ende des Boot-Vorgangs der OPNsense |reg| gelangst du zu folgendem Bildschirm:

.. figure:: media/basis_opnsense_001.png
   :align: center
   :alt: OPNsense: First boot

Melde dich als Benutzer ``installer`` mit dem Passwort ``opnsense`` an.

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

Bestätige die Festplatte und wähle ``Install (UFS) UFS GPR/UEFI Hybrid``. 

Jetzt wird OPNsense |reg| auf der Festplatte installiert. Zuvor musst du diese noch auswählen.

.. figure:: media/basis_opnsense_006.png
   :align: center
   :alt: OPNsense: UFS Configuration

Bestätige diesen Vorgang:

.. figure:: media/basis_opnsense_007.png
   :align: center
   :alt: OPNsense: UFS Configuration 2

Warte nun, bis die Installation abgeschlossen ist.

.. figure:: media/basis_opnsense_008.png
   :align: center
   :alt: OPNsense: UFS Configuration 2

Zum Abschluss der Konfiguration musst du das Kennwort für den Benutzer ``root`` neu setzen.

.. figure:: media/basis_opnsense_009.png
   :align: center
   :alt: OPNsense: Root Password

.. attention:: 

   An dieser Stelle muss als root-Passwort ``Muster!`` eingegeben werden, da später der lmn-Server beim Einrichten der Firewall davon ausgeht, dass das root-Passwort ``Muster!`` ist!

Gebe das neue Passwort für root ein.

.. figure:: media/basis_opnsense_010.png
   :align: center
   :alt: OPNsense: Type new root password

Gebe dieses Kennwort erneut ein.

.. figure:: media/basis_opnsense_011.png
   :align: center
   :alt: OPNsense: Retype new root password

Setze es mit ``OK``

.. figure:: media/basis_opnsense_012.png
   :align: center
   :alt: OPNsense: Type new root password

Wähle danach die Option ``Exit and reboot`` aus.

Starte OPNsense |reg| zum Abschluss neu und werfe die DVD / den USB-Stick aus. 
Hast du OPNsense |reg| in eine VM installiert, so werfe die CD aus und ändere die Boot-Reihenfolge, sodass direkt von der Festplatte gestartet wird.

Der Boot-Vorgang kann dann eine Weile dauern. Vor allem, wenn der Router kein DHCP anbieten sollte.

Wenn alles geklappt hat, ist Folgendes zu sehen:

.. figure:: media/basis_opnsense_013.png
   :align: center
   :alt: OPNsense: Final Configuration

.. hint::

   Die dargestellte IPs und Netze können bei deiner OPNsense |reg| andere sein.

Basis-Konfiguration der OPNsense |reg|
======================================

Melde dich als ``root`` mit dem Passwort ``Muster!`` an der OPNsense |reg| an.

Tastaturbelegung
----------------

.. figure:: media/basis_opnsense_014.png
   :align: center
   :alt: OPNsense: Final Configuration

Zuerst überprüfe, ob die Tastaturbelegung richtig ist. Dazu wähle den Punkt 8) aus. Auf der Konsole kannst du dann die Umlaute und Sonderzeichen der deutschen Tastaturbelegung testen. Sollte sie korrekt sein, verlässt du mit ``exit`` die Konsole und bist wieder im Auswahl-Bildschirm. Fahre mit `Überprüfung der Zuordnung der Netzwerkkarten`_ fort, ansonsten ...

.. hint::

   Solltest du feststellen, dass nach dem Neustart in der Konsole der OPNsense |reg| die Tastaturbelegung immer noch falsch ist, stelle diese dauerhaft wie nachstehend beschrieben um:

   .. code::

     cd /usr/share/syscons/keymaps    # Für den Buchstaben "z" musst du die Taste "y" drücken ;-)

     ls german.iso.kbd                # listet das deutsche Tastaturlayout auf, sofern vorhanden
    
     kbdcontrol -l german.iso.kbd     # (-l = Language; "-" zu finden unter "?" ;-) stelle temporär auf das neue Layout um
                                      # - teste, ob es dem gewünschten Layout entspricht
     
     echo "keymap='de'">>/etc/rc.conf # die Wahl des Tastaturlayouts dauerhaft hinzufügen  
     
     cat /etc/rc.conf                 # kontrolliere, ob der Eintrag vorhanden ist

     exit                             # Konsole verlassen

Überprüfung der Zuordnung der Netzwerkkarten
--------------------------------------------

.. figure:: media/basis_opnsense_013.png
   :align: center
   :alt: OPNsense: Final Configuration

Die erste Netzwerkkarte (LAN) ist mit dem pädagogischen Netz verbunden. Allerdings noch mit den falschen Netzwerkeinstellungen, da die Installationsroutine der OPNsense |reg| immer die IP 192.168.1.1/24 zuweist. Diese gilt es noch zu ändern.

Die zweite Netzwerkkarte (WAN) ist mit dem Router verbunden. Die IP hängt davon ab, welche IPs via DHCP von deinem DSL_Router verteilt werden.

In einer Schulumgebung kann es sein, dass der Router keinen DHCP-Service anbieten. In diesem Fall musst du dafür sorgen, dass sich sowohl das Interface (WAN) der OPNsense |reg| als auch der Router im gleichen Netzwerk befinden. 

iHier in unserem Beispiel hat die Zuordnung der Netzwerkkarten nicht geklappt, der Router sollte 192.168.21.212 der OPNsense |reg| zuweisen.

Sollte bei dem WAN Interface keine, eine IP-Adresse nach dem Muster 0.0.0.0/8 oder eine andere als die von dir erwartete erscheinen, dann muss die Zuordnung der Netwerkkarte überprüft werden. Hier beispielhaft anhand unserer Proxmox-Umgebung.

Anpassung der Zuordnung der Netzwerkkarten
------------------------------------------

Rufe dazu den Menüeintrag ``1) Assign interfaces`` auf. Die Nachfragen bezüglich LAGGs und VLAN verneinst du.

.. figure:: media/basis_opnsense_015.png
   :align: center
   :alt: OPNsense: GUI - LAGGs an VLANs no 

Dann gilt es die MAC-Adressen zwischen denen der Virtuellen Maschine hier vtnet0 und vtnet1

.. figure:: media/basis_opnsense_016.png
   :align: center
   :alt: OPNsense: GUI - Valid Interfaces 

und denen der Netzwerkbrücken vmbr0 und vmbr1 zu überprüfen: 

.. figure:: media/basis_opnsense_017.png
   :align: center
   :alt: Proxmox: GUI -s Network Devices 

``hv01`` --> ``VM100`` --> ``Hardware`` --> ``Network Device (net`` 

Unter ``hv01`` unter ``Network`` kannst du dir jetzt mittels dem Kommentarfeld wieder die Zuordnung ins Gedächtnis rufen.

==========  ======  =================  ===  =================  ==========  ===
Bridge des Virtualisierers             <->  Virtuelle Machine
-------------------------------------  ---  ----------------------------------
Kommtentar  Brücke  MAC                     MAC                Interfaces  Typ
==========  ======  =================  ===  =================  ==========  ===
red         vmbr0   0E:76:8B:51:85:15  <->  0e:76:8b:51:85:15  vtnet0      WAN
green       vmbr1   DA:97:1B:E1:35:9C  <->  da:97:1b:E1:35:9c  vtnet1      LAN
==========  ======  =================  ===  =================  ==========  ===

Aus diesem Wissen und dem Vergleich erkennst du, |...|

.. figure:: media/basis_opnsense_018.png
   :align: center
   :alt: OPNsense: GUI - WAN connect to vtnet0 

|...| dass WAN zum Interface vtnet0 zugeordnet gehört.

.. figure:: media/basis_opnsense_019.png
   :align: center
   :alt: OPNsense: GUI - 

|...| dass LAN zum Interface vtnet1 ghört.

.. figure:: media/basis_opnsense_020.png
   :align: center
   :alt: OPNsense: GUI - Assign unterfaces 

Hast du kein weiteres Interface dann ``Enter``

.. figure:: media/basis_opnsense_021.png
   :align: center
   :alt: OPNsense: GUI - Assign unterfaces 

Diese Zuordnung ist nun richtig, also weiter mit ``y``, |...|

.. figure:: media/basis_opnsense_022.png
   :align: center
   :alt: OPNsense: GUI - Assign unterfaces 

|...| welches dann die Konfiguration startet.

.. figure:: media/basis_opnsense_023.png
   :align: center
   :alt: OPNsense: GUI - Assign unterfaces 

Die Zuordnung des WAN Interfaces ist nun richtig.

WAN Zugang testen
^^^^^^^^^^^^^^^^^

Um zwei erste Tests durchzuführen, wechsel mit ``8) Shell`` auf die Kommandozeile und gebe dort folgende Befehle ein.

.. code::

   ping -c 3 8.8.8.8

Die Ausgabe sollte wie folgt aussehen:

.. figure:: media/basis_opnsense_024.png
   :align: center
   :alt: OPNsense: GUI - Assign unterfaces 

.. code::

   ping -c 3 linuxmuster.net

.. figure:: media/basis_opnsense_025.png
   :align: center
   :alt: OPNsense: GUI - Assign unterfaces 

IP-Adressen zuweisen
--------------------

Solltest du in deiner Netzwerkkonfiguration von unserem Muster abweichen, musst du bei nachfolgenden Schritten deiner Festlegung folgen.

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

Bestätige die Nachfrage mit ``N`` und ``ENTER``. (Alternativ wäre auch nur ``ENTER`` möglich, da der großgeschriebene Buchstabe in der Auswahlmöglichkeit darauf hinweist, was die default Einstellung ist.)

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

Nach erfolgreicher Übernahme erhältst du den Hinweis, dass du dich mit der LAN IP auf die GUI der OPNsense |reg| aufschalten könntest.

.. figure:: media/basis_opnsense_040.png
   :align: center
   :alt: OPNsense: GUI IP

Bevor du das aber machst, erfolgt ein letzter Test:

Aktualisierung der OPNsense |reg|
---------------------------------

Aktualisiere die OPNsense |reg| in der Konsole, indem du den Punkt ``12) Update from console`` aufrufst und die Rückfrage mit ``Y`` bestätigst.

.. hint::

  Sollte hierbei keine Verbindung zu den externen Update-Servern möglich sein, dann stimmt deine Netzwerkkartenzuordnung noch nicht. Ändere dies, bevor du fortfährst.

Klappt das Update, startest du die OPNsense |reg| neu nachdem du dich erneut eingeloggt hast.

.. figure:: media/basis_opnsense_023.png
   :align: center
   :alt: OPNsense: GUI - Assign unterfaces

``6) Reboot`` dessen Nachfrage du mit ``y`` beantwortest .

.. todo:: Benennung der Bilder aktualisieren

Konfiguration der OPNsense |reg|
================================

Für die nachfolgende Konfiguration der OPNsense |reg| brauchst du einen Rechner mit Webbrowser im LAN-Bereich der OPNsense |reg|. Das kann ein Laptop mit einem beliebigen Betriebssystem sein. Wichtig ist nur, dass er mit dem LAN-Adapter der OPNsense |reg| verbunden ist und sich im gleichen Netzwerk wie die OPNsense |reg| befindet. In unserer Beschreibung gehen wir davon aus, dass seine manuell zugewiesene IP-Adresse 10.0.0.10 ist.

Nachdem der Browser gestartet ist, gib folgende URL für den Zugriff auf die GUI der OPNsense |reg| ein:

``https://10.0.0.254``

Du erhältst zunächst eine Zertifikatswarnung, da OPNsense |reg| ja ganz frisch installiert ist und ein selbst erstelltes Zertifikat nutzt. 

.. figure:: media/basis_opnsense_041.png

``Erweitert`` und anschließend ``Risiko akzeptieren und fortfahren`` bringt dich auf die Login-Seite.

.. figure:: media/basis_opnsense_042.png

Melde dich mit ``root`` und dem Passwort ``Muster!`` an. 

Starte den General Setup Wizard mit dem ``Next``-Knopf. "Er" wird dich durch die Konfiguration führen, wobei schon einiges richtig durch die zuvor erfolgte Basis-Konfiguration eingerichtet wurde.  

System: Assistent: Allgemeine Information
-----------------------------------------

.. figure:: media/basis_opnsense_043.png

.. attention::
   Die Länge des ersten Teils der Domäne darf maximal 15 Zeichen betragen. Die Domäne ``muster-gymnasium.de`` ist um ein Zeichen zu lang, da muster-gymnasium 16 Zeichen lang ist. 
   Eine gute Wahl ist beispielsweise ``linuxmuster.lan``. Beim späteren Setup von linuxmuster.net wird diese ggf. für alle Server-Dienste angepasst.

.. hint:: Gib als Primary DNS, die neue IP des Upstream Gateway der externen WAN-Schnittstelle an und deaktiviere Override DNS.

Weiter geht es mit ``Next``

System: Assistent: Zeitserverinformation
-----------------------------------------

.. figure:: media/basis_opnsense_044.png

Die Angaben zum Time Server übernimmst du ebenfalls mit ``Next``.

System: Assistent: Konfiguriere WAN-Schnittstelle
-------------------------------------------------

Danach kommst du zu den Einstellungen für die WAN-Schnittstelle.
Nutzt du hier DHCP z.B. eines vorgelagerten DSL-Routers so gibst du hier DHCP an, ansonsten ändere diese bitte auf ``Static``.

.. figure:: media/basis_opnsense_045.png

Falls deine Firewall eine statische IP-Adresse hat, die nicht über DHCP erteilt wird, trägst du sie hier ein.

.. figure:: media/basis_opnsense_046.png

Falls dein Router eine private IP hat, musst du den Haken bei ``Private RFC1918-Netzwerke blockieren`` entfernen. Diesen Eintrag findest du ganz unten auf der Seite, nachdem du runtergescrollt hast.

Mit ``Weiter`` übernimmst du die von dir gemachten Einstellungen

System: Assistent: Konfiguriere LAN-Schnittstelle
-------------------------------------------------

.. figure:: media/basis_opnsense_047.png

Die IP-Adresse und die Subnetzmaske des Schulnetzes sollte hier eingetragen sein. Sollte dies nicht der Fall sein, ändere das nun.

System: Assistent: Setze Root-Passwort 
--------------------------------------

.. figure:: media/basis_opnsense_048.png

.. hint:: 

   An dieser Stelle muss als root-Passwort ``Muster!`` eingegeben werden, da später der lmn-Server beim Einrichten der Firewall davon ausgeht, dass das root-Passwort ``Muster!`` ist!

System: Assistent: Konfiguration neu laden
------------------------------------------

.. figure:: media/basis_opnsense_049.png

Nachdem du die Einstellungen übernommen hast, können sich auch die Einstellungen des LAN-Netzwerks geänderthaben. Dann wirst du nicht über die erfolgreiche Konfiguration informiert |...|

.. figure:: media/basis_opnsense_050.png

... sondern musst deinem Admin PC die IP-Adresse 10.0.0.10/16, DNS: 10.0.0.254 und den Gateway: 10.0.0.254 geben. (hier exemplarisch für unseren Standard-LAN-Bereich)

Gehe dann mit einem Webbrowser auf ``https://10.0.0.254``.

.. hint:: 

   Falls du dich für das Netz der linuxmuster.net v6.2 entschieden hast, solltest du die IP-Adresse 10.16.0.10/12, DNS: 10.16.1.254 und das Gateway 10.16.1.254 verwenden.
  
   Du solltest dann auch mit einem Webbrowser auf https://10.16.1.254 gehen.

Du erhältst eventuell wieder eine Zertifikatswarnung. Akzeptiere diese und fahre fort.

Melde dich wieder mit ``root`` und dem Passwort ``Muster!`` an.

DHCP abschalten
---------------
Jetzt musst du den DHCP-Service der Firewall abschalten. Der wird ja später vom Server übernommen. 

.. figure:: media/basis_opnsense_051.png

Gehe auf ``Dienste -> DHCPv4 -> [LAN]`` und lösche den Haken bei ``Aktivieren`` wenn gesetzt. ``Speichern`` lässt dich deine Einstellungen unten auf der Seite.

Zusätzliche Netzwerkkarte hinzufügen (Optinal)
----------------------------------------------

Die linuxmuster.net v7 läuft bereits mit zwei Netzwerkkarten. Möchtest du allerdings ein WLAN oder in einer DMZ einen Webserver betreiben, brauchst du noch weitere Netzwerkkarten.

Wie das geht, siehst du im Folgenden:

.. figure:: media/basis_opnsense_052.png

Bei ``Schnittstellen -> Zuweisungen`` drückst du ``+``, um die dritte Schnittstelle deinem System hinzuzufügen. Diese dritte Schnittstelle ist dann als ``OPT1`` im System bekannt. OPT1 muss nur noch aktiviert und es muss ihr noch eine IP-Adresse zugewiesen werden. 

.. figure:: media/basis_opnsense_053.png

Unter ``Schnittstellen -> [OPT1]`` kannst du diese Einstellungen vornehmen. Der Screenshot zeigt ein Beispiel. Für weitere Netzwerkkarten verfährst du entsprechend. OPT1 wird dann hochgezählt zu OPT2 etc.

ssh erlauben
------------

.. attention:: Damit der Server für das weitere Setup Zugriff auf die OPNsense |reg| hat, musst du den ssh-Zugriff erlauben. Gehe dafür auf ``System -> Einstellungen -> Verwaltung``.

.. figure:: media/basis_opnsense_054.png

Setze jeweils den Haken bei ``Aktiviere Secure Shell``, ``Erlaube Anmeldung mit dem root-Benutzer`` und ``Anmeldung mit Passwort erlauben``.

Diese Einstellungen wieder ``Speichern``.

Update der OPNsense |reg|
-------------------------

Aktualisiere nun die OPNsense |reg|, indem du unter 

.. figure:: media/basis_opnsense_055.png

``System`` ``->`` ``Firmware`` ``-->`` ``Aktualisierungen`` ``--->`` ``Status`` ``----> `` ``Auf Aktualisierungen prüfen`` klickst.

Wenn keine Aktualisierung verfügbar sind erhälst du folgende Meldung |...|

.. figure:: media/basis_opnsense_056.png

|...| und kannst zum abschließenden Schritt `Logout`_ gehen.

Sollten dir wie in nachstehender Abbildung unter dem Reiter ``Aktualisierungen`` zu aktualisierenden Pakete angezeigt werden |...|

.. figure:: media/basis_opnsense_057.png

.. hint::

   Falls du nicht ins Internet kommst, kann es an der Gateway-Einstellung liegen. Gehe auf ``System`` --> ``Gateways`` --> ``Einzeln`` und editiere dein Gateway (WANGW).

   Setze einen Haken bei ``Deaktiviere Gatewayüberwachung``, speichere die Einstellung und übernimm die Änderung. Jetzt ist dein Gateway online und du kommst ins Internet. Erstaunlicherweise kannst du die Gatewayüberwachung wieder aktivieren, ohne dass das Gateway offline geht.

dann klicke in o.g. Fenster ``Jetzt aktualisieren``. 

Je nach gefundenen Aktualisierungen, kann ein Neustart erforderlich sein. Dies wird vor dem Update abgefragt und ist zu bestätigen.

.. figure:: media/basis_opnsense_058.png

Danach werden die Aktualisierungen heruntergeladen und angewendet.

.. figure:: media/basis_opnsense_059.png

Zum Abschluss erfolgt der Neustart automatisch.

.. figure:: media/basis_opnsense_060.png

Nach dem Neustart ist die OPNsense |reg| soweit vorbereitet.

Logout
------

.. figure:: media/basis_opnsense_061.png

.. todo:: Unterstehende offnene Fragen klären

.. hint:: 

   Installierst du die OPNsense |reg| in einer VM, so solltest du nun noch die Tools der gewählten Virtualisierungsumgebung installieren, damit die VM komfortabel gesteuert werden kann.
   Für XCP-ng findest du nachstehend die Hinweise: https://xcp-ng.org/docs/guides.html#pfsense-opnsense-vmi
   
   - Kann diese hint-Box ganz raus, da verschoben ins Wiki?

   Ich habe keine Guest-Tools für OPNsense |reg| gefunden.
   dafür aber weitere Konfigurationen:

   https://pfstore.com.au/blogs/guides/run-opnsense-in-proxmox

   - Könnte da für uns etwas dabei sein?

   Timezone: Warum Etc/UTC? 