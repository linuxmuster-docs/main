========================
Was ist linuxmuster.net?
========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_, `@MachtDochNix <https://ask.linuxmuster.net/u/machtdochnix>`_

Schulnetz - Komplett - Anpassbar!
=================================

Schulnetz
---------

Schulische IT wird mit einer vollintegrierten Open-Source-Lösung abgebildet. Dieses umfasst alle Bereiche, die in einer Bildungseinrichtung anzutreffen sind.

Ein Augenmerk liegt dabei auf der Unabhängigkeit von der eingesetzten Hard- und Software. Dieses wird zum Beispiel erkennbar an dem Umfang der unterstützten Betriebssysteme (BS) für die Arbeitsstationen. Selbstredend ist für uns das Open-Source-BS Linux erste Wahl, welches wir mit einem Muster-Client zur Verfügung stellen. BS anderer Hersteller, z.B. Microsoft©, lassen sich aber ebenso leicht in unsere Infrastruktur integrieren.

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

Die Funktionsweise in ein paar Worten beschrieben: 

.. TODO:: Eventuell mittels einer zu erstellenden Grafik erklären.

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

Firewall
++++++++

.. image::    media/about_04_firewall.png
   :name:     box-firewall
   :alt:      box-firewall
   :height:   40px

Als Standard ist die Firewall OPNSense® Gegenstand der Auslieferung.

Durch die Integration an den AD DS (Active Directory Domain Services) des Servers (Samba4) werden sämtliche Benutzer-Zugriffe der Nutzer auf das Internet geregelt.

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
   Die bis hier vorgestellten Bestandteile werden vom Verein linuxmuster.net e. V. entwickelt und unterstützt. Diese Unterstützung wird durch die telefonische Hotline `<https://www.linuxmuster.net/de/support-de/hotline/>`_ und durch das Hilfe-Forum `<https://www.linuxmuster.net/de/support-de/discourse-forum/>`_ geleistet.

   All diese Leistungen sind nicht von einer Mitgliedschaft im Verein abhängig.

   Aufgrund der großen Spannweite möglicher Einsatzszenarien umfasst der telefonische Support nicht die mit [#FN1]_ und [#FN2]_ gekennzeichneten Elemente. Berät aber gerne und zeigt Möglichkeiten auf.

   
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

Exemplarisch seien hier Services der Kultusministerien lanis, mebis u. a. aufgeführt. Auch extern gehostete Server wie zum Beispiel nextcloud, moodle, hpi-schulcloud oder Videokonferenzsysteme lassen sich integrieren. Weitere mögliche Dienste sind der Übersicht zu entnehmen. [#FN1]_ :sup:`und/oder` [#FN2]_

:download:`Übersicht als PDF <media/about_10_structure_of_version_7_simple.pdf>`

.. [#FN1] Die gekennzeichneten Elemente werden durch die Community über das `Hilfeforum <https://ask.linuxmuster.net/>`_ bereitgestellt und unterstützt.
.. [#FN2] Die gekennzeichneten Elemente werden durch deren Hersteller/Dienstleister unterstützt. 
