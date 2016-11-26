=====================================
 Anzeigen des eigenen Plattenplatzes
=====================================


Jeder Benutzer kann sich auf der Startseite der *Schulkonsole* über
seinen verbrauchten Plattenplatz und seine Quota informieren. Um
genauere Angaben zu bekommen, genügt es, mit dem Mauszeiger auf die
entsprechende Leiste zu gehen.

Melden Sie sich in der Schulkonsole an.


.. image:: media/schulkonsole-benutzer-quota.png

In diesem Beispiel ist die Quota nur zu einem geringen Anteil ausgeschöpft. Die Maximalwerte stimmen mit den vorgegebenen nicht genau überein.

Das liegt daran, dass unter Linux zwischen einem sogenannten „soft limit“ und einem „hard limit“ unterschieden wird. Die vom
administrator eingestellten Werte (s. u.) werden als „hard limit“ gesetzt. Das „soft limit“ wird automatisch mit einem um 20% kleineren Wert 
gesetzt. Das „soft limit“ ist das Limit, das *Windows* anzeigt. Überschreitet das Datenvolumen diese Grenze, wird ein Warnhinweis ausgegeben, 
die Dateien werden aber noch bis zum Erreichen des „hard limit“ abgespeichert.

Bei Erreichen des „hard limit“ geht dann für diesen Benutzer wirklich nichts mehr, bis er wieder so viel Platz geschaffen hat, dass er unter 
das „soft-limit” rutscht. Da wir uns auf einem Linux-Server befinden, wird auch die Anzahl der Dateien begrenzt.


