Weiterführendes zur Benutzerverwaltung mit Sophomorix
-----------------------------------------------------

In der *linuxmuster.net* wird die Benutzerverwaltung mit Hilfe des Programms *Sophomorix* durchgeführt. Alle Schüler und Lehrer einer Schule, 
die als Benutzer im System vorhanden sein sollen, sind in vier Benutzerlisten (schueler.txt, lehrer.txt, extraschueler.txt und
extrakurse.txt) aufgeführt.

Zur Verwaltung der Benutzer wird folgendermaßen verfahren:

*   Alle Datensätze aus den Benutzerlisten werden geprüft und vorsortiert.
*   Bestehende Benutzer, die nicht mehr in den Listen aufgeführt sind, werden zum Verschieben auf dem
    *Dachboden* (*attic*) vorgesehen.
*   Ähnelt ein Datensatz (z.B. nach Namenskorrekturen im Sekretariat) einem, der zum Verschieben auf dem
    *Dachboden* vorgesehen wurde, wird er - evtl. nach Rückfrage -  mit
    dem bestehenden Benutzernamen verbunden und somit der Benutzer nicht auf den *Dachboden*
    verschoben. In diesem Fall behält der Benutzer seinen alten Login-Namen.
*   Neue Datensätze werden als Benutzer neu angelegt (Status U) und bekommen Benutzername und Passwort zugewiesen.
*   Bestehende Benutzer werden evtl. in neue Klassen versetzt.
*   Bestehende Benutzer, die nicht mehr in den Benutzerlisten vorhanden sind, werden auf den *Dachboden* verschoben (Status T). Sie können sich dann 
    während eines *Duldungszeitraumes* zwar noch anmelden, haben aber keinen Zugriff mehr auf die Tauschverzeichnisse.
*   Benutzer, deren *Duldungszeitraum* auf dem *Dachboden* abgelaufen ist, können sich nicht mehr anmelden, aber ihre Daten verbleiben während eines
    *Reaktivierungszeitraumes* noch auf dem *Dachboden* (Status D).
*   Benutzer, deren *Reaktivierungszeitraum* abgelaufen ist, werden zum Löschen vorgesehen (Status R).
*   Benutzer auf dem *Dachboden*, die wieder in den Benutzerlisten aufgeführt sind, werden aus dem *Dachboden* wieder zurückgeholt (reaktiviert) 
    und bekommen den Status E.
*   Benutzer, die zum Löschen markiert sind, werden mit ihren Daten endgültig gelöscht.

