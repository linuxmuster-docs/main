Schritt 1: adminPC
==================

.. hint:: 
	Der *adminPC* soll zur Administration des KVM-Servers dienen. Der
	Vorteil dieser Variante liegt vor allen Dingen darin, dass der
	Virtualisierungsserver so schlank wie möglich gehalten werden kann.

.. image:: media/adminpc/adminpc-image01.png

Die Hardware sollte folgende Mindestmerkmale aufweisen:

* DualCore CPU
* 1GB RAM
* 20GB HDD

Schritt 1a: Installation des *adminPCs*
---------------------------------------

Als Betriebssystem wird *Lubuntu* in der Version 16.04 LTS verwendet. Es kann
`hier <http://cdimage.ubuntu.com/lubuntu/releases/16.04.1/release/lubuntu-16.04.1-alternate-amd64.iso>`_
heruntergeladen werden.  

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/hHrpioJ0lvk" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 1b: Installation der Updates
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
	<iframe width="696" height="392" src="https://www.youtube.com/embed/zxLkNzFparA?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. _Schritt_1c-label:

Schritt 1c: Installation des Virt-Managers
------------------------------------------

.. hint::
	Der Schritt 1c erfolgt thematisch nach :ref:`Schritt_2e-label` und ist erforderlich, um in der Administration des KVM-Servers weiter zu kommen.

In diesem Schritt erfolgt die Installation des Virt-Managers, um die virtuellen Maschinen auf dem KVM-Server zu verwalten.

.. code-block:: console

	Optional: Installation von aptitiude zum Suchen
	# apt-get install aptitude

	Suchen des Paketes
	# aptitude search virt-manager

	... natuerlich geht auch ein
	# apt-cache search virt-manager

	Installieren des Paketes
	# apt-get install virt-manager

.. raw:: html

   	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/tYqksSGla7Y?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 1d: Deaktivierung von IPv6
----------------------------------

Um sich später keine Gedanken um Netzwerksicherheit machen zu müssen, sollte IPv6 global deaktiviert werden.

.. code-block:: console

	/etc/default/grub
	GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1"

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/Wbf4s0mdqM8?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 1e: Umstellen der Netzwerkverbindung auf das Schulnetz
--------------------------------------------------------------

Die Netzwerkverbingung kann nun mit Hilfe des *Network Managers* auf das Schulnetz umgestellt werden.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/rrOif_nPA8k?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. _Schritt_1f-label:

Schritt 1f: Erstellung eines ssh-Aliases zum KVM-Server
-------------------------------------------------------

.. hint::
	Der Schritt erfolgt thematisch nach :ref:`Schritt_3b-label` zur einfacheren Administration des KVM-Servers.

.. code-block:: console
	
	.bash_aliases
	alias kvm="ssh root@10.16.1.10

	# source bash.aliases

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/W3U5EOu23vw?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. _Schritt_1g-label:

Schritt 1g: Zulassen des Zugriffs auf den Server
------------------------------------------------

.. hint::
	Der Schritt erfolgt thematisch nach :ref:`Schritt_4g-label`  zur Administration des Schulservers und Zugang zum Internet.

Nach der Installation des Schulservers ist der Zugriff auf ihn komplett gesperrt. Ein Eintrag in die ``/etc/linuxmuster/workstations`` ist erforderlich. Die einfachste Möglichkeit, diese Datei zu bearbeiten, ist die Schulkonsole. Um auf Diese Zugriff zu erhalten, muss temporär die Firewall deaktiviert werden.

.. code-block:: console

	Firewall stoppen/starten
	# linuxmuster-base stop/start

Zugriff auf die Schulkonsole über https://server:242

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/rMK0bYrmvno?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. _Schritt_1h-label:

Schritt 1h: Anpassen der Zeitquelle
-----------------------------------

.. hint::
	Der Schritt erfolgt thematisch nach :ref:`Schritt_4g-label` zur Administration des Schulservers und Zugang zum Internet.
	

Als Zeitquelle des adminPCs soll auch die Firewall dienen.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/QNz3WNwMzYg?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. _Schritt_1i-label:

Schritt 1i: Erstellen eines ssh-Aliases zum Server
--------------------------------------------------

.. hint::
	Der Schritt erfolgt thematisch nach :ref:`Schritt_4g-label` zur Administration des Schulservers und Zugang zum Internet.
	
Die Einrichtung erfolgt analog zu :ref:`Schritt_1f-label`.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/lnOlyK9h8QI?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..
