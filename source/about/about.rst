========================
Was ist linuxmuster.net?
========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_, `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

Schulnetz - Komplett - Anpassbar!
=================================

Schulnetz
---------

Schulische IT wird mit einer vollintegrierten Open-Source-Lösung abgebildet. Dieses umfasst alle Bereiche, die in einer Bildungseinrichtung anzutreffen sind.

Unser Anspruch liegt dabei auf der Bereitstellung eines Systems, das folgende Punkte erfüllt ...

    * schnelle Installation.
    * Anpassbarkeit an die vorhandene Infrastruktur.
    * bestehend aus Server, Firewall und vorkonfigurierten Arbeitsstationen.
    * mehrstufige ausbau- und anpassbare Struktur mit heterogenen Clients und unterschiedlichsten Diensten bzw. Cloud-Lösungen.

Ein Augenmerk liegt dabei auf der Unabhängigkeit von der eingesetzten Hard- und Software. 

Dieses wird zum Beispiel erkennbar an dem Umfang der unterstützten Betriebssysteme (BS) für die Arbeitsstationen. 

Proprietäre BS, z.B. aus dem Hause Microsoft©, können aufgrund der Lizenzpolitik der Hersteller nicht von uns vorbereitet mit ausgeliefert werden. Lassen sich aber ebenso leicht in unsere Infrastruktur integrieren, wie solche die als Open-Source erhältlich sind. 

Auf der Basis von Linux stellen wir ein Open-Source-BS zur Verfügung, dass folgende Vorteile bietet:

    * entwickelt von Praktikern für den täglichen Einsatz an Schulen.
    * mit hilfreichen Schulfunktionen für den Unterrichtseinsatz.
    * in einfacher Form anpass- und erweiterbar an die eigenen Bedürfnisse.
    * keine Lizenzkosten

Im Zusammenspiel der Clients mit dem Server und einer Firewall entsteht so die grundlegende Infrastruktur. Diese lässt sich aufgrund des modularen Aufbaues weiter an die darüber hinausgehenden Anforderungen erweitern.

Komplett
--------

Die volle Funktionsfähig des Systems wird durch die Interaktion der verschieden Server miteinander und mit den Clients erreicht. Dieses wird in der Grafik durch das blaue Band dargestellt. Es symbolisiert den Datenaustausch zwischen ihnen.

  .. figure:: media/about_01_structure_of_version_7_simple_web.svg
     :align: center
     :alt: Übersicht der Komponenten

Die Basisdienste des links abgebildeten Servers sind für die Funktion des ganzen Systems verantwortlich:

.. image::    media/about_02_server.png
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

Vielfältige Möglichkeiten stehen den Lehrkräften zur Verfügung um Einfluss auf die Rechner der zu Unterrichtenden zu nehmen.

    * Internet - An/Aus
    * Intranet - An/Aus
    * WIFI - An/Aus
    * Drucker - An/Aus

Klassenarbeitsmodus
+++++++++++++++++++

In Prüfungssituationen wie Abitur, Klassenarbeiten und andere Leistungsüberprüfungen kann die Lehrkraft mit einfachen Mitteln die Nutzung des Systems für die Prüfungsgruppe einschränken. Das Spektrum umfasst dabei alle Möglichkeiten der Unterrichtssteuerung plus die Sperrung des persönlichen Speicherbereiches.

Dateiverwaltung und -verteilung
+++++++++++++++++++++++++++++++

Jeder Nutzer besitzt einen eigenen Bereich auf dem Netzwerkspeicher. Darüber hinaus steht ein solcher den Gruppen für den Austausch ihrer gemeinschaftlichen Arbeit zur Verfügung.

schulinterne E-Mail-Korrespodenz
++++++++++++++++++++++++++++++++

Von den einigen Kultusministerien wird eine Grundkompetenz in der Nutzung von E-Mail gefordert. Um diesem Anspruch gerecht zu werden ist ein E-Mail-Server Bestandteil von linuxmuster.net. Jeder Nutzer des Systems hat eine eigene Mail-Adresse, die es ihm ermöglicht schulintern zu kommunizieren.

Diese Funktionalität lässt sich bei Bedarf an die Bedürfnisse der Bildungseinrichtung anpassen bzw. weiterausbauen. linuxmuster.net bringt dafür verschiedene Alternativen mit.

.. image::    media/about_03_client-integration.png
   :name:     box-client-integration
   :alt:      box-client-integration
   :height:   40px

Selbstheilende Arbeitsstationen durch LINBO
+++++++++++++++++++++++++++++++++++++++++++

Das Konzept der Selbstheilenden Arbeitsstationen (SheilA) ermöglicht einheitliche identische Schulungssysteme. Diese können bei jedem Start der Rechner in einen vorher definierten Zustand zurückgesetzt werden. Dieser standardmäßige Standard wird durch die letzte Veränderung oder Installation festgelegt, in dem ein Abbild des BS auf dem Server gespeichert wird. Weitere Vorteile sind ...

    * vorhalten von verschiedenen BS auf den Clients.
    * schnelle Erst- oder Neueinrichtung.
    * keine Einschränkung der Nutzer durch Benutzerrechte nötig.
    * einfache Wiederherstellung der Clients ist jedem Benutzer möglich.
    * einfache Softwareverteilung durch Installation auf einem Client. Keine gesonderten Kenntnisse erforderlich bei demjenigen der die Software-Installation betreut.
    * Möglichkeit der zeit- und/oder ferngesteuerten Aktualisierung der Clients.
    * mit sogenannten Postsync-Scripten kann der Administrator für einzelne, raumweite oder für alle Geräte notwendige Konfigurationsänderung beim Systemstart einpflegen.

Die Funktionsweise am Beispiel eines Clients beschrieben.
Auf dem Server sind dessen zwei Betriebssysteme komprimiert gespeichert. 

.. image::    ..//clients/linbo/media/linbo_functionality_detail.svg
   :name:     linbo-functionality
   :alt:      linbo-functionality
   :height:    150px

* Der Benutzer wählt das erste BS zum synchronisierten Start aus.
* Der Client überprüft, ob sein lokal gespeichertes Systemabbild identisch ist mit dem auf dem Server. (1.)
* Dieses ist der Fall und der Client entpackt das erste BS auf die eigentliche System-Partition und startet das System anschließend. (3.)

  Wäre das nicht der Fall gewesen hätte er zuerst das Systemabbild vom Server heruntergeladen (2.) um dann mit (3.) fortzufahren.

Der hier aufgezeigte Fall ist einer von vielen Einsatzszenarien und dient der Veranschaulichung. Nähere Information sind im Kapitel "Linbo nutzen" beschrieben.

Vorkonfigurierter Linux-Client
++++++++++++++++++++++++++++++

Ein Linuxclient mit einer umfänglichen Softwareausstattung für Schulen ist Bestandteil unserer Software. Dieser lässt sich via  Internet auf den Server kopieren, um anschließend von LINBO in der oben beschriebenen Art und Weise auf die lokalen Rechner gebracht zu werden. 

Integration unterschiedlicher Geräte (BYOD)
+++++++++++++++++++++++++++++++++++++++++++

Da sich alle Steuerungsfunktionen in unserer Lösung an den Benutzern orientieren, ist es unerheblich an welchem Gerät sie sich befinden. Das Gleiche gilt auch für mitgebrachte Geräte, mit denen sie sich mit dem Intranet via WLAN verbinden.

Firewall
++++++++

.. image::    media/about_04_firewall.png
   :name:     box-firewall
   :alt:      box-firewall
   :height:   40px

Als Standard ist die Firewall OPNSense® Gegenstand der Auslieferung.

Durch die Integration an den AD DS (Active Directory Domain Services) des Servers (Samba4) werden sämtliche Benutzer-Zugriffe der Nutzer mittels Single-Sign-On auf das Internet geregelt.

Sämtliche verfügbaren Bausteine dieser Open-Source-Firewall stehen selbstverständlich zur Verfügung. [#FN1]_
Für weitergehende Informationen `siehe opnsense.org <https://opnsense.org/>`_. 

Anpassbar
---------

Alle bisher vorgestellten Basisdienste werden vorkonfiguriert bereitgestellt, bleiben aber frei anpass- und erweiterbar.


.. image::    media/about_05_optionale-server.png
   :name:     box-optionale-server
   :alt:      box-optionale-server
   :height:   40px

Integraler Bestandteil sind für weitergehende Anpassungen die optional verwendbaren Server. Sie dienen als Basis für eine Erweiterung an die Bedürfnisse der Bildungseinrichtung. 

docker
++++++

.. image::    media/about_06_docker.png
   :name:     box-docker
   :alt:      box-docker
   :height:   80px

Ein docker-Server steht zur Installation bereit, um über die Basisdienste hinausgehende Server zu integrieren.  
docker ist ein Open-Source-Projekt zur automatisierten Anwendungsverteilung.

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


.. note::
   Die bis hier vorgestellten Bestandteile werden vom Verein   
   **linuxmuster.net e. V. entwickelt und unterstützt**.
   
   Diese Unterstützung wird geleistet durch die 
   
   **telefonische Hotline** `<https://www.linuxmuster.net/de/support-de/hotline/>`_ 
   
   und das
    
   **Hilfe-Forum** `<https://www.linuxmuster.net/de/support-de/discourse-forum/>`_ geleistet.

   **All diese Leistungen sind nicht von einer Mitgliedschaft im Verein abhängig.**

   Aufgrund der großen Spannweite möglicher Einsatzszenarien umfasst der telefonische Support alle beschriebenen Absätze die nicht mit [#FN1]_ und [#FN2]_ gekennzeichneten sind.

   [#FN1]_ sind Elemente die aus der Community hervorgegangen sind und auch von ihr im Hilfe-Forum supportet werden.

   [#FN2]_ sind Elemente von externen Anbietern (Hersteller und Dienstleister).

   **Das Support-Team berät aber gerne und zeigt alle Möglichkeiten und Alternativen auf.**


Alternativ
++++++++++

.. image::    media/about_08_alternativ.png
   :name:     box-alternativ
   :alt:      box-alternativ
   :height:   40px

Weitere Server mit ihren Diensten lassen sich in der lokalen Infrastruktur bereitstellen. Wenn diese über die Möglichkeit einer Anbindung an den Samba des linuxmuster.net-Servers mittels LDAP verfügen, dann lassen sich auch auf ihnen alle aufgezeigten Vorteile nutzen. [#FN1]_

Beispielhaft ist hier eine alternative Firewall als Hardware-Appliance gezeigt, die den Internetverkehr regelt. [#FN2]_

Extra
+++++

.. image::    media/about_09_extra.png
   :name:     box-extra
   :alt:      box-extra
   :height:   40px


Verschiedenste externe Dienste lassen sich ebenso anbinden, wie die unter "Alternativ" genannten.

Exemplarisch seien hier Services der Kultusministerien wie zum Beispiel lanis, mebis u. a. aufgeführt. Auch extern gehostete Server wie zum Beispiel nextcloud, moodle, hpi-schulcloud oder Videokonferenzsysteme lassen sich integrieren. Weitere mögliche Dienste sind der Übersicht zu entnehmen. [#FN1]_ :sup:`und/oder` [#FN2]_

:download:`Übersicht als PDF <media/about_10_structure_of_version_7_simple.pdf>`

.. [#FN1] Die gekennzeichneten Elemente werden durch die Community über das `Hilfeforum <https://ask.linuxmuster.net/>`_ bereitgestellt und unterstützt.
.. [#FN2] Die gekennzeichneten Elemente werden durch deren Hersteller/Dienstleister unterstützt. 
