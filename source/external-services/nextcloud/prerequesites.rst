
Vorüberlegungen zum Standort des Nextcloud-Services
===================================================

Vor dem Einsatz einer Nextcloud ist zu überlegen, wie die Nutzung geplant ist und wie sich die technischen Voraussetzungen an der Schule darstellen.

Hierbei spielen auch Überlegungen eine Rolle, ob die Daten, die auf den internen Home-Laufwerken der lmn7 liegen, über die Nextcloud eingebunden und zur Verfügung gestellt werden sollen. Sollte dies der Fall sein, so bietet sich ein interner Docker-Host an (u.a. auch aus Sicherheitsüberlegungen). Kann darauf verzeichtet werden und ist die  Anbindung der Schule nur mit begrenzter Bandbreite gegeben, so könnte eine externer Docker-Host besser für die Schule geeignet sein.

Beide Szenarien werden nachstehend kurz dargestellt.


Nextcloud auf einem internen Docker-Host
----------------------------------------

.. image:: media/index-01.png
   :align: center

In der Grafik ist der Nextcloud-Service auf dem Docker-Host der Schule installiert. Da der Docker-Host Web-Services wie das Medien- und Raumbuchungssystem und die Nextcloud zur Verfügung stellt, ist er ein völlig eigenständiger Server, der außerhalb der linuxmuster.net steht. Er sollte also direkt an den Router angeschlossen sein und eine eigene IP-Adresse haben. Hier ist später darauf zu achten, dass die Portweiterleitungen am Router für den Docker-Host und die lmn7 korrekt gesetzt sind.

Greift ein Gerät in der Schule, z.B. ein Tablett oder ein Handy, über die Nextcloud auf Daten zu, die in den Home-Laufwerken der lmn7 liegen, müssen die Daten nicht über das Internet gesendet werden. Hier ist der Datenzugriff schnell.

Greift ein Gerät außerhalb der Schule über die Nextcloud auf Daten auf dem Schulserver zu, müssen die Daten vom Docker-Host über das Internet zum Gerät. Hier hängt die Geschwindigkeit von der Internetanbindung der Schule ab.

Nextcloud auf einem externen Docker-Host
----------------------------------------

.. image:: media/index-02.png
   :align: center

In der Grafik ist ein externer Nextcloud-Service außerhalb der Schule dargestellt.

Greift ein Gerät in der Schule über die Nextcloud auf Daten auf dem Schulserver zu, müssen die Daten vom Schulserver über das Internet zum Nextcloud-Service und wieder zurück zum Schulserver. Hier ist der Datenzugriff erheblich langsamer als oben.

Greift ein Gerät außerhalb der Schule über die Nextcloud auf Daten auf dem Schulserver zu, müssen die Daten vom Schulserver über das Internet zum Nextcloud-Service und dann zum Gerät. Der Datenzugriff ist hier nicht schneller als oben.

Sollte ein Zugriff auf die Home-Laufwerke der lmn7 nicht vorgesehen sein, ist die externe Nextcloud, was die Rechenleistung angeht, leistungsstärker als eine interne Nextcloud.

Falls du bereits einen Nextcloud-Service hast, kannst du das erste Kapitel überspringen.

Voraussetzung: Docker-Host
==========================

Um den Nextcloud-Service in der hier beschriebenen Form zu betreiben, ist die Installation eines Docker-Hosts erforderlich.
Hierzu ist ein dedizierter oder als VM entsprechend leistungsstarker Linux-Server mit Ubuntu 18.04 oder 20.04 LTS zu installieren. Auf dem Server ist dann der Docker-Host einzurichten.

Auf dem Docker-Host müssen die Dienste ufw, dehydrated, nginx u.a. installiert und eingerichtet sein. Dies lässt sich wie folgt erreichen:

Docker vorbereiten
------------------

.. hint::

   Hinweise und vordefinierte Rollen zur Installation des Docker-Hosts findest Du unter `linuxuster-docker <https://github.com/linuxmuster/linuxmuster-docker/tree/master/create-dockerhost>`_.

Docker: 1. Schritt
------------------

Auf dem Linux-Server sind die Pakete ``git`` und ``ansible`` zu installieren. Danach ist ein ``sudo-Benutzer`` anzulegen. Für diesen Benutzer ist der öffentliche Teil des ssh-keys in der Datei ``/home/<benutzer>/.ssh/authorized_keys`` zu ergänzen.

Nachdem ein ssh-key erstellt wurde findet sich der öffentliche Teil des Schlüssel des Benutzers unter ``~/.ssh/id_rsa.pub``.

Dieser kann mit folgendem Befehl auf den Server übertragen werden:

.. code::

  ssh-copy-id -i ~/.sshd/id_rsa.pub user@nextcloudserverurl

Der Key wurde nun in der Datei ``authorized_keys`` ergänzt.

Der ssh-Zugang sollte danach für den Benutzer gestestet werden (``ssh -i user@nextcloudserverurl``).

Docker: 2. Schritt
------------------

- mit sudo-Benutzer auf dem Linux-Server anmelden.
- DNS Eintrag für den Nextcloud-Server vornehmen. Es wird bei der Einrichtung ein Lets' encrypt Zertifikat erstellt.
- Repo klonen: ``git clone https://github.com/linuxmuster/linuxmuster-docker.git``
- ins Verzeichnis wechseln: ``cd linuxmuster-docker/create-dockerhost``
- hosts-Datei kopieren: ``cp hosts.ex hosts``
- in hosts-Datei IP-Adresse oder FQDN des Remotehosts eintragen.
- Playbook-Datei kopieren: cp dockerhost.yml.ex dockerhost.yml
- Playbook anpassen (siehe Zeilen mit "### anpassen"):
   - remote_user: Name des Remote-Users auf dem Docker-Host,
   - hostname: Name des Docker-Hosts,
   - user: Name des SSH-Users auf dem Docker-Host (i.d.R. identisch zu obigem remote_user) und
   - key: Pfad zum eigenen öffentlichen SSH-Key.
- ansible: in ``/etc/ansible/hosts`` -> URL und IP des nextcloud hosts eintragen (zusätzlich zur hosts-Datei im github Verzeichnis)
- ansible: in ``/etc/ansible/ansible.cfg`` -> host_key_checking = true setzen.
- Docker-Host ausrollen: ``ansible-playbook -i hosts -k -K dockerhost.yml`` - Passwort des Users wird zweimal abgefragt (für SSH & Sudo).

Docker: 3. Schritt
------------------

Danach steht der Docker-Host zur Verfügung. Der Benutzer kann sich via ssh nur via key anmelden. Die Firewall ufw auf dem Linux-Server lässt nur die Ports 22, 80 und 443 zu.