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

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_, `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

**Schulnetzwerk vs. "normales" Netzwerk**

Warum unterscheiden wir eigentlich zwischen einer IT in einer Firma und einer Schule?

Im Prinzip gibt es vier große Merkmale die auffallen:

1. Das Verhältnis von der Anzahl von Usern zu den Arbeitsmitteln

.. tabularcolumns:: |c|c|c|c|

+-----------++-----------+
| Firma     || Schule    |
+------+----++------+----+
| User | PC || User | PC |
+======+====++======+====+
|  50  | 50 || 500  | 50 |
+------+----++------+----+

2. Die Zusammensetzung von Usern in den Abteilungen  

.. tabularcolumns:: |c|c|c|c|

+------------------++---------------+
|      Firma       ||    Schule     |
+------+-----------++------+--------+
| User | Abteilung || User | Gruppe |
+======+===========++======+========+
|  A   |     1     ||  A   | Klasse |
|      |           ||      +--------+
|      |           ||      | Kurs 1 |
|      |           ||      +--------+
|      |           ||      | Kurs 2 |
|      |           ||      +--------+
|      |           ||      | AG 1   |
+------+-----------++------+--------+
|  B   |     1     ||  B   | Klasse |
|      |           ||      +--------+
|      |           ||      | Kurs 3 |
|      |           ||      +--------+
|      |           ||      | Kurs 2 |
|      |           ||      +--------+
|      |           ||      | AG 1   |
+------+-----------++------+--------+

3. Die Fluktuation im jährlichen Wechsel

   Zum Schuljahreswechsel verlässt eine große Anzahl an Schüler und Schülerinnen die Einrichtung und neue müssen in das System eingepflegt werden. Die Zusammensetzung der Klassen, Kurse und Arbeitsgruppen werden zu großen Teilen neu formiert.
  
   Solch einen administrativen Aufwand finden man in einer Firma äußerst selten.

4. Der Umgang mit den Arbeitsmitteln

   Aufgrund der Tatsache die im 1. Punkt dargelegt wurde, teilen sich Schüler und Schülerinnen ein und das selbe Arbeitsmittel im schulischen Alltag. Dabei ist es für die nächste Unterrichtseinheit unablässig, dass zum Start immer eine einheitliche Umgebung auf den den Rechner vorhanden ist. Die zeitliche Taktung zwischen den Wechseln kann sehr kurz sein.
   
   Dies ist in einer Firma so nicht gegeben. Wenn ein User seinen Rechner verlässt, findet er ihn der Regel immer genauso wieder.

Aus diesen Gründen sprechen wir von einem 

Schulnetz 
=========

Schulische IT wird mit einer voll integrierten Open-Source-Lösung abgebildet. Dieses umfasst alle Bereiche, die in einer Bildungseinrichtung anzutreffen sind.

Unser Anspruch liegt dabei auf der Bereitstellung eines Systems, das folgende Punkte erfüllt:

    * automatisierte Installation der Server-Komponenten
    * durch einen freien Zugang zu einer umfänglichen Dokumentation eine möglichst einfache Installation
    * einfache Integration in vorhandene Infrastruktur
    * bestehend aus Server, Firewall und vorkonfigurierten Arbeitsstationen
    * mehrstufige ausbau- und anpassbare Struktur mit heterogenen Clients und unterschiedlichsten Diensten bzw. Cloud-Lösungen
    * letzter Punkt ergänzt um das frei zugängliche `Community-Wiki <https://wiki.linuxmuster.net/community/>`_ mit Anleitungen vielfältigster Erweiterungen aus dem Umfeld der Unterstützer von linuxmuster.net

**Schulnetz - Komplett - Anpassbar!**

.. image::    media/structure_of_version_7.svg
   :name:     structure-over-all 
   :alt:      Struktur über alles
   :height:   40px

Ein Augenmerk liegt dabei auf der Unabhängigkeit von der eingesetzten Hard- und Software. Dieses wird zum Beispiel erkennbar an dem Umfang der unterstützten Betriebssysteme für die Arbeitsstationen.

Proprietäre Betriebssyteme, |zb| aus dem Hause Microsoft |reg|, können aufgrund der Lizenzpolitik der Hersteller nicht von uns vorbereitet ausgeliefert werden. Diese lassen sich aber ebenso leicht in unsere Infrastruktur integrieren, wie solche die als Open-Source erhältlich sind.

Auf der Basis von Linux stellen wir ein Open-Source-Betriebssytem zur Verfügung, das folgende Vorteile bietet:

    * entwickelt von Praktikern für den täglichen Einsatz an Schulen
    * mit hilfreichen Schulfunktionen für den Unterrichtseinsatz
    * in einfacher Form anpass- und erweiterbar an die eigenen Bedürfnisse
    * keine Lizenzkosten

.. image::    media/structure_of_version_7_lmn.svg
   :name:     structure-basic-components
   :alt:      Struktur der Basis Komponenten
   :width:    500px
   :align:    center

Im Zusammenspiel der Clients mit dem Server und einer Firewall entsteht so die grundlegende Infrastruktur. Diese lässt sich aufgrund des modularen Aufbaus weiter an die darüber hinausgehenden Anforderungen erweitern und anpassen.

.. image::    media/structure_of_version_7_server.svg
   :name:     structure-lmn-server
   :alt:      Struktur der Basis-Komponente - LMN-Server
   :height:   40px
   :align:    left

Die Basis
---------

Der linuxmuster.net-Server
++++++++++++++++++++++++++

Die Basisdienste des links abgebildeten Servers sind für die Funktion des ganzen Systems verantwortlich:

Benutzer- und Gruppenverwaltung
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Die Benutzer- und Gruppenverwaltung orientiert sich an den Bedürfnissen, die der Schulbetrieb vorgibt.

    * Schülerinnen und Schüler bekommen mit der Einschulung ihren persönlichen Benutzer-Account.
    * Dieser bleibt ihnen bis zum Ende ihrer Laufbahn an der Schule erhalten.
    * Die Gruppenzugehörigkeit der einzelnen Schülerinnen und Schüler werden in Klassen, Kursen und Projekten abgebildet.
    * Zu Beginn eines Schuljahres können diese Daten und Abhängigkeiten aus der Schulverwaltung mittels Import der Daten eingespielt bzw. fortgeschrieben werden.
      Gleiches gilt selbstverständlich auch für Veränderungen während eines laufenden Schuljahres.
    * Für Lehrerinnen und Lehrer gilt dies ebenso.

Unterrichtssteuerung
^^^^^^^^^^^^^^^^^^^^

Vielfältige Möglichkeiten stehen den Lehrkräften zur Verfügung, um Einfluss auf die Rechner der zu Unterrichtenden zu nehmen.

    * Internet - An/Aus
    * Intranet - An/Aus
    * WIFI - An/Aus
    * Drucker - An/Aus

Klassenarbeitsmodus
^^^^^^^^^^^^^^^^^^^^

In Prüfungssituationen wie Abitur, Klassenarbeiten und andere Leistungsüberprüfungen kann die Lehrkraft mit einfachen Mitteln die Nutzung des Systems für die Prüfungsgruppe einschränken. Das Spektrum umfasst dabei alle Möglichkeiten der Unterrichtssteuerung plus die Sperrung des persönlichen Speicherbereichs.

Dateiverwaltung und -verteilung
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Jeder Nutzer besitzt einen eigenen Bereich auf dem Netzwerkspeicher. Darüber hinaus steht ein solcher den Gruppen für den Austausch ihrer gemeinschaftlichen Arbeit zur Verfügung.

Selbstheilende Arbeitsstationen durch LINBO 4
+++++++++++++++++++++++++++++++++++++++++++++

.. image::    media/structure_of_version_7_client.svg
   :name:     structure-linbo-client-management
   :alt:      Struktur der Basis-Komponente - LINBO (Client-Managements)
   :height:   40px
   :align:    left 

Das Konzept der Selbstheilenden Arbeitsstationen (SheilA) ermöglicht einheitliche identische Schulungssysteme. Diese können bei jedem Start der Rechner in einen vorher definierten Zustand zurückgesetzt werden. Dieser Standard wird durch die letzte Veränderung oder Installation festgelegt, in dem ein Abbild des Betriebssytems auf dem Server gespeichert wird. Weitere Vorteile sind:

    * verschiedene Betriebssyteme auf jedem Client möglich
    * schnelle Erst- oder Neueinrichtung
    * keine Einschränkung der Nutzer durch Benutzerrechte auf den Clients nötig
    * einfache Wiederherstellung der Clients ist jedem Benutzer möglich
    * einfache Softwareverteilung durch Installation auf einem Client - keine gesonderten Kenntnisse erforderlich, bei demjenigen der die Software-Installation betreut.
    * Möglichkeit der zeit- und/oder ferngesteuerten Aktualisierung der Clients.
    * mit sogenannten Postsync-Scripten kann der Administrator für einzelne, raumweite oder für alle Geräte notwendige Konfigurationsänderung beim Systemstart einpflegen.

Die Funktionsweise wird am Beispiel eines Clients (rechts im Bild) beschrieben.
Auf dem Server (links im Bild) sind zwei Betriebssysteme für Clients dieses Typs komprimiert gespeichert. 

.. image::    ..//clients/linbo/media/linbo_functionality_detail.svg
   :name:     linbo-functionality
   :alt:      linbo-functionality
   :height:   150px
   :align:    center

* Der Benutzer wählt das erste Betriebssytem zum synchronisierten Start aus.
* Der Client überprüft, ob sein lokal gespeichertes Systemabbild identisch ist mit dem auf dem Server (1.).
* Dieses ist der Fall und der Client entpackt das erste Betriebssytem auf die eigentliche System-Partition und startet das System anschließend (3.). Wäre das nicht der Fall gewesen, hätte dieser zuerst das Systemabbild vom Server heruntergeladen (2.), um dann mit (3.) fortzufahren.

Der hier aufgezeigte Fall ist einer von vielen Einsatzszenarien und dient der Veranschaulichung. Nähere Information sind im Kapitel "Linbo nutzen" beschrieben.

Integration unterschiedlicher Geräte (BYOD)
+++++++++++++++++++++++++++++++++++++++++++

Da sich alle Steuerungsfunktionen in unserer Lösung an den Benutzern orientieren, ist es unerheblich an welchem Gerät sie sich befinden. Das Gleiche gilt auch für mitgebrachte Geräte, mit denen sie sich mit dem Intranet via WLAN verbinden.


.. image::    media/structure_of_version_7_firewall.svg
   :name:     structure-firewall
   :alt:      Struktur der Basis-Komponente - Firewall 
   :height:   40px
   :align:    left

Firewall
++++++++

Als Standard wird die Firewall OPNSense |reg| ausgeliefert.

Durch die Integration an den AD DS (Active Directory Domain Services) des Servers (Samba4) werden sämtliche Benutzer-Zugriffe der Nutzer mittels Single-Sign-On auf das Internet geregelt.

Sämtliche verfügbaren Bausteine dieser Open-Source-Firewall stehen selbstverständlich zur Verfügung.
Für weitergehende Informationen `siehe opnsense.org <https://opnsense.org/>`_.

.. note::
   Diese vorgestellten Bestandteile werden vom Verein
   **linuxmuster.net e. V. entwickelt und unterstützt**.

   Diese Unterstützung wird durch das

   **Hilfe-Forum** `<https://www.linuxmuster.net/de/support-de/discourse-forum/>`_

   und die

   **telefonische Hotline** `<https://www.linuxmuster.net/de/support-de/hotline/>`_ 

   geleistet.

   **All diese Leistungen sind nicht von einer Mitgliedschaft im Verein abhängig.**

   Aufgrund der großen Spannweite möglicher Einsatzszenarien umfasst der telefonische Support alle bereitgestellten Basis-Dienste, die in der Dokumentation beschrieben sind.

   **Das Support-Team berät aber gerne und zeigt alle Möglichkeiten und Alternativen auf.**

Anpassbar
---------

Alle bisher vorgestellten Basisdienste werden mithilfe des Setups konfiguriert, bleiben aber frei anpass- und erweiterbar. Es folgt eine einführende Beschreibung der letzten drei Bausteine die linuxmuster.net zu der Komplettlösung machen.

.. image::    media/structure_of_version_7_community.svg
   :name:     structure-community-components
   :alt:      Struktur der Erweiterungen (Community)
   :height:   500px
   :align:    center 

.. note:: Die Unterstützung erfolgt für die nachfolgenden Bestandteile durch das

   Hilfe-Forum https://www.linuxmuster.net/de/support-de/discourse-forum/

   Die detailierte Beschreibung ist nicht Gegenstand dieser Dokumentation, sondern wird durch die Community in derem Wiki festgehalten.

   Community-Wiki: https://wiki.linuxmuster.net/community/

:Alternative Firewall: Einsatzszenarien, die mit einer anderen Firewall als OPNsense |reg| ausgesattet sein sollen, bietet linuxmuster.net eine Möglichkeit der Umsetzung.

   .. image::    media/structure_of_version_7_alternate.svg
      :name:     structure-alternativ-firewall
      :alt:      Struktur der Einbindung einer alternaiven Firewall
      :width:    150px
      :align:    right

   Wenn diese über die Möglichkeit einer Anbindung an den Samba des linuxmuster.net-Servers verfügen, können diese alle aufgezeigten Vorteile nutzen.

:Optionale Server: Für weitergehende Anpassungen besteht die Möglichkeit optionale Server einzubinden.

   .. image::    media/structure_of_version_7_optional.svg
      :name:     structure-option-server
      :alt:      Struktur der Einbindung optionaler lokaler Server
      :width:    150px
      :align:    right 

  In der Darstellung ist zum Beispiel ein Docker-Server als Erweiterung an die Bedürfnisse der Bildungseinrichtung eingebunden. Docker ist ein Open-Source-Projekt zur automatisierten Anwendungsverteilung durch Container, die alle benötigten Pakete mitbringen. So vereinfacht sich die Bereitstellung und Verteilung. Außerdem gewährleisten sie die Trennung und Verwaltung der auf dem Docker-Server genutzten Ressourcen.

 Für weitergehende Informationen siehe die Docker-Homepage. https://www.docker.com

:Extra: Verschiedenste externe Dienste lassen sich an die linuxmuster.net Lösung anbinden, so dass eine einheitliche Authentifizierung erfolgt. 

   .. image::    media/structure_of_version_7_extra.svg
      :name:     structure-extra-server-and-services
      :alt:      Struktur der Einbindung externer Server und Dienste
      :width:   150px
      :align:    right

   Es können z.B. extern gehostete Server wie zum Beispiel nextcloud, moodle oder Konferenzsysteme integriert werden.

:download:`Komplette Struktur als Inkkscape SVG <media/structure_of_version_7_simple.svg>`
