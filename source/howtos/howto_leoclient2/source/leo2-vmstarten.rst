Virtuelle Maschinen starten
===========================

Das Script ``leovirtstarter2`` findet automatisch jede verfügbare VM und bietet diese zum Starten an.

Nachdem eine VM gewählt wurde, wird angeboten:

- „Starten wie vorgefunden“ - startet den aktuellen Zustand der VM.
- „Standard“ - verwendet den Snapshot aus ``/PFAD/MASCHINENNAME/snapshot-store/standard/`` und startet die VM.
- weitere lokale Snapshot aus ``/PFAD/MASCHINENNAME/snapshot-store/`` (optional - jeweils in einem eigenen Unterverzeichnis gespeichert)
- weitere Snapshots auf einem Serverlaufwerk (optional - Standardverzeichnis ``/media/leoclient2-vm``)
- RAM: Arbeitsspeicherzuweisung an die VM - wird vorher automatisch an den vorhandenen Rechner angepasst. Hier kann man der VM mehr/weniger RAM zuweisen.
- (Virtuelle Grafik: bisher ohne Funktion)

Nach Auswahl einer VM wird die Umgebung automatisch vorbereitet und gestartet.
