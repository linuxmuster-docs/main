FAQ - Häufige Fragen 
====================

Wie kann ich ich sehen, welche Daten übertragen werden?
-------------------------------------------------------

Mit dem Befehl

.. code::

    linuxmuster-community-feedback -v

werden die Daten angezeigt, die dem linuxmuster.net Server übermittelt werden.

Technisch wird dabei die Datei

.. code::

    /var/cache/linuxmuster/feedback-<systemid>.txt

zum linuxmuster.net Server übertragen.

Stimmt es, dass die Daten regelmäßig übermittelt werden?
--------------------------------------------------------

Ja.

Nach Aktivierung des Feedbacks wird auf dem System in der Datei
``/etc/cron.d/linuxmuster-community-feedback`` ein cronjob eingerichtet, der
die Statistikdaten einmal pro Woche zum linuxmuster.net-Server überträgt.  Der
genaue Zeitpunkt (Uhrzeit, Samstag/Sonntag) wird bei der Paketkonfiguration
zufällig ermittelt und variiert von System zu System.

.. code:: 

   # Diese Datei wird automatisch erstellt.
   # Manuelle Aenderungen werden ueberschrieben!
   48 4 * * 6   root /usr/bin/linuxmuster-community-feedback -u > /dev/null 2>&1

Warum werden die Daten regelmäßig übertragen?
----------------------------------------------

Die regelmäßige Übertragung hat zwei Gründe:

1. Einige der statistischen Daten sind nicht statisch, beispielsweise die Versionsnummern der 
essentiellen linuxmuster-Pakete. Für die Projektentwicklung ist es wichtig, zu wissen, wie 
der Update-Stand der Lösung im Einsatz ist. Aus diesem Grund müssen die Daten regelmäßig 
aktualisiert werden.

2. Um "Karteileichen" von Systemen, die außer Betrieb genommen werden zu
vermeiden, werden Installationen, die einige Zeit keine aktualisierten Daten
mehr übermittelt haben serverseitig automatisch aus der Statistik entfernt.


