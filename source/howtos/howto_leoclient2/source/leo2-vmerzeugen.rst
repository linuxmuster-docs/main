Virtuelle Maschine erzeugen
================================

Das ``leoclient2-init``-Script bereitet eine virtuelle Machine (VM) vor, die später mit dem Programm ``leovirtstarter2`` gestartet werden kann. Es muss mit root-Rechten gestartet werden:

``# sudo leoclient2-init``

Die Abfragen sollten selbsterklärend sein, drei Dinge werden abgefragt:

- der MASCHINENNAME für die VM (keine Leerzeichen verwenden)
- der PFAD für den Speicherort der VM (Standardpfad ``/var/virtual/``)
- die Größe der virtuellen Festplatte für die VM in MB

Damit werden folgende Aktionen vom Script ausgeführt:

- das Verzeichnis ``/PFAD/MASCHINENNAME`` angelegt,
- die virtuelle Festplatte ``/PFAD/MASCHINENNAME/MASCHINENNAME.vdi`` erzeugt
- die Konfigurationsdatei für die VM ``/etc/leoclient2/machines/MASCHINENNAME.conf`` mit dem ``/PFAD/MASCHINENNAME`` als Inhalt erzeugt
- anschließend wird die Konfiguration für die VM eingestellt und VirtualBox damit gestartet

Ab jetzt arbeitet man unter VirtualBox.

Man kann unter VirtualBox die Konfiguration der VM noch an die eigenen Bedürfnisse anpassen (Der RAM für die VM wird beim Starten an die Gegebenheiten der vorhandenen Maschine angepasst).

Ein CD-/DVD-Laufwerk kann man ebenso einbinden wie iso-Dateien (→ CD-/DVD-Laufwerk hinzufügen → kein Medium (Laufwerk) → über das CD-Symbol rechts das Laufwerk auswählen bzw. → CD-/DVD-Laufwerk hinzufügen → Medium auswählen (iso-Datei) ).

Sollte man, wie voreingestellt, USB2 verwenden wollen, muss man das zur Version von VirtualBox passende Extension Pack installieren (→ Datei → Globale Einstellungen … → Zusatzpakete → Rechtsklick auf rechtes Feld → Paket hinzufügen → auswählen → installieren → OK). Ältere Extension Packs findet man unter https://virtualbox.org/wiki/Download_Old_Builds .

Eine Netzwerkkarte ist in der Standardkonfiguration nicht aktiviert, dadurch bietet die VM keine Angriffsfläche und man kann auf zeitraubende Updates verzichten.
Trotzdem ist es möglich auf die Netzlaufwerke auf dem Server zuzugreifen und Netzwerkdrucker zu verwenden.

Sind die Einstellungen wunschgemäß, startet man die VM und installiert das Betriebssystem über eine verbundene Installations-CD-/DVD oder eine entsprechende iso-Datei.

Ist die Installation abgeschlossen, fährt man die VM herunter.
Bevor VirtualBox beendet wird, sollte man eventuell verbundene CD-/DVD-Laufwerke trennen.

Nach Beenden von Virtualbox wird die VM für den Start mit dem Programm ``leovirtstarter2`` fertiggestellt.
