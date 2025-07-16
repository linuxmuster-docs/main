.. |zb| unicode:: z. U+00A0 B. .. Zum Beispiel 

.. |_| unicode:: U+202F
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. _what-is-linuxmuster.net-label:

========================
Was ist linuxmuster.net?
========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

linuxmuster.net ist eine Komplettlösung für den digital unterstützten Unterricht für Schüler:innen und Lehrer:innen einer zeitgemäßen Bildungseinrichtung.

Die langjährigen Erfahrungen aller Beteiligten aus der linuxmuster.net Gemeinde haben gezeigt, dass sich ein Firnmennetzwerk fundamental von den Anforderungen an ein 
heutige Schulnetz unterscheiden. 

Die Entwicklung von linuxmuster.net greift all diese Anforderungen auf und stellt eine modulare Lösung für ein Schulnetz zur Verfügung. 

Diese kann von einer Ein-Server-Lösung (mit drei virtuellen Maschinen - VMs) bis hin zu einer Mehr-Server-Lösung mit Cloud-Anbindung und BYOD-Integration und mehreren physikalischen Servern skaliert werden.

Die Anforderungen, die heute an ein Schulnetz gestellt werden, erklären wir im nachfolgenden Abschnitten detailliert. Im Anschluss zeigen wir auf, wie linuxmuster.net diese umsetzt.

Schulnetzwerk vs. "normales" Netzwerk
=====================================

**Welche Unterschiede in der IT in einer Firma und einer Schule sind für uns relevant?**

Im Prinzip gibt es vier große Merkmale, die auffallen:

1. Das Verhältnis der Anzahl von Usern zu den Arbeitsmitteln

.. tabularcolumns:: |c|c|c|c|

+-----------+-----------+
| Firma     | Schule    |
+------+----+------+----+
| User | PC | User | PC |
+======+====+======+====+
|  50  | 50 | 500  | 50 |
+------+----+------+----+

2. Die Zusammensetzung von Usern in Abteilungen/Gruppen

.. tabularcolumns:: |c|c|c|c|c|

+------------------+----+---------------+
|      Firma       |    |    Schule     |
+------+-----------+ vs +------+--------+
| User | Abteilung |    | User | Gruppe |
+======+===========+====+======+========+
|  A   | Marketing |    |  A   | Klasse |
|      |           |    |      +--------+
|      |           |    |      | Kurs 1 |
|      |           |    |      +--------+
|      |           |    |      | Kurs 2 |
|      |           |    |      +--------+
|      |           |    |      | AG 1   |
+------+-----------+    +------+--------+
|  B   | Marketing |    |  B   | Klasse |
|      |           |    |      +--------+
|      |           |    |      | Kurs 3 |
|      |           |    |      +--------+
|      |           |    |      | Kurs 2 |
|      |           |    |      +--------+
|      |           |    |      | AG 1   |
+------+-----------+----+------+--------+

3. Die Fluktuation im jährlichen Wechsel

   Zum Schuljahreswechsel verlässt eine große Anzahl an Schüler:innen die Einrichtung und neue Schüler:innen müssen in das System eingepflegt werden. Die Zusammensetzung der Klassen, Kurse und Arbeitsgruppen werden zu großen Teilen neu formiert, so dass Änderungen an bestehenden Schüler:innen erforderlich sind.

   Solch ein administrativen Aufwand ergibt sich in einer Firma selten.

4. Der Umgang mit den Arbeitsmitteln

   Schüler:innen teilen sich ein und dasselbe Arbeitsmittel im schulischen Alltag. Dabei ist es für die nächste Unterrichtseinheit entscheidend, dass zum Start immer eine einheitliche und funktionsfähige Umgebung auf den Rechnern vorhanden ist. Die zeitliche Taktung zwischen den Wechseln kann sehr kurz sein.

   Dies ist in einer Firma so nicht gegeben. Wenn ein User seinen Rechner verlässt, findet er ihn der Regel immer genauso wieder.

Aus diesen Gründen sprechen wir von einem

Schulnetz
=========

Mit linuxmuster.net wird die schulische IT mit einer voll integrierten Open-Source-Lösung abgebildet. Dieses umfasst alle Bereiche, die in einer Bildungseinrichtung anzutreffen sind.

Unser Anspruch liegt dabei auf der Bereitstellung eines Systems, das folgende Punkte erfüllt:

    * automatisierte Installation der Server-Komponenten
    * durch einen freien Zugang zu einer umfänglichen Dokumentation eine möglichst einfache Installation
    * einfache Integration in vorhandene Infrastruktur
    * bestehend aus Server, File-Server und vorkonfigurierten Arbeitsstationen. 
    * Integration einer bestehenden Firewall oder alternativ Integration der Open-Source Firewall OPNsense |reg|
    * mehrstufige ausbau- und anpassbare Struktur mit heterogenen Clients und unterschiedlichsten Diensten bzw. Cloud-Lösungen
    * ein frei zugängliches `Community-Wiki <https://wiki.linuxmuster.net/community/>`_ mit einer Vielzahl an ergänzenden Anleitungen und Erweiterungen aus dem Umfeld der Unterstützer von linuxmuster.net

**Schulnetz - Komplett - Anpassbar!**

.. image::    media/structure_of_version_7.svg
   :name:     structure-over-all 
   :alt:      gesamte Struktur

Ein Augenmerk liegt dabei auf der Unabhängigkeit eingesetzter Hard- und Software. Dieses wird unter anderem an dem Umfang der unterstützten Betriebssysteme für die Arbeitsstationen erkennbar.

Proprietäre Betriebssysteme, |zb| aus dem Hause Microsoft |reg|, können aufgrund der Lizenzpolitik der Hersteller nicht von uns vorbereitet ausgeliefert werden. Diese lassen sich aber ebenso leicht in unsere Infrastruktur integrieren, wie solche, die als Open-Source erhältlich sind.

Auf der Basis von Linux stellen wir ein Open-Source-Betriebssystem zur Verfügung, das folgende Vorteile bietet:

    * entwickelt von Praktikern für den täglichen Einsatz an Schulen
    * mit hilfreichen Schulfunktionen für den Unterrichtseinsatz
    * in einfacher Form anpass- und erweiterbar an die eigenen Bedürfnisse
    * keine Lizenzkosten

.. image::    media/structure_of_version_7_lmn.svg
   :name:     structure-basic-components
   :alt:      Struktur der Basis-Komponenten
   :width:    500px
   :align:    center

Im Zusammenspiel der Clients mit dem Server, dem File-Server und einer Firewall entsteht so die grundlegende professionelle Infrastruktur zur zentralen Administration der Schülergeräte und der Verwaltung des pädagogischen Schulnetzwerks.

Dieses lässt sich aufgrund des modularen Aufbaus weiter an die darüber hinausgehenden Anforderungen, unter anderem einer schulweiten WLAN-Verfügbarkeit erweitern und anpassen.

Die Basis
---------

linuxmuster.net ist eine Lösung, die auf drei Servern aufsetzt. 

Server 1: Der linuxmuster.net-Server
+++++++++++++++++++++++++++++++++++++

.. image::    media/structure_of_version_7_server.svg
   :name:     structure-lmn-server
   :alt:      Struktur der Basis-Komponente - LMN-Server

Die Basisdienste dieses Servers sind für die Funktion des ganzen Systems verantwortlich:

Benutzer- und Gruppenverwaltung
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Die Benutzer- und Gruppenverwaltung orientiert sich an den Bedürfnissen, die der Schulbetrieb vorgibt.

    * Schüler:innen bekommen mit der Einschulung ihren persönlichen Benutzer-Account.
    * Dieser bleibt ihnen bis zum Ende ihrer Laufbahn an der Schule erhalten.
    * Die Gruppenzugehörigkeit der einzelnen Schüler:innen werden in Klassen, Kursen und Projekten abgebildet.
    * Zu Beginn eines Schuljahres können diese Daten und Abhängigkeiten aus der Schulverwaltung mittels Import der Daten eingespielt bzw. fortgeschrieben werden.
      Gleiches gilt selbstverständlich auch für Veränderungen während eines laufenden Schuljahres.
    * Für Lehrer:innen gilt dies ebenso.
    * Zudem können Benutzer-Accounts sowie Gruppenzugehörigkeiten für Schulpersonal und Eltern nahtlos abgebildet werden.

Unterrichtssteuerung
^^^^^^^^^^^^^^^^^^^^

Vielfältige Möglichkeiten stehen den Lehrkräften zur Verfügung, um Einfluss auf die Rechner der zu Unterrichtenden zu nehmen.

    * Internet - An/Aus
    * Intranet - An/Aus
    * Wi-Fi - An/Aus
    * Drucker - An/Aus

Klassenarbeitsmodus
^^^^^^^^^^^^^^^^^^^^

In Prüfungssituationen wie Abitur, Klassenarbeiten und andere Leistungsüberprüfungen kann die Lehrkraft mit einfachen Mitteln die Nutzung des Systems für die Prüfungsgruppe einschränken. Das Spektrum umfasst dabei alle Möglichkeiten der Unterrichtssteuerung ergänzt um die Sperrung des persönlichen Speicherbereichs.

Server 2: Fileserver
++++++++++++++++++++

Dateiverwaltung und -verteilung
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. image::    media/structure_of_version_7_fileserver.svg
   :name:     structure-fileserver
   :alt:      Struktur der Basis-Komponente - Fileserver

Alle Nutzer besitzen einen persönlichen Bereich auf dem Netzwerkspeicher (File-Server).

Ebenso steht er allen Gruppen für den Austausch ihrer gemeinschaftlichen Arbeiten zur Verfügung. 

Server 3: Firewall
++++++++++++++++++

OPNsense |reg|
^^^^^^^^^^^^^^
Durch die Integration der Firewall an AD DS (Active Directory Domain Services) des Servers werden sämtliche Benutzer-Zugriffe der Nutzer mittels Single-Sign-On auf das Internet geregelt.

Die Open-Source Firewall OPNsense |reg| wird nach einer auszuführenden Grundinstallation in das System der linuxmuster-net-Server aufgenommen. Hierfür wurde das Setup des linuxmuster.net Server so vorbereitet, dass die Integration bereits vollständig durchgeführt wird.

Sämtliche verfügbaren Bausteine dieser Open-Source-Firewall stehen selbstverständlich zur Verfügung.

Für weitergehende Informationen `siehe opnsense.org <https://opnsense.org/>`_.

.. image::    media/structure_of_version_7_firewall.svg
   :name:     structure-firewall
   :alt:      Struktur der Basis-Komponente - Firewall 

Bestehende Firewall
^^^^^^^^^^^^^^^^^^^
Es kann auch eine bestehende Firewall weiter genutzt und vollständig in linuxmuster.net integriert werden. Da diese Intergration von deren verwendeten Betriebssystem abhängt und unterschiedliche Schritte erfordert, können wir nicht eine datailierte Anleitung hier aufzeigen. Geben aber Hinweise dazu im Kapitel `Anpassbar`_. 

  
Selbstheilende Arbeitsstationen durch LINBO 4.3
+++++++++++++++++++++++++++++++++++++++++++++++

.. image::    media/structure_of_version_7_client.svg
   :name:     structure-linbo-client-management
   :alt:      Struktur der Basis-Komponente - LINBO (Client-Managements)

Das Konzept der Selbstheilenden Arbeitsstationen (SheilA) ermöglicht einheitliche, identische Schulungssysteme. Diese können bei jedem Start der Rechner in einen vorher definierten Zustand zurückgesetzt werden. Dieser Standard wird durch die letzte Veränderung oder Installation festgelegt, in dem ein Abbild des Betriebssystems auf dem Server gespeichert wird. Weitere Vorteile sind:

    * verschiedene Betriebssysteme auf jedem Client möglich
    * schnelle Erst- oder Neueinrichtung
    * keine Einschränkung der Nutzer durch Benutzerrechte auf den Clients nötig
    * einfache Wiederherstellung der Clients ist jedem Benutzer möglich
    * einfache Softwareverteilung durch Installation auf einem Client - keine gesonderten Kenntnisse erforderlich, bei demjenigen, der die Software-Installation betreut.
    * Möglichkeit der zeit- und/oder ferngesteuerten Aktualisierung der Clients.
    * Möglichkeit sich via VNC auf den LINBO-Client aufzuschalten.
    * mit sogenannten Postsync-Scripten kann der Administrator für einzelne, raumweite oder für alle Geräte notwendige Konfigurationsänderungen beim Systemstart einpflegen.

Nähere Information sind im Kapitel "Clientverwaltung" beschrieben.

Integration unterschiedlicher Geräte (BYOD)
+++++++++++++++++++++++++++++++++++++++++++

Da sich alle Steuerungsfunktionen in unserer Lösung an den Benutzern orientieren, ist es unerheblich an welchem Gerät sie sich befinden. Das Gleiche gilt auch für mitgebrachte Geräte, die sich via WLAN verbinden.


Anpassbar
---------

.. hint::

   Grafik ist noch anzupassen

.. image::    media/structure_of_version_7_community.svg
   :name:     structure-community-components
   :alt:      Struktur der Erweiterungen (Community)
   :height:   500px
   :align:    center 

Alle bisher vorgestellten Basisdienste werden mithilfe des Setups konfiguriert, bleiben aber frei anpass- und erweiterbar. Es folgt eine einführende Beschreibung der letzten drei Bausteine, die linuxmuster.net zu der Komplettlösung machen.

Bestehende oder alternative Firewall
++++++++++++++++++++++++++++++++++++

   .. image::    media/structure_of_version_7_alternate.svg
      :name:     structure-alternativ-firewall
      :alt:      Struktur der Einbindung einer alternativen Firewall
      :width:    150px
      :align:    right

Wenn diese Firewall über die Möglichkeit einer Anbindung an den Samba4-Dienst des linuxmuster.net-Servers verfügt, kann diese problemlos genutzt werden.

Dafür sind folgende Schritte erforderlich:

1. Installation und Setup des linuxmuster.net - Server für das Dienst-, User- und Client-Management
2. Installation und Einbindung des linuxmuster.net - File-Server für die Bereitstellung von Speicherplatz für Benutzer, Klassen etc.
3. Anpassung der bestehenden Firewall, um die Internet-Sperre u.a. Dienste von linuxmuster.net voll zu unterstützen.

.. hint::

   In der bestehenden Firewall müssen hier

   - Routen gesetzt
   - für die Internetsperre die Gruppenmitgliedschaften im AD abgefragt
   - ein Zeitserver bereitgestellt
   - ein DNS-Forwarder so konfiguriert werden, dass externe URLs aufgelöst und lokale URLs an den AD weitergeleitet werden, der für die lokale Zone als DNS arbeitet
 
Optionale Server
++++++++++++++++

Für weitergehende Anpassungen besteht die Möglichkeit, optionale Server einzubinden.

   .. image::    media/structure_of_version_7_optional.svg
      :name:     structure-option-server
      :alt:      Struktur der Einbindung optionaler lokaler Server
      :width:    150px
      :align:    right

In der Darstellung ist etwa ein Docker-Server als Erweiterung an die Bedürfnisse der Bildungseinrichtung eingebunden. Docker ist ein Open-Source-Projekt zur automatisierten Anwendungsverteilung durch Container, die alle benötigten Pakete mitbringen. So vereinfacht sich die Bereitstellung und Verteilung. Außerdem gewährleisten sie die Trennung und Verwaltung der auf dem Docker-Server genutzten Ressourcen.

Für weitergehende Informationen siehe die Docker-Homepage: https://www.docker.com


externe Dienste / Server
++++++++++++++++++++++++

Ein Porfolio an unterschiedlichen externen Diensten / Servern lässt sich an die linuxmuster.net Lösung anbinden, sodass eine einheitliche Authentifizierung erfolgt.

.. hint::

   Grafik ist noch anzupassen

   .. image::    media/structure_of_version_7_extra.svg
      :name:     structure-extra-server-and-services
      :alt:      Struktur der Einbindung externer Server und Dienste
      :width:   150px
      :align:    right

Es können extern gehostete Server wie Nextcloud, Moodle, Konferenzsysteme oder andere Dienste integriert werden.

Eine weitere Alternative wäre die Integration von verschiedenen Diensten mittels edulution.io. Für weitere Informationen zu dieser als open-source-software frei verfügbare Lösung siehe `edulution.io <https://ask.linuxmuster.net/t/edulution-io-ankuendigungen-news/11388>`_

:download:`Vorgestellte Struktur als Inkscape SVG <media/structure_of_version_7_simple.svg>`

Support
-------

Die unter `Die Basis`_ vorgestellten Bestandteile werden vom Verein **linuxmuster.net e. V.** entwickelt und unterstützt.

Diese Unterstützung wird durch das

   **Hilfe-Forum** `<https://www.linuxmuster.net/de/support-de/discourse-forum/>`_

und die

   **telefonische Hotline** `<https://www.linuxmuster.net/de/support-de/hotline/>`_

geleistet.

   **All diese Leistungen sind nicht von einer Mitgliedschaft im Verein abhängig.**

   Aufgrund der Vielzahl möglicher Einsatzszenarien umfasst der telefonische Support alle bereitgestellten Basis-Dienste, die in der Dokumentation beschrieben sind.

   **Das Support-Team berät aber gerne und zeigt alle Möglichkeiten und Alternativen auf.**



