Drucker Informationen
=====================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

Um in linuxmuster.net mit Druckern zu arbeiten, ist es erforderlich, dass Netzwerkdrucker zur Verfügung stehen.
Es können entweder Drucker mit eingebauten Netzwerkkarten (Printservern) eingesetzt, oder bisherige Drucker mit 
einer geeigneten sog. "Printserver-Box" in das Netzwerk eingebunden werden.

Vor dem Hinzufügen und Einrichten von Druckern in linuxmuster.net ist es sehr hilfreich, vorab nachstehende 
Informationen zu erfassen:

- die genaue Bezeichnung des Druckermodells
- mögliche Treiber für Linux, Windows und ggf. andere Clients
- MAC-Adresse des Druckers
- Raum / Standort des Druckers
- IP-Adresse gemäß des genutzen Adressschema

Die meisten Netzwerkdrucker sind bei Auslieferung so eingestellt, dass diese eine IP-Adresse via DHCP beziehen. 
Die IP-Adresse für den Drucker muss daher in der Schulkonsole gesetzt werden.

Um eine Steuerung der Drucker via Schulkonsole zu ermöglichen, müssen die Drucker zentral auf dem Server 
als Geräte eingetragen und auf dem Server in CUPS konfiguriert werden. 

CUPS arbeitet als "zentraler Printserver" und hält für alle dort eingerichteten Drucker
entsprechende Druckwarteschlangen vor.
