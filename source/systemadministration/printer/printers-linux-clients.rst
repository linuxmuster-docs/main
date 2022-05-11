Drucker am Linux-Client
=======================

In dieser Dokumentation wird davon ausgegangen, dass der Linux-Client mithilfe des aktuellen Pakets linuxmuster-linuxclient7 der Domäne hinzugefügt wurde.

Vorgehen
--------

1. Drucker - wie zuvor dokumentiert - auf dem Server einrichten.
2. Linux-Client erstellen wie unter ref:`install-linux-clients-label` beschrieben
3. ggf. das CUPs Browsing auf dem Server anpassen, sofern nicht jeder Rechner alle Drucker anzeigen soll. (siehe: ref:`install-linux-clients-label`)
4. Auf dem Server cupsd neu starten.
5. Linux-Client neu synchronisieren.
6. Nach der Anmeldung prüfen, ob Drucker angezeigt werden und dann Drucker testen.

Drucker testen
--------------

Nachdem der Linux-Client neu gestartet und synchronisiert wurde, meldest Du Dich an und prüfst, ob unter ``Drucker`` alle zuvor auf dem Server eingerichteten Drucker angezeigt werden. Dies muss der Fall sein, sofern aus dem jeweiligen Raum oder von dem jeweiligen PC ein Zugriff auf dem Drucker überhaupt gewünscht ist und zuvor eingerichtet wurde.

Markiere einen Drucker, klicke mit der rechten Maustaste und wähle im Kontextmenü den Punkt ``Eigenschaften`` aus. Klicke unterhalb von ``Tests und Wartungen`` den Button ``Testseite drucken`` aus.

Führe das Verfahren aus allen Räumen und von allen PCs durch.

