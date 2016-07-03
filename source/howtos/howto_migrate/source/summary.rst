Übersicht zu den Migrationsschritten 
====================================

Voraussetzungen
---------------

.. attention::

    Es muss als Quellsystem die sog. paedML in der Version >= 4.0.6 installiert sein. Es kann ebenfalls 
    als Quellsystem eine sog. openML/paedML Version 5.x oder linuxmuster.net Version 6.x installiert 
    sein.

Vorgehen
--------

1. Zunächst installiert man auf dem Quellsystem (mind. Version 4.0.6) das Paket `linuxmuster-migration`
   und erstellt dann ein Backup der zu migrierenden Daten in ein Verzeichnis auf einer lokal 
   angeschlossenen Festplatte oder einem NFS-Share.
    
2. Danach setzt man das Zielsystem (linuxmuster.net 6.x mit IPFire und Server) neu auf. Hardware und 
   Partitionierung können von derjenigen des Quellsystems abweichen.
    
3. Schließlich installiert man auf dem Zielsystem ebenfalls das linuxmuster-migration-Paket, stellt 
   dann das Sicherungsverzeichnis aus Schritt 1 per lokaler Festplatte oder NFS-Share auf dem Server 
   bereit und spielt die Daten aus der Sicherung wieder zurück.

