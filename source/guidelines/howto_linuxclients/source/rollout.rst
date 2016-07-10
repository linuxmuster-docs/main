Clients synchronisieren
=======================

Wenn Sie nun den Client neu starten, erscheint die LINBO-Startseite mit der Auswahl, wie der Ubuntuclient gebootet werden soll.

.. image:: media/rollout/linbo_startpage_ubuntu.png 

Festplatte partitionieren
-------------------------

Bevor ein Betriebssystem installiert werden kann, muss die Clientfestplatte entsprechend der in der Gruppenkonfiguration festgelegten Werte partitioniert werden. Klicken Sie wieder auf den Reiter `Imaging` und geben das LINBO-Passwort ein, danach die Schaltfläche `Partitionieren` wählen.

.. image:: media/rollout/linbo_imaging_partitioning.jpg

Bestätigt man die Sicherheitsabfrage mit `Ja`, wird die Festplatte nach den Vorgaben der Gruppenkonfiguration partitioniert.

Abbild synchronisieren und installieren
---------------------------------------

Jetzt synchronisiert man mit dem Schalter ``Cache aktualisieren`` das Abbild des Linuxclients mit dem lokalen Cache und bereitet damit den Computer zur Synchronisation auf die Festplatte vor.
Mit der Schaltfläche `Logout` kommt zurück zur Auswahl zum Starten des Systems.

.. figure:: media/rollout/linbo-neustart.png 

Starten Sie nun das System über den Knopf `Neu+Start`, dann wird das System durch Kopieren installiert und gestartet.

Der Ubuntuclient startet und aufgenommene Benutzer können sich nun am System anmelden.

Weiterführende Dokumentation
----------------------------

- Howto: Patchklassen, Rechnergruppe, postsync skript
- Howto: Linbo
- Howto: Standardclient updaten


