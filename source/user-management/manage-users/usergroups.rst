Benutzergruppen in der linuxmuster.net
--------------------------------------

Wenn man auf Dienste und Dateien des Servers zugreifen möchte, muss
man sich mit einem Benutzernamen (Loginname) und einem Kennwort
(Passwort) am Server anmelden (authentifizieren). Dabei sollen nicht
alle Benutzer am System auf die gleichen Dateien und Drucker zugreifen
oder an Dateien die selben Rechte haben können.

Es ist üblich, Benutzer, die gleiche Rechte haben sollen, zu
Benutzergruppen zusammenzufassen. In der *linuxmuster.net* gibt es,
angepasst auf Schulbedürfnisse, die folgenden Hauptbenutzergruppen:

<Klassengruppe> (z.B. 10a, 5a, usw):
 Schüler-Benutzer mit (halb)privatem Datenbereich. Es dürfen keinerlei
 Systemdateien modifiziert werden.

teachers:
 Lehrer-Benutzer mit privatem Datenbereich. Es dürfen keine
 Systemdateien modifiziert werden.  Zusätzlich hat der Lehrer Zugriff
 auf alle Klassentauschverzeichnisse und lesenden Zugriff auf die
 Schüler-Homeverzeichnisse. Alle Lehrer können über die Schulkonsole
 pädagogisch notwendige Aufgaben auf dem Server ausführen
 (z. B. Dateien austeilen, Internetzugang abschalten)

domadmins:
 Dürfen alle für den reinen Schulbetrieb wichtigen Aufgaben am Server
 durchführen, vor allem der Benutzer ``administrator`` wird dafür
 verwendet.

root:
 Darf ohne Einschränkung alle Aufgaben am Server
 durchführen. (u.a. alle Dateien, auch Passwortdateien,
 einsehen/verändern/löschen)

