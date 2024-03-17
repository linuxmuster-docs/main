.. _install-overview-label:

Installationablauf
==================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

Um **linuxmuster.net latest** zu installieren musst Du folgende Schritte durchlaufen:

1. Planung der Infrastruktur (Server und Netzwerk)

2. ggf. Vorbereitung / Setup der Netzkomponenten

3. Einrichtung einer Basis für linuxmuster.net

   .. figure:: media/overview-installation-process-part1-preliminary-consideration.svg
       :align: center
       :alt:

..       :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part1-preliminary-consideration.svg

Diese Dokumentation konzentriert sich auf die Umsetzung als Zwei-Server-Lösung auf einem Hypervisor (Proxmox). 
Andere Virtualisierungslösungen sind möglich, werden aber von linuxmuster.net nicht (mehr) offiziell unterstützt.

Falls Du einen anderen Hypervisor bevorzugst, kannst Du Dich dennoch an der Dokumentation orientieren und findest im linuxmuster.net Forum (https://ask.linuxmuster.net) und im Community-Wiki (https://wiki.linuxmuster.net/community/) Unterstützung.

4. Vorbereitung der benötigten Server

   .. figure:: media/overview-installation-process-part2-basis-server-provision.svg
       :align: center
       :alt: Installation: Übersicht

..       :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part2-basis-server-provision.svg

\* Bei der aktuellen linuxmuster.net Version dient die LTS Version 22.04 als Basis.

5. Installation in die vorbereiteten VMs (virtuelle Maschinen)

   .. figure:: media/overview-installation-process-part3-lmn-server-preparation.svg
       :align: center
       :alt: Installation: Übersicht

..       :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part3-lmn-server-preparation.svg

6. Test der Netzwerkfunktionen

   .. figure:: media/overview-installation-process-part4-lmn-server-setup.svg
      :align: center
      :alt: Installation: Übersicht

..      :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part4-lmn-server-setup.svg

7. Ersteinrichtung (Setup) der Server

   .. figure:: media/overview-installation-process-part5-user-reception.svg
      :align: center
      :alt: Installation: Übersicht

..      :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part5-user-reception.svg

8. Anlegen der Benutzer und Gruppen

   .. figure:: media/overview-installation-process-part6-computer-registration.svg
      :align: center
      :alt: Installation: Übersicht

..      :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part6-computer-registration.svg

9. Einrichtung der Clients

    .. figure:: media/overview-installation-process-part7-installation-finish.svg
       :align: center
       :alt: Installation: Übersicht

..       :target: https://docs.linuxmuster.net/de/latest/_images/overview-installation-process-part7-installation-finish.svg


Nachstehend kannst Du den Installationsablauf als Übersicht herunterladen:

:download:`Übersicht als PDF-Datei <media/overview-installation-process.pdf>`

:download:`Übersicht als Inkscape SVG-Datei <media/overview-installation-process_inkscape_latest.svg>`

.. todo::

   Grafik anpassen

