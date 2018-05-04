.. |br| raw:: html

   <br />

.. _preface-preparations-label:

Vorwort und Vorbereitungen
==========================

:fixme: Ins andere Kapitel verschieben!

Checkliste
----------
Nutzen Sie die :download:`Checkliste  <./media/preamble/checklist/checklist.pdf>`, um alle während der Installation gemachten Einstellungen festzuhalten. Es handelt sich um ein PDF-Formular, Sie können es also auch am PC ausfüllen. Halten Sie diese Checkliste bereit, wenn Sie den Telefon-Support in Anspruch nehmen wollen.

Download der Software
---------------------
Laden Sie sich zunächst die benötigte Software herunter, beachten Sie dabei die Versionshinweise sorgfältig.

.. _`net-infrastructure-label`:

Hinweise zur Netzwerkstruktur
-----------------------------

IP-Bereiche
```````````
Die linuxmuster.net-Lösung kann mit unterschiedlichen IP-Bereiche arbeiten. Jede Zeile der folgenden Tabelle stellt eine Möglichkeit dar.

+---------+-------------------+-----------------+------------+--------------+
| Auswahl | Beginn IP-Bereich | Ende IP-Bereich | Server-IP  | IPFire-IP    |
+=========+===================+=================+============+==============+
| 16-31   | 10.16.0.0         | 10.31.255.255   | 10.16.1.1  | 10.16.1.254  |
+---------+-------------------+-----------------+------------+--------------+
| 32-47   | 10.32.0.0         | 10.47.255.255   | 10.32.1.1  | 10.32.1.254  |
+---------+-------------------+-----------------+------------+--------------+
| ...     | ...               | ...             | ...        | ...          |
+---------+-------------------+-----------------+------------+--------------+
| 224-239 | 10.224.0.0        | 10.239.255.255  | 10.224.1.1 | 10.224.1.254 |
+---------+-------------------+-----------------+------------+--------------+

Bei der Installation entscheiden Sie sich für einen der Bereiche. Liegen keine besonderen Anforderungen (z.B. Testbetrieb von linuxmuster.net in einem weiteren produktiv laufenden linuxmuster.net-System) vor, wird empfohlen den Bereich 16-31 zu verwenden.  |br| Dies hat auch den Vorteil, dass alle im vorliegenden Dokument enthaltenen Screenshots bei einer Installation mit diesem Bereich gemacht wurden.

Netzwerknamen der Firewall-Lösung IPFire
````````````````````````````````````````
Linuxmuster.net ordnet den unterschiedlichen Netzwerken Farben zu:

*  Das interne Netzwerk wird GRÜNES Netzwerk genannt.
*  Das externe Netzwerk wird ROTES Netzwerk genannt, es ist über einen Router mit dem Internet verbunden.
*  Optional kann z.B. für WLAN-Accesspoints ein weiteres Netzwerk aufgebaut werden (BLAU), für welches andere Zugangsberechtigungen als denen im grünen Netzwerk gelten.
*  Ebenso optional kann eine sog. demilitarisierte Zone (DMZ) als zusätzliches Netzwerk (ORANGE) aufgebaut werden.

.. figure:: media/preamble/einfaches-netz.png
   :align: center
   :alt: Schematischer Aufbau eines Computernetzes mit linuxmuster.net.

   Schematischer Aufbau eines Computernetzes mit linuxmuster.net.

Hinweise für Profis
```````````````````
Die linuxmuster.net-Lösung unterstützt auch komplexere Netzwerkstrukturen mit

* subnetting
* VLANS
* Bonding

Siehe dazu auch :doc:`Netzsegmentierung mit linuxmuster.net <../network/subnetting-basics/index/>`
