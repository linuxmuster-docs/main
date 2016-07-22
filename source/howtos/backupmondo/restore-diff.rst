Restore von differentiellen und inkrementellen Backups
``````````````````````````````````````````````````````

Wenn Sie nach einem Vollbackup noch weitere differentielle und/oder inkrementelle Backups erstellt haben, müssen diese anschließend an den Restore des Vollbackups in chronologischer Reihenfolge zurückgespielt werden. Das muss dann im [[backup.disaster.recovery.interactiv|interaktiven Modus]] erfolgen.
FIXME

Haben Sie differentielle Backups erstellt, wird als nächstes das aktuellste, differentielle Backup restauriert. Sind dann noch inkrementelle Backups jüngeren Datums vorhanden, müssen diese nacheinander auch noch zurückgespielt werden.

Die Vorgehensweise anhand des oben genannten Beispiels

.. image:: media/konfiguration/backup1.png

wäre dann:

 - Automatisches Restore des Vollbackups 070201_010002_full, wie im Abschnitt :doc:`restore-full` beschrieben;
 - Restore des differentiellen Backups 070225_020002_diff;
 - Restore der beiden nachfolgenden inkrementellen Backups 070227_030002_inc und 070228_030002_inc.

Nach erfolgtem Restore des Vollbackups booten Sie das System also nicht neu, sondern starten auf der Mondo-Rescue-Konsole das Programm *mondorestore*:

.. code-block:: bash

	mondorestore

Fahren Sie fort, wie im :doc:`restore-interactive` beschrieben. Wiederholen Sie den Restorevorgang für jedes differentielle und inkrementelle Backup, das Sie restaurieren müssen.
