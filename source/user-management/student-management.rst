.. _howto-change-student-passwords-label:

============================
Schülerverwaltung als Lehrer
============================

Als Lehrer hat man in der Schulkonsole mehrere pädagogische und
verwaltungstechnische Funktionen zur Verfügung.

Melde dich an der Schulkonsole an, d.h. besuche mit dem Browser die
Webseite ``https://server.linuxmuster.lan`` oder die an deiner Schule
äquivalent vom Administrator eingerichtete Seite und melde dich mit
den Schulkontodaten an.

Passwörter der Schüler ausdrucken
=================================

Unter dem Menüpunkt `KLASSENZIMMER/Passwörter drucken` wähle aus der
Liste aller Klassen die entsprechende aus.

.. figure:: media/print-passwords-class.png

Das resultierende PDF enthält Benutzername und Erstpasswort aller
Schülerinnen und Schüler der Klasse und kann so ausgeteilt werden.

.. figure:: media/print-passwords-example.png

Unterrichtskurs einrichten
==========================

Für die folgende Anleitung musst du nicht in der Klasse eingeschrieben
sein.  Unter ``KLASSENZIMMER/Unterricht`` klicke auf ``Neuer Kurs``
und gib dem Kurs einen Namen. Im Kurs können sowohl Schülerinnen und
Schüler einer Klasse als auch verschiedener Klassen zusammengestellt
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

Passwörter zurücksetzen
-----------------------

Vergisst ein Schüler sein Passwort, kann jede Lehrkraft das Passwort
des Schülers über die Schulkonsole auf das Erstpasswort zurücksetzen
und dies dem Schüler mitteilen. Voraussetzung für die Passwortänderung
ist die Aufnahme des Schülers in einen Kurs. Klickst du auf das
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


Nach Setzen des Erst- oder Benutzerpasswortes muss nicht mit
`SPEICHERN & ÜBERNEHMEN` abgeschlossen werden.

Zugriff auf WLAN, Internet und Drucker regeln
---------------------------------------------

In einem Kurs kann einzelnen Personen oder dem gesamten Kurs die
Berechtigung zu Drucken oder der Zugriff auf WLAN und Internet gegeben
oder genommen werden. Sobald der Kurs eingerichtet und abgespeichert
kannst du über die Auswahlfelder des jeweiligen Schülers oder über das
Auswahlfeld oberhalb des ersten Schülers alle Schüler gemeinsam über
diese Zugriffsrechte bestimmen.

.. figure:: media/change-student-access.png


Änderungen werden gelb hinterlegt bis sie mit `SPEICHERN & ÜBERNEHMEN`
übernommen wurden.


Austeilen und Einsammeln
========================

:fixme:
