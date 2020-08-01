.. _what-is-linuxmuster.net-label:

========================
Was ist linuxmuster.net?
========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_, `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

**Schulnetz - Komplett - Anpassbar!**

Schulnetz
---------

Schulische IT wird mit einer vollintegrierten Open-Source-Lösung abgebildet. Dieses umfasst alle Bereiche, die in einer Bildungseinrichtung anzutreffen sind.

Unser Anspruch liegt dabei auf der Bereitstellung eines Systems, das folgende Punkte erfüllt:

    * schnelle Installation
    * einfache Integration in vorhandene Infrastruktur
    * bestehend aus Server, Firewall und vorkonfigurierten Arbeitsstationen
    * mehrstufige ausbau- und anpassbare Struktur mit heterogenen Clients und unterschiedlichsten Diensten bzw. Cloud-Lösungen
    * einen freien Zugang zu einer umfänglichen Dokumentation
    * letzter Punkt ergänzt um das frei zugängliche `Community-Wiki <https://wiki.linuxmuster.net/community/>`_ mit Anleitungen vielfältigster Erweiterungen aus dem Umfeld der Unterstützer von linuxmuster.net [#FN1]_

Ein Augenmerk liegt dabei auf der Unabhängigkeit von der eingesetzten Hard- und Software. Dieses wird zum Beispiel erkennbar an dem Umfang der unterstützten Betriebssysteme für die Arbeitsstationen. 

Proprietäre Betriebssyteme, z.B. aus dem Hause Microsoft©, können aufgrund der Lizenzpolitik der Hersteller nicht von uns vorbereitet ausgeliefert werden. Diese lassen sich aber ebenso leicht in unsere Infrastruktur integrieren, wie solche die als Open-Source erhältlich sind. 

Auf der Basis von Linux stellen wir ein Open-Source-Betriebssytem zur Verfügung, das folgende Vorteile bietet:

    * entwickelt von Praktikern für den täglichen Einsatz an Schulen
    * mit hilfreichen Schulfunktionen für den Unterrichtseinsatz
    * in einfacher Form anpass- und erweiterbar an die eigenen Bedürfnisse
    * keine Lizenzkosten

Im Zusammenspiel der Clients mit dem Server und einer Firewall entsteht so die grundlegende Infrastruktur. Diese lässt sich aufgrund des modularen Aufbaus weiter an die darüber hinausgehenden Anforderungen erweitern und anpassen.

Komplett
--------

Die vier unter der blauen Überschrift "linuxmuster.net - Version 7" veranschaulichten Bereiche zeigen die Kern-Komponenten. Für dieses Grundsystem halten wir vorgefertigte virtuelle Maschinen zum Download bereit.

Damit stellen wir sicher, dass sowohl ein schulischer Administrator, die IT-Abteilung eines Schulträgers oder ein Dienstleister im Vorfeld von Arbeit entlastet wird. Zu jedem Zeitpunkt der Projektierung (Planung, Installation und Betrieb) steht unser Telefon-Support und unser Hilfeforum beratend zur Seite.

Im Folgenden betrachten wir die einzelnen Komponenten.

Die volle Funktionsfähigkeit des Systems wird durch die Interaktion der verschiedenen Server miteinander und den Clients erreicht. Dieses wird in der Grafik durch das untere blaue Band dargestellt. Es symbolisiert den Datenaustausch zwischen ihnen. Darüber hinaus aber auch zu externen Diensten.

  .. figure:: media/about_01_backbone.svg
     :align: center
     :alt: Übersicht der Komponenten

Die Basisdienste des links abgebildeten Servers sind für die Funktion des ganzen Systems verantwortlich:

.. image::    media/about_02_server.svg
   :name:     box-server
   :alt:      box-server
   :height:   40px

Benutzer- und Gruppenverwaltung
+++++++++++++++++++++++++++++++

Die Benutzer- und Gruppenverwaltung orientiert sich an den Bedürfnissen, die der Schulbetrieb vorgibt.

    * Schülerinnen und Schüler bekommen mit der Einschulung ihren persönlichen Benutzer-Account.
    * Dieser bleibt ihnen bis zum Ende ihrer Laufbahn an der Schule erhalten.
    * Die Gruppenzugehörigkeit der einzelnen Schülerinnen und Schüler werden in Klassen, Kursen und Projekten abgebildet.
    * Zu Beginn eines Schuljahres können diese Daten und Abhängigkeiten aus der Schulverwaltung mittels Import der Daten eingespielt bzw. fortgeschrieben werden.
      Gleiches gilt selbstverständlich auch für Veränderungen während eines laufenden Schuljahres.
    * Für Lehrerinnen und Lehrer gilt oben genanntes in gleichem Maße.

Unterrichtssteuerung
++++++++++++++++++++

Vielfältige Möglichkeiten stehen den Lehrkräften zur Verfügung, um Einfluss auf die Rechner der zu Unterrichtenden zu nehmen.

    * Internet - An/Aus
    * Intranet - An/Aus
    * WIFI - An/Aus
    * Drucker - An/Aus

Klassenarbeitsmodus
+++++++++++++++++++

In Prüfungssituationen wie Abitur, Klassenarbeiten und andere Leistungsüberprüfungen kann die Lehrkraft mit einfachen Mitteln die Nutzung des Systems für die Prüfungsgruppe einschränken. Das Spektrum umfasst dabei alle Möglichkeiten der Unterrichtssteuerung plus die Sperrung des persönlichen Speicherbereichs.

Dateiverwaltung und -verteilung
+++++++++++++++++++++++++++++++

Jeder Nutzer besitzt einen eigenen Bereich auf dem Netzwerkspeicher. Darüber hinaus steht ein solcher den Gruppen für den Austausch ihrer gemeinschaftlichen Arbeit zur Verfügung.

Schulinterne E-Mail-Korrespondenz
+++++++++++++++++++++++++++++++++

Von einigen Kultusministerien der Länder wird eine Grundkompetenz in der Nutzung von E-Mail gefordert. Um diesem Anspruch gerecht zu werden, ist ein E-Mail-Server Bestandteil von linuxmuster.net. Jeder Nutzer des Systems hat eine eigene Mail-Adresse, die es ihm ermöglicht ``schulintern`` zu kommunizieren.

Selbstheilende Arbeitsstationen durch LINBO
+++++++++++++++++++++++++++++++++++++++++++

.. image::    media/about_03_client-integration.svg
   :name:     box-client-integration
   :alt:      box-client-integration
   :height:   40px

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
   :height:    150px

* Der Benutzer wählt das erste Betriebssytem zum synchronisierten Start aus.
* Der Client überprüft, ob sein lokal gespeichertes Systemabbild identisch ist mit dem auf dem Server (1.).
* Dieses ist der Fall und der Client entpackt das erste Betriebssytem auf die eigentliche System-Partition und startet das System anschließend (3.). Wäre das nicht der Fall gewesen, hätte dieser zuerst das Systemabbild vom Server heruntergeladen (2.), um dann mit (3.) fortzufahren.

Der hier aufgezeigte Fall ist einer von vielen Einsatzszenarien und dient der Veranschaulichung. Nähere Information sind im Kapitel "Linbo nutzen" beschrieben.

Vorkonfigurierter Linux-Client
++++++++++++++++++++++++++++++

Ein Linuxclient mit einer umfänglichen Softwareausstattung für Schulen ist Bestandteil unserer Software. Dieser lässt sich via  Internet auf den Server kopieren, um anschließend von LINBO in der oben beschriebenen Art und Weise auf die lokalen Rechner gebracht zu werden. 

Integration unterschiedlicher Geräte (BYOD)
+++++++++++++++++++++++++++++++++++++++++++

Da sich alle Steuerungsfunktionen in unserer Lösung an den Benutzern orientieren, ist es unerheblich an welchem Gerät sie sich befinden. Das Gleiche gilt auch für mitgebrachte Geräte, mit denen sie sich mit dem Intranet via WLAN verbinden.

Firewall
++++++++

.. image::    media/about_04_firewall.svg
   :name:     box-firewall
   :alt:      box-firewall
   :height:   40px

Als Standard wird die Firewall OPNSense® ausgeliefert.

Durch die Integration an den AD DS (Active Directory Domain Services) des Servers (Samba4) werden sämtliche Benutzer-Zugriffe der Nutzer mittels Single-Sign-On auf das Internet geregelt.

Sämtliche verfügbaren Bausteine dieser Open-Source-Firewall stehen selbstverständlich zur Verfügung. [#FN1]_
Für weitergehende Informationen `siehe opnsense.org <https://opnsense.org/>`_. 

Anpassbar
---------

Alle bisher vorgestellten Basisdienste werden vorkonfiguriert bereitgestellt, bleiben aber frei anpass- und erweiterbar.


.. image::    media/about_05_optional-servers.svg
   :name:     box-optionale-server
   :alt:      box-optionale-server
   :height:   40px

Integraler Bestandteil für weitergehende Anpassungen sind die optional verwendbaren Server. Sie dienen als Basis für eine Erweiterung an die Bedürfnisse der Bildungseinrichtung. 

docker
++++++

.. image::    media/about_06_docker.png
   :name:     box-docker
   :alt:      box-docker
   :height:   80px

Ein Docker-Server steht zur Installation bereit, um über die Basisdienste hinausgehende Server zu integrieren.  
``Docker`` ist ein Open-Source-Projekt zur automatisierten Anwendungsverteilung.

Durch Container, die alle benötigten Pakete mitbringen, vereinfacht sich so die Bereitstellung und Verteilung. Außerdem gewährleisten sie die Trennung und Verwaltung der auf dem Docker-Server genutzten Ressourcen. [#FN1]_

Für weitergehende Informationen `siehe die Docker-Homepage <https://www.docker.com/>`_. 

opsi
++++

.. image::    media/about_07_opsi.png
   :name:     box-opsi
   :alt:      box-opsi
   :height:   80px

opsi (Open PC Server Integration) ist ein Clientmanagement-System zur Verwaltung von Windows- und Linux-Clients. Die Kernkomponenten von opsi sind Open-Source.

Es steht als alternatives System oder als Ergänzung zu LINBO zur Verfügung. So lassen sich zum Beispiel opsi-Pakete auf einem Musterclient installieren, um sie anschließend mittels LINBO auszurollen. [#FN1]_ [#FN2]_

Für weitergehende Informationen `siehe die OPSI-Homepage <https://uib.de>`_. 

.. figure:: media/about_08_lmn-servers.svg
     :align: center
     :alt: Übersicht der Komponenten
     
Alle bis hier gemachten Ausführungen bezogen sich auf die vier linken Teilbereiche. Sie bilden die Grundlage auf denen die freie Erweiter- und Anpassbarkeit beruht.      
     
.. note::
   Diese vorgestellten Bestandteile werden vom Verein   
   **linuxmuster.net e. V. entwickelt und unterstützt**.
   
   Diese Unterstützung wird durch das
    
   **Hilfe-Forum** `<https://www.linuxmuster.net/de/support-de/discourse-forum/>`_

   und die 
   
   **telefonische Hotline** `<https://www.linuxmuster.net/de/support-de/hotline/>`_ 
   
   geleistet.

   **All diese Leistungen sind nicht von einer Mitgliedschaft im Verein abhängig.**

   Aufgrund der großen Spannweite möglicher Einsatzszenarien umfasst der telefonische Support alle beschriebenen Absätze die nicht mit [#FN1]_ und [#FN2]_ gekennzeichneten sind.

   [#FN1]_ sind Elemente die aus der Community hervorgegangen sind und auch von ihr im Hilfe-Forum supportet werden.

   [#FN2]_ sind Elemente von externen Anbietern (Hersteller und Dienstleister).

   **Das Support-Team berät aber gerne und zeigt alle Möglichkeiten und Alternativen auf.**

Es folgt die Beschreibung der letzten zwei Bausteine die linuxmuster.net zu einer Komplettlösung machen.

Alternativ
++++++++++

.. image::    media/about_09_alternativ.svg
   :name:     box-alternativ
   :alt:      box-alternativ
   :height:   40px

Weitere Server mit ihren Diensten lassen sich in der lokalen Infrastruktur bereitstellen. Wenn diese über die Möglichkeit einer Anbindung an den Samba des linuxmuster.net-Servers mittels LDAP verfügen, können diese alle aufgezeigten Vorteile nutzen. [#FN1]_

Beispielhaft ist hier eine alternative Firewall als Hardware-Appliance gezeigt, die den Internetverkehr regelt. [#FN2]_

Extra
+++++

.. image::    media/about_10_extra.svg
   :name:     box-extra
   :alt:      box-extra
   :height:   40px


Verschiedenste externe Dienste lassen sich ebenso anbinden, wie die unter "Alternativ" genannten.

Exemplarisch seien hier Services der Kultusministerien wie zum Beispiel lanis, mebis u. a. aufgeführt. Auch extern gehostete Server wie zum Beispiel nextcloud, moodle, hpi-schulcloud oder Videokonferenzsysteme lassen sich integrieren. Weitere mögliche Dienste sind der Übersicht zu entnehmen. [#FN1]_ :sup:`und/oder` [#FN2]_

:download:`Übersicht als PDF <media/about_10_structure_of_version_7_simple.pdf>`

Im nächsten Kapitel  wird beschrieben, welche Neuerungen es zur Vorgängerversion gibt. Sollte diese Information für dich nicht von Interesse sein, kannst du sie hier direkt überspringen: :ref:`Vorüberlegungen für die Installation <prerequisites-label>`

.. [#FN1] Die gekennzeichneten Elemente werden durch die Community über das `Hilfeforum <https://ask.linuxmuster.net/>`_ bereitgestellt und unterstützt.
.. [#FN2] Die gekennzeichneten Elemente werden durch deren Hersteller/Dienstleister unterstützt. 
