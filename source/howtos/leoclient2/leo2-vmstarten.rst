Virtuelle Maschinen starten
===========================

Das Script ``leovirtstarter2`` findet automatisch jede verfügbare VM und bietet diese zum Starten an.
Das kann über den mitgelieferten Menüeintrag oder über die Konsole stattfinden.

.. code-block:: console

   $ leovirtstarter2

.. figure:: media/leovirtstarter2_dialog1.png
   :align: center
   :alt: Wählen Sie eine virtuelle Maschine

   Wählen Sie eine virtuelle Maschine

Nachdem eine VM gewählt wurde, werden mehrere Optionen angeboten

.. figure:: media/leovirtstarter2_dialog2.png
   :align: center
   :alt: Optionen zum Starten der virtuellen Maschine

   Optionen zum Starten der virtuellen Maschine


*<VM> wie vorgefunden*
   startet den aktuellen unveränderten Zustand der VM

*<VM> Standard*
   verwendet den Standard-Snapshot und startet die VM, d.h. die
   virtuelle Maschine wird auf den Zustand des Snapshots zurückgesetzt.

*optional weitere Snapshots*
   wenn konfiguriert, tauchen weitere lokal oder auf einem Serverlaufwerk gespeicherte Snapshots auf

*Virtuelle Grafik*
   Diese Optionen sind bisher ohne Funktion

*Virtueller Arbeitsspeicher (RAM)*
   Arbeitsspeicherzuweisung an die VM - vorausgewählt ist ein automatisch an den
   vorhandenen Rechner angepasster Wert. Hier kann man der VM den minimalen oder
   maximalen RAM zuweisen.


Nach Auswahl einer VM wird die Umgebung automatisch vorbereitet und gestartet.
