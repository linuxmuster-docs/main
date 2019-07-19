================
 Beta-Test lmn7
================

Die aktuelle Dokumentation ist im Fluss, alle nicht aktualisierte Dokumentation betrifft noch die 6.2.

Feedback
========

Im Forum
https://ask.linuxmuster.net/t/betatest-probleme-und-loesungen
wird möglichst aktuell

- der Status vermittelt
- Rückmeldung erwartet und dokumentiert

Appliances
==========

Siehe :ref:`getting-started-downloads-label`


Neuinstallation
===============

Die wichtigsten Schritte sind natürlich die Neuerungen und
Vorraussetzungen durchzulesen.

- :ref:`install-on-kvm-label`
- :ref:`install-on-xen-label`
- :ref:`setup-using-selma-label`

Erster Benutzer- und Computerimport kann auch getestet werden.

Migration
=========

Die Migration eines kompletten Schulnetzes, das über Jahre gewachsen
ist, ist eine sehr große Aufgabe. Zuerst sollte man sich Gedanken
darüber machen, welche Dienste nach der Migration noch laufen müssen
und wo diese gerade sind.

Beispiele wären: Openschulportfolio, Raumbuchung (MRBS), interner
Mailserver. Das sind Dienste die möglicherweise auf dem Server
laufen. Diese werden nach der Migration nicht mehr dort sein und es
ist auch nicht vorgesehen, dass diese Dienste nach der Migration
wieder auf dem Server laufen. Für diese Dienste gibt es jetzt schon
Docker Images um sie noch während des Betriebs der lmn 6.2 auf einen
Dockerhost (in Rot) zu migrieren. Hat man dann auf die lmn 7 migriert,
so kann man einfach das dem Dockercontainer zugrunde liegende Image
gegen das für die lmn7 austauschen.

Ein anderes Beispiel sind moodle und nextcloud.  Diese Dienste laufen
normalerweise auf eigenen Servern und sind nur per LDAP an die lmn
angebunden. Nach der Migration werden die LDAP Angaben in Nextcloud
und moodle einfach angepasst (ein neues openLML-enrol script ist in
Arbeit). Natürlich darf man die Portweiterleitungen in der OPNSense
nicht vergessen.

Es ist also ratsam die Migration durch gezieltes Auslagern von Diensten,
die in der lmn 62 noch auf dem Server laufen, vorzubereiten.
Hat man das getan ist die eigentliche Migration mehr ein Zeitproblem als
ein Komplexitätsproblem.

Die eigentliche Migration (ohne diese Dienste) ist hier dokumentiert:
:ref:`migration-label`
