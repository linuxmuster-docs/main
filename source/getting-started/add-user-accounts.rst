
=======================================
 Benutzeraufnahme mit der Schulkonsole
=======================================

.. sectionauthor:: `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_
		   

In einer Schule müssen meist mehrere hundert bis einige tausend
Schüler als Benutzer angelegt werden. Die Schulkonsole (WebUI) erlaubt
das Einlesen aller Schülerdaten aus einer Text-Datei, die z.B. aus dem
Schulverwaltungsprogramm der Schule bezogen wurde. Anschließend werden
Konten aller Schüler dieser Liste, die im System noch nicht vorhanden
sind, angelegt, solche mit einer neuen Klasse versetzt und Konten
nicht mehr aufgeführter Schüler schrittweise aus dem System entfernt.

In diesen Abschnitten wird beispielhaft ein Lehrer händisch angelegt
und per Datei-Import einige Schüler aufgenommen. Melde dich dafür an
der Schulkonsole als ``global-admin``, wie es in
:ref:`login-dselma-global-admin` beschrieben wird.


Zeichenkodierung wählen
=======================

Bei einem neuen System ohne Lehrer und Schüler kann die automatische
Erkennung der Zeichencodierung der Eingabedatei (modern "UTF-8" oder
eine andere wie z.B. "iso8859") nicht gut funktionieren.

Die Zeichencodierung kann daher festgelegt werden, wenn man die
Kodierung der Eingabedatei kennt. Unter dem Menüpunkt
`EINSTELLUNGEN/Schuleinstellungen` im Reiter `Listenimport` unterhalb von `Zeichenkodierung` ist im
Beispiel auf "UTF-8" gestellt worden.

.. figure:: media/settings-settings-charencoding.png
   :align: center
   :alt: Character encoding for imported data

Schließe die Eingabe ab mit "Speichern".

Lehrer importieren
==================

Unter dem Menüpunkt `BENUTZERVERWALTUNG/Listenverwaltung` wird
`Lehrer` ausgewählt.  Der Knopf `+ Lehrer hinzufügen` fügt eine Zeile
hinzu, die man nun mit den angezeigten Daten ausfüllt. Mit `+ Lehrer
hinzufügen` können auf diese Art und Weise einzelne weitere Lehrer
aufgenommen werden.

.. figure:: media/user-add-teacher-data.png
   :align: center
   :alt: User entry to add teacher

Der Knopf `Speichern` am unteren Ende des Fensters fügt die Lehrer
noch nicht hinzu, testet aber auf eventuelle Eingabefehler und
Inkonsistenzen. 

Am Ende der Eingabe aller hinzuzufügenden Lehrer drückst du `Speichern
& Prüfen`. Der folgende Dialog zeigt in der Übersicht an, was getan
wird und kann im Reiter `Hinzuzufügen` überprüft werden, welche Lehrer
hinzugefügt werden, sobald man `ÜBERNEHMEN` anklickt.

.. figure:: media/user-add-check.png
   :align: center
   :alt: User entry check dialog

Der Importdialog zeigt den Fortschritt an und meldet zurück, wenn die
Aufnahme abgeschlossen wurde.
	 
.. figure:: media/user-add-output-finished.png
   :align: center
   :alt: User entry output dialog

Ab jetzt können Lehrer, im Menüpunkt `BENUTZERVERWALTUNG/Lehrer`
aufgelistet, deren Kontoinformationen abgerufen und
z.B. Erstpasswörter (zurück-)gesetzt werden.

.. figure:: media/user-modify-teacher.png
   :align: center
   :alt: User entry output dialog

Schüler importieren
===================

Schüler können analog zu Lehrern einzeln hinzugefügt werden.

Alternativ können **alle** Schüler (alte wie neue) importiert werden.
Wähle im Menüpunkt `BENUTZERVERWALTUNG/Listenverwaltung` (es erscheint
automatisch die Schülerliste) die Schaltfläche `IM EDITOR
ÖFFNEN`. 

.. figure:: media/user-add-students-csv.png
   :align: center
   :alt: User entry dialog via CSV

Eine zu importierende Datei sollte folgende Daten aufweisen:
Klassenbezeichnung,Nachname, Vorname und Geburtsdatum (optional eine
eindeutige ID aus einem Schulverwaltungsprogramm). Beispielsweise:

.. code-block:: console

   10A;Testuser;Heinz;1.1.2001;
   13a;Musterfrau;Tanja;2.1.2001;
   5b;Hausmann;Hans;3.1.2001;   

.. attention::

   Die Datei muss alle alten und neuen Schüler enthalten, sonst werden
   alle fehlenden Schüler zur Entfernung (Versetzung aus der Schule)
   vorgemerkt. Siehe auch :ref:`add-user-errorcorrection-label` unten.

Per "Drag & Drop" lässt sich eine so formatierte Datei nun hochladen,
alternativ kann die Schaltfläche `CSV LADEN` gewählt werden. Es wird
abgefragt, welche Spalte welche Art von Daten enthält und du kannst
das durch Umsortieren richtigstellen und mit ``SORTIERUNG
AKZEPTIEREN`` abschließen.

.. figure:: media/user-import-sortorder.png
   :align: center
   :alt: User sort order dialog of imported CSV

Mit `SPEICHERN` werden eventuelle Konsistenzfehler überprüft.  Die
Schaltfläche `SPEICHERN & PRÜFEN` zeigt nun an, wieviele Schüler bei
`ÜBERNEHMEN` ins System übernommen, versetzt (aktualisiert) oder
gelöscht werden. Ab der erfolgreichen Übernahme können die Schüler
unter dem Menüpunkt `BENUTZERVERWALTUNG/Schüler` gefunden und deren
Konten bearbeitet werden.

.. _add-user-errorcorrection-label:

Fehlerkorrektur
===============

Hat man einen fehlerhafte Daten in das System eingepflegt und hat sie
noch nicht imporiert, lassen sich Schüler und Lehrerlisten aus einer
Sicherung zurückholen. Der Knopf für die Sicherung ist rechts unten in
der Listenverwaltung.


Ausführlichere Dokumentation zur Benutzerverwaltung findet sich im
entsprechenden Abschnitt dieser Dokumentation.
