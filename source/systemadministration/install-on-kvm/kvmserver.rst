Schritt 2: KVM Virtualisierungshost
====================================

.. hint::
	Der *kvm* Server bildet das Grundgerüst für die Firewall *ipfire* und
	den Schulserver *server*. Da KVM im Gegensatz zu Xen oder VMWare auf
	die Virtualisierungsfunktionen der CPU angewiesen ist, müssen Diese
	natürlich vorhanden sein.

.. image:: media/kvmserver/kvmserver-image01.png


Die folgende Anleitung beschreibt die *einfachste* Implementierung ohne Dinge
wie VLANs, Teaming oder Raids. Diese Themen werden (hoffentlich schon vorhanden
;-) in zusätzlichen Anleitungen betrachtet. 

Folgende Hardware sollte der Server mindestens zur Verfügung stellen:

* CPU mit 4 Kernen
* 16GB RAM
* 1TB HDD plus zweite HDD für ein Backup
* 2x 1GBit/s Netzwerkkarten

Schritt 2a: Installation des KVM-Servers
----------------------------------------

Als Betriebssystem wird *Ubuntu Server* in der Version 16.04 LTS verwendet. Es kann
`hier <http://releases.ubuntu.com/16.04.3/ubuntu-16.04.3-server-amd64.iso>`_
heruntergeladen werden.  

**Kopieren des ISOs auf einen USB Stick**

Hilfreiche Befehle sind:

.. code-block:: console

	Löschen des MBRs des USB-Sticks
	# sudo dd if=/dev/zero of=/dev/sdX bs=1M count=10

	Kopieren des ISOs auf den Stick
	# sudo dd if=<Name des ISOs> | sudo pv -s <Groesse des ISOs> | sudo dd of=/dev/sdX bs=1M && sync

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/7NIoQpSSVQw?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

**Installation**

.. hint::
	Bei der Installation sind folgende Merkmale zu berücksichtigen:

		* Auswahl des HWE Kernels
		* Einrichtung eines LVMs auf der HDD mit 25GB für das Betriebssystem
		* Auswahl der Pakete *Virtual Machine host* und *OpenSSH server*

	Des Weiteren ist es sinnvoll, die erste Netzwerkkarte des Servers an
	den Internet-Router anzuschließen, um eventuell notwengige Pakete
	(Sprachpakete) während der Installation zu installieren.	

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/ZL0e07nJI_w?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..
 
Schritt 2b: Netzwerkkonfiguration des KVM-Servers
-------------------------------------------------

In diesem Schritt erfolgt die Anbindung des KVM-Servers an das Schulnetz und an das Internet sowohl für den KVM-Server selbst, als auch für die virtuellen Maschinen. Die Implementierung erfolgt mit Hilfe von Bridges.

**Herausfinden der Namen der Netzwerkkarten**

.. code-block:: console

	# dmesg | grep eth

**Anpassen der Netzwerkkonfiguration**

.. code-block:: console

	# vi /etc/network/interfaces

	# Internet Interface
	auto <Internet Interface>
	iface <Internet Interface> inet manual

	auto br-red
	iface br-red inet static
	address 192.168.1.10
	netmask 255.255.255.0
	gateway 192.168.1.1
	bridge_ports <Internet Interface>
	bridge_stp off
	dns-nameservers 192.168.1.1
	
	# Schulnetz Interface
	auto <Schulnetz Interface>
	iface <Schulnetz Interface> inet manual

	auto br-green
	iface br-green inet static
	address 10.16.1.10
	netmask 255.240.0.0
	bridge_ports <Schulnetz Interface>
	bridge_stp off

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/efja1qQ_wfw?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 2c: Installation der Updates
------------------------------------

Nach der Erstinstallation ist es sinnvoll, das System erst einmal auf den
aktuellen Stand zu bringen. Auf der Console wird dies mit folgenden Befehlen
durchgeführt:

.. code-block:: console

	# sudo apt-get update
	# sudo apt-get upgrade
	# sudo apt-get dist-upgrade
	# sudo apt-get autoremove
	# sudo apt-get autoclean

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/DgMkFhBbrlY?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..


Schritt 2d: Einrichten des SSH-Zugangs auf Zertifikatsbasis
-----------------------------------------------------------

Die Remote-Administration des KVM-Servers soll per SSH und Zertifikaten erfolgen. Als Benutzer wird root verwendet.

**Setzen des Rootpassworts und Aktivierung des SSH-Zugangs für root**

.. code-block:: console

	# sudo passwd

	# vi /etc/ssh/sshd_config
		PermitRootLogin yes

**Erstellen von SSH-Zertifikaten auf dem AdminPC und Kopieren auf den KVM-Server**

.. code-block:: console

	# ssh-keygen

	# ssh-copy-id root@192.168.1.10

**Deaktivierung des SSH-Zugangs für root per Passwort**

.. code-block:: console

	# vi /etc/ssh/sshd_config
		PermitRootLogin prohibit-password

**Löschen des lmadmin Users auf dem KVM-Server**

.. code-block:: console

	# userdel -r lmadmin

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/AUGVGgqRkU0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. _Schritt_2e-label:

Schritt 2e: Einrichten der Zeit-Synchronisation
-----------------------------------------------

Immer eine gute Sache ist es, z.B. in Logfiles die korrekte Zeit zu finden. Aus diesem Grund erfolgt die Konfiguration eines NTP-Clients.

.. code-block:: console

	Installieren von ntpdate
	# apt-get install ntpdate

	Einmaliges Stellen der Uhrzeit
	# ntpdate 0.de.pool.ntp.org

	Installieren des NTP-Daemons
	# apt-get install ntp

	Anzeigen der Zeitsynchronisation
	# ntpq -p

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/tHqFTfS99xo?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. hint::

	Falls noch nicht geschehen :ref:`Schritt_1c-label` 

Schritt 2f: Konfigurieren der Virt-Manager-Verbindung im Schulnetz
------------------------------------------------------------------

In diesem Schritt erfolgt nach der Installation der *Virt-Managers* die Konfiguration

* der Anbindung des adminPCs an das Schulnetz und
* die Einrichtung der *KVM-Server* Verbindung.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/GHTihR3GffI?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 2g: Anpassen des Namens der Virt-Manager-Verbindung 
-----------------------------------------------------------

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/zEsV2P9JOCk?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>	
	</p>
..

Schritt 2h: Einrichtung des LVM-Storage-Pools
---------------------------------------------

In diesem Schritt erfolgt die Einrichtung des Speicherplatzes der virtuellen HDDs. Die Nutzung eines LVM-Storages stellt dabei die performanteste Möglichkeit dar.

.. hint:: 
	Leider ist es nicht möglich, direkt über den *Virt-Manager* Snapshots zu erstellen, wie z.B. bei Nutzung von qcow2 HDDs. Diese werden jedoch nicht verwendet, da es einen erheblichen Geschwindigkeitsnachteil gibt. LVM bietet aber selbst eine Snapshotfunktionalität, die Du später beim Backup der VMs nutzen kannst.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/N-K-WkuH7ss?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>

Schritt 2i: Deaktivierung von IPv6
----------------------------------

Um sich später keine Gedanken um Netzwerksicherheit machen zu müssen, sollte IPv6 global deaktiviert werden.

.. code-block:: console

	/etc/default/grub
	GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/SQuVytwtFc0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 2j: Einstellen der Swappiness
--------------------------------------

Der Swap-Speicher soll nur im Notfall verwendet werden. Dazu wird die *swappiness* auf 0 gestellt.

.. code-block:: console
	
	Sofort auf der Konsole
	# sysctl vm.swappiness=0

	/etc/sysctl.conf
	vm.swappiness = 0

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/PaVDFQCUNIM?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>

..
