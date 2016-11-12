Grundkonfiguration der Benutzerverwaltung
-----------------------------------------

Einstellungen in der Datei sophomorix.conf vor dem ersten Anlegen von Benutzern
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Nach Installation des Servers muss die Hauptkonfigurationsdatei *sophomorix.conf*, die man unter
``/etc/sophomorix/user/`` findet, angepasst werden [#f1]_. Dazu muss die Datei vom Benutzer root editiert werden.
Dies können Sie direkt am Server machen, oder Sie gehen von einem Client des Netzwerks aus mittels *putty*
auf den Server.

*Putty* ist ein Freewareprogramm, das Sie sich herunterladen und dann starten können. Nach dem Aufruf
geben Sie den Namen des Servers an und stellen auf *ssh* mit Port 22 um. Dann können Sie sich als root
anmelden und die Datei in einem Editor [#f2]_ aufrufen [#f3]_.

Die einzelnen Angaben sind sehr gut kommentiert und mit Beispielen versehen. Zeilen, die mit einem ``#`` beginnen,
sind Kommentarzeilen.

Die meisten der Festlegungen können auch vom Benutzer administrator in der *Schulkonsole* im Menü unter
*Einstellungen* -> *Benutzerverwaltung* gemacht werden.

In der *sophomorix.conf* können viele Einstellungen gemacht werden, unter anderem folgende Dinge werden dort festgelegt:

*   der Schulname (Vorgabe: Schule), wird z.B. bei Passwortlisten benutzt
*   die Kodierung von Benutzerdateien
*   die zulässigen Geburtsjahreszahlen für Schüler
*   Mindest- und Maximalschüleranzahl pro Klasse
*   Anlegen von Schülern zukünftiger Klassen (Sternchenklassen)
*   Anzahl von Zeichen für Schüler/Lehrer Loginnamen
*   Zufallspasswörter verwenden (getrennt für Lehrer und Schüler)
*   Länge der Zufallspasswörter (getrennt für Lehrer und Schüler)
*   Einloggen per *ssh* (getrennt für Lehrer und Schüler), entspricht „Shell aktivieren“ in der Schulkonsole,
*   Erstpasswort ändern müssen beim ersten Anmelden unter Windows(getrennt für Lehrer und Schüler)
*   Duldungs- und Deaktivierungszeitraum vor dem Löschen von Benutzern
*   Zusammensetzung der E-Mailadressen
*   Warnung bei Plattenplatzmangel für E-Mails
*   Festlegung des Log-Levels
*   Einschalten der Quotas


.. rubric:: Footnotes

.. [#f1] Die Datei muss ggf. hinsichtlich des Alters der Schüler angepasst werden.
.. [#f2] Z.B. mcedit oder vim
.. [#f3] Es gibt noch weitere Möglichkeiten um von außen auf den Server zuzugreifen.
