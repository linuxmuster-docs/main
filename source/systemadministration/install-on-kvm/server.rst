Schritt 4: Server
=================

.. hint::
	In diesem Schritt folgt die Installation der Firewall dieser :ref:`Anleitung <server-install-label>` und diesen :ref:`Voraussetzungen <preface-preparations-label>`.

.. image:: media/server/server-image01.png

Schritt 4a: Download des Ubuntu 12.04.5 ISOs
--------------------------------------------

Der Download des ISOs erfolgt auf dem KVM-Server im Verzeichnis analog zum ISO der Firewall unter ``/var/lib/libvirt/images``.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/-ZuMFRMGoy0?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 4b: Erstellen, Konfigurieren und Installieren der VM des Servers
------------------------------------------------------------------------

In diesem Schritt erfolgt die Erstellung, Konfiguration und Installation des Ubuntu-Systems des Schulservers. Die VM verfügt dabei über folgende Parameter:

* 2 CPUs,
* 8GB RAM,
* HDDs für / (50GB), swap (2GB), /home (500GB) und /var (500GB),
* 1 NIC.

.. hint::
	Die Grössen der virtuellen HDDs sind natürlich auf die eigenen Erfordernisse anzupassen.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/4Ld6KL1Tt_U?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 4c: Installieren aller verfügbaren Updates nach der Installation des Servers
------------------------------------------------------------------------------------

Die Installation der Updates erfolgt mit den üblichen Befehlen:

.. code-block:: console

	# apt-get update
	# apt-get upgrade
	# apt-get dist-upgrade
	# apt-get autoremove
	# apt-get clean

.. hint::

	Falls beim *apt-get update* Fehlermeldungen erscheinen: *Fehlschlag beim Holen ...*, so hilft es, den Inhalt des Verzeichnisses ``/var/lib/apt/lists`` zu löschen und den Befehl erneut auszuführen.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/2WHzgtVcYjE?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 4d: Grundkonfiguration des Servers
------------------------------------------

Im letzten Schritt vor der eigentlichen Installation werden folgende Schritte durchgeführt:

* Setzen des Root-Passwortes und Löschen des *lmadmin* Accountes,
* Setzen der *vm.swappiness auf 0*,
* Deaktivierung von IPv6 und Setzen des Text-Modes beim Booten.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/oX6SpWdmrq4?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 4e: Installation des linuxmuster-base Paketes
-----------------------------------------------------

Die Installation erfolgt mittels:

.. code-block:: console

	# apt-get install linuxmuster-base


.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/eWKi2cDo_7c?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

Schritt 4f: Start der LinuxMuster-Erstkonfiguration
---------------------------------------------------

Endlich ist das Ziel der Vorbereitungen erreicht und mittels

.. code-block:: console

	# linuxmuster-setup --first

kann die eigentliche Konfiguration des Servers gestartet werden. Zu Beachten ist hierbei, dass ein Neustart der Firewall erfolgen muss.

.. hint::
	Nach dem Start der Installation mittels *linuxmuster-setup --first* wird im Screencast mit *Alt+F2* kurz auf das zweite Terminal des Servers gewechselt um die Konnektivität zum *ipfire* zu testen.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/vGcskDUPQP4?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. _Schritt_4g-label:

Schritt 4g: Schaffung einer einheitlichen Netzwerkzeit mit der Firewall als Quelle
----------------------------------------------------------------------------------

.. hint::
	Dieser Schritt ist optional. Aus der Sicht des Schreibers ist es jedoch sinnvoll, pro Netzwerk eine Zeitquelle zu definieren, an der sich Alle orientieren.

Die Firewall holt sich die Zeit aus dem Internet und verteilt sie im Schulnetz. So ist sichergestellt, dass auch bei Ausfall des Internets alle Geräte die selbe Zeit sprechen.

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/Em9paXezO9Q?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>
..

.. hint::

	Falls noch nicht geschehen :ref:`Schritt_1g-label` 

.. hint::

	Falls noch nicht geschehen :ref:`Schritt_1h-label` 

.. hint::

	Falls noch nicht geschehen :ref:`Schritt_1i-label` 

Damit ist die Erstinstallation aller Komponenten mittels KVM geschafft.
