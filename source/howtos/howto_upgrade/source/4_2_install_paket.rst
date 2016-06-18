Paket linuxmuster-migration installieren
========================================

Je nach Quellsystem sind zur Installation des linuxmuster-migration Pakets verschiedene Paketquellen einzutragen, die zum Qellsystem passen müssen.

In nachstehender Tabelle sind diese zusammengefasst:

+--------------------+--------------------+---------------------------------------------------------+
|Quellsystem         |     Repo           | Eintrag sources.list                                    |
+====================+====================+=========================================================+
|paedML 4.X          | openml5-stable     |deb http://pkg.linuxmuster.net/ openml5-stable/          |
|                    |                    |deb-src http://pkg.linuxmuster.net/ openml5-stable/      |
+--------------------+--------------------+---------------------------------------------------------+
|openML 5.X          | openml5-stable     |deb http://pkg.linuxmuster.net/ openml5-stable/          |
|linuxmuster.net 5.X |                    |deb-src http://pkg.linuxmuster.net/ openml5-stable/      |
+--------------------+--------------------+---------------------------------------------------------+
|linuxmuster.net 6.0 | precise            |deb http://pkg.linuxmuster.net/ precise/                 |
|                    |                    |deb-src http://pkg.linuxmuster.net/ precise/             |
+--------------------+--------------------+---------------------------------------------------------+
|linuxmuster.net 6.1 | babo               |deb http://pkg.linuxmuster.net/ babo/                    |
|                    |                    |deb-src http://pkg.linuxmuster.net/ babo/                |
+--------------------+--------------------+---------------------------------------------------------+
|linuxmuster.net 6.2 | babo62             |deb http://pkg.linuxmuster.net/ babo62/                  |
|                    |                    |deb-src http://pkg.linuxmuster.net/ babo62/              |
+--------------------+--------------------+---------------------------------------------------------+

Ergänzen Sie in der nachstehendeb Datei gemäß Ihres eingesetzten Quellsystems die Eintragungen für das Repository:

.. code:: bash

    /etc/apt/sources.list.d/linuxmuster.net.list

Danach aktualisieren Sie die Paketquellen mit nachstehendem Befehl:

.. code:: bash

    # apt-get update

Anschließend installieren Sie das Paket **linuxmuster-migration**:

.. code:: bash

    # apt-get install linuxmuster-migration


