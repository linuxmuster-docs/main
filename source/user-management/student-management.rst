.. _howto-change-student-passwords-label:

==============================
 Schülerverwaltung als Lehrer
==============================

Als Lehrer hat man in der Schulkonsole mehrere pädagogische und
verwaltungstechnische Funktionen zur Verfügung.

Melde dich an der Schulkonsole an, d.h. besuche mit dem Browser die
Webseite ``https://server.linuxmuster.lan`` oder die an deiner Schule
äquivalent vom Administrator eingerichtete Seite und melde dich mit
den Schulkontodaten an.

Klassen, Projekte, Kurse - Einführung
=====================================

In der linuxmuster.net v7 gibt es zwei Kategorien von
Gruppierungen. Klassen und Projekte sind Gruppierungen,

- denen Schüler automatisch angehören (Klassen) oder denen sie
  angehören durch Anlegen eines Lehrers (Projekte)
- die einen Tauschordner besitzen
- über die eine Zuordnung auch außerhalb der lmn7 möglich ist (z.B. Nextcloud, Moodle)

Kurse dagegen sind Gruppierungen,

- die jeder Lehrer selbst anlegt
- die für Unterrichtsfunktionen wie Teilen/Einsammeln/Klassenarbeit verwendet werden
- die zum Zurücksetzen der Passwörter durch Lehrer verwendet werden

Es werden meist beide Kategorien für den täglichen Umgang benötigt. 

.. figure:: media/webui-teacher-overview.png

Solange ein Lehrer nur den automatisch angelegten Tauschordner der
Klasse verwenden will, muss er keine Kurse einrichten. Die
Konfiguration findet sich unter `KLASSENZIMMER/Einschreiben`.

Sobald ein Lehrer die Unterrichtsfunktionen verwenden will, die über
einen Tauschordner hinausgehen, muss er einen Kurs anlegen und die
gewünschten Schüler hinzufügen. Die Konfiguration findet sich unter
`KLASSENZIMMER/Unterricht`.


Passwörter der Schüler ausdrucken
=================================

Für ein klassenweises Ausdrucken der Erstpasswörter gibt es einen
zusätzlichen Menüpunkt in der Schulkonsole. Unter dem Menüpunkt
`KLASSENZIMMER/Passwörter drucken` wähle aus der Liste aller Klassen
die entsprechende aus.

.. figure:: media/print-passwords-class.png

Das resultierende PDF enthält Benutzername und Erstpasswort aller
Schülerinnen und Schüler der Klasse und kann so ausgeteilt werden.

.. figure:: media/print-passwords-example.png

In Klassen einschreiben und Projekte anlegen
============================================

Die folgende Anleitung brauchst du dann, wenn du mit einer gesamten
Schulklasse oder einem Teilnehmer einer Teilgruppe von Schülern
Dateien über einen gemeinsamen Ordner bearbeiten willst oder diese
Gruppierung in einer externen Anwendung gemeinsam ansprechen willst
(z.B. Nextcloudgruppe oder Moodlegruppe). Für alle
Unterrichtsfunktionen benötigst du dagegen einen Kurs, siehe nächsten
Abschnitt.

In Klassen einschreiben
-----------------------

Unter ``KLASSENZIMMER/Einschreiben`` klicke auf die Klasse, der du
angehören willst. Die Veränderung wird gelb hinterlegt
angezeigt. Bestätige alle Änderungen mit ``ÜBERNEHMEN``, das sich am
unteren Ende der Seite befindet.

.. figure:: media/webui-teacher-subscribe.png

Das Austragen aus einer Klasse funktioniert analog mit Entfernen des
Hakens und Übernehmen der Änderung.

Projekte erstellen und beitreten
--------------------------------

Unter ``KLASSENZIMMER/Einschreiben`` klicke in der oberen Leiste auf
``Neues Projekt``.

.. figure:: media/webui-teacher-project-new.png

In dem sich öffnenden Eingabefeld kann der Projektname mit kleinen
Buchstaben (a-z, keine Umlaute oder Sonderzeichen) und Zahlen (0-9)
festgelegt werden. Die Schulkonsole meldet zurück, wenn das Projekt
erfolgreich erstellt wurde und es erscheint in der Liste der Projekte.

.. figure:: media/webui-teacher-project-new-name.png

:fixme: Rest der Erstellung der Projekte

Unterrichtsfunktionen nutzen
============================

Die folgende Anleitung brauchst du für alle Unterrichtsfunktionen
(außer Tauschordner) und dafür musst du nicht in der Klasse
eingeschrieben sein.

Unterrichtskurs einrichten
--------------------------

Unter ``KLASSENZIMMER/Unterricht`` klicke auf ``Neuer Kurs`` und gib
dem Kurs einen Namen. Im Kurs können sowohl Schülerinnen und Schüler
einer Klasse als auch verschiedener Klassen zusammengestellt
werden. Der Kurs ist auch nur für dich sichtbar und verwendbar.

.. figure:: media/create-session-naming.png

Der Kurs taucht nun in der Auflistung mittig auf. Klicke ihn an, er
ist zunächst leer. In der ersten Zeile kannst du nun bei `Schüler
hinzufügen` einzelne Schülernamen eingeben oder bei `Klasse
hinzufügen` Klassennamen eingeben.

Die Schulkonsole beschränkt während der Eingabe die möglichen Benutzer
oder Gruppen des Systems und zeigt sie an. Klicke auf die angebotene
Gruppe (z.B. hier: `10a`) um die entsprechenden Benutzer hinzuzufügen.

.. figure:: media/create-session-addclass.png

Die Schüler werden nun aufgelistet und können bei Bedarf über das
Symbol des Mülleimers einzeln aus der Liste wieder entfernt werden.

Ist die Liste vollständig klicke unten rechts auf `SPEICHERN &
ÜBERNEHMEN`.

.. figure:: media/create-session-save.png

Rechts oben wird das erfolgreiche Speichern mit einem grünen Haken
zurückgemeldet.

.. figure:: media/create-session-success.png

Der Kurs kann später an dieser Stelle auch umbenannt oder gelöscht
werden.


Passwörter zurücksetzen
-----------------------

Vergisst ein Schüler sein Passwort, kann jede Lehrkraft das Passwort
des Schülers über die Schulkonsole auf das Erstpasswort zurücksetzen
und dies dem Schüler mitteilen. Voraussetzung für die Passwortänderung
ist die Aufnahme des Schülers in einen Kurs. 

Öffne in der Schulkonsole unter ``KLASSENZIMMER/Unterricht`` den
angelegten Kurs.

.. figure:: media/webui-teacher-sessions-overview.png

Die Liste mit Schülern des Kurses wird angezeigt. Klickst du auf das
Zahnradsymbol in der Zeile des Schülers im Kurs, erscheinen die
Möglichkeiten

.. figure:: media/change-student-password.png

.. important:: 

   Das **Erstpasswort** ist ein Passwort, dass beim Anlegen des
   Schülers durch den Administrator oder durch eine Lehrperson in der
   Schulkonsole gesetzt wurde. Das Erstpasswort wird auch im Klartext
   gespeichert und ist daher nicht für die dauerhafte Verwendung
   geeignet. Die Schüler müssen es selbst ändern.

   Das **Benutzerpasswort** also das geheime vom Schüler geänderte
   Passwort kann weder von Lehrer noch Administrator eingesehen
   werden.  Diese Passwörter werden grundsätzlich nur verschlüsselt
   gespeichert.

Klicke auf
	  
Erstpasswort anzeigen
  um das aktuelle Erstpasswort anzuzeigen

Erstpasswort wiederherstellen
  um das Passwort des Schülers (wieder) auf das Erstpasswort
  zurückzusetzen

Erstpasswort zufällig festlegen
  um dem Schüler ein zufälliges neues Erstpasswort zu erzeugen und zu
  setzen

Erstpasswort benutzerdefiniert festlegen
  um dem Schüler ein selbstgewähltes neues Erstpasswort zu erzeugen
  und zu setzen. Der folgende Dialog enthält einen Hinweis auf die
  Komplexitätsregeln des Passworts.

Benutzerpasswort festlegen
  um direkt das Passwort des Schülers festzulegen. Das Erstpasswort
  wird dabei nicht geändert. Diese Option bietet sich an, wenn der
  Schüler selbst hier sein geheimes Passwort eingeben kann. Der
  folgende Dialog enthält einen Hinweis auf die Komplexitätsregeln des
  Passworts.

Nach Setzen des Erst- oder Benutzerpasswortes muss *nicht* mit
`SPEICHERN & ÜBERNEHMEN` abgeschlossen werden.

Zugriff auf WLAN, Internet und Drucker regeln
---------------------------------------------

In einem Kurs kann einzelnen Personen oder dem gesamten Kurs die
Berechtigung zu Drucken oder der Zugriff auf WLAN und Internet gegeben
oder genommen werden. Voraussetzung für diese Funktionen ist die
Aufnahme des Schülers in einen Kurs.

Öffne in der Schulkonsole unter ``KLASSENZIMMER/Unterricht`` den
angelegten Kurs.

.. figure:: media/webui-teacher-sessions-overview.png

Die Liste mit Schülern des Kurses wird angezeigt. Es gibt
Auswahlfelder bei den Schülern und oberhalb des ersten Schülers für
alle Schüler für

- den Prüfungsmodus (siehe nächstes Kapitel)
- WLAN-Zugang
- Internetzugang
- Druckerzugriff

.. figure:: media/change-student-access.png

Änderungen werden gelb hinterlegt bis sie mit `SPEICHERN & ÜBERNEHMEN`
übernommen werden.

Prüfungsmodus, austeilen und einsammeln
---------------------------------------

In einem Kurs können Schülerkonten in den Prüfungsmodus versetzt
werden, ebenso kann man mit oder ohne Prüfungsmodus Schülern Dateien
austeilen und von dort wieder einsammeln. Voraussetzung für diese
Funktionen ist die Aufnahme des Schülers in einen Kurs.

Öffne in der Schulkonsole unter ``KLASSENZIMMER/Unterricht`` den
angelegten Kurs.

.. figure:: media/webui-teacher-sessions-overview.png

Die Liste mit Schülern des Kurses wird angezeigt. Der Prüfungsmodus
wird aktiviert durch Anklicken in der ersten Spalte. 

.. figure:: media/webui-teacher-session-examstart.png

Änderungen werden gelb hinterlegt bis sie mit `SPEICHERN & ÜBERNEHMEN`
übernommen werden.

Prüfungsmodus
~~~~~~~~~~~~~

Während des Prüfungsmodus wird für jedes Schülerkonto ein neues Konto
angelegt mit dem bisherigen Kontonamen mit angehängter Zeichenkette
"-exam". Ebenso wird der Schüler in eine zugehörige Klasse "-exam"
gesetzt (siehe Abbildung). Das Passwort zur Anmeldung wird dabei
übernommen.

.. figure:: media/webui-teacher-session-exam-status.png

Die Prüfungsaufsicht zu diesem Konto übernimmt der Lehrer. Der
Prüfungsmodus bleibt so lange erhalten, bis der Lehrer (oder auch ein
anderer Lehrer) den Haken bei dem Schülerkonto entfernt.

Der Schüler meldet sich am Computer mit seinem Examenskonto und seinem
Passwort an. Dann hat er ein leeres Profil und keine Daten im
Home-Laufwerk (``Home_auf_Server`` bzw. ``H:\\``). Der Internetzugang, der
WLAN-Zugang und der Druckerzugriff sind standardmäßig zunächst
deaktiviert.

:fixme: Internetsperrung funktioniert momentan nicht mit der Firewall OpnSense.


Austeilen und Einsammeln
~~~~~~~~~~~~~~~~~~~~~~~~

Im Home-Laufwerk aller Benutzer (``Home_auf_Server`` bzw. `H:\\`) gibt
es einen Ordner für den Transfer ``transfer``. Über diesen Ordner wird
ausgeteilt und eingesammelt. Folgende Anleitung funktioniert mit und
ohne Prüfungssituation.

Es gibt zwei Arten Daten an Schüler im aktuellen Kurs auszuteilen. Zum
einen kann man Ordner und Dateien im Ordner ``transfer`` ablegen. Zum
anderen kann man im folgenden Dialog per Drag and Drop *einzelne*
Dateien hochladen. Klickt man nun bei einzelnen Schülern oder unten
auf der Seite für alle Schüler des Kurses auf ``Teilen``, kann man im
folgenden Dialog neben dem Hochladen auch die zum Teilen gewünschten
Daten auswählen und  das Austeilen anstoßen.

.. figure:: media/webui-teacher-session-upload.png

Die ausgeteilten Daten landen nun als Kopien im
``transfer``-Verzeichnis der entsprechenden Schüler.

Die Schüler speichern ihre Daten ebenso im ``transfer``-Ordner.

Der Lehrer hat nun während dieser Phase die Möglichkeit die Daten
einzusammeln. Dabei gibt es die Variante, die Daten zu kopieren oder
einzusammeln (und damit auf Benutzerseite zu löschen).

.. figure:: media/webui-teacher-session-collect.png

Das Beenden des Prüfungsmodus sammelt automatisch die Daten von den
Schülern ein, verschiebt die Benutzer zurück auf ihre normalen
Benutzernamen und aktiviert die Internet-, WLAN- und Druckzugriffe.
Die Änderung muss ebenso durch ``SPEICHERN & ÜBERNEHMEN`` quittiert
werden.



