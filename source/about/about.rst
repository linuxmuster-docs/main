========================
Was ist linuxmuster.net?
========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_, `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

Schulnetz - Komplett - Anpassbar!
=================================

Schulnetz
---------

Schulische IT wird mit einer vollintegrierten Open Source Lösung abgebildet. Dieses umfasst alle Bereiche, die in einer Bildungseinrichtung anzutreffen sind.

Ein Augenmerk liegt dabei auf der Unabhängigkeit von der eingesetzten Hard- und Software. Dieses wird zum Beispiel erkennbar an dem Umfang der unterstützten Betriebssysteme (BS) für die Arbeitsstationen. Selbstredend ist für uns das Open Source BS Linux erste Wahl, welches wir mit einem Muster-Client zur Verfügung stellen. BS anderer Hersteller lassen sich aber ebenso in unsere Infrastruktur integrieren.

  .. figure:: media/about_01_structure_of_version_7_simple_web.svg
     :align: center
     :alt: Übersicht der Komponenten

Komplett
--------

Es werden folgende Basisdienste bereitgestellt:

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

Unterricht ist einfacher in einer für alle gleichen Umgebung zu geben. Dieses lässt sich dadurch erreichen, dass die Nutzung der Rechner so weit eingeschränkt wird, dass nur freigegebene Teilbereiche nutzbar sind.

**Diesen Ansatz verfolgt unsere Lösung nicht!**

Wir ermöglicht es jedem Benutzer beim Start das System auf den Standard zurückzusetzen. Selbst ein Formatieren der Festplatte durch den vorherigen Nutzer lässt sich so wieder beheben. Das ist das was wir unter selbstheilende Arbeitsstationen (SheilA) verstehen.

Die Funktionsweise in ein paar Worten beschrieben: (eventuell mittels einer Grafik erklären)

    * Auf dem Server liegt ein Abbild der Festplatte mit dem Betriebssystem des Clients.
    * Nach dem Einschalten des Clients überprüft dieser, ob ein für ihn aktuelleres Festplattenabbild auf dem Server vorhanden ist.
    * Ist dieses der Fall, lädt er sich dieses in einen speziellen Bereich auf seine lokale Festplatte. 
    * Dieses Abbild ist dann der Master für das lokale Betriebssystem.
    * Diese wird dann im letzten Schritt gestartet.

Daraus ergeben sich folgende Vorteile:

    * Software-Installation durch Kopieren des Clients auf den Server. Keine gesonderten Kenntnisse erforderlich bei demjenigen der die Software-Installation betreut.
    * Vorhalten mehrere verschiedene Betriebssysteme auf den Clients.
    * Möglichkeit der zeit- und/oder ferngesteuerten Aktualisierung der Clients.
    * Mit sogenannten Postsync-Scripten kann der Administrator für einzelne, raumweite oder für alle Geräte notwendige Konfigurationsänderung beim Systemstart einpflegen. 
    * Einfache Wiederherstellung der Clients ist jedem Benutzer möglich.
    * Keine Einschränkung der Benutzerrechte auf den Clients nötig.

Vorkonfigurierter Linux-Client
++++++++++++++++++++++++++++++

Ein Linuxclient mit einer umfänglichen Softwareausstattung für Schulen ist Bestandteil unserer Software. Dieser lässt sich via  Internet auf den Server kopieren, um anschließend von LINBO in der oben beschriebenen Art und Weise auf die lokalen Rechner gebracht zu werden. 

Integration unterschiedlicher Geräte (BYOD)
+++++++++++++++++++++++++++++++++++++++++++

Da sich alle Steuerungsfunktionen in unserer Lösung an den Benutzern orientieren, ist es unerheblich an welchem Gerät sie sich befinden. Das Gleiche gilt auch für mitgebrachte Geräte, mit denen sie sich mit dem Intranet via WLAN verbinden.

.. image::    media/about_04_firewall.png
   :name:     box-firewall
   :alt:      box-firewall
   :height:   40px

* ... zu ergänzen

Anpassbar
---------

Basisdienste werden vorkonfiguriert bereitgestellt, bleiben aber frei anpass- und erweiterbar.


.. image::    media/about_05_optionale-server.png
   :name:     box-optionale-server
   :alt:      box-optionale-server
   :height:   40px

Integraler Bestandteil sind die optional verwendbaren Server.

Docker
++++++

.. image::    media/about_06_docker.png
   :name:     box-docker
   :alt:      box-docker
   :height:   80px

Als Plattform um über die Basisdienste hinausgehende Server-Dienste zu integrieren. ... zu ergänzen

OPSI
++++

.. image::    media/about_07_opsi.png
   :name:     box-opsi
   :alt:      box-opsi
   :height:   80px

Als alternatives System zu LINBO zur Software-Verteilung. ... zu ergänzen

Es können so in einfacher Form eigene IT-Dienste bereitgestellt und integriert werden.

Alternativ
++++++++++

.. image::    media/about_08_alternativ.png
   :name:     box-alternativ
   :alt:      box-alternativ
   :height:   40px

... zu ergänzen

Beschreibung am Beispiel einer alternativen Firewall ... zu ergänzen

Extra
+++++

.. image::    media/about_09_extra.png
   :name:     box-extra
   :alt:      box-extra
   :height:   40px


Anbindung externer Dienste ... zu ergänzen

:download:`Übersicht als PDF <media/about_10_structure_of_version_7_simple.pdf>`
