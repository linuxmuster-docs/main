=================================
 LINBO Imageverwaltung am Client
=================================

Über den Tab "Imaging" erhält der Administrator neue Funktionen

.. figure:: ./media/linbo_imagingscreen/linbo_imagingscreen.png


Für jedes definierte Betriebssystem gibt es Schaltflächen für die Funktionen

.. figure:: ./media/linbo_imagingscreen/image-22x22.png

   Image erstellen
   
   Es öffnet sich ein neues Dialogfenster, über das man ein neues
   Abbild erstellen (und hochladen) kann.

.. figure:: ./media/linbo_imagingscreen/upload-22x22.png

   Image hochladen
   
   Es öffnet sich ein neues Dialogfenster, über das man das aktuelle
   Abbild auf den Server hochladen kann.
	    

Daneben können gibt es Schaltflächen für folgende administrative Funktionen 

.. figure:: ./media/linbo_imagingscreen/console-22x22.png

   Console
   
   Man kann eine (rudimentäre) Console öffnen, um Shell-Befehle
   abzusetzen und Fehler zu diagnostizieren.

.. figure:: ./media/linbo_imagingscreen/cache-22x22.png

   Cache aktualisieren
   
   Üblicherweise wird eine Partition auf dem Client als Cache
   festgelegt. Mit dieser Schaltfläche kann der Cache aktualisiert
   werden, d.h. alle für diesen Client nötigen Abbilder und
   postsync-Dateien werden gegebenenfalls heruntergeladen.

.. figure:: ./media/linbo_imagingscreen/partition-22x22.png

   Partitionieren
   
   Partitioniert die gesamte Festplatte.

.. figure:: ./media/linbo_imagingscreen/register-22x22.png

   Registrieren

   Öffnet den Registrierungdialog zur erstmaligen Aufnahme dieses
   Rechners.

Darüberhinaus läuft in einem kleinen Fenster ein Timeout herunter, den
man abstellen kann. Dort kann man auch über die Schaltfläche LOGOUT
zurück zum Startbildschirm.

Dialog: Image erstellen
=======================

.. figure:: ./media/linbo_imagingscreen/create_image_dialog.png

Zur Auswahl steht der momentane Name des Abbilds. Das aktuelle Abbild
wird dann beim Erstellen überschrieben. Beim Hochladen des aktuellen
Abbilds mit demselben Namen wird auf dem Server ein Backup des
vorherigen Abbilds erstellt.

Wird ein neuer Dateiname gewählt, kann man Informationen zu dem neuen
Image verfassen.

Wird "Differentielles Image" gewählt, dann gilt der neue Dateiname für
das zu erstellende differentielle Image (mit der Dateiendung '.rsync').

Es gibt die beiden Optionen zum Abschluss der Aktion "Erstellen" oder
"Erstellen+Hochladen" den Computer neu zu starten oder
herunterzufahren.

Dialog: Image hochladen
=======================

.. figure:: ./media/linbo_imagingscreen/upload_image_dialog.png

Wie beim Image erstellen Dialog, kann hier explizit nur ein
ausgewähltes Image hochgeladen werden und der Rechner zum Abschluss
neu gestartet oder heruntergefahren werden.

Dialog: Console
===============

.. figure:: ./media/linbo_imagingscreen/console_dialog.png

Der einfache Konsolendialog erlaubt die Eingabe einzelner Befehle in
die untere Zeile. Die Ausgabe des ausgeführten Befehls erscheint im
oberen Fenster.

Dialog: Cache aktualisieren
===========================

.. figure:: ./media/linbo_imagingscreen/update_cache_dialog.png

Der Cache wird aktualisiert. Es werden die drei Möglichkeiten der
Synchronisation zur Auswahl gegeben: Rsync, Multicast oder Bittorrent.


Dialog: Partitionieren
======================

Es wird noch einmal gefragt, ob man wirklich alle Daten auf der
Festplatte löschen will. Danach kann man mit "Cache aktualisieren"
aber auch wieder die Abbilder vom Server kopieren.

Dialog: Registrieren
====================

.. figure:: ./media/linbo_imagingscreen/register_dialog.png

Mit diesem Dialog kann ein erstmalig genutzer Rechner registriert
werden. Dafür müssen alle Eingabefelder dem Vergabeschema entsprechend
ausgefüllt werden.

