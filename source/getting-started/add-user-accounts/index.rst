========================
 Erste Benutzeraufnahme
========================

In einer Schule müssen meist mehrere hundert bis einige tausend Schüler als
Benutzer angelegt werden müssen. Deshalb übernimmt diese komplexe
Aufgabe bei der *linuxmuster.net* das Programm *Sophomorix*.

*Sophomorix* liest alle Schüler aus einer Text-Datei ein, die z.B. aus
dem Schulverwaltungsprogramm der Schule bezogen wurde. Anschließend
werden alle Schüler dieser Liste, die im System noch nicht vorhanden
sind, angelegt, solche mit einer neuen Klasse versetzt und nicht mehr
aufgeführte Schüler aus dem System gelöscht.

Mit der *Schulkonsole* gibt es für den Netzwerkbetreuer ein
webbasiertes Werkzeug, das ihm die Bedienung von *Sophomorix* sehr
erleichtert. Die einzelnen Schritte werden im Folgenden erläutert. Der
Netzwerkbetreuer muss nur noch in Ausnahmefällen mit der Kommandozeile
arbeiten.

Um Benutzer neu aufzunehmen müssen die folgenden Schritte nacheinander
ausgeführt werden:

*   Schüler und Lehrerliste aus dem Schulverwaltungsprogramm exportieren.
*   Die Benutzerlisten auf dem Server einlesen. 
*   Alle Benutzerlisten auf Fehleingaben, oder Ähnlichkeiten mit vorhandenen Benutzern prüfen.
*   Danach evtl. die Benutzerlisten entsprechend korrigieren.
*   Benutzerdaten übernehmen, d.h. Benutzer jetzt tatsächlich anlegen
*   Passwortlisten bzw. Anmeldekärtchen ausdrucken

Im folgenden wird gezeigt wie die Erstaufnahme von Schülern vonstatten geht.

Erstaufnahme von Schülern
-------------------------

Benutzerverwaltung ist Sache des Administrators, deshalb loggt sich der Administrator in die Schulkonsole ein

.. image:: media/school-console-admin-login.png

In der Schulkonsole wählen Sie  im Menü `Benutzer` `Schülerliste pflegen`

.. image:: media/menu-studentslist.png

und sehen ein leeres Fenster.

.. image:: media/user-management-students-empty.png

Nach Klick auf `Durchsuchen`

.. image:: media/user-management-browse.png

navigiert man zu dem Ort an dem die aus der Schülerverwaltungsdatei exportierte Datei liegt. Hier der ``Desktop``

.. image:: media/students-import-1.png

Man wählt die Datei durch Doppelklick aus und klickt im folgenden Fenster auf Hochladen

.. image:: media/students-import-3.png

Je nach Anzahl der Schüler dauert es eine Weile bis im folgenden Fenster die Liste der aufzunehmenden Schüler erscheint.

.. image:: media/students-import-4.png

Mit Klick auf `Änderungen speichern`

.. image:: media/students-import-5.png

werden die aufzunehmenden Schüler in der Datei schueler.txt abgespeichert

Nun muss de Datei schueler.txt überprüft werden. Dies geschieht durch Auswahl im Menü `Benutzer` `Benutzerlisten prüfen`

.. image:: media/studentslist-check.png

um dann auf `Benutzerlisten überprüfen` zu klicken

.. image:: media/studentslist-check-2.png

Ist das Prüfen beendet erhält man eine Liste ähnlich der hier gezeigten

.. image:: media/studentslist-check-finished.png

Gegebenenfalls muss man die Datei schueler.txt noch überarbeiten, wenn in der Liste Fehler gemeldet werden

.. image:: media/studentslist-check-confirm.png

Sind alle Fehler beseitigt, dann klickt man auf `Benutzerdaten übernehmen`

Es wird erneut eine Liste der anzulegenden Schüler angezeigt

.. image:: media/students-adduser.png

Unterhalb dieser Liste klickt man auf `Benutzer anlegen`

Es folgen Statusmeldungen wie die im folgenden Bild gezeigten

.. image:: media/students-adduser-status.png 

Bei einer großen Schülerzahl kann es einige Stunden dauern bis das folgende Bild das Ende des Benutzerimports anzeigt

.. image:: media/students-adduser-finished.png

Damit ist die Erstaufnahme abgeschlossen.
