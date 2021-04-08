.. include:: /guided-inst.subst

.. _network-label:

===============================
Anpassung des Netzwerkbereiches
===============================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_


Voreingestellten Netzbereich verwenden
--------------------------------------

Allgemeine Hinweise
^^^^^^^^^^^^^^^^^^^

Die linuxmuster.net-Lösung kann mit unterschiedlichen IP-Bereichen arbeiten. Standardmäßig wird das interne Netz aus dem privaten IPv4-Bereich 10.0.x.x mit der 16-bit Netzmaske 255.255.0.0 eingerichtet. Die virtuellen Appliances sind mit diesem Netz voreingestellt.

Jedoch kann man sowohl die bisher in früheren Versionen von linuxmuster.net verwendeten Netze (10.16.0.0/12 oder 10.32.0.0/12 usw.) weiterverwenden.

Sollten es zwingende Gründe erfordern, sind auch komplett andere private Adressbereiche realisierbar.

Bei einer Migration wird empfohlen, den früheren IP-Bereich zu behalten.

Standard IP-Adressen
^^^^^^^^^^^^^^^^^^^^

Hast du die VMs imporiert und nimmst keinerlei Änderungen vor, dann weisen diese folgende voreingestellten IP-Adressen auf.

========== ===========
Server     IP-Bereich 
           10.0.0.0/16
========== ===========
OPNsense®  10.0.0.254 
Server     10.0.0.1   
Opsi       10.0.0.2   
Dockerhost 10.0.0.3   
XOA (*)    10.0.0.4   
Admin-PC   10.0.0.10  
========== ===========

.. hint::

   (*) Die XenOrchestra-Appliance (XOA) wird nur benötigt, wenn eine Virtualisierung mit XCP-ng erfolgen soll. Mithilfe von XenOrchestra kann die Virtualisierungsumgebung XCP-ng web-basiert verwaltet werden werden.

Proxmox - Besonderheiten
^^^^^^^^^^^^^^^^^^^^^^^^

Nach der beschriebenen Installation und Einrichtung des Proxmox-Host und dem Import der VMs muss der Proxmox - Host noch in ein anderes Netz gebracht werden, damit dieser nicht im externen Netz erreichbar ist.

Die erforderlichen Schritte sind in nachstehend verlinktem Kapitel beschrieben.

+--------------------------------------------------------------------+-------------------------------------------+
| Absicherung der Proxmox UI                                         | |follow_me2proxmox-ui-protection_a|       |
+--------------------------------------------------------------------+-------------------------------------------+

.. toctree::
  :maxdepth: 3
  :caption: Voreingestellten Netzbereich verwenden
  :hidden:

  proxmox-ui-protection

Netzbereich-Anpassung
---------------------

Die Umstellung auf einen anderen Netzbereich als dem zuvor dargestellten Standard-Netzbereich ist immer vor Aufruf des Erst-Setups druchzuführen. Dazu sind einige Schritte in der nachstehend dargestellten Reihenfolge durchzuführen.

Ablauf
^^^^^^

Voraussetzung: Die imporierten VMs wurden gestartet

  1. IPs der OPNsense® auf die bisher verwendeten bzw. die gewünschten IPs/Netze anpassen
  2. VMs (server, opsi, docker, ggf. XOA): Mit ``netplan`` die IPs so ändern, dass diese die korrekte IP im internen (grünen) Netz nach neuer Struktur oder nach früherer Struktur (Migration) haben.
  3. VMs vor dem Erst-Setup auf die neue Netzstruktur vorbereiten (linuxmuster-prepare)
  4. Erreichbarkeit der VMs im internen Netz testen.
  5. Update der VMs
  6. Erst-Setup durchführen

IPs OPNsense® anpassen
^^^^^^^^^^^^^^^^^^^^^^

Die IP der externen Schnittstelle (WAN) der OPNsense® ist ggf. anzupassen. Diese ist in der Erstauslieferung so konfiguriert, das diese eine IP via DHCP erhalten würde. Sollte die OPNsense® Firewall hinter einem Router arbeiten, so sollte eine Anpassung erfolgen und eine statische IP eingetragen werden.

Hierzu rufst du auf der Konsole in der OPNsense®, nachdem du dich als ``root`` angemeldet hast, den Punkt ``2) Set interface IP address`` auf. Wähle zunächst die WAN-Schnittstelle aus und träge die IP-Adresse aus deinem lokalen Netz mit korrekter Subnetzmaske, Gateway und DNS ein.

Danach wählst du die ``LAN-Schnittstelle`` aus und konfigurierst die neue IP. Bei einer Migration ist dies die IP, die im IPFire bereits genutzt wurde.
Hast du z.B. ein Subnetting für das Server-Netz in der v6.2 genutzt, das im "grünen" Netz den Bereich 10.16.1.0/24 vorsieht,
so vergibst du hier auf der LAN-Schnittstelle der OPNsense® die IP 10.16.1.254/24 (Subnetmask 255.255.255.0 = 24 Bit).

Bei vorhandener Subnettierung dürfte für o.g. bsp. der L3-Switch im Server - VLAN die IP 10.16.1.253 haben. Zudem ist darauf zu achten, dass auf der Virtualisierungsumgebung die korrekten Bridges für das jeweilige VLAN den Schnittstellen der VMs korrekt zugeordnet wurden.

Wählst du einen neuen IP-Bereich, so weise der LAN-Schnittstelle die letzte nutzbare IP des gewünschten Netzes zu.
Sollte du z.B. für das interne / grüne Netz mit 10.1.1.0/24 verwenden, so konfigurierst du hier die IP: 10.1.1.254/24

VMs vorbereiten
^^^^^^^^^^^^^^^

netplan
"""""""

Die VMs server, opsi, docker und ggf. xoa müssen nun ``vor dem Erst-Setup`` vorbereitet werden.

In der Datei ``/etc/netplan/01-meine-netzconfig.yaml`` - Name bitte auf dein System anpassen - sind die Netzwerkeinstellungen 
wie folgt zu ändern 
(**Hinweis:** nachstehende Angaben greifen o.g. Beispiel hier nur für die Server-VM auf):

.. code::

  network:
   version: 2
   renderer: networkd
   ethernets:
    enp0s3:
       dhcp4: no
       dhcp6: no
       addresses: [10.16.1.1/24]
       gateway4: 10.16.1.254
       nameservers:
         addresses: [10.16.1.254, 10.16.1.1]

Danach speicherst du die Änderungen und wendest diese mit folgendem Befehl an und testest, ob die Firewall im internen Netz erreichbar ist:

.. code::

  netplan apply
  ping 10.16.1.254

Erhälst du erfolgreich Pakete zurück, so kannst du die Firewall erreichen. Diese Schritte wiederholst du dann mit den VMs opsi, docker und ggf. xoa. Hierbei gibst du dann die jeweils korrekten IPs (abweichend zu o.g. Beispiel) an.

Können alle VMs im internen Netz sich untereinander via ping erreichen, bereitest du die VMs mit ``linuxmuster-prepare`` vor.

linuxmuster-prepare
"""""""""""""""""""

.. hint::

   Detailliertere Informationen zu linuxmuster-prepare sind hier dokumentiert :ref:`modify-net-label`

Jetzt meldest du dich auf der Eingabekonsole an den VMs server, opsi, docker und ggf. xoa an.

Du bereitest diese VMs für das Erst-Setup vor, indem du die korrekten Angaben zur gewünschten IP der VM und der Firewall mit linuxmuster-prepare angibst.

Gehen wir davon aus, dass du für die Server-VM im vorangegangenen Schritt die IP ``10.16.1.1/24`` und für die 
OPNsense® als Firewall die IP ``10.16.1.254/24`` zugeordnet hast. Zudem nehmen wir an, dass Deine zukunftige Schuldomäne den Namen ``schuldomaene`` erhalten wird und deine Domain ``meineschule``.``de`` lautet.

Mit diesen Vorgaben bereitest du die Server-VM nun mit folgendem Befehl auf das Setup vor:

.. code::

   linuxmuster-prepare -s -u -d schuldomaene.meineschule.de -n 10.16.1.1/24 -f 10.16.1.254

Gleiches Vorgehen wählst du zur Vorbereitung der VMs opsi, docker und ggf. xoa, aber mit abweichender IP für die Option ``-n``.
Starte nach den Anpassungen jede der VMs neu mit ``reboot``.

Tests & Setup
"""""""""""""

Teste nun die Erreichbarkeit der VMs im internen Netz mit folgenden Befehlen (angepasst auf o.g. Bsp.):

.. code::

   ping 10.16.1.254
   ping 10.16.1.1
   ping 10.16.1.2
   ping 10.16.1.3
   ping 10.16.1.4

Funktioniert dies von allen VMs aus korrekt, so kann jetzt die Aktualisierung aller VMs erfolgen.

Aktualisiere jede VM mit folgendem Befehl:

.. code::

   apt update
   apt dist-upgrade

Starte danach alle VMs neu.

Nach dem Neustart meldest du dich an der Server-VM als Benutzer ``root`` an und rufst das Setup auf:

+--------------------------------------------------------------------+-------------------------------------------+
| linuxmuster-setup                                                  | |follow_me2setup|                         |
+--------------------------------------------------------------------+-------------------------------------------+


Willst Du eine Migration durchführen, durchläufst du die nachstehend dargestellten Schritte nach der erfolgreichen Durchführung des Setups.

.. toctree::
  :maxdepth: 3
  :caption: Netzbereich anpassen
  :hidden:

  preliminarysettings/index


Hinweise zur Migration
""""""""""""""""""""""

.. hint::

   Möchtest du eine Migration durchführen, so must du nach Anpassung des Netzbereichs zunächst das Erst-Setup durchführen.

