Welche Informationen benötige ich vorab?
========================================

Um mit linuxmuster.net mit Druckern zu arbeiten, ist es erforderlich, dass Netzwerkdrucker zur Verfügung stehen.
Es können entweder Drucker mit eingebauen Netzwerkkarten (Printservern) eingesetzt, oder bisherige Drucker mit einer geeigneten  sog. "Printserver-Box" in das Netzwerk eingebunden werden.

Vor dem Hinzufügen und Einrichten von Druckern in linuxmuster.net ist es sehr hilfreich, vorab nachstehende Informationen zu erfassen:

- die genaue Bezeichnung des Druckermodells
- mögliche Treiber für Linux, Windows und ggf. andere Clients
- MAC-Adresse des Druckers
- Raum / Standort des Druckers
- IP-Adresse gemäß des genutzen Adressschema

Die meisten Netzwerkdrucker sind bei Auslieferung so eingestellt, dass diese eine IP-Adresse via DHCP beziehen. Die IP-Adresse für den Drucker kann dann einfach in der Schulkonsole gesetzt werden.

.. caution::

   Im folgenden Skript werden Änderungen an der Schulkonsole
   vorgenommen. Alternativ können Änderungen meist auch über ein
   Terminal direkt in den Konfigurationsdateien auf dem Server
   vorgenommen werden. Das Mischen beider Verfahren ist zu vermeiden
   und Fachkundigen zu überlassen.

