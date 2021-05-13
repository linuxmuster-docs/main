.. include:: /guided-inst.subst

.. _install-kvm-label:

=======================
Virtualisierung mit KVM
=======================

.. sectionauthor:: `@morbweb <https://ask.linuxmuster.net/u/morpweb>`_,
		   `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,
		   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

In diesem Dokument findest du unsere "Schritt für Schritt" Anleitungen um linuxmuster.net unter KVM zu installieren. Als Basis dient ein Ubuntu Server 18.04.5 LTS.

Wir setzen voraus, dass du die Abschnitte :ref:`what-is-new-label` und :ref:`prerequisites-label` gelesen hast, bevor du dieses Kapitel durcharbeitest.

Im folgenden Bild ist die einfachste Form der Implementierung der Musterlösung schematisch mit dem gewählten (Standard-)Netzwerk ``10.0.0.0/16`` dargestellt:

.. figure:: media/install-on-kvm-image01.png

Nach der Installation gemäß dieser Anleitung erhältst du eine einsatzbereite Umgebung bestehend aus

 * einem Host (KVM) für alle virtuellen Maschinen,
 * einer Firewall (OPNsense für linuxmuster.net) und
 * einem Server (linuxmuster.net)

Ähnliche, hier nicht dokumentierte, Installationen gelten für einen OPSI-Server und einen Docker-Host, die dann ebenso auf dem KVM-Host laufen können.

Voraussetzungen
===============

* Der Internetzugang des KVM-Hosts muss gewährleistet sein.
 
  Entweder bekommt er von einem Router per DHCP eine IP-Adresse, Gateway- und DNS-Server oder man trägt diese Daten von Hand ein.

* Sofern ein Admin-PC eingerichtet wird, sollte dieser für die Installation die Möglichkeit haben, sich bei Bedarf mit dem entsprechende Netzwerk zu verbinden. Im letztendlichen linuxmuster.net-Intranet erhält dieser dann die folgenden Einstellungen:

  * IP-Adresse:  ``10.0.0.10/16``
  * Gateway und DNS-Server jeweils: ``10.0.0.254``

  Für solch einen Administrations-Rechner bietet sich ein Ubuntu-Desktop mit der Software `virt-manager` an.

Vorgehen
========

1. Der KVM-Host wird an einen Router angeschlossen, sodass er ins Internet kommt. Es wird ein heruntergeladenes "Server install image 64bit" von einem Boot-Medium auf dem KVM-Host installiert.

2. Die Software für KVM und die Zeitsynchronisation werden installiert, aktualisiert und konfiguriert.

3. Das virtuelle Netzwerk wird auf dem KVM-Host konfiguriert.

4. Das heruntergeladene Abbild der Firewall wird importiert, an die neue Netzwerkumgebung angepasst und die Netzwerkverbindung zur Firewall getestet. 

 .. todo:: zu klären: "In der Firewall wird optional die externe Netzwerkanbindung konfiguriert."   

5. Der linuxmuster.net-Server wird importiert, dessen Festplattengrößen und die Netzwerkverbindung angepasst und getestet.

6. Abschließende Konfigurationen auf dem KVM-Host.

Bereitstellen des KVM-Hosts
===========================

.. hint::

   Der KVM-Host bildet die Grundlage für die Firewall *OPNsense®* und den Schulserver *server*. Da KVM im Gegensatz zu Xen oder VMWare auf die Virtualisierungsfunktionen der CPU angewiesen ist, müssen diese natürlich hardwareseitig vorhanden und im BIOS aktiviert sein.

Die folgende Anleitung beschreibt die einfachste Implementierung ohne Dinge wie VLANs, Teaming/Bonding oder RAIDs. Diese Themen werden in zusätzlichen Abschnitten im Kapitel "SYSTEMADMINISTRATION" betrachtet.

Wir beschreiben hier die Installation von dem Erstellen eines Bootmediums bis zum fertigen Ubuntu-Server. Sollte das für dich ein alter Hut sein, kannst du das überspringen und mit der Installtion von der Pakete für `Installation der KVM-Pakete`_ fortfahren 

.. _preface-usb-stick-label:

Erstellen eines Installationsmediums
------------------------------------

.. _Download: https://releases.ubuntu.com/18.04.5/

Es wird für die Installation des KVM-Hosts ein Ubuntu Server 64bit in der Version 18.04 LTS verwendet. Welches du unter "Server install image" auf der Ubuntu-Seite zum Download_ findest. Diese iso-Datei muss auf ein Bootmedium so kopiert werden, dass sich der zukünftige KVM-Host von diesem Medium starten lässt.

.. _heruntergeladen: https://unetbootin.github.io/

Neben dem "Brennen" auf einer DVD, stehen dir zum Erzeugen eines USB-Boot-Sticks diverse Anleitung im Internet bereit. Da diese immer von deinem verwendeten Betriebssystem abhängen, zeigen wir dir dieses an dem Programm UNetbootin. Dieses hat für uns den Vorteil, dass es die Erstellung unter verschiedenen Betriebssystemen (Linux, Windows und macOS) ermöglicht und die Erkläung davon unabhängig bleibt.

Installiere das Programm nachdem du es dir hier heruntergeladen_ hast. Vor dem Start des Programms verbinde deinen USB-Stick mit dem Rechner.

Nachdem du es gestartet hast, begrüßt dich dieser Bildschirm. Eventuell musstest du vorher die erweiterten Rechte für den Programmstart erlauben. Diese sind für den Zugriff auf den USB-Stick nötig. 

.. figure:: ../media/unetbootin_001_open-program.png
   :align: center
   :alt: Das geöffnete Programm

Zwar bietet UNetbootin für viele Livesystem die Möglichkeit diese direkt herunterzuladen. Leider aber nicht für den benötigten Ubuntu Server. Aber da du die iso-Datei ja zuvor schon auf deinem Rechner geladen hast, wählst du sie mit dem nächsten Schritt aus. Dazu klickst du auf den gezeigten Button ``...``.

.. figure:: ../media/unetbootin_002_select-iso.png
   :align: center
   :alt: Auswahl der iso-Datei 

Wähle die iso-Datei und bestätige sie mit ``Open``.

.. figure:: ../media/unetbootin_003_start-copy.png
   :align: center
   :alt: Starten der USB-Stick-Erstellung

Überprüfe ob ``Typ`` und ``Laufwerk`` den von dir gewünschten USB-Stick beschreiben.

.. Attention:: Sollte da nicht das richtige Medium ausgewählt sein, würde der nächste Schritt das falsch ausgewählte Medium unwiederbringbar löschen!

Mit ``OK`` startest du die Erstellung

.. figure:: ../media/unetbootin_004_copy-progress.png
   :align: center
   :alt: Fortschritt der USB-Stick-Erstellung

Warte den Fortschritt des Installationsprozesses ab, bis ...

.. figure:: ../media/unetbootin_005_finish.png
   :align: center
   :alt: Erfolgreiche Beendigung des Vorganges
   
... er erfolgreich abgeschlossen wurde.

Installation des KVM-Hosts
--------------------------

Nachdem du deinen zukünftigen KVM-Host von deinem zuvor erstellten Boot-Medium gestaret hast, beginn die eigentlichen Installation.

.. todo:: Installation KVM

.. figure:: ../media/ubuntu-installation_001_select-language.png
   :align: center
   :alt: Auswahl der Sprache für die Installation

Nach einiger Zeit wird dich der Installer von Ubuntu nach der Sprache für die Installattion fragen. Markiere deine gewünschte Sprache und wähle sie mir `Enter` aus. 

.. figure:: ../media/ubuntu-installation_002_without-actualisation.png
   :align: center
   :alt: Überspringe die Auswahl der Aktualisierung

Die nächste Frage bezieht sich auf den aktualisierten Installer. Dieses Frage kannst du mit `Ohne Aktualisierung fortfahren` und `Enter` überspringen.

.. figure:: ../media/ubuntu-installation_003_keyboard-configuration.png
   :align: center
   :alt: Auswahl des Tastaturlayouts 

Wir beschreiben die Funktion `Tastatur erkennen` solltest du Belegung und Variante kennen, kannst du das hier direkt auswählen und mit `Enter` `weiter voranschreiten`_ : 

.. figure:: ../media/ubuntu-installation_004_keyboard-autodetection.png
   :align: center
   :alt: Einleitung der Tastatur-Autoerkennung

Der Text in der Grafik erklärt das weitere Vorgehen. Folge einfach den dargestellten Bildern und beachte den dargestellten Mauszeiger bzw. den grünen oder grauen Auswahlmöglichkeiten.

.. figure:: ../media/ubuntu-installation_005_select-key.png
   :align: center
   :alt: 

.. figure:: ../media/ubuntu-installation_006_question4key.png
   :align: center
   :alt: 

.. figure:: ../media/ubuntu-installation_007_press-key.png
   :align: center
   :alt: 

.. figure:: ../media/ubuntu-installation_008_question4key.png
   :align: center
   :alt: 

.. figure:: ../media/ubuntu-installation_009_keyboard-pre-confirmation.png
   :align: center
   :alt: 

.. figure:: ../media/ubuntu-installation_010_keyboard-confirmation.png
   :align: center
   :alt: 

.. _`weiter voranschreiten`:

Als nächstes geht es an die Einrichtung der Netzwerkschnittstelle. Das nachfolgende Bild veranschaulicht die momentane Netzwerkanbindung für die Installation.

.. todo:: Grafik überarbeiten - Proxmox ersetzen durch (Virtualisierungs)-Host.

.. figure:: ../media/install_01_network-4-installation.svg
   :align: center
   :alt: Netzwerkstruktur zur Einrichtung
   
Also dein Host ist an dem selben Switch angeschlossen wie dein Router.

Wir gehen davon aus das dein Router IP-Adressen via DHCP vergibt.

Wenn dein Host momentan nur mit einer Schnittstelle angeschlossen ist, solltest du ein fast identisches Bild erhalten.

.. figure:: ../media/ubuntu-installation_011_network-interface-selection.png
   :align: center
   :alt: Auswahl der Netzwerk-Schnittstelle

Einzige Abweichung können die Bezeichnung `ens18` und die erhaltene Adresse sein. Solltest du solch eine Abweichung feststellen, dann wirst du die Konfiguration manuel ausführen müssen. Dafür benötigst du die IP-Adresse, das Gateway und den DNS-Server (z.B. für die Kunden von Belwue). 

Wichtig ist dabei, dass du die richige Schnittstelle ausgewählt hast, die mit deinem Switch/Router verbunden ist.

.. figure:: ../media/ubuntu-installation_012_proxy-konfiguration.png
   :align: center
   :alt: Eingabe einer eventuellen Proxy-Adresse für den Internet-Zugriff

Eventuell brauchst du für den Internetzugang in deiner Infrastruktur einen Proxy-Server. Dessen Daten müsstest du wie in der letzten Zeile "http://..." beschrieben eingeben. Mit `Erledigt` geht es weiter.

.. figure:: ../media/ubuntu-installation_013_update-server.png
   :align: center
   :alt: Auswahl eines alternativen Spiegelservers

Solltest du wissen, das deine Internet-Verbindung über einen bestimmten Spiegelserver schneller ist, dann könntest du ihn hier angeben. Ist in aller Regel aber nicht notwendig.

Nun geht es daran die Festplatte(n) einzurichten.

.. figure:: ../media/ubuntu-installation_014_hdd-konfiguration.png
   :align: center
   :alt: Konfiguration der Festplatten

Im Beispiel wird `Geführt - gesamte Platte verwenden und LVM einrichten` gewählt. Wer eine Festplatte bzw. ein RAID verwendet, die eine Partitionierung enthält, dem wird dementsprechend die Option zur Wiederverwendung angeboten. Hast du bereits eine exisitierenden Partition und ein existierendes LVM und willst sie `nicht` wiederverwenden, so muss du dementsprechend zustimmen, dass die existierenden Daten entfernt werden.

.. figure:: ../media/ubuntu-installation_015_summary-hdd-configuration.png
   :align: center
   :alt: 

Bevor die von dir vorgenommenen Änderungen auf die Festplatte geschrieben werden, wird dir eine Übersicht deiner getroffenen Auswahl angezeigt. Mit `Erledigt` verlässt du diese Ansicht.  

.. figure:: ../media/ubuntu-installation_016_hdd-configuration-confirm.png
   :align: center
   :alt: 

Im Anschluss musst du auf alle Fälle dem Schreiben der Änderungen auf die Speichergeräte mit `Fortfahren` zustimmen.

.. figure:: ../media/ubuntu-installation_017_user-registration.png
   :align: center
   :alt: 

In dieser Maske gibst du deinem Systembenutzer ebenso einen passenden Namen wie deinem Host. Es wird empfohlen wie im Beispiel ``host``, als Rechnernamen zu verwenden. Der Benutzername wird im Beispiel ``administrator`` genannt und für dessen Zugang solltest du ein sicheres Passwort vergeben. Deine Eingaben übernimmst du mit `Erledigt`. Sollten die Passwörter nicht identisch sein, wirst du darauf hingewiesen.

.. figure:: ../media/ubuntu-installation_018_install-openssh.png
   :align: center
   :alt: 

Den OpenSSH-Server musst du für die weitere Verwendung auf alle Fälle aktivieren. Die Frage nach der SSH-Identität kannst du verneinen.

.. figure:: ../media/ubuntu-installation_019_optional-software.png
   :align: center
   :alt: 

Von den vorgeschlagenien Programmen brauchst du keine. Mit `Erledigt` beginnt der eigentliche Installationsvorgang über dessen Stand dich dann die folgende Ansicht informiert. Dieses erkennst du in dem oberen Feld daran, dass dort "Installation des Grundsystemes" steht.

Die Ansicht wechselt zwar irgendwann nach "Installation komplett", aber es werden noch Sicherheits-Aktualisierungen nachgeladen und installiert.

.. figure:: ../media/ubuntu-installation_020_first-update.png
   :align: center
   :alt: 

Diesen Vorgang solltest du nicht mit `Aktualisierung abbrechen und neustarten` unterbrechen.  

.. figure:: ../media/ubuntu-installation_021_finish-installation.png
   :align: center
   :alt: 

Nach Abschluss der Aktualisierung, erkennbar daran, dass dir nur noch `Neustart` als Auswahlmöglichkeit angeboten wird, startest du deinen Host neu. 

Nach dem Neustart meldest du dich an der Konsole mit deinen Zugangsdaten das erste Mal an.

.. figure:: ../media/ubuntu-installation_022_first-login.png
   :align: center
   :alt: 

Dort erkennst du das noch Updates ausstehen. Diese installierst du als Erstes mit

.. code::

  sudo apt update && sudo apt upgrade

Installation der KVM-Pakete
---------------------------

Die qemu/KVM-Software installierst du mit den folgenden Befehlen durch das Bestätigen der jeweiligen Fragen.

.. code::

   sudo apt install libvirt-bin qemu-kvm kpartx qemu-utils

Weitere benötigte Programme und Bibliotheken werden automatisch aufgelöst und dir zur Ansicht gebracht. Diese Auswahl musst du mit ``Y`` bestätigen.

Nach der Abarbeitung des letzten Befehls schließt der folgende Befehl die Installation der KVM-Pakete ab.

.. code::

   sudo apt --no-install-recommends install virtinst

Einrichten der Zeitsynchronisation
----------------------------------

In dem Intranet, welches du ja einrichtest, sollten alle Systemuhren die gleiche Zeitbasis verwenden. Aus diesem Grund richtest du jetzt auf deinem Virtualisierungshost einen Zeitserver-Dienst ein. Außerdem wird bei der Analyse von Logdateien so die Suche vereinfacht.

.. code-block:: console

   Installieren von ntpdate
   $ sudo apt install ntpdate

   Einmaliges Stellen der Uhrzeit
   $ sudo ntpdate 0.de.pool.ntp.org

   Installieren des NTP-Daemons
   $ sudo apt install ntp

   Anzeigen der Zeitsynchronisation
   $ sudo ntpq -p

Weiter geht es mit dem Import der Virtuellen Maschinen.

.. toctree::
  :maxdepth: 2
  :caption: Externe Dienste
  :hidden:

  import-kvm-vms

.. todo::

   Nachfolgende auskommentierte Zeilen im rst-Filei müssen entfernt werden, wenn das Kapitel redigiert ist.

.. Netzwerkkonfiguration des KVM-Hosts
   ===================================
   
   Nach der Installation der KVM-Software (``virbr0*`` wurden automatisch hinzugefügt) ist die Netzwerksituation folgende:

   .. code::

      $ ip -br addr list
      lo               UNKNOWN        127.0.0.1/8 ::1/128 
      enp0s8           DOWN        
      enp0s17          UP             192.168.1.2/16 fe80::ae1c:ba12:6490:f75d/64
      virbr0           DOWN           192.168.122.1/24 
      virbr0-nic       DOWN           

   Im nächsten Schritt wird die direkte Verbindung des KVM-Hosts mit dem Internet gekappt und eine virtuelle Verkabelung über sogenannte `bridges` erstellt.

    *  Zunächst werden die Brücken ``br-red`` (Internetseite) und ``br-server`` (Schulnetzseite) definiert.
    
    *  Zuletzt kann der KVM-Host auch über die Brücke ``br-red`` eine IP-Adresse ins Internet bekommen, genau wie er über die Brücke ``br-server`` auch im pädagogischen Netzwerk auftauchen kann. Letzteres ist nicht zu empfehlen.

    .. hint:: Komplett raus? Tests erforderlich

   .. hint::

      Die Netzwerkkonfiguration wird seit Ubuntu 18.04 standardmäßig über netplan realisiert. Wer seinen KVM-Host von früheren Ubuntu-Versionen updatet, bei dem wird nicht automatisch `netplan` installiert, sondern `ifupdown` wird mit der Konfigurationsdatei ``/etc/network/interfaces`` beibehalten.

   Namen der Netzwerkkarten
   ------------------------

   .. todo:: Ändere enp0s18 in enp0s8

   Mit dem folgenden Befehl 

   .. code::
      
      dmesg | grep eth
  
   werden dir alle physischen Netzwerkkarten angezeigt:

   .. code::

      [    9.432342] e1000e 0000:08:00.0 enp0s18: renamed from eth0
      [    9.654232] e1000e 0000:11:00.1 enp0s17: renamed from eth1

   Die Netzwerkkonfiguration enthält standardmäßig die Schnittstelle, die bei der Installation mit dem Internet verbunden war. 

   .. code:: 

      cat /etc/netplan/00-installer-config.yaml

   .. code::

      # This is the network config written by 'subiquity'
      network:
        ethernets:
          enp0s18:
            dhcp4: true
      version: 2
   
   Damit hast du nun alle Informationen gesammelt um die Netzwerkkonfiguration mit einem Editor deiner Wahl zu erstellen. (Hier am Beispiel nano)

   .. code::

     $ sudo nano /etc/netplan/01-netcfg.yaml

   Diese Schnittstelle wird dann auch mit der Brücke ``br-red`` verbunden. 

   .. code::

      network:
        version: 2
        renderer: networkd
        ethernets:
          enp0s8:
            dhcp4: no
          enp0s17:
            dhcp4: no
        bridges:
          br-red:
            interfaces: [enp0s18]
            dhcp4: yes
          br-server:
            interfaces: [enp0s17]
            addresses: [ ]

   .. hint:: Als Hinweis für die Syntax merke dir:

      * Jede Zeile besteht aus einem Wertepaar ``Schlüssel: Wert``
      * Ist der Schlüssel im Singular, dann folgt der dazugehörende Wert
      * Ist der Schlüssel im Plural und es folgt kein in Klammern ``[]`` gesetzteŕ Wert, dann beziehen sich die nächsten Zeilen auf diesen Schlüssel 
        Dessen Zeilen müssen durchgehend um die gleichen Anzahl von identischen Zeichen eingerückt sein 
     
      Potenzielle Fehlerquellen sind also nicht konsequent eingerückte Zeilen (Leerzeichen, TABs). 

   Diese Netzwerkkonfiguration kann nun ausprobiert und angewandt werden. 

   Nach dem Aufruf von 

   .. code::

      sudo netplan try
   
   hast du 120 Sekunden Zeit die gemachten Einstellungen zu übergrüfen. Der Befehl 

   .. code:: 

   sudo ip address

   sollte dir jetzt deine Konfiguration anzeigen.

   .. todo:: richtige Konfiguraton zeigen

   Zur Übernahme der Konfiguration gibt du folgenden Befehl ein:

   .. code:: 

      sudo netplan apply

.. .. error:: Wie beschrieben ist die Einrichtung nun richtig. Führt allerdings zum Verlust der Verbindung.

   .. code::

     Invalid YAML at /etc/netplan/01-netcfg.yaml line 6 column 0: found character that cannot start any token

  Bei fehlerhaften Anläufen lohnt es sich, den KVM-host zu rebooten und die Netzwerkkonfiguration erneut zu betrachten. 
  
  .. hint:: Soll das wirklich so beschrieben werden?

     KVM-Host auch im Internet

     Soll später nicht nur die Firewall sondern auch der KVM-Host im Internet erreichbar sein, dann muss der entsprechende Block so aussehen:

     .. code::

        network:
          ...
          bridges:
            br-red:
              interfaces: [enp0s17]
              dhcp4: yes
            br-server:
              ...

     Wer bisher einen statischen Zugang eingerichtet hatte, der kann das genauso hier tun. Der entsprechende Abschnitt wäre beispielhaft

     .. code::

        bridges:
          br-red:
            interfaces: [enp0s17]
              addresses: [141.1.2.5/29]
              gateway4: 141.1.2.3
              nameservers:
                addresses: [129.143.2.1]
     
