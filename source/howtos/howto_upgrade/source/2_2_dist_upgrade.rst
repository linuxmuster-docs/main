Dist-Upgarde durchführen
========================

Nachdem die Paketquellen in der gannten Datei für Apt eingetragen wurden, können Sie nun die Paketquellen aktualisieren und die Pakete selbst aktualisieren.

Dazu sind auf der Eingabekonsole als Benutzer root folgende Befehle einzugeben:

.. code:: bash

    # apt-get update && apt-get dist-upgrade

Das Paketsystem fragt bei einigen Paketen nach, ob bei **geänderten Konfigurationsdateien die aktuelle Konfiguration beibehalten** werden sollen, oder ob die neuen angewendet werden sollen.

.. attention:: Aktuelle Konfiguration beibehalten

    Wählen Sie immer us, dass die aktuelle Konfiguration beibehalten werden soll. Dies entspricht auch 
    der Voreinstellung, die Sie mit ENTER bestätigen können.



