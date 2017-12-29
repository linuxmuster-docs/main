.. _docker-installation-label:

=================================
 Installation des Docker-Servers
=================================

Zwei Varianten werden unterstützt: Docker kann auf dem
linuxmuster.net-Server oder auf einem eigenständigen Server
installiert werden. In beiden Fällen wird ein Skript
``lmn7-prepare.py`` aufgerufen, das die weitere Installation zu einem
vollständigen Docker-Host übernimmt.


Installation auf eigenem Server
===============================

Installiere ein Ubuntu Server 64bit, folge der Installation
:ref:`server-install-label`, richte dazu das Netzwerk ein.  Lade mit
folgendem Befehl das Einrichtungsskript herunter:

.. code-block:: console

   # wget http://schmitt.linuxmuster.org/lmn7/lmn7-prepare.py

Jetzt wird durch Ausführung des Skriptes `Docker` und die weiterhin
nötige Software installiert.

.. code-block:: console

   # python3 lmn7-prepare.py -p docker -n 10.16.1.x/24
   <snip>
   ### linuxmuster-prepare
   ## Profile
   Enter host profile [server, opsi, docker] [docker]: 
   # Interface
   Enter network interface to use ['ens8']: 
   # IP
   Enter ip address with net or bitmask [10.16.1.x/24]: 10.16.1.26/24
   # Firewall
   Enter gateway/firewall ip address [10.16.1.254]: 
   # Hostname
   Enter hostname [docker]: 
   # Domainname
   Enter domainname [linuxmuster.lan]:
   ## Passwords
   # root ... OK!
   ## Installing updates and host specific software
   OK
   Holen:1 http://fleischsalat.linuxmuster.org/lmn7 ./ InRelease [2.826 B]

   <snip>

   Die folgenden NEUEN Pakete werden installiert:
     bridge-utils cgroupfs-mount containerd docker docker-compose docker.io libpython-stdlib libpython2.7-minimal libpython2.7-stdlib
     libyaml-0-2 python python-backports.ssl-match-hostname python-cached-property python-cffi-backend python-chardet python-cryptography
     python-docker python-dockerpty python-docopt python-enum34 python-funcsigs python-functools32 python-idna python-ipaddress
     python-jsonschema python-minimal python-mock python-ndg-httpsclient python-openssl python-pbr python-pkg-resources python-pyasn1
     python-requests python-six python-texttable python-urllib3 python-websocket python-yaml python2.7 python2.7-minimal runc ubuntu-fan
   0 aktualisiert, 42 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
   Es müssen 22,9 MB an Archiven heruntergeladen werden.

   <snip>		

Der Docker-Host sollte dann neu gestartet werden.

.. code-block:: console

   # reboot

Teste, ob deine Dockerinstallation funktioniert:

.. code-block:: console

   # docker --version
   Docker version 1.13.1, build 092cba3
   # docker run hello-world
   Unable to find image 'hello-world:latest' locally
   latest: Pulling from library/hello-world
   ca4f61b1923c: Pull complete
   Digest: sha256:445b2fe9afea8b4aa0b2f27fe49dd6ad130dfe7a8fd0832be5de99625dad47cd
   Status: Downloaded newer image for hello-world:latest

   Hello from Docker!
   This message shows that your installation appears to be working correctly.
		

