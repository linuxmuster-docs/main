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
-------------------------------

Lade dir die ISO-Datei der OPNsense® von der Seite https://opnsense.org/download/ herunter.

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
-------------------------

Starte dann OPNsense |reg| auf dem Rechner oder in der neu angelegten VM von deinem Installationsmedium. Je nach Virtualisierungsumgebung hast du ggf. die ISO-Datei bereits auf den ISO-Datenspeicher des Hypervisors abgelegt. Boote dann die VM hierüber.

Am Ende des Boot-Vorgangs der OPNsense® gelangst du zu folgendem Bildschirm:

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

Installiere nun OPNsense via ``Install (UFS)``.

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
   :alt: OPNsense: Final Configuration

.. attention:: 

   An dieser Stelle muss als root-Passwort ``Muster!`` eingegeben werden, da später der lmn-Server beim Einrichten der Firewall davon ausgeht, dass das root-Passwort ``Muster!`` ist!

Bestätige dieses Kennwort.

.. figure:: media/basis_opnsense_010.png
   :align: center
   :alt: OPNsense: Final Configuration

Wähle danach die Option ``Exit Apply configuration and exit installer`` aus.

Starte OPNsense |reg| zum Abschluss neu und werfe die DVD / den USB-Stick aus. 

Hast du OPNsense |reg| in eine VM installiert, so werfe die CD aus und ändere die Boot-Reihenfolge, sodass direkt von der Festplatte gestartet wird.

Der Boot-Vorgang kann dann eine Weile dauern. Vor allem, wenn der Router kein DHCP anbieten sollte.

Wenn alles geklappt hat, ist Folgendes zu sehen:

.. figure:: media/basis_opnsense_011.png
   :align: center
   :alt: OPNsense: Final Configuration

.. hint::

   Die dargestellte IPs und Netze können bei deiner OPNsense |reg| andere sein.

Die erste Netzwerkkarte (LAN) ist mit dem pädagogischen Netz verbunden. Allerdings noch mit den falschen Netzwerkeinstellungen, da die Installationsroutine der OPNsense |reg| immer die IP 192.168.1.1/24 zuweist. Diese gilt es noch zu ändern.

Die zweite Netzwerkkarte (WAN) ist mit dem Router verbunden. Die IP hängt davon ab, welche IPs via DHCP von deinem DSL_Router verteilt werden. In einer Schulumgebung kann es sein, dass der Router keinen DHCP-Service anbieten. In diesem Fall musst du dafür sorgen, dass sich sowohl das Interface (WAN) der OPNsense |reg| als auch der Router im gleichen Netzwerk befinden.

Basis-Konfiguration der OPNsense |reg|
--------------------------------------

Melde dich als ``root`` mit dem Passwort ``Muster!`` an der OPNsense |reg| an.

Tastaturbelegung
^^^^^^^^^^^^^^^^

.. figure:: media/basis_opnsense_012.png
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. todo:: Tests genauer beschreiben:

   * optische Zuordnung der Schnittstellen 
   * ping-test auf 8.8.8.8
   * ping test auf internet-Seite z.b. heise.de
   
   wenn alles i.O. dann Sprung zu `IP-Adressen zuweisen`_

   Richtig einstellen beschreiben

   Neustart

.. hint:: 

   Prüfe, ob die Zuordnung der Netzwerkkarten, in Abhängigkeit der Installationsart, die du gewählt hast, korrekt ist. Also ob du OPNsense |reg| in eine VM oder direkt auf der Hardware (bare metal) installiert hast. Sollte diese nicht stimmen, kannst du an der Konsole dies nach der Anmeldung mit dem Menüeintrag ``1) Assign interfaces`` anpassen.

   Hast du auf der Konsole diesen Eintrag aufgerufen, werden dir die gefundenen Netzwerkkarten mit deren MAC-Adressen angezeigt. Achte nun darauf, dass die Netzwerkkarte mit der dargestellten MAC-Adresse und der geeigneten physikalischen Verkabelung korrekt zugeordnet werden. 
   
   * Internes Netz - GREEN muss unter OPNsense |reg| als LAN,

   * das externe Netz - RED unter OPNsense |reg| als WAN und
   
   * weitere Netzwerkkarte |zB| für das WLAN - BLUE unter OPNsense |reg| als OPT1 angegeben werden.
  
   Das WAN-Interface - also die externe Schnittstelle (RED) - wird hierbei zuerst abgefragt, danach das LAN-Interface für das lokale Netz (GREEN) und danach Opt1 für BLUE.
   
   Die Zuordnung wird auf der Konsole nochmals angezeigt und diese ist dann mit ``y`` zu bestätigen.

    reboot # Neustart - kontrolliere danach, ob das gewünschte Layout angewendet wurde

IP-Adressen zuweisen
^^^^^^^^^^^^^^^^^^^^

Solltest du in deiner Netzwerkkonfiguration von unserem Muster abweichen, musst du bei nachfolgenden Schritten eben deiner Festlegung folgen.

.. figure:: media/basis_opnsense_013.png
   :align: center
   :alt: OPNsense: GUI - Set interfaces IP address 

Wähle an der Konsole der OPNsense |reg| den Eintrag ``2) Set interface IP address`` aus.

.. figure:: media/basis_opnsense_014.png
   :align: center
   :alt: OPNsense: GUI - LAN auswählen

Wähle ``1 - LAN (`` |...| ``)`` für die nächsten Schritte.

.. figure:: media/basis_opnsense_015.png
   :align: center
   :alt: OPNsense: GUI - Nicht via DHCP zuweisen lassen

Bestätige die Nachfrage mit ``N`` und ``ENTER``. (Alternativ wäre auch nur ``ENTER`` möglich, da der großgeschriebene Buchstabe in der Auswahlmöglichkeit darauf hinweist, was die default Einstellung ist.)

 .. figure:: media/basis_opnsense_016.png
   :align: center
   :alt: OPNsense: GUI - Eingabe der IP

Gib die IPv4 Adresse ``10.0.0.254`` ein, unter der die OPNsense |reg| im lokalen Netz zu erreichen sein wird.

.. figure:: media/basis_opnsense_017.png
   :align: center
   :alt: OPNsense: GUI - Eingabe der Netzwerkmaske in CIDR

Gib ``16`` für die Netzwerkmaske ein

.. figure:: media/basis_opnsense_018.png
   :align: center
   :alt: OPNsense: GUI - Keine Eingabe nötig, also Enter

Da keine Eingabe eines Upstream-Gateways nötig ist, einfach ``ENTER``

.. figure:: media/basis_opnsense_019.png
   :align: center
   :alt: OPNsense: GUI - keine IPv6 via WAN tracking nötig

.. attention:: Gib ein ``n`` ein.

.. figure:: media/basis_opnsense_020.png
   :align: center
   :alt: OPNsense: GUI - keine IPv6 Adresse via DHCP6 

Gib ein ``N`` ein.

.. figure:: media/basis_opnsense_021.png
   :align: center
   :alt: OPNsense: GUI - keine manuelle IPv6 

Da keine IPv6-Adresse benötigt wird: ``ENTER``

.. figure:: media/basis_opnsense_022.png
   :align: center
   :alt: OPNsense: GUI - keine Aktivierung eines DHCP-Servers auf LAN

Diese und die nächsten drei Fragen ebenfalls jeweils ``N`` und ``ENTER`` bzw. nur ``ENTER`` beantworten. 

.. figure:: media/basis_opnsense_023.png
   :align: center
   :alt: OPNsense: GUI - ändern von Protokolls von https auf http verneinen

.. figure:: media/basis_opnsense_024.png
   :align: center
   :alt: OPNsense: GUI - Erstellung eines neuen Zertifikates für die GUI verneinen

.. figure:: media/basis_opnsense_025.png
   :align: center
   :alt: OPNsense: GUI - Wiederherstellung der GUI Zutrittsberechtigungen

Nach der letzten Eingabe startet die Übernahme in das System.

.. figure:: media/basis_opnsense_026.png
   :align: center
   :alt: OPNsense: GUI IP

Nach erfolgreicher Übernahme erhältst du den Hinweis, dass du dich mit der LAN IP auf die GUI der OPNsense |reg| aufschalten könntest.

.. figure:: media/basis_opnsense_027.png
   :align: center
   :alt: OPNsense: GUI IP

Bevor du das aber machst, erfolgt ein letzter Test:

Aktualisierung der OPNsense |reg|
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Aktualisiere die OPNsense |reg| in der Konsole, indem du den Punkt ``12) Update from console`` aufrufst und die Rückfrage mit ``Y`` bestätigst.

.. hint::

  Sollte hierbei keine Verbindung zu den externen Update-Servern möglich sein, dann stimmt deine Netzwerkkartenzuordnung noch nicht. Ändere dies, bevor du fortfährst.

Klappt das Update, startest du die OPNsense neu. Dazu beantwortest du die Nachfrage mit ``y``.

Konfiguration der OPNsense |reg|
--------------------------------

Für die Konfiguration der OPNsense |reg| brauchst du einen Rechner mit Webbrowser im LAN-Bereich der OPNsense |reg|. Das kann ein Laptop mit Linux oder einem anderen Betriebssystem sein. Wichtig ist nur, dass er mit dem LAN-Adapter der OPNsense |reg| verbunden ist und sich im gleichen Netzwerk wie die OPNsense |reg| befindet. In unserer Beschreibung gehen wir davon aus, dass seine manuell zugewiesene IP-Adresse 10.0.0.10 ist.

Nachdem der Browser gestartet ist, gib folgende URL für den Zugriff auf die GUI der OPNsense ein:

``https://10.0.0.254``

Du erhältst zunächst eine Zertifikatswarnung, da OPNsense |reg| ja ganz frisch installiert ist und ein selbst erstelltes Zertifikat nutzt. 

.. figure:: media/basis_opnsense_028.png

``Erweitert`` und anschließend ``Risiko akzeptieren und fortfahren`` bringt dich auf die Login-Seite.

.. figure:: media/basis_opnsense_029.png

Melde dich mit ``root`` und dem Passwort ``Muster!`` an. 

Starte den General Setup Wizard mit dem ``Next``-Knopf.

.. figure:: media/basis_opnsense_030.png

.. attention::
   Die Länge des ersten Teils der Domäne darf maximal 15 Zeichen betragen. Die Domäne ``muster-gymnasium.de`` ist um ein Zeichen zu lang, da muster-gymnasium 16 Zeichen lang ist. 
   Eine gute Wahl ist beispielsweise ``linuxmuster.lan``. Beim späteren Setup von linuxmuster.net wird diese ggf. für alle Server-Dienste angepasst.

.. hint:: Gib als Primary DNS, die neue IP des Upstream Gateway der externen WAN-Schnittstelle an und deaktiviere Override DNS.

Weiter geht es mit ``Next``

.. figure:: media/basis_opnsense_031.png

Die Angaben zum Time Server übernimmst du ebenfalls mit ``Next``. Danach kommst du zu den Einstellungen für die WAN-Schnittstelle.
Nutzt du hier DHCP z.B. eines vorgelagerten DSL-Routers so gibst du hier DHCP an, ansonsten ändere diese bitte auf ``Static``.

.. figure:: media/basis_opnsense_032.png

Falls deine Firewall eine statische IP-Adresse hat, die nicht über DHCP erteilt wird, trägst du sie hier ein.

.. figure:: media/basis_opnsense_033.png

Falls dein Router eine private IP hat, musst du den Haken bei ``Private RFC1918-Netzwerke blockieren`` entfernen.

Mit ``Weiter`` übernimmst du die von dir gemachten Einstellungen

.. figure:: media/basis_opnsense_034.png

Die IP-Adresse und die Subnetzmaske des Schulnetzes sind hier einzutragen.
 
.. figure:: media/basis_opnsense_035.png

.. hint:: 

   An dieser Stelle muss als root-Passwort ``Muster!`` eingegeben werden, da später der lmn-Server beim Einrichten der Firewall davon ausgeht, dass das root-Passwort ``Muster!`` ist!

.. figure:: media/basis_opnsense_036.png

Nachdem du die Einstellungen übernommen hast, haben sich auch die Einstellungen des LAN-Netzwerks geändert.

Jetzt solltest du deinem Admin PC die IP-Adresse 10.0.0.10/16, DNS: 10.0.0.254 und den Gateway: 10.0.0.254 geben.

Gehe mit einem Webbrowser auf ``https://10.0.0.254``.

.. hint:: 

   Falls du dich für das Netz der linuxmuster.net v6.2 entschieden hast, solltest du die IP-Adresse 10.16.0.10/12, DNS: 10.16.1.254 und das 
   Gateway 10.16.1.254 verwenden. Du solltest dann auch mit einem Webbrowser auf https://10.16.1.254 gehen.

Du erhältst wieder eine Zertifikatswarnung. Akzeptiere und fahre fort.

Melde dich wieder mit ``root`` und dem Passwort ``Muster!`` an.

DHCP abschalten
---------------
Jetzt musst du den DHCP-Service der Firewall abschalten. Der wird ja später vom Server übernommen. 

.. figure:: media/basis_opnsense_037.png

Gehe auf ``Dienste -> DHCPv4 -> [LAN]`` und lösche den Haken bei ``Aktivieren``. Speichere deine Einstellungen.

Zusätzliche Netzwerkkarte hinzufügen
------------------------------------

Die linuxmuster.net v7 läuft bereits mit zwei Netzwerkkarten. Möchtest du allerdings ein WLAN oder in einer DMZ einen Webserver betreiben, brauchst du noch weitere Netzwerkkarten.

Wie das geht, siehst du im Folgenden:

.. figure:: media/basis_opnsense_038.png

Bei ``Schnittstellen -> Zuweisungen`` drückst du ``+``, um die dritte Schnittstelle deinem System hinzuzufügen. Diese dritte Schnittstelle ist dann als ``OPT1`` im System bekannt. OPT1 muss nur noch aktiviert und es muss ihr noch eine IP-Adresse zugewiesen werden. 

.. figure:: media/basis_opnsense_039.png

Unter ``Schnittstellen -> [OPT1]`` kannst du diese Einstellungen vornehmen. Der Screenshot zeigt ein Beispiel. 
Für weitere Netzwerkkarten verfährst du entsprechend. OPT1 wird dann hochgezählt zu OPT2 etc.

ssh erlauben
------------

.. attention:: Damit der Server Zugriff auf die OPNsense |reg| hat, musst du einen ssh-Zugriff erlauben. Gehe dafür auf ``System -> Einstellungen -> Verwaltung``.

.. figure:: media/basis_opnsense_040.png

Setze einen Haken bei ``Aktiviere Secure Shell``, ``Erlaube Anmeldung mit dem root-Benutzer`` und ``Anmeldung mit Passwort erlauben``. Speichere die Einstellungen.

.. attention::

   Diese Einstellung ist entscheidend, damit zwischen Server und Firewall eine SSH-Verbindung erfolgreich hergestellt werden kann. 
   
   Diese ist vor Aufruf des linuxmuster-Setup-Skritpes von beiden Seiten zu testen. Dazu später mehr |...|

Update der OPNsense |reg|
-------------------------

Aktualisiere nun die OPNsense |reg|, indem du unter 

.. figure:: media/basis_opnsense_041.png

``System`` ``->`` ``Firmware`` ``-->`` ``Aktualisierungen`` ``--->`` ``Status`` ``----> `` ``Auf Aktualisierungen prüfen`` klickst.

Es werden dir dann wie in nachstehender Abbildung unter dem Reiter ``Aktualisierungen`` die zu aktualisierenden Pakete angezeigt.

.. figure:: media/basis_opnsense_042.png

.. hint::

   Falls du nicht ins Internet kommst, kann es an der Gateway-Einstellung liegen. Gehe auf ``System -> Gateways -> Einzeln`` und editiere dein Gateway (WANGW).
   Setze einen Haken bei ``Deaktiviere Gatewayüberwachung``, speichere die Einstellung und übernimm die Änderung. Jetzt ist dein Gateway online und du kommst ins Internet.
   Erstaunlicherweise kannst du die Gatewayüberwachung wieder aktivieren, ohne dass das Gateway offline geht.

Um jetzt zu aktualisieren, klicke in o.g. Fenster ``Jetzt aktualisieren``. Je nach gefundenen Aktualisierungen, kann ein Neustart erforderlich sein. 
Dies wird vor dem Update abgefragt und ist zu bestätigen.

.. figure:: media/basis_opnsense_043.png

Danach werden die Aktualisierungen heruntergeladen und angewendet.

.. figure:: media/basis_opnsense_044.png

Zum Abschluss erfolgt der Neustart automatisch.

.. figure:: media/basis_opnsense_045.png

Nach dem Neustart ist die OPNsense |reg| soweit vorbereitet.

.. hint::

   Installierst du die OPNsense |reg| in einer VM, so solltest du nun noch die Tools der gewählten Virtualisierungsumgebung installieren, damit die VM komfortabel gesteuert werden kann.
   Für XCP-ng findest du nachstehend die Hinweise: https://xcp-ng.org/docs/guides.html#pfsense-opnsense-vm

.. todo:: Bei Release nachfolgende Zeilen 497-879 (auskommentiert) löschen. Altlast Sicherheitshalber noch vorhalten.

.. 

.. Anlegen und Installieren des Servers
.. ====================================

.. Bist du zuvor der Anleitung "Proxmox vorbereiten" gefolgt, dann kannst du fortfahren mit `Erster Start des Servers`_.

.. .. hint::

   Willst du in einer VM installieren, so must du für die neue VM folgende Mindesteinstellungen angeben:
     
     - Template - Ubuntu Bionic Beaver 18.04, installation from ISO library, 
     - Boot-Mode - BIOS Boot / MBR, 
     - 2 vCPU, 
     - 3 GiB RAM, 
     - storage -> hdd1: 25 GiB -> hdd2: 100 GiB, 
     - 1 NIC mit Zuordnung zu vSwitch green.
   
   Achte darauf, dass vor dem Start der VM beide Festplatten der VM zugewiesen wurden.

   Bei der Einrichtung des Servers musst du nur einen Server mit 2 HDDs haben und Ubuntu 18.04 auf der ersten HDD installieren. Die zweite HDD bleibt frei. Auf dieser 2. HDD richtest du - wie nachstehend beschrieben -  ein LVM ein.

.. Erster Start des Servers
.. ------------------------

.. Starte den Server via Ubuntu 18.04 Server ISO-Image (USB-Stick oder CD-ROM). Es erscheint das erste Installationsfenster mit der Abfrage zur gewünschten Sprache.

.. Wähle deine bevorzugte Sprache.

.. Beantworte danach die Frage, ob auf einen neuen Installer (für 20.04) aktualisiert werden soll, mit ``Ohne Aktualisierung fortfahren``.

.. Danach wähle dein Tastaturlayout.

.. .. figure:: media/server01.png

.. Wähle das Tastaturlayout Deutsch und bestätige dies mit ``Erledigt``.

.. .. hint:: Das Tastaturlayout wirkt sich während der Installation noch nicht aus! 

.. Konfiguriere danach deine Netzwerkkarte.

.. .. figure:: media/server02.png

.. In der Voreinstellung ist die Netzwerkkarte auf DHCP eingestellt. Das klappt natürlich nicht, da der DHCP-Service der Firewall deaktiviert wurde. 
.. Du musst also die Konfiguration von Hand einstellen.

.. Gehe dazu auf die Netzwerkkarte und wähle ``Edit IPv4``.

.. .. figure:: media/server03.png

.. Wähle ``Manual`` aus.

.. .. figure:: media/server04.png

.. Gib die Netzwerkkonfiguration, wie im oberen Bild, ein und übernehme sie mit ``Speichern``.

.. .. hint:: 

   Bedenke, dass das deutsche Tastaturlayout noch nicht aktiv ist. Den ``/``, den du für die Eingabe des Subnetzes brauchst, bekommst du mit der ``-``-Taste!

.. .. figure:: media/server05.png

.. Mit ``Èrledigt`` geht es weiter.

.. .. figure:: media/server06.png

.. Lass die Proxy-Adresszeile leer. Auch diese Anfrage verlässt du mit ``Erledigt``.

.. .. figure:: media/server07.png

.. Die Mirror-Adresse übernimmst du ebenfalls mit ``Erledigt``.

.. .. figure:: media/server08_new-installer.png

.. Bei der angebotene Aktualisierung des Installers wählst du ``Ohne Akualisierungi fortfahren``.

.. Jetzt must du die Festplattten einrichten. Bei einer bare metal Installation hast du zwei physikalische Festplatten installiert (also /dev/sda und /dev/sdb) 
.. alternativ richtest du zwei Partitionen ein. Die erste Partition mit mind. 25 GiB (/dev/sda1) und die zweite mit der restlichen Größe der Festplatte (/dev/sda2).

.. .. figure:: media/server09_custom-storage-layout.png

.. Wähle nun zur Einrichtung der Festplatten ``Custom Storage Layout`` aus.

.. .. figure:: media/server10_custom-storage-layout-create-partition-table.png

.. Es werden dir dann die verfügbaren Geräte angezeigt. 

.. Wähle die erste Festplatte bzw. die erste Partition aus. Es wird ein Kontextmenü angezeigt, bei der du eine ``GPT/Partition`` erstellen musst. 

.. .. figure:: media/server11_custom-storage-layout-create-partition-table2.png

.. Wähle den gesamten Festplattenplatz und formatiere diesen mit dem ext4-Dateiformat und weise diese dem ``Mount Point /`` zu.

.. .. figure:: media/server12_custom-storage-layout-create-partition-table3.png

.. Gehe auf ``Erstellen``.

.. Danach gelangst Du zu nachstehendem Bildschirm.

.. .. .. figure:: media/server13.png

.. .. figure:: media/server14_custom-storage-layout-create-partition-table-lvm-hdb-5.png

.. .. todo:: Irgendwie passen die Bilder nicht zum Ablauf bzw. zur v7.0

.. .. todo:: Folgende Beschreibung sollte umgestellt geschrieben werden, dass Sprung über LVM Konf möglich ist

.. .. hint:: Solltest du unserere Standard Einteilung für das lvm nutzen wollen, dann kannst du den nächsten Abschnitt überspringen. Die Standardvorgabe ist wie folgt:

.. ============== ========================== ========================= =====
.. LV Name        LV Pfad                    Mountpoint                Größe
.. ============== ========================== ========================= =====
.. var            /dev/sg_srv/var            /var                      10G
.. linbo          /dev/sg_srv/linbo          /srv/linbo                40G
.. global         /dev/sg_srv/global         /srv/samba/global         10G
.. default-school /dev/sg_srv/default-school /srv/samba/default-school 40G
.. ============== ========================== ========================= =====

.. Für kleine Schulen oder eine Test-Installation sollten diese Vorgaben passen, ansonsten:

.. Richte nun auf der 2. HDD ein LVM ein.
   
.. Wähle den Eintrag ``Datenträgergruppe (LVM) anlegen`` aus.

.. Hier gibst du einen eigenen Namen für die LVM Volume Group an (z.B. vg0).

.. .. figure:: media/server15_custom-storage-layout-create-partition-table-lvm-6.png

.. Zum Abschluss werden dir die Partitionsierungseinstellungen angezeigt.

.. .. figure:: media/server16_custom-storage-layout-create-partition-table-overview.png

.. Stimmen diese mit den gewünschten überein, so wähle ``Erledigt`` aus.

.. Danach erhälst du die Rückfrage, ob die Installation fortgesetzt werden soll und die Daten auf der Festplatte gelöscht werden sollen.

.. Bestätige dies.

.. .. hint::

   Ohne LVM sind die Mount Points ``/var`` und ``/srv`` auf die 2. HDD zu legen. Die Zuordnung der Mount Points zum LVM wird später detailliert beschrieben.

.. .. figure:: media/server17.png

.. Nenne den Server ``server``. Der Benutzername (lmnadmin) und das Passwort (Muster!) sind frei wählbar - wie in der Abb. dargestellt.

.. .. todo:: Bild fehlt .. figure:: media/_server_001.png

.. Installiere OpenSSH **nicht**

.. .. figure:: media/_server_002.png

.. und installiere keine weiteren optionalen Pakete.

.. .. figure:: media/_server_003.png

.. Bestätige die Installation mit ``Fortfahren``.

.. Zum Abschluß der Installation wird automatisch versucht, Updates zu installieren

.. .. figure:: media/_server_004.png

.. und danach den Server neu zu starten.

.. .. figure:: media/_server_005.png

.. Bei laufender und wie zuvor beschriebener Einrichtung der OPNsense |reg| sollte dies erfolgreich verlaufen.

.. Wenn die Installation abgeschlossen und der Server neu gestartet ist, meldest du dich mit den zuvor angegeben Login-Daten an.

.. .. hint::

..    Bei einer Installation in eine VM achte vor dem Neustart darauf, dass du die ISO-Datei / DVD ausgeworfen hast und die Boot-Reihenfolge so unmgestellt hast,
..    dass die VM direkt von HDD bootet.

.. .. todo:: Time to do snapshot

.. LVM - Besonderheiten
.. --------------------

.. 1. Hast du wie zuvor beschrieben ein LVM angelegt, gib auf der Konsole ``sudo vgscan --mknodes`` ein. Es wird dir dann die sog. ``volume group "vg0"`` angezeigt, die du während der Installation auf der 2. HDD angelegt hast.

.. 2. Führe ``sudo vgchange -ay`` aus, um das Volume zu aktivieren.

.. 3. Gib ``sudo pvdisplay`` an, um Informationen zu der Logical Volume Group auszugeben. PV = physical volume = hdd, vg = volume group. Du kannst für Kurzinformationen auch ``sudo pvs`` angeben. Die vg - volume group sollte schon vorhanden sein und wie zuvor angegeben hier ``vg0`` heißen.

.. 4. Lege nun logical volumes an. Wir gehen von 100G für die HDD aus:

.. .. code::

   sudo lvcreate -L 10G -n /dev/vg0/var vg0
   sudo lvcreate -L 40G -n /dev/vg0/linbo vg0
   sudo lvcreate -L 10G -n /dev/vg0/global vg0
   sudo lvcreate -L 38G -n /dev/vg0/default-school vg0
   
.. 5. Um zu prüfen, ob die logical volumes angelegt wurden, gib den Befehl ``sudo lvs`` an.

.. 6. Aktiviere nun diese logical volumes wie folgt:

.. .. code::

   sudo lvchange -ay /dev/vg0/var
   sudo lvchange -ay /dev/vg0/linbo
   sudo lvchange -ay /dev/vg0/global
   sudo lvchange -ay /dev/vg0/default-school
   
.. 7. Formatiere die Verzeichnisse in den neu angelegten logical volume groups wie folgt:

.. .. code::

   sudo mkfs.ext4 /dev/vg0/var
   sudo mkfs.ext4 /dev/vg0/linbo
   sudo mkfs.ext4 /dev/vg0/global
   sudo mkfs.ext4 /dev/vg0/default-school
   
.. 8. Lege nachstehende Verzeichnisse an, die wir danach auf die logical volumes mounten:
   
.. .. code:: 

   sudo mkdir /srv/linbo
   sudo mkdir /srv/samba
   sudo mkdir /srv/samba/global
   sudo mkdir /srv/samba/schools
   sudo mkdir /srv/samba/schools/default-school
 
.. 9. Kopiere den Inhalt von ``/var`` zunächst in einen neuen Ordner ``/savevar``. Das Verzeichnis ``/var`` soll später auf das LVM gemountet werden.
   Hierbei ist darauf zu achten, dass das virtuelle Dateisystem unterhalb von /var, das für die LX-Container genutzt wird, zunächst ausgehangen und der entsprechende    
   Dienst ``lxcfs.service`` beendet wird.

.. .. code:: 

   sudo mkdir /savevar
   sudo systemctl stop lxcfs.service
   sudo cp -R /var /savevar

.. 10. Rufe die Datei ``/etc/fstab`` mit dem Editor nano auf und ergänze den bisherigen Eintrag für die 1. HDD um nachstehenden Eintragungen:

.. .. code::

   /dev/vg0/var              /var ext4 defaults 0 1
   /dev/vg0/linbo            /srv/linbo ext4 defaults 0 1
   /dev/vg0/global           /srv/samba/global ext4 user_xattr,acl,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0,barrier=1 0 1
   /dev/vg0/default-school   /srv/samba/schools/default-school ext4 user_xattr,acl,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0,barrier=1 0 1

.. Speichere die Einstellung mit ``Strg+w`` und verlasse den Editor mit ``Strg+x``. 

.. 11. Lade die Eintragungen aus der Datei ``/etc/fstab`` neu mit ``mount -a``. Ggf. erkennst Du auch noch Fehler, die sich aufgrund von Tippfehlern in der Datrei /etc/fstab ergeben.
    Behebe diese zuerst bevor du fortfährst.

.. 12. Kopiere dann die gesicherten Inhalte wieder in das Verzeichnis ``/var``, das jetzt auf dem LVM gemountet ist und noch keinen Inhalt hat. Starte danach wieder   
    das virtuelle Dateisystem oder gehe direkt zu Punkt 13, da beim Neustart dieses wieder eingehangen wird.

.. .. code::

   cd /savevar/var
   sudo cp -R * /var
   sudo systemctl start lxcfs.service

.. 13. Boote danach den Server neu mit ``sudo reboot``. Startet dieser ohne Fehlermeldungen durch, kannst du nun das Verzeichnis ``savevar`` wieder löschen mit ``rm -R /savevar``.

.. .. hint::

   Solltest Du beim Kopieren des Inhalts von ``var`` Fehler angezeigt bekommen, so hast du das virtuelle Dateisystem zuvor nicht ausgehangen. Gehe dann wie unter 9. vor.

.. Automatische Updates abschalten
.. -------------------------------

.. Der frisch installierte Ubuntu-Server hat automatische Updates aktiviert. Das solltest du abschalten.

.. Werde mit ``sudo -i`` root und editiere, beispielsweise mit nano, die Datei ``/etc/apt/apt.conf.d/20auto-upgrades``:

.. .. code::

  nano /etc/apt/apt.conf.d/20auto-upgrades

.. Ersetze bei ``APT::Periodic::Unattended-Upgrade`` die ``"1";`` durch ``"0";``. Mit ``<Strg>+o`` speicherst du die Änderung ab. Und mit ``<Strg>+x`` verlässt du nano wieder.

.. Jetzt kannst du den Server mit ``apt-get update`` und anschließendem ``apt-get dist-upgrade`` updaten. 

.. cloud-init abschalten
.. ---------------------

.. 1. Erstelle eine leere Datei um den Dienst am Start zu hindern.

.. .. code::

      sudo touch /etc/cloud/cloud-init.disabled


.. 2. Deaktiviere alle Dienste.

.. .. code::

      sudo dpkg-reconfigure cloud-init

.. 3. Deinstalliere alle Pakete und Ordner, auch wenn o.g. Befehl nicht ausgeführt werden konnte !

.. .. code::

      sudo dpkg-reconfigure cloud-init
      sudo apt-get purge cloud-init
      sudo rm -rf /etc/cloud/ && sudo rm -rf /var/lib/cloud/

.. 4. Starte den Server neu.

.. .. code::

      sudo reboot

.. Server auf lmn7.1 vorbereiten
.. =============================

.. Nachdem du ``from scratch`` installiert hast, musst du vorab mit dem Skript ``lmn71-appliance`` den soeben installierten und vorbereiteten Ubuntu-Server vor dem ersten Setup für linuxmuster v7.1 vorbereiten.

.. .. hint::
   
   Die Anpassung des Netzbereichs / des Profils ist vor Aufruf des eigentlichen Setups auszuführen.

.. Das Skript lmn71-appliance
.. --------------------------

.. Das Skript lmn71-appliance ...

.. - bringt das Betriebssystem auf den aktuellen Stand,
.. - installiert das Paket linuxmuster-prepare und
.. - startet dann das Vorbereitungsskript linuxmuster-prepare,
.. - das die für das jeweilige Appliance-Profil benötigten Pakete installiert,
.. - das Netzwerk konfiguriert,
.. - das root-Passwort auf Muster! setzt und
.. - im Falle des Serverprofils LVM einrichtet.

.. Melde dich am neu installierten Ubuntu 18.04 Server an und werde root mit ``sudo -i``.
.. Führe danach folgende Befehle in der Eingabekonsole aus:

.. .. code::

   sudo sh -c 'echo "deb https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'
   sudo apt-get update
   sudo apt-get dist-upgrade

.. .. todo:: Check des Repros bei Release

   .. code::
   
   # wget https://raw.githubusercontent.com/linuxmuster/linuxmuster-prepare/master/lmn71-appliance
   # chmod +x lmn71-appliance
   # ./lmn71-appliance -p server -u

.. .. hint:: 
 bei Release

   
   Hast du nicht wie zuvor beschreiben bereits ein LVM auf dem Server eingerichtet und dieses bereits gemountet, dann gibst du zur Installation    
   folgendes an: ``./lmn71-appliance -p server -l /dev/sdb`` aus. Hierbei wird auf dem angegebenen Device (hier also 2. Festplatte) ein LVM eingerichtet.


.. Für weitere Hinweise zum linuxmuster-prepare Skript siehe: https://github.com/linuxmuster/linuxmuster-prepare

.. .. todo:: Überprüfen ob der nächste momentan kommentierte Absatz raus kann. siehe auch https://ask.linuxmuster.net/t/lmn-7-1-linuxmuster-prepare-webui-laeuft-nicht/8655/13?u=machtdochnix

.. .. Fahre den Server herunter und erstelle einen Snapshot in der Virtualisierungsumgebung. Starte danach den server wieder und führe dann das Setup für die lmn v7.1 aus.


.. Paketquellen lmn71
.. ------------------

.. Die Paketquellen, die für die lmn71 eingebunden werden müssen, werden von o.g. Skript lmn71-applicance bereits korrekt eingetragen.
.. Es wurden somit in den Paketquellen die ``linuxmuster.net sources`` eingetragen und der Schlüssel des Paketserver importiert.

.. Solltest du diesen Vorgang manuell durchführen müssen, gehst du wie folgt vor:

.. * Zunächst wirst du wieder root mit ``sudo -i``.
.. * Dann lädst du den key für das repository für lmn71 mit ``wget -qO - "https://deb.linuxmuster.net/pub.gpg" | sudo apt-key add -`` herunter.
.. * Jetzt fügst du das linuxmuster 7.1 repository hinzu und aktualisierst: 

.. .. todo:: Verbindungscheck zur OPNsense einfügen
   
..    ssh root@opnsense

..    Key akzeptieren

