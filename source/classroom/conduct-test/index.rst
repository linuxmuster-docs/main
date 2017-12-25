===========================
 Klassenarbeit durchführen
===========================

Um sich in der Schulkonsole einloggen zu können, ruft man in einem Browser die Seite 
https://10.16.1.1:242 auf. Eventuelle Warnmeldungen wegen eines selbst erstellten Zertifikates 
kann man ignorieren.

.. image:: media/login1.png

Klassenarbeit starten
=====================

Nach dem Login sieht man folgende Ansicht:

.. image:: media/class-start.png

und beginnt mit Klick auf `Unterricht beginnen` den Unterricht.

Unter "aktueller Raum" findet man den Menüpunkt "Klassenarbeit", den man mit Klick auswählt.

.. image:: media/currentroom-test.png 

Bevor der Klassenarbeitsmodus gestartet wird setzt man ein Workstationpasswort, welches man den Teilnehmern an der Klassenarbeit mitteilt (hier: ``frei_wählbar``).

.. image:: media/set-password-start-test.png

und startet mit Klick auf "Klassenarbeit starten" den Klassenarbeitsmodus.

Dateien bereitstellen und Schüler melden sich an
================================================

In der Schulkonsole bekommt man nun folgende Informationen:

- an welchem Rechner, welcher Benutzer angemeldet ist
- welche Dateien unter ``H:\bereitstellen\bereitstellen-klassenarbeit`` zum Bereitstellen an die Schüler hochgeladen wurden (hier: die Datei ``Klassenarbeit.txt``).

Schüler melden sich jetzt an den Clients mit jeweiligen PC-Namen als
Benutzernamen (hier z.B.: ``r306-c01``) und dem Workstationpasswort
an (hier: ``frei_wählbar``).

.. note:: Unter Login dürfen nur Rechnernamen auftauchen, da man sich
          im Klassenarbeitsmodus mit den Rechnernamen
          anmeldet. Solange nicht alle an der Klassenarbeit
          beteiligten Benutzer unter "Login" zu sehen sind klickt man
          immer wieder auf "Aktualisieren".

.. image:: media/provide-files.png

Ist an jedem Platz ein Teilnehmer der Klassenarbeit angemeldet, dann klickt man auf "bereitstellen" und stellt damit den Schülern die Aufgabe "Klassenarbeit.txt" 
bereit. 

Passwort neu setzen
===================

Man hat jetzt die Möglichkeit ein neues Passwort (hier:
``neues_PW_setzen``) zu setzen. Dies verhindert, dass Schüler die
Computerkonten missbrauchen.

.. image:: media/set-password-second-time.png

.. note:: Das neue Passwort darf erst gesetzt werden, wenn sich alle Teilnehmer an den Rechnern angemeldet haben

Während des Unterrichts
=======================

Die Schulkonsole sieht nach dem Passwort setzen so aus:

.. image:: media/during-test.png

Der Lehrer hat dann folgende Möglichkeiten:

- Kopien einsammeln (sparsam nutzen ist sinnvoll)
- Einsammeln der Schülerdateien und Beenden des Klassenarbeitsmodus'
- Es ist aber auch immer wieder möglich auf "Passwort ändern" zu klicken, um zwischendurch ein neues Passwort zu setzen. Das kann notwendig werden, wenn z.B. ein Rechner während der Klassenarbeit abstürzt und sich ein Schüler erneut anmelden muss.

Die Schüler holen sich den Arbeitsauftrag für die Klassenarbeit im Ordner ``V:\Räume\r306\rau`` (Windows) bzw. im Ordner ``Vorlagen_auf_Server/r306/rau`` (Linux) ab.

.. note:: Die Angabe des Raumes (hier: r306) und des Lehrerordners (hier: rau) werden nach Schule und Lehrer variieren

.. image:: media/students-view-winclient.png

Die Schüler müssen alle ihre Ergebnisse im Ordner ``H:\_einsammeln``
(Windows) bzw. unter ``Home_auf_Server/_einsammeln`` (Linux)
speichern.

.. note:: Es ist sinnvoll, den Schülern zu raten, die Vorlagen sofort
	  dort abzulegen und dort zu bearbeiten. Es ist auch sinnvoll die Datei
	  mit dem Schülernamen zu versehen.

.. image:: media/students-saveto-winclient.png

Klassenarbeit beenden und Daten einsammeln
==========================================

Ist die Klassenarbeit beendet, dann klickt der Lehrer auf "Einsammeln und beenden"

.. image:: media/collect-and-finish.png

und wird im folgenden Fenster aufgefordert das Beenden zu bestätigen.

.. image:: media/confirm-finish.png

.. note:: Ehe man den Klassenarbeitsmodus beendet fordert man die
          Schüler auf, ihre Arbeiten im Ordner "Einsammeln" letztmalig
          zu speichern. Durch Klick auf "Aktualisieren" werden in der
          Tabelle unter "Dateien" die gespeicherten Dateien sichtbar.

Der Klassenarbeitsmodus ist damit beendet und der Raum kann wieder als Computerraum benutzt werden.

Die eingesammelten Dateien findet der Lehrer nach dem Beenden des Klassenarbeitsmodus im Ordner ``_eingesammelt`` mit einem Datums-Zeitstempel versehen.

.. image:: media/collected-folderview1.png 
.. image:: media/collected-folderview2.png

