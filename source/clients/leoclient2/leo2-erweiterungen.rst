Weitere Informationen zu leoclient2
===================================

Speicherort der virtuellen Maschinen
------------------------------------

Virtuelle Maschinen auf einer zusätzlichen Partition
````````````````````````````````````````````````````

Standardmäßig werden die Dateien einer lokalen VM unter
``/var/virtual/`` abgelegt. Dieses Verzeichnis liegt im normalen
Dateisystem des Linuxclients.  Es wird empfohlen, diesen Speicherort
auf eine zusätzliche Partition auszulagern und nach ``/var/virtual``
per fstab mounten.

Gründe für diese Empfehlung:

- Eine Partition dynamisch unter ``/media`` dafür zu verwenden ist
  ungeeignet, da sich deren Namen und Zugriffsberechtigung je nach
  User ändern kann.
- Mit der Auslagerung erfolgt die Synchronisation der Installation des
  Linuxclients deutlich schneller.
- Die virtuellen Maschinen können über das Synchronisieren der
  zugehörigen Partition unabhängig von der Linuxinstallation
  zurückgesetzt werden.

Vorgehensweise:

Es existiert eine Partition ``/dev/sda3`` (wie z.B. bei der start.conf
zum default-cloop), die mit ``ext4`` formatiert ist.

- Zunächst das Verzeichnis ``/var/virtual/`` leeren bzw. den Inhalt
  wegsichern.
- Die Datei ``/etc/fstab`` als root editieren und letzte Zeile
  ergänzen:

  .. code:: bash
     
     #  /etc/fstab: static file system information.
     #
     /dev/sda3   /var/virtual    ext4   defaults  0  0

- Danach als ``root`` die Partition mounten und das ganze dann noch
  mit ``df`` überprüfen:

  .. code-block:: console

     # mount -a
     # df -h

- Nun ggf. die weggesicherten Dateien wieder nach ``/var/virtual/``
  zurückspielen und von beiden Partitionen mit Hilfe von LINBO ein
  Image erstellen.


.. attention:: 

   Nach dem Anlegen einer neuen VM müssen beide Partitionen geimaged
   werden da beim Anlegen einer neuen VM diese unter
   ``/etc/leoclient2/machines`` registiert wird.  Nach dem Verändern
   einer VM muss nur die zusätzliche VM-Partition geimaged werden.


Virtuelle Maschinen auf dem Server
``````````````````````````````````

Remote virtuelle Maschine erzeugen
''''''''''''''''''''''''''''''''''

Eine lokale VM wird zur remoten VM, indem

- die in ``/etc/leoclient2/servers.conf`` konfigurierbare Variable
  ``SERVERDIR`` auf ein Verzeichnis gesetzt wird, in das im Verlauf des
  Bootprozesses oder der Anmeldung ein Netzwerk-Share gemountet wird

- das Datenverzeichnis der VM auf den Server kopiert wird, z.B. das
  Verzeichnis ``/var/virtual/winxp`` in das vom Server gemountete
  Netzlaufwerk ``/media/leoclient2-vm`` kopiert wird.
  
  .. code-block:: console

     $ sudo cp -R /var/virtual/winxp /media/leoclient2-vm
  
Prinzipiell kann die VM danach lokal gelöscht werden.

Dann wird die VM vor dem Starten vom Server nach lokal
synchronisiert/kopiert. Da dabei beträchtliche Datenmengen übertragen
werden, sollte man das nur bei kleinen, wenig genutzen VM's machen
(z.B. einem Linux-MySQL-Server o.ä.).

VM Windows XP – Tipps und Tricks
--------------------------------

- Zur Installation in VirtualBox ein CD-Rom-Laufwerk hinzufügen und
  dann darin das Installations-ISO einlegen, die
  NTFS-Schellformatierung genügt.

- Die Gasterweiterungen installieren, mit Hilfe der Menüleiste des
  VBox-Fensters bei "Geräte". Dadurch wird auch die Maus nicht mehr
  gefangen und das Fenster der VM ist beliebig skalierbar.

Verbindung zu ``Home_auf_Server`` einrichten:

  - Windows Explorer → Menü Extras → Netzlaufwerk verbinden
  - einen Laufwerksbuchstabe auswählen (z.B. H:) und Ordner angeben: ``\\vboxsrv\home``
  - ggf. Verknüpfung auf Desktop ziehen und umbenennen

Verbindung zu Tausch-Ordner und USB-Sticks einrichten:

  - Windows Explorer → Menü Extras → Netzlaufwerk verbinden
  - einen Laufwerksbuchstabe und Ordner angeben: ``\\vboxsrv\media``
  - ggf. Verknüpfungen auf Desktop ziehen und umbenennen

PDF-Drucker in der VM einrichten

  - Siehe FreePDF-Webseite: http://freepdfxp.de/download_de.html
  - ghostscript Installieren
  - Free-PDF Installieren (Version 4.08 bei mir ging 4.14 NICHT(Eigener Drucker anlegen bei 32bit Windows 7))
  - FreePDF Config starten → admin Config starten
  - Profile neu : Profil ausdrucken anlegen
  - Button: Für das aktuelle Profil einen eigenen Drucker anlegen
  - Profil ausdrucken bearbeiten: FreePDF Dialog

     - Als festen Dateinamen speichern
     - H:\ausdruck.pdf (anpassen, entsprechend ``/etc/leoclient2/leoclient-vm-printer2.conf``)
     - Speichern

  - Den Drucker FreePDF als Standard Drucker anlegen
  - Äquivalent funktioniert das Programm PDF24


VM Windows 7 – Tipps und Tricks
-------------------------------

Bei der Installation bricht die 64bit Version ab, wenn nur 1 GB RAM da ist.

Verbindung zu ``Home_auf_Server`` einrichten:

- Windows Explorer → Rechte Maustaste auf Netzwerk → Netzlaufwerk
     verbinden
- Laufwerksbuchstabe (Üblicherweise ``H:``) und Pfad nennen: ``\\vboxsrv\home``
- Verknüpfung auf Desktop ziehen und umbenennen

Verbindung zu Tausch-Ordnern und USB-Sticks einrichten:

- Windows Explorer → Rechte Maustaste auf Netzwerk → Netzlaufwerk
     verbinden
- Laufwerksbuchstabe (Üblicherweise ``M:``) und Pfad nennen: ``\\vboxsrv\media``
- Verknüpfung auf Desktop ziehen und umbenennen

VM Windows 10 - Tipps und Tricks
--------------------------------

Bei der Installation kommen komische Fehlermeldungen, wenn nicht mindestens 2 CPU und 2096MB RAM vorhanden sind.

Verbindung zu ``Home_auf_Server`` (im Homeverzeichnis) einrichten:

- Windows Explorer → Rechte Maustaste auf Dieser PC → Netzlaufwerk
     verbinden
- Laufwerksbuchstabe (Üblicherweise ``H:``) und Pfad nennen:
  ``\\vboxsrv\home`` sowie Haken bei "Verbindung bei Anmeldung
  wiederherstellen".
- Verknüpfung auf Desktop ziehen und umbenennen in z.B. ``Home_auf_Server``

Verbindung zu Tausch-Ordnern und USB-Sticks einrichten:

- Windows Explorer → Rechte Maustaste auf Dieser PC → Netzlaufwerk
     verbinden
- Laufwerksbuchstabe (Üblicherweise ``M:``) und Pfad nennen:
  ``\\vboxsrv\media`` sowie Haken bei "Verbindung bei Anmeldung
  wiederherstellen".
- Verknüpfung auf Desktop ziehen und umbenennen in z.B. ``Medien``

PDF-Drucker in der VM einrichten

- PDFXLiteHome9 installieren
- PDFXChange 9.0.354.0 - complete
- Druckerverwaltung
- Benutzerdefinierte Filter → Alle Drucker → Rechtsklick auf PDF-XChangeLite
- Eigenschaften → Allgemein → Einstellungen
- Speichern:  Pfad: H:\
- Name: ausdruck-winxp (.pdf wird ergänzt)
- Dialog zeigen: Aus
- Ausführen: Aus
- Drucker entfernen: alle außer PDFXLite9 (OneNote, Microsoft XPS, …)

  
VM schrumpfen – Tipps und Tricks
--------------------------------

Die virtuellen dynamischen Festplattendateien werden im Laufe des
Betriebes immer größer, nie kleiner, auch wenn man Dateien löscht. Zum
Verkleinern muss man vierschrittig vorgehen:

- Alles überflüssige in der VM löschen
- Unbenutzte Festplattenbereiche in der VM nullen
- Mit dem Tool VBoxManage die .vdi-Festplattendatei kompakter machen
- Die kompakte Festplattendatei als neuen base-Snapshot setzen

Windows XP kompakter machen
```````````````````````````

Vorgehensweise (am Beispiel einer virtuellen Maschine mit Namen „winxp“):

- Die leoclient-VM booten und ``sdelete`` und ``CCleaner`` in der VM
  installieren:

  - download → ``sdelete`` (Microsoft-Tool), kopieren nach ``C:\Windows``
  - download → ``CCleaner`` von heise.de

- Auslagerungsdatei abschalten, reboot der VM und dann die versteckte
  Datei ``C:\pagefile.sys`` löschen
- CCleaner ausführen und alles Wesentliche löschen lassen
- Ggf. Defragmentieren von c: (Auswirkung unklar)
- In der Windows Eingabeaufforderung ausführen: ``sdelete.exe -z c:``
  (dauert etwas)
- Auslagerungsdatei wieder anschalten, Herunterfahren der VM
- Als linuxadmin im Terminal ausführen und den Anweisungen folgen:

  .. code-block:: console
		
     # sudo leoclient2-base-snapshot-renew

  Der aktuelle Snapshot ``Snapshots/{...}.vdi`` wird dadurch zur
  Basisfestplatte ``winxp.vdi`` „gemerged“ und ist diese danach wieder
  sehr kein.

- Als linuxadmin im Terminal ausführen um die Basisfestplatte zu
  schrinken:

  .. code-block:: console
		
     # sudo VBoxManage modifymedium --compact /var/virtual/winxp/winxp.vdi

- Nun Basis nochmals neu erstellen, um die kompaktere Festplatte zu
  zippen und nach ``snapshot-store/`` zu kopieren:

  .. code-block:: console
		
     # sudo leoclient2-base-snapshot-renew

Linux-VM kompakter machen
`````````````````````````

Zuerst alles Überflüssige in der laufenden VM löschen, u.a. auch der
apt-Cache. Die anschließend beste Vorgehensweise ist das Einbinden der
.vdi-Festplatte in ein anderes System, z.B. in ein live-Linux-System,
um das „Nullen“ durchzuführen:

- das Tool „zerofree“ nullt die unbenutzten Festplatteninhalte
- auch Swap-Partition nullen per dd-Befehl
- Schließlich die 3 Punkte wie oben bei WinXP durchführen.

  - leoclient2-base-snapshot-renew
  - vboxmanage modifymedium
  - leoclient2-base-snapshot-renew
    
Das Tool VBoxManage kann nur .vdi-Datein schrinken. Dateien vom Typ
.vmdk müssen zuerst in .vdi-Datein umgewandelt werden und danach
ge-shrinked werden:

.. code-block:: console
		
   # VBoxManage clonehd disk1.vmdk disk1.vdi --format vdi
   # VBoxManage modifyhd --compact disk1.vdi

Virtuelle Maschine direkt starten
---------------------------------

Das zusätzliche Skript :download:`leoclient2-directstart
<media/leoclient2-directstart>` startet direkt ohne Dialog eine VM.

Vorgehensweise:

- Laden Sie das Skript herunter :download:`leoclient2-directstart
  <media/leoclient2-directstart>`
- Legen Sie das Skript unter ``/usr/bin`` ab und machen es ausführbar.

  .. code-block:: console

     $ sudo mv leoclient2-directstart /usr/bin/
     $ sudo chmod 755 /usr/bin/leoclient2-directstart

- Das Skript kann mit folgenden Parameter gestartet werden:

  .. code:: 
     
     # /usr/bin/leoclient2-directstart -m <VM> [-s <Snapshot>] -r <RAM>
     
     m: Name der lokalen VM, zwingend notwendig
     s: Name des lokalen Snapshots, ohne wird "wie vorgefunden" verwendet
     r: RAM in MB, zwingend notwendig

- Starten Sie das Skript 

  .. code-block:: console

     $ leoclient2-directstart -m winxp -r 1024 -s standard

.. hint::

   Einschränkungen des Skriptes:

   - Eine Datei ``network.conf`` wird von dem Script nicht
     ausgewertet.
   - Bei den Berechtigungen wird nur der Snapshot und die primäre
     Gruppe des Users überprüft.
   - Bei Angabe ohne Snapshot, kann "wie vorgefunden" nicht einen
     gespeicherten Zustand starten.
  
Zum bequemen Starten kann man einen Desktop-Starter anlegen, z.B. für
die VM „winxp“ mit 1024 MB RAM und „standard“-Snapshot:

.. code-block:: bash
   :caption: /usr/share/applications/leoclient2-directstart.desktop

   [Desktop Entry]
   Version=1.0
   Type=Application
   Name=VirtualBox Direktstart
   Comment=Starting Snapshots of VirtualBox
   Comment[de]=Starten von VirtualBox Snapshots
   Exec=/usr/bin/leoclient2-directstart -m winxp -r 1024 -s standard
   Icon=leovirtstarter2
   Categories=Graphics;Engineering;
   Categories=Emulator;System;Application;
   Terminal=false

Netzwerkeinstellungen einer VM
------------------------------

Die Netzwerkkonfiguration der VM erfolgt durch eine Datei
``network.conf``, die zusätzlich im Verzeichnis der VM angelegt werden
muss. Fehlt diese Datei oder treten Fehler bei der Konfiguration auf,
werden beim Snapshot-Start des leovirtstarters2 immer alle
Netzwerkkarten deaktiviert.

Möchte man eine Netzwerkkarte aktivieren, so muss im
Maschinenverzeichnis der VM eine Datei
``<MASCHINENPFAD>/network.conf`` angelegt werden, die 5 Einträge in
einer Zeile, durch Strichpunkt getrennt, enthält. Diese Konfiguration
gilt dann für alle lokalen Snapshots dieser VM.

- hostname (Name des Linux-Clients auf dem VirtualBox installiert ist)
- vm-nic (1-4)
- mode (none|null|nat|bridged|intnet|hostonly|generic|natnetwork)
- macaddress
- devicename (eth0,eth1,…) oder (auto-unused-nic|auto-used-nic)

Z.B. ``/var/virtual/winxp/network.conf``
  
.. code:: bash

    # Beispiel einer NAT-Netzwerkkarte
    r100-pclehrer;1;nat;080011223344;auto-used-nic

Folgendes typische Netzwereinstellungen können bisher (Version 0.5.4-1, Juli 2015) umgesetzt werden:

-    nat - NAT auf die NIC des pädagogischen Netzes (VM kann ins Internet)
-    bridged + auto-used-nic - Bridge auf die Karte ins pädagogische Netz
-    bridged + auto-unused-nic - Bridge auf eine zweite Karte (nicht ins pädagogische Netz verbunden -> unused)

Mit Hilfe des ``hostname`` kann man z.B. auf verschiedenen Clients
verschiedene MAC-Adressen in der VM für den Bridged-Modus verwenden.

Es gibt insgesamt 4 Möglichkeiten eine ``network.conf`` -Datei
abzulegen: zweimal lokal und zweimal im ``SERVERDIR``. Für die
Priorität der Möglichkeiten gilt folgende Reihenfolge:

- Ist auf dem Server speziell für einen Snapshot der VM eine eigene
     Datei
     ``<SERVERDIR>/<MACHINENAME>/snapshot-store/<SNAPSHOT>/network.conf``
     vorhanden, so wird diese benutzt.
-    Danach wird die Datei auf dem Server für die VM ``<SERVERDIR>/<MACHINENAME>/network.conf`` ausgewertet (falls vorhanden).
-    Anschließend wird die lokale Datei für den Snapshot der VM ``<lokaler Maschinenpfad>/network.conf`` ausgewertet (falls vorhanden).
- Abschließend wird die lokale Datei für die VM ``<lokaler Maschinenpfad>/snapshot-store/<SNAPSHOT>/network.conf``
     ausgewertet (falls vorhanden).
-    Ist keine Datei ``network.conf`` vorhanden, werden alle Netzwerkkarten für die VM deaktiviert.

Fehlersuche - Fehlerbehebung
----------------------------

Log-Datei ````````` Am Client findet man unter
``/tmp/leovirtstarter2.log`` die aktuelle log-Datei des
``leovirtstarters2`` zur Fehlersuche.

Endlosschleife bei ``leoclient2-base-snapshot-renew``
````````````````````````````````````````````````````` Problem: Das
Script ``leoclient2-base-snapshot-renew`` läuft in eine
Endlosschleife, wenn im Verzeichnis ``<lokaler
Maschinenpfad>/Snapshots/`` eine verweiste Snapshot-Datei übrig
bleibt.

Lösung: Die verweiste Snapshot-Datei manuell löschen, dann
``leoclient2-base-snapshot-renew`` nochmals ausführen.

Snapshot passt nicht zur Basisfestplatte
````````````````````````````````````````

Nach einem ``leoclient2-base-snapshot-renew`` werden bisherige
Snapshots unbrauchbar und sollten auch nicht mehr verwendet
werden. Der Snapshotname wird dabei auch geändert. In der Datei
``<Maschinennamen>.vbox`` wird der aktuell gültige ``Snapshotnamen
{…}.vdi`` aufgeführt.

Problem: Unter ``<Maschinenpfad>/Snapshots`` liegt ein alter Snapshot, der Name passt nicht. VirtualBox startet deshalb nicht.

Lösung: Den Snapshot in ``<Maschinenpfad>/Snapshots`` manuell löschen
und dann einen Snapshot mit dem aktuellen Namen aus
``<Maschinenpfad>/snapshot-store/standard/`` in das Verzeichnis
``<Maschinenpfad>/Snapshots`` kopieren.

``network.conf`` für lokalen Snapshot bereitstellen
```````````````````````````````````````````````````

Problem: Aktuell wertet der ``leovirtstarter2`` eine ``network.conf``
im Verzeichnis des lokalen Snapshots nicht aus. (leoclient2-Version:
0.5.4-1)

Lösung: Wenn man jedoch eine ``network.conf`` im remote-Pfad des
Snapshots ablegt, wird diese ausgewertet. Weitere Dateien müssen im
remote-Pfad nicht vorhanden sein. Der remote-Pfad muss nicht zwingend
remote liegen!  Z.B. mit den voreingestellten Standard-Pfaden des
Snapshots „physik“:

- lokaler Snapshot-Pfad: ``/var/virtual/winxp1/snapshot-store/physik/...``
- ergibt ``network.conf``-Pfad: ``/media/leoclient2-vm/winxp1/snapshot-store/physik/network.conf``

``leovirtstarter2`` zeigt "wie vorgefunden" nicht an
````````````````````````````````````````````````````
Problem: Im Auswahlmenü wird „wie vorgefunden“ nicht angezeigt oder kann nicht gestartet werden.

Ursache 1: Die VM wurde nicht ausgeschaltet sondern befindet sich in
einem gespeicherten Zustand. Im Verzeichnis ``.../Snapshots`` befindet
sich eine ``*.sav``-Datei.

Lösung 1: Den „Standard“-Snapshot starten oder die Maschine direkt mit
VirtualBox starten und dann herunterfahren.

Ursache 2: Im Verzeichnis ``Maschinenpfad>/Snapshots/`` befinden sich
überflüssige Dateien.

Lösung 2: Alle Dateien löschen bis auf den aktuellen Snapshot:
``{...}.vdi``. Der Name/die UUID des aktuellen Snapshots kann man
(falls unklar) aus der ``<Maschinenname>.vbox``-Datei ermitteln.





Hintergrundinformationen
------------------------

Virtuelle Maschine erzeugen
```````````````````````````

Beim Anlegen einer virtuellen Maschine mit ``leoclient2-init`` wird
der Pfad zur Maschine in
``/etc/leoclient2/machines/MASCHINENNAME.conf`` gespeichert.

Nach Beenden von Virtualbox werden folgende Aktionen vom Script ausgeführt:

- Ein Snapshot wird erzeugt (in ``/PFAD/MASCHINENNAME/Snapshot/``) und
  dieser als Standard-Snapshot nach
  ``PFAD/MASCHINENNAME/snapshot-store/standard/`` gesichert.
- Außerdem werden die Konfigurationsdateien (compreg.dat,
  VirtualBox.xml, xpti.dat und MASCHINENNAME.vbox) gesichert nach
  ``/PFAD/MASCHINENNAME/defaults/``.
- Abschließend werden alle Dateirechte für den Einsatz gesetzt
  (z.B. ``/PFAD/MASCHINENNAME/MASCHINENNAME.vdi`` nur lesbar, da diese
  Datei nicht verändert werden darf)

Jede VM ist vollständig in ihrem Maschinenverzeichnis gespeichert.


Serverbasierte VM kopieren, lokaler cache
`````````````````````````````````````````

Die auf dem Server liegenden gezippten Basisimages und Snapshots
werden (falls lokal nicht vorhanden oder verändert) beim Start in den
lokalen cache kopiert und dann lokal an die Stelle entpackt, wo sie
genutzt werden. Der Cache hat eine maximale Größe, die in
``SERVERDIR/caches.conf`` definiert wird. Es empfielt sich dafür ein
lokales Datenlaufwerk zu verwenden. Falls das nicht vorhanden ist, ein
Verzeichnis auf der Partition mit den virtuellen Maschinen.


Virtuelle Maschine starten
``````````````````````````

VirtualBox startet mit der Umgebungsvariablen ``VBOX_USER_HOME`` (``$
export VBOX_USER_HOME=/PFAD/MASCHINENNAME``) und mit der Einstellung
für den Standardort für die VM für Virtualbox (``$ VBoxManage
setproperty machinefolder /PFAD/MASCHINENNAME``).  Mit diesen
Anpassungen und anschließendem Starten von Virtualbox (``$
VirtualBox``) kann eine VM auch von Hand gestartet werden.

Damit ``leovirtstarter2`` eine lokale Maschine findet, muss in
``/etc/leoclient2/machines/MASCHINENNAME.conf`` ihr Pfad eingetragen
sein. (leoclient2-init erzeugt diese Datei automatisch). Der
Standard-Pfad für die lokalen VM ist dabei ``/var/virtual/`` .

Außer den lokal vorhandenen Maschinen wird auch in allen in
``SERVERDIR`` konfigurierten Pfaden nach Maschinen gesucht. (Der Pfad
MUSS NICHT remote liegen, allerdings geht ``leovirtstarter2`` davon
aus und holt diese Maschinen in gezippter Form
(Netzwerk-Bandbreitenschonend) zu den lokalen Maschinen und startet
Sie dort).  Der Standard-Pfad für die remote VM ist dabei
``/media/leoclient2-vm`` .

Auflisten kann man alle sichtbaren VM's mit:

.. code-block:: console

   $ leovirtstarter2 -i
   $ leovirtstarter2 --info

Wird mit dem ``leovirtstarter2`` ein Snapshot einer VM zum Starten
ausgewählt, wird folgendes abgearbeitet:

- Kopieren der Standard-Konfigurationsdateien aus
  ``/PFAD/MASCHINENNAME/defaults/`` nach ``/PFAD/MASCHINENNAME/``
- Anpassen folgender Angaben:

  - Shared Folder verbinden ins Heimatverzeichnis des angemeldeten
    Benutzers
  - Netzwerkeinstellungen (verschiedene Möglichkeiten stehen zur Verfügung)

- Starten der Maschine

Gibt es die Maschine auch Remote, können zusätzlich folgende Dinge erfolgen:

- Snapshots wird gegebenenfalls vom Server in den lokalen Cache
  kopiert.
- Reparatur des Basisimages, falls notwendig
- Update der lokalen VM durch die Remote-VM, falls verschieden.
- Der Snapshot wird aus dem Cache bzw. aus
  ``/PFAD/MASCHINENNAME/snapshot-store/default/`` nach
  ``/PFAD/MASCHINENNAME/Snapshots/{…}.vdi`` entzippt


Berechtigungen zum Starten einer VM bzw. eines Snapshots
````````````````````````````````````````````````````````

An welchen Rechnern (Hosts) welcher User eine VM starten darf wird in ``/PFAD/MASCHINENNAME/image.conf`` konfiguriert.

Es werden USER, GROUP, HOST, ROOM gelistet, die Zugriff erhalten
sollen (Positivliste). Wenn nichts konfiguriert wird, haben alle User
von allen Hosts Zugriff.  Es gibt 2 Arten des Zugriffs:

USER-LEVEL Zugriff:

Zeile mit user=user1,user2 für den Zugriff eines Users Zeile mit
group=group1,group2 für den Zugriff eines in der primären/sekundären
Gruppe group1,group2 befindlichen Users (z.B. teachers)

HOST-LEVEL Zugriff:

Zeile mit host=host1,host2 für den Zugriff eines Hosts Zeile mit
room=raum1,raum2 für den Zugriff eines in der primären Gruppe
raum1,raum2 befindlichen Hosts

Um eine Maschine starten zu können, müssen BEIDE Level erfüllt sein
(logische UND-Verknüpfung): Der User muss auf die VM zugreifen dürfen
UND der Host muss die VM starten dürfen.  Die Dateirechte der VM-
bzw. Snapshot-Verzeichnisse müssen so eingestellt sein (z.B. Zugriff
für alle), das die Konfigurierten USER, GROUP, HOST, ROOM Zugriff auf
die VM/den Snapshot besitzen.

Beispieldatei image.conf

.. code:: bash

  # Berechtigugen eine VM zu starten. 
  group=teachers
  host=
  room=lehrerzimmer

Hinweis: Die Berechtigung für einen einzelnen Snapshot wird nur dann
korrekt ausgewertet, wenn beim HOST-LEVEL beide Optionen host und room
auftauchen. Fehlt z.B. die „room“-Option ist jeder Raum und damit auch
jeder Host zugelassen!

Stand Version 0.5.4-1 Juli 2015: Die Gruppen- und User-Beschränkung
auf VM-Ebene wird z.Z. nicht korrekt ausgelesen → 'group' und 'user'
damit ohne Funktion



Datenstruktur einer VM
``````````````````````

Virtualbox-Dateien

In der obersten Verzeichnisebene im Verzeichnis der VM verwaltet
VirtualBox die aktuell verwendete Maschine:

- Die Basisdatei ist ``MASCHINENNAME.vdi``, sie enthält den Basis-Zustand der Festplatte und ist meist mehrere GB groß
- Konfigurationsdateien
- Logdateien
- usw. ...
- Im Unterverzeichnis ``Snapshots`` verwaltet VirtualBox den aktuell verwendeten Snapshot {*}.vdi.

leoclient2-Dateien

- ``MASCHINENNAME.conf`` beinhaltet den Pfad in dem die VM erstellt
  wurde. Dorthin wird sie im Fall einer remoten Maschine auch wieder
  entpackt (funktioniert nur in diesem Pfad)
- ``network.conf`` ist optional. Konfiguriert die Netzwerkkarten der
  Virtuellen Maschine (falls keine network.conf speziell für den
  Snapshot exisiert)
- ``image.conf`` ist optional.
- Das Unterverzeichnis ``snapshot-store`` enthält in
  Unterverzeichnissen weitere Snapshots. (Bei einer lokalen VM ist
  meist nur das Verzeichnis standard vorhanden):
- ``{*}.vdi`` ist die Snapshot-Datei.
- ``{*}.vdi.zip`` ist die gezippte Snapshot-Datei (nur etwa 1/3 so
  groß wie ``{*}.vdi)`` .
- ``filesize.vdi`` ist eine Textdatei und enthält die Größe von
  ``{*}.vdi`` .
- ``filesize.vdi.zipped`` ist eine Textdatei und enthält die Größe von
  ``{*}.vdi.zip`` .
- ``network.conf`` ist optional. Konfiguriert die Netzwerkkarten für
  diesen Snapshot.
- Das Unterverzeichnis ``defaults`` enthält ein Backup der
  Konfigurationsdateien. Vor dem Start der Maschine kann mit diesen
  Dateien die Maschine zurückgesetzt werden (Kopieren auf eine
  Verzeichnisebene höher).


Übersicht der Scripte/Befehle zum leoclient2
````````````````````````````````````````````

leoclient2-init:
  legt eine neue lokale VM an

leovirtstarter2
  startet das grafische Auswahlfenster und anschließend die VM
  mit Optionen

  .. code:: 

     --info 	listet alle VMs auf der Konsole auf
     --vbox 	startet das grafische Auswahlfenster und VirtualBox ohne die VM zu starten
     -h 	        Hilfe anzeigen
     --local-snapshots 	nur lokale Snapshots listen
     --ignore-virtualbox 	startet den leovirtstarter auch wenn gerade VirtualBox ausgeführt wird
     --serverdir <abs path> 	verwendet anderen Pfad statt SERVERDIR zu den remote VMs

leoclient2-base-snapshot-renew
   Erstellt eine neue Basisfestplatte mit dem aktuellen Snapshot der zur bisherigen Basisfestplatte ge-„merged“ wird. Der „Aktuelle Zustand“ wird somit gesichert/festgeschrieben.

leoclient2-vm-move
  Importiert eine VM (z.B. vom externen Speichermedium) oder verschiebt ein VM

VBoxManage
  mit vielen Optionen Konsolen-Tool zum Bearbeiten von VMs 


Entwicklungsdokumentation des leoclient2
````````````````````````````````````````

siehe http://www.linuxmuster.net/wiki/entwicklung:linuxclient:leoclient2


