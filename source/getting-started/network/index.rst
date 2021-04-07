.. include:: /guided-inst.subst

.. _network-label:

===============================
Anpassung des Netzwerkbereiches
===============================

.. sectionauthor:: `@Name des Autors in ask <https://ask.linuxmuster.net/u/Dein_Name>`_

.. hint:: Verlinkung der Unterabschnitte:

   * Für die Migration

   * Netzbereich abweichend von 10.0.0.0/16 ohne Segmentierung

   * Netzbereich abweichend von 10.0.0.0/16 mit Segementierung 


.. todo:: Inhalt ergänzen
          ...

Default-Netzbereich verwenden
-----------------------------

...

+--------------------------------------------------------------------+-------------------------------------------+
| Absicherung der Proxmox UI                                         | |follow_me2proxmox-ui-protection_a|       |
+--------------------------------------------------------------------+-------------------------------------------+


Netzbereich-Anpassung
---------------------

Ablauf
------

1. VMs importieren
2. VMs starten
3. IPs der OPNsense® auf die bisher verwendeten IPs/Netze anpassen
4. VMs (server, opsi,docker) mit netplan die IPs so ändern, dass diese die korrekte IP im internen (grünen) Netz haben wie bisher
5. VMs vor dem Setup auf die neue Netzstruktur vorbereiten (linuxmuster-prepare)
6. Erreichbarkeit der VMs im internen Netz testen.
7. Update der VMs
8. Erst-Setup durchführen

IPs OPNsense® anpassen
----------------------

Die IP der externen Schnittstelle (WAN) der OPNsense® ist ggf. anzupassen. Diese ist in der Erstauslieferung so konfiguriert, das diese eine IP via DHCP erhalten würde. Sollte die OPNsense® Firewall hinter einem Router arbeiten, so kann eine Anpassung für eine statische IP erforderlich sein.

Hierzu rufst Du auf der Konsole in der OPNsense®, nachdem du dich als `root` angemeldet hast, den Punkt `2) Set interface IP address` auf. Solle eine DHCP-Konfiguration in deinem Netz hier nicht möglich sein,  wählst du zunächst die WAN-Schnittstelle aus und trägst die IP Adresse aus deinem lokalen Netz mit korrekter Subnetzmaske, Gateway und DNS ein.

Danach wählst du die `LAN-Schnittstelle` aus und konfigurierst die bisherige IP, die im IPFire bereits genutzt wurde.
Hast du z.B. ein Subnetting für das Server-Netz in der v6.2 genutzt, das im "grünen" Netz den Bereich 10.16.1.0/24 vorsieht, 
so vergibst du hier auf der LAN-Schnittstelle der OPNsense® die IP 10.16.1.254/24 (Subnetmask 255.255.255.0 = 24 Bit).

Bei vorhandener Subnettierung dürfte für o.g. bsp. der L3-Switch im Server - VLAN die IP 10.16.1.253 haben. Zudem ist darauf zu achten, dass auf der Virtualisierungsumgebung die korrekten Bridges für das jeweilige VLAN den Schnittstellen der VMs korrekt zugeordnet wurden.

VMs vorbereiten
^^^^^^^^^^^^^^^

netplan
"""""""

Die VMs server, opsi und docker müssen nun `vor dem Erst-Setup` vorbereitet werden.

In der Datei `/etc/netplan/01-meine-netzconfig.yaml` - Name bitte auf dein System anpassen - sind die Netzwerkeinstellungen 
wie folgt zu ändern (**Hinweis:** nachstehende Angaben greifen o.g. Beispiel hier nur für die Server-VM auf):

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

Erhälst du erfolgreich Pakete zurück, so kanst du die Firewall erreichen. Diese Schritte wiederholst du dann mit den VMs opsi und docker. Hierbei gibst du dann die jeweils korrekten IPs (abweichend zu o.g. Beispiel) an.

Können alle VMs im internen Netz sich untereinander via ping erreichen, bereitest du die VMs mit linuxmuster-prepare vor.

linuxmuster-prepare
"""""""""""""""""""

Jetzt meldest du dich auf der Eingabekonsole an den VMs server, opsi und docker an.

Du bereitest diese VMs für der Erstsetup vor, indem du die korrekten Angaben zur gewünschten IP der VM und der Firewall mit linuxmuster-prepare angibst.

Gehen wir davon aus, dass Du für die Server VM im vorangegangenen Schritt die IP `10.16.1.1/24` und für die 
OPNsense® als Firewall die IP `10.16.1.254/24` zugeordnet hast. Zudem nehmen wir an, dass Deine zukunftige Schuldomäne den Namen `schuldomaene` erhalten wird und deine Domain `meineschule`.`de` lautet.

Mit diesen Vorgaben bereitest du die Server-VM nun mit folgendem Befehl auf das Setup vor:

.. code::

   linuxmuster-prepare -s -u -d schuldomaene.meineschule.de -n 10.16.1.1/24 -f 10.16.1.254

Gleiches Vorgehen wählst du zur Vorbereitung der VMs opsi und docker, aber mit abweichender IP für die Option `-n`.
Starte nach den Anpassungen jede der VMs neu mit 'reboot'.

Tests & Setup
"""""""""""""

Teste nun die Erreichbarkeit der VMs im internen Netz mit folgenden Befehlen (angepasst auf o.g. Bsp.):

.. code::

   ping 10.16.1.254
   ping 10.16.1.1
   ping 10.16.1.2
   ping 10.16.1.3

Funktioniert dies von allen VMs aus korrekt, so kann jetzt die Aktualisierung aller VMs erfolgen.

Aktualisiere jede VM mit folgendem Befehl:

.. code::

   apt update
   apt dist-upgrade

Starte danach alle VMs neu.

Nach dem Neustart meldest du dich an der Server-VM als Benutzer `root` an und rufst das Setup mit folgendem 
Befehl auf:

+--------------------------------------------------------------------+-------------------------------------------+
| linuxmuster-setup                                                  | |follow_me2setup|                         |
+--------------------------------------------------------------------+-------------------------------------------+

Nach erfolgreichem Setup durchläuft du die nachstehend dargestellten schritte zur Migration.


Migration
---------

...

+--------------------------------------------------------------------+-------------------------------------------+
| Migration                                                          | |follow_me2network-migration|             |
+--------------------------------------------------------------------+-------------------------------------------+



Template für den Inhalt einer noch leeren Seite
-----------------------------------------------

Sicherlich ist der Inhalt dieser Seite nicht das was du gesucht und erwartest hast. Dieser Part der Dokumentation ist leider noch nicht mit Informationen gefüllt.

Eventuell kannst du uns helfen dieses zu ändern. Es gibt verschiedene Möglichkeiten uns zu unterstützen:

* Du weißt, was hier stehen müsste und könntest uns Text und/oder Screenshots liefern.

    Schicke deinen unformatierten Text oder die Bilder an dokumentation(et)linuxmuster.net oder einfach in unser Forum `<https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_.

* Du hast schon Erfahrung mit der vereinfachten Auszeichnugssprache RST (reStructuredText) oder willst sie erlernen.

    Unsere :ref:`guidelines-label` zeigen dir welche Absprachen wir diesbezüglich getroffen haben. Schicke uns deinen Inhalt für diese Seite an eine der zuvor genannten Adressen.

* Hast du eventuell schon einen git-hub-Account oder wolltest dich schon immer mit git befassen.
 
    Wir nutzen für die Organisation unserer Dokumentation git. Aus dem in github gehosteten RST-Files werden automatisch via ReadTheDocs (Sqhinx) diese Seiten hier erzeugt. 
 
    So hättest du direkt die Möglichkeit unsere Dokumentation zu verbessern. Dafür gibt es den Button der sich immer oben rechts auf den Seiten befindet: **Edit on GitHub**. Eine Beschreibung findest du hier: :ref:`edit-on-github-label`

* Du willst git auf deinem Rechner einsetzen um dort lokal arbeiten zu können.

    Auch dafür stehen wir dir hilfreich zur Seite, wie das geht haben wir hier :ref:`new-label` beschrieben.
  
Also wir würden uns freuen, wenn du uns unterstützen würdest. 

Wie immer bei linuxmuster.net niemand ist bei uns allein.
Für Fragen einfach einen Post an die im ersten Punkt genannten Adressen. (E-Mail oder Forum) 

Muster für Tabelle:

====== ===== ===== =======
\          XOR
--------------------------
\      Input       Output
------ ----------- -------
Lfd-Nr A     B     A xor B     
====== ===== ===== =======
1      0     0     0
2      0     1     1
3      1     0     1
4      1     1     0
====== ===== ===== =======

Muster für Verlinkung:


.. toctree::
  :maxdepth: 1
  :caption: Netzwerk Anpassungen
  :hidden:
  
  migration/index
  preliminarysettings/index
  networksegmentation/index
  segmentation/index
  proxmox-ui-protection
  network-test
