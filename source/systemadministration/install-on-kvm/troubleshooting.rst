Troubleshooting
===============

server: Cups startet nicht sowie LDAP Fehler bei import_workstations
--------------------------------------------------------------------

Möglicherweise treten bei Dir nach der Erstinstallation, Konfiguration und Einspielen aller Updates auch folgende Probleme auf:

* Cups startet nicht und

* **import_workstations** bricht mit Fehlermeldung ab, dass LDAP nicht verfügbar ist.

.. code-block:: console

	Fatal! LDAP is not available! Is slapd running?

Darüber hinaus sind im ``/var/log/syslog`` Logfile **apparmor DENIEDs** zu finden.

.. code-block:: console

	apparmor="DENIED"

Für Beides sind im Forum Lösungsvorschläge zu finden: `Apparmor <https://www.linuxmuster.net/wiki/anwenderwiki:apparmor_fehler>`_, `LDAP <https://www.linuxmuster.net/forum/thread/920;?unb925sess=3fe94941ffd5a8d21766b3e5abff733a>`_.

Beide Probleme können auf dem **server** folgendermaßen behoben werden:

.. code-block:: console

	Apparmor 
	Schritt 1: Deinstallation des Dienstes

	# service apparmor stop
	# update-rc.d -f apparmor remove
	# apt-get --purge remove apparmor apparmor-utils libapparmor-perl libapparmor1
	# rm -rf /etc/apparmor*
	# update-initramfs -u

	Schritt 2: Installation des Dienstes

	# apt-get install apparmor apparmor-utils

	LDAP

	# sophomorix-dump-pg2ldap  
..

.. raw:: html

	<p>
	<iframe width="696" height="392" src="https://www.youtube.com/embed/c_XEN0EPldg?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
	</p>

..
