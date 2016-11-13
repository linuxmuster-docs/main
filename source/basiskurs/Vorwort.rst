Vorwort
=======

Zielgruppe dieses Basiskurses
-----------------------------

Das vorliegende Basiskursskript ist gedacht für Netzwerkberaterinnen
und Netzwerkberater [#f1]_, die an einer einwöchigen Schulung an der
Landesakademie für Fortbildung und Personalentwicklung an Schulen
(Standort Esslingen) teilnehmen. Diese sollen mit dem im Kurs
vermittelten Wissen in der Lage sein, ein installiertes Schulnetz auf
Basis der *linuxmuster.net* zu pflegen. Es handelt sich schon aus
diesem Grunde weder um ein Linux-Buch, noch um eine
Installationsanleitung.

Voraussetzung für die Umsetzung der im Kurs behandelten Themen ist
eine vorhandene Installation der *linuxmuster.net* in der Version 6.2
im Schulnetz.

Um Doppelungen zu vermeiden, wird im vorliegenden Skript zum Basiskurs
öfters auf die Benutzerdokumentation verwiesen.
Das Installationshandbuch als Ganzes muss aber als ergänzende
Literatur angesehen werden, um sich vertiefendes Wissen anzueignen.

Dieses Dokument wurde ursprünglich mit OpenOffice 2 / 3 und
LibreOffice 4.x geschrieben und wird inzwischen mit in github
versioniert abgelegt, mit der Auszeichnungssprache "rST" formatiert
und mit Hilfe von python und sphinx in HTML, PDF und epub Formate
übersetzt.

Vielen Dank an die unermüdlich arbeitende Open Source-Gemeinde für
ihre professionelle Software und Dokumentation!


.. [#f1] In der vorliegenden Dokumentation wurde aus Gründen der
	 Vereinfachung und besseren Lesbarkeit fast ausschließlich die
	 männliche Form der Schreibweise verwendet. Es ist jedoch
	 stets ausdrücklich auch die weibliche Schreibweise gemeint,
	 ohne dass dies immer erwähnt wird.

Anforderungen an ein Computernetzwerk
-------------------------------------

Die Anforderungen an ein Computernetzwerk in einer Schulumgebung, also
an ein sogenanntes pädagogisches Netzwerk, sind komplexer bzw. einfach
andere als beispielsweise die in einer reinen Büroumgebung. Die
geforderten Grundfunktionen sind in allen Schulen und Schularten
dieselben, so dass es sich anbietet eine vorkonfigurierte
Serverumgebung zur Verfügung zu stellen, damit nicht jede Schule das
Rad von ihrem Dienstleister neu erfinden lassen muss.

Funktionalität der *linuxmuster.net*
------------------------------------

*linuxmuster.net* bietet

* Eine Serverumgebung, die dem Netzwerkberater der Schule möglichst
  einfache Umgebungen für seine Aufgaben, wie Benutzerverwaltung und
  Installation der Anwendungssoftware, zur Verfügung stellt
  (Schulkonsole, HowTo Anleitungen). Außerdem für den Dienstleister
  vorgefertigte Installationspakete mit guter Dokumentation, so dass
  der Installations- und Wartungsaufwand so gering wie möglich ist.
* Restauration der Betriebssysteme (Linux, Windows) eines
  Clientrechners auf Knopfdruck in kurzer Zeit z.B. beim Start des
  Rechners am Beginn der Unterrichtsstunde (selbstheilende
  Arbeitsstationen (SheilA) mit Linbo)
* Filterung problematischer Internet-Inhalte (Sex, Gewalt, Drogen,
  Raubkopien) über die Firewall IPFire bzw. Einbindung eines
  externen Filters
* Sicherheit im LAN: Paketfilter Firewall ( *IPFire* )
* Massenhafte Erzeugung privater Schüler- und Lehrer-Benutzernamen aus
  Namenslisten mit automatische Zuordnung zu Klassen, automatischem
  Versetzen beim Schuljahreswechsel, Erzeugung einer persönlichen
  E-mail Adresse, automatischem Löschen von abgegangenen Schülern
* Tauschmöglichkeiten innerhalb der Klassen, unter den Lehrern und für
  alle Benutzer des Unterrichtsnetzwerks
* Begrenzung des Plattenplatz für Benutzer (Quotas)
* Sichere Umgebung für Klassenarbeiten und Abschlussprüfungen am
  Rechner
* Komplettes Intranet (E-Mail, www, Datenbankanbindung)
* Möglichkeit der Einbindung eines Elearningsystems wie *moodle*
* Remote Administration über das Internet möglich
* Administration des Systems für den Administrator und Nutzung der
  *unterrichtlichen Möglichkeiten für Schüler, Lehrer über die
  *Schulkonsole* im Browser.
* Webaccess auf Mails vom LAN und von zu Hause für Schüler und Lehrer
* Verschlüsselter Zugriff auf eigene Daten für Lehrer und Schüler von
  zu Hause aus
* Drucker- und Internetzugang raumweise und in Computerräumen auch
  rechnerweise an- u. abschaltbar
* Vollautomatische Installation!
* Halbautomatische Aufnahme der Arbeitsstationen in den DHCP- und DNS-Server
* Auf den Arbeitsstationen kann wahlweise *Linux* oder *Windows* als
  Betriebssystem eingesetzt werden.

Weitere Informationen finden Sie unter:

`www.lehrerfortbildung-bw.de/netz/muster/linux <http://www.lehrerfortbildung-bw.de/netz/muster/linux>`_


