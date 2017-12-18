========================
 Erste Benutzeraufnahme
========================

In einer müssen meist mehrere hundert bis einige tausend Schüler als
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


