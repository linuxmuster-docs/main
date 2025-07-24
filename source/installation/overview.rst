.. include:: /guided-inst.subst
.. _install-overview-label:

Installationablauf
==================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

Um **linuxmuster.net** zu installieren musst Du folgende Schritte durchlaufen:

Die Punkte 1 und 2 werden in dem Kapitel "Vorüberlegungen" behandelt.

1. Planung der Infrastruktur (Server und Netzwerk)

2. ggf. Vorbereitung / Setup der Netzkomponenten

Der Punkt 3 findet sich in dem Kapitel "Proxmox vorbereiten"

3. Einrichtung einer Basis für linuxmuster.net

   .. figure:: media/overview-installation-process-part1-preliminary-consideration.svg
         :align: center
         :alt: Installtion-Übersicht
         :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part1-preliminary-consideration.svg

Diese Dokumentation konzentriert sich auf die Umsetzung als Drei-Server-Lösung auf einem Hypervisor. 

Unsere Dokumentation basiert auf der Virtualisierung mittels Proxmox  

   .. figure:: media/overview-installation-process-part1-default.svg
         :align: center
         :alt: Installtion Hypervisor default
         :width: 40%
         :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part1-default.svg

Andere Virtualisierungslösungen sind möglich, werden aber von linuxmuster.net nicht offiziell unterstützt.

Falls Du einen anderen Hypervisor bevorzugst, kannst Du Dich dennoch an der Dokumentation orientieren und zusätzlich findest im linuxmuster.net Forum (https://ask.linuxmuster.net) und im Community-Wiki (https://wiki.linuxmuster.net/community/) Unterstützung.

   .. figure:: media/overview-installation-process-part1-alternativ.svg
            :align: center
            :alt: Installation Hypervisor alternativ 
            :width: 40%
            :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part1-alternativ.svg

Das Kapitel "Install-from-Scratch" beschreibt die Arbeitsschritte 4 und 5.

4. Vorbereitung der benötigten virtualisierten Server (VMs)

   .. figure:: media/overview-installation-process-part2-basis-server-provision.svg
       :align: center
       :alt: Vorbereitung der benötigten virtualisierten Server
       :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part2-basis-server-provision.svg

\* Bei der aktuellen linuxmuster.net Version dient die LTS Version |lts_version| als Basis.

5. Installation in die vorbereiteten VMs (virtuelle Maschinen)

   .. figure:: media/overview-installation-process-part3-lmn-server-preparation.svg
       :align: center
       :alt: Installation in die vorbereiteten VMs
       :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part3-lmn-server-preparation.svg

6. Test der Netzwerkfunktionen

   .. figure:: media/overview-installation-process-part4-lmn-server-setup.svg
      :align: center
      :alt: Test der Netzwerkfunktionen
      :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part4-lmn-server-setup.svg

7. Ersteinrichtung (Setup) der Server

   .. figure:: media/overview-installation-process-part5-user-reception.svg
      :align: center
      :alt: Ersteinrichtung der Server
      :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part5-user-reception.svg

8. Anlegen der Benutzer und Gruppen

   .. figure:: media/overview-installation-process-part6-computer-registration.svg
      :align: center
      :alt: Anlegen der Benutzer und Gruppen
      :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part6-computer-registration.svg

9. Einrichtung der Clients

    .. figure:: media/overview-installation-process-part7-installation-finish.svg
       :align: center
       :alt: Einrichtung der Clients
       :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part7-installation-finish.svg


Nachstehend kannst Du den Installationsablauf als Übersicht herunterladen:

:download:`Übersicht als PDF-Datei <media/overview-installation-process.pdf>`

:download:`Übersicht als Inkscape SVG-Datei <media/overview-installation-process_inkscape_latest.svg>`



