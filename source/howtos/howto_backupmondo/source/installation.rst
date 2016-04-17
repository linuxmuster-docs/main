Installation
------------

Das **linuxmuster-backup**-Programm befindet sich im Hauptrepo, ist also in der normalen Paketauswahl verfügbar.
Für das eigentlich Backup wird **mondo** verwendet. Dieses befindet sich nicht im Hauptrepo und auch nicht
in den üblichen Paketquellen für Ubuntu. Daher muss die Paketquelle für mondo eingerichtet werden, was
im folgenden schrittweise beschrieben wird.

1. Erstellen Sie mit dem Editor ihrer Wahl als Benutzer ''root'' auf dem Server die Datei ``/etc/apt/sources.list.d/mondorescue.list`` mit folgendem Inhalt:

.. note:: Momentan (April/2015) ist die Mondorescue-Version 3.2.0 aktuell. Sie enthält einen schwerwiegenden
	Fehler, der ein korrektes Backup großer Dateien verhindert. Daher muss abweichend die aktuelle Testversion
	3.2.0.xxx verwendet werden, bis die Version 3.2.1 erschienen ist.

Die Paketquelle lautet:

.. code-block:: bash

	# Quellen für mondorescue
	#deb ftp://ftp.mondorescue.org/ubuntu 12.04 contrib
	# deb-src ftp://ftp.mondorescue.org/ubuntu 12.04 contrib
	# Quellen für mondorescue Testversion
	deb ftp://ftp.mondorescue.org/test/ubuntu 12.04 contrib
	# deb-src ftp://ftp.mondorescue.org/test/ubuntu 12.04 contrib

Zusätzlich muss noch ein Link gesetzt werden:

.. code-block:: bash

	ln -s /sbin/parted2fdisk /usr/sbin/parted2fdisk


.. note::
	- Damit das System der Quelle vertraut, müssen noch der Repository-Schlüssel installiert werden:

	.. code-block:: bash

		wget ftp://ftp.mondorescue.org/ubuntu/12.04/mondorescue.pubkey
		apt-key add mondorescue.pubkey
		rm mondorescue.pubkey


2. Nun aktualisieren wir die Paketlisten, damit dem System bekannt wird, welche zusätzlichen Pakete zur Verfügung stehen:

.. code-block:: bash

	apt-get update


3. Schließlich installieren wir das Paket, welches das Backup-Programm zur Verfügung stellt und mondo mit installiert:

.. code-block:: bash

	apt-get install linuxmuster-backup

Abhängigkeiten werden dadurch automatisch mit installiert.
