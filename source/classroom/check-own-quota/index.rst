==========================================
(v6.2) Anzeigen des eigenen Plattenplatzes
==========================================

Jeder Benutzer kann sich auf der Startseite der *Schulkonsole* über
seinen verbrauchten Speicherplatz und seine Quota (im zustehenden
Anteil) informieren. 

Melden Sie sich in der Schulkonsole an.

.. image:: media/schulkonsole-benutzer-quota.png

In diesem Beispiel ist die Quota nur zur Hälfte ausgeschöpft. Um
genauere Angaben zu bekommen, genügt es, mit dem Mauszeiger auf die
entsprechende Leiste zu gehen. Die Zahlen bedeuten: 180308 kiloByte
von ca. 400 MegaByte sind belegt, das entspricht 45%.  Nur 6 von 40000
möglichen Dateien machen die 180 MB aus und gehören dem Benutzer.

Es gibt ein "soft limit" (hier 400MB), das unter einem
Windows-Arbeitsplatz als maximaler Speicherplatz angezeigt
wird. Überschreitet das Datenvolumen diese Grenze, wird ein
Warnhinweis ausgegeben, die Dateien werden aber noch bis zum Erreichen
des "hard limit" (hier 500MB) abgespeichert.  Bei Erreichen des "hard
limit" geht dann für diesen Benutzer wirklich nichts mehr, bis er
wieder so viel Platz geschaffen hat, dass er unter das "soft-limit"
rutscht. Ebenso wird auch die Anzahl der Dateien begrenzt.

Beachten Sie auch, dass das gesetzte Quota immer für eine ganze
Festplattenpartition auf dem Linux-Server gilt, d.h. in den meisten
Fällen zählen auch Dateien auf den Tauschverzeichnissen zum
verbrauchten Speicherplatz.

Neben der Speicherplatzbeschränkung kann im Schulnetz auch eine
Beschränkung des E-Mail-Speicherplatzes und der gedruckten Seiten
eingerichtet sein.
