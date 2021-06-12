Hinweise Mac OS X - Clients
===========================

Für Mac OS X - Clients gibt es für linuxmuster.net keine Pakete zur Einbindung. Daher an dieser Stelle in der Dokumentation nur für diejenigen, die Mac OS X - Clients in einem linuxmuster.net Netzwerk einsetzen und mit diesen Clients drucken möchte, nachstehend nur kurz einige Hinweise zu Druckerproblemen:

Bei der Standardkonfiguration kann es passieren, dass die Kommunikation mit dem Drucker nicht funktioniert und zum Beispiel nach der Installation jeder Druck auf einen Fehler läuft:

.. code::

  Waiting for Authentication...

Wenn ein Drucker unter MacOS mit dem Drucker-Dialog hinzufügt wird, kann nur das IPP-Protokoll ausgewählt (Reiter "IP") werden. 
Bei "Address" ist dann die Server-IP mit dem CUPS-Port ``10.0.0.1:631`` einzutragen. Bei "Queue" ``/printers/printer-name`` ist der Druckername anzugeben (z.B. /printers/lz-drucker).

.. hint::

   Sollte dies nicht funktionieren, ist zunächst die Web-Oberfläche von CUPS local auf dem Mac zu aktivieren (localhost:631) und anschließend dort der Drucker per IPP-Protokol und http://10.0.0.1:631/printers/printer-name hinzuzufügen. Gibt es Treiberprobleme und der Drucker druckte nur Kauderwelsch, kann es helfen, statt den generischen Postscript-Treiber den generischen PCL-Treiber auszuwählen, oder ggf. die Installation der Originaltreiber (in dem Fall von Kyocera) auszuführen. Ein ähnliches Problem mit dem Drucker und MacOS X wird hier veschrieben: https://ask.linuxmuster.net/t/mac-os-x-clients-an-cups/1176

