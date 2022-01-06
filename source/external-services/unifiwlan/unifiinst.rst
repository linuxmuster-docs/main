Die Installation
================

Hardwareanforderungen
---------------------

- 3 GB RAM
- Eine Netzwerkkarte im Schulnetz (VLAN 16)
- 10 GB Festplatte (bei mir im Schulbetrieb sind 3,3 GB vom 40 GB belegt).


Die Grundinstallation
---------------------

Für die Installation brauchen wir einen ``Dockerhost ohne nginx und dehydrated`` (siehe :ref:`Installation eines Dockerhosts <dockerhost-install-label>`).

.. hint::

   Es kann hierzu jeder bereits bestehende Docker-Host verwendet werden, sofern die u.g. Ports nicht bereits belegt sind.

Unifi-Controller mit docker-compose einrichten und starten
==========================================================

Melde dich auf dem Docker-Host an, werde mit ``sudo -i`` `root` und lege mit ``mkdir -p /srv/docker/unifi`` das Verzeichnis `/srv/docker/unifi` an. 

Gehe mit ``cd /srv/docker/unifi`` in das neue Verzeichnis und lege die Datei docker-compose.yml an mit folgendem Inhalt an:

.. code-block:: console

  version: "2.1"
  services:
    unifi-controller:
      image: ghcr.io/linuxserver/unifi-controller
      container_name: unifi-controller
      environment:
        - PUID=1000
        - PGID=1000
        - MEM_LIMIT=1024M #optional
      volumes:
        - ./data:/config
      ports:
        - 3478:3478/udp
        - 10001:10001/udp
        - 8080:8080
        - 8443:8443
        - 1900:1900/udp #optional
        - 8843:8843 #optional
        - 8880:8880 #optional
        - 6789:6789 #optional
        - 5514:5514 #optional
      restart: unless-stopped
     
Starte den Unifi-Controller mit ``docker-compose up -d``.

.. hint::

   Zur Zeit wird die Unifi-Controller-Version 6.5.53 installiert. Möchtest du eine frühere Version installieren, musst du das in Zeile 4 angeben. Beispiel: ``image: ghcr.io/linuxserver/unifi-controller:LTS-version-5.6.42``. Welche Versionen es gibt, siehst du `hier <https://hub.docker.com/r/linuxserver/unifi-controller/tags?page=1>`_ .

