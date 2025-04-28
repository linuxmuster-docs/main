.. _exam-and-transfer-label:

=============
Prüfungsmodus
=============

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix (pics) <https://ask.linuxmuster.net/u/MachtDochNix>`_

In einem Kurs / einer Klasse können Schülerkonten (einzeln oder der gesamte Kurs / die Klasse) in den Prüfungsmodus versetzt werden, ebenso kann man mit oder ohne Prüfungsmodus Schülern Dateien
austeilen und von dort wieder einsammeln. Voraussetzung für diese Funktionen ist die :ref:`Aufnahme des Schülers <session-setup-label>`
in einen Kurs.

.. hint::

   Um sicherzustellen, dass alle Prüfungsbenutzerkonten von vorherigen Prüfungen zurückgesetzt wurden, starte vor der Prüfung alle Clients neu und lasse diese mit LINBO synchronisieren.

Öffne in der Schulkonsole unter ``KLASSENZIMMER -> Session-PREVIEW`` den angelegten Kurs oder die gewünschte Klasse.

.. figure:: media/webui-teachers-session-class.png
   :align: center
   :scale: 70%
   :alt: WebUI Start Teacher Session
   
   Starte die Session für die Klasse

Hast Du einen Kurse / eine Klasse ausgewählt, wird Dir die Liste mit Schülern des Kurses / der Klasse angezeigt. 

.. figure:: media/webui-teachers-session-members.png
   :align: center
   :alt: WebUI Session Members
   
   Teilnehmer

Du kannst den Prüfungsmodus entweder für alle zusammen über das Prüfungssymbol im Spaltenkopf aktivieren. Alternativ kannst Du für einzelne Prüflingen den Prüfungsmodus starten, indem Du in der Zeile des Prüflings das Prüfungssymbol klikcst.

Du erhälst in einem neuen Fenster die Rückfrage, ob Du den Prüfungsmodus wirklich starten möchtest. Bestätige dies mit einem Klick auf ``PRÜFUNGSMODUS STARTEN``.

.. figure:: media/webui-teachers-session-start-exam-mode.png
   :align: center
   :scale: 70%
   :alt: WebUI Start Exam Modus
   
   Starte den Prüfungsmodus
   
Wurde der Prüfungsmodus aktiviert, so erkennst Du in der Spalte mit dem Prüfungssymbol pro Teilnehmer ein rotes Rechteck mit dem Prüfungssymbol und dem Namen des Lehrers, der für diese Teilnehmer den Prüfungsmodus aktiviert hat.

.. figure:: media/webui-teachers-session-activated-exam-mode.png
   :align: center
   :alt: WebUI Activated Exam Modus
   
   Aktivierter Prüfungsmodus

Prüfungsmodus = Klassenarbeitsmodus
===================================

Bei Aktivierung des Prüfungsmodus wird für jedes Schülerkonto ein neues Konto angelegt mit dem bisherigen Kontonamen mit angehängter Zeichenkette ``-exam``. Ebenso wird der Schüler in eine zugehörige Klasse "-exam" gesetzt (siehe Abbildung). Das Passwort zur Anmeldung wird dabei übernommen.

.. figure:: media/webui-teachers-session-accounts.png
   :align: center
   :scale: 60%
   :alt: WebUI New Accounts
   
   Angelegte Schüleraccounts im Prüfungsmodus
   
In o.g. Abbildung müsste sich der Benutzer ``Achim Testuser`` nun mit dem Login ``testusac-exam`` und seinem bisherigen Kennwort am Client-PC anmelden. Zum Zeitpunkt des aktivierten Prüfungsmodus wurde die Klasse ``10a-exam`` angelegt.

Die Prüfungsaufsicht übernimmt der Lehrer, der den Prüfungsmodus aktiviert hat. Dies ist in den roten Rechtecken zu erkennen.

Ist es erforderlich, dass für einzelne Benutzer das Kennwort neu zu setzen ist, da es z.B. vergessen wurde, dann kann dieses von der Prüfungsaufsicht neu gesetzt werden.

.. figure:: media/webui-teachers-reset-exam-password.png
   :align: center
   :alt: Reset exam password for users
   
   Setze für Prüflinge ein neues Prüfungskennwort

Klicke in der Zeile des betreffenden Prüflings ganz rechts auf das Zahnrad-Symbol und wähle ``Setze das aktuelle Passwort für <Prüfungs-Account>``.

.. hint::

   Die Lehrkraft könnte das Passwort für den Klassenarbeitsbenutzer auch ändern, um die Anmeldung schon vorab durchzuführen und eventuell spezielle Vorbereitungen für eine Prüfung ohne die Prüflinge vorzunehmen.

Der Prüfungsmodus bleibt so lange erhalten, bis der Lehrer (oder auch ein anderer Lehrer) diesen beendet. Dazu muss dieser entweder pro Prüfling das rote Rechteck zum Beenden der Prüfung für den einzelnen Prüfling (pro Zeile) anklicken. Alternativ kann dieser den Prüfungsmodus für alle Prüflinge gleichzeitig beenden, indem dieser im Spaltenkopf das rote Prüfungsymbol anklickt.

.. figure:: media/webui-teachers-session-deactivate-exam-mode.png
   :align: center
   :alt: WebUI Deactivate Exam Mode
   
   Beende den Prüfungsmodus

Danach erscheint eine Rückfrage zur Bestätigung:

.. figure:: media/webui-teachers-confirm-deactivation-exam-mode.png
   :align: center
   :scale: 70%
   :alt: WebUI Confirm Deactivation Exam Mode
   
   Bestätige das Beenden des Prüfungsmodus
   
Du erhälst ein Fenster mit der Nachfrage, ob Du den Prüfungsmodus wirklich beenden möchstest. Hast Du alle gewünschten Daten der Prüflinge zuvor eingesammelt, bestätige diesen Vorgang mit ``PRÜFUNGSMODUS BEENDEN``.

.. figure:: media/webui-teachers-session-deactivated-examm-mode.png
   :align: center
   :alt: WebUI Deactivated exam Mode
   
   Prüfungsmodus beendet
   
Nachdem der Prüfungsmodus beendet wurde, werden alle Benutzer wie zuvor dargestellt und die Nutzung des Internet sowie der Drucker automatisch aktiviert.

Möchtest Du, dass mit einer anderen Klasse nach erfolgter Prüfung eine weitere Prüfung geschrieben wird, sollten die Clients zuvor alle einmal neu gestartet und mit LINBO automatisch synchronisiert gestartet werden. Dies sollte zudem auch vor jeder Prüfung einmal durchgeführt werden, um sicherzustellen, dass alle Prüfungsbenutzerkonten vollständig zurückgesetzt wurden.

Grundsätzlich ist es hilfreich, wenn die Clients so konfiguriert sind, dass diese mit LINBO immer synchronisiert werden. Dies kann zudem mit einem automatischen Start der Clients verbunden werden.

Ablauf der Prüfung
------------------
0. Die Clients wurden mit LINBO synchronisiert gestartet.
1. Der Lehrer meldet sich an der Schulkonsole an.
2. Der Lehrer wählt unter Session-PREVIEW die gewünschte Klasse aus.
3. Der Lehrer aktiviert mit dem Prüfungssymbol den Prüfungsmodus.
4. Der Lehrer teilt den Prüflingen im Raum mit wie diese sich am PC für die Prüfung anmelden müssen (<bisherigsLogin>+"-exam" & bisheriges Kennwort).
5. Der Lehrer teilt die Prüfungs und ggf. weitere Vorlagen an die Prüfungsteilnehmer aus.
6. Die Dateien liegen für die Prüfungsteilnehmer im Verzeichnis ``transfer/LEHRER/``.
7. Schüler nutzen die bereitgestellten Daten und erstellen ihre Lösungen.
8. Schüler speichern die bearbeiteten Daten unter einem vorher vom Lehrer mitgeteilen Namen bzw. Namensschema ab und legen diese zur Abgabe in das Verzeichnis ``transfer/LEHRER/_collect``.
9. Aktiviert der Lehrer das Symbol ``Recycling`` im Spaltenkopf zur Erneuerung der Anzeige des Arbeitsverzeichnisses der Prüflinge, dann wird die Anzeige so lange wiederkehrend neu aufgebaut, bis der Knopf erneut geklickt wird.
10. Der Lehrer beendet mit Ablauf der Prüfung den Prüfungsmodus. Dabei wird das vollständige Heimatverzeichnis der Prüflinge auf dem Server eingesammelt (, für den Fall, dass Prüflinge den falschen Ort auf dem Server gewählt haben sollten). Der Lehrer findet die eingesammelten Daten einer Prüfungsgruppe im Ordner ``/transfer/collected/EXAM_group_GRUPPENNAME_DATUM_UHRZEIT/``. Dort werden die Verzeichnisse der Benutzer der Gruppe abgelegt. Startet bzw. beendet man den Klassenarbeitsmodus für einzelne Prüflinge, entfällt dieses Verzeichnis beim Einsammeln.

Austeilen und Einsammeln
========================

Lehrer
------

Hast Du als Lehrer, wie zuvor beschrieben, für die gewünschte Klasse den Prüfungsmodus aktiviert, siehst Du folgende Anzeige:

.. figure:: media/webui-teachers-session-exam-mode-started.png
   :align: center
   :alt: WebUI Exam Started
   
   Prüfungsmodus aktiviert
   
Stellen nun den Prüflingen die Prüfung bzw. Vorlagendateien bereit. Klicke hierzu unten links auf den Button ``Mit allen teilen``.

.. figure:: media/webui-teachers-session-share-files-for-all.png
   :align: center
   :scale: 70%
   :alt: WebUI Share Files
   
   Dateien bereitstellen
   
Es öffnet sich ein neues Fenster, in dem Dir der Inhalt Deines Home-Verzeichnisses dargestellt wird. 

.. figure:: media/webui-teachers-session-share-files-home-directory.png
   :align: center
   :scale: 70%
   :alt: WebUI Share Files Home Directory
   
   Dateien bereitstellen: Verzeichnisansicht

Sollten die gewünschten Dateien noch nicht in Deinem Ordner sein, klickst Du oben rechts auf das Wolkensymbol, um Dateien von Deinem USB-Stick oder dem lokalen PC in Dein Home-Verzeichnis hochzuladen.

Die hochgeladenen Dateien werden Dir ebenfalls hier angezeigt.

.. figure:: media/webui-teachers-session-share-files-list.png
   :align: center
   :scale: 70%
   :alt: WebUI Share Files List
   
   Dateien bereitstellen: Auflistung der Dateien im Home-Verzeichnis

Aktiviere nun die gewünschten Dateien und /oder Verzeichniss, die Du den Prüflingen austeilen möchtest.

.. figure:: media/webui-teachers-session-share-activate-files.png
   :align: center
   :scale: 50%
   :alt: WebUI Activate Files
   
   Dateien bereitstellen: Aktiviere die bereitzustellenden Dateien
   
Um die Dateien auszuteilen, klickst Du nun unten rechts auf ``TEILEN``.

Bist Du als Lehrer an einem Client angemeldet, so findest Du die zu teilenden Daten unter Deinem Home-Laufwerk ``H:\`` im Unterverzeichnis ``transfer``.

.. figure:: media/webui-teachers-session-share-files-client-view.png
   :align: center
   :scale: 80%
   :alt: WebUI Share Files Client View
   
   Zu teilende Daten am Client
   
Prüflinge
---------

1. Nachdem der Lehrer den Prüflingen ihre Prüfungs-Accounts mitgeteilt hat, melden diese sich mit den Daten an.
2. Der Prüfling geht im Dateiverzeichnis in sein Home-Laufwerk (H:\\) in den Transfer-Ordner, dort in den Ordner des Lehrers der Prüfung.
3. Sollen bereitgestellte Dateien aus dem Ordner H:\\transfer\\LEHRER\\ bearbeitet werden, empfiehlt es sich diese direkt in den Ordner H:\\transfer\\LEHRER\\_collect\\ zu kopieren und dort zu bearbeiten.
4. Bei Abschluss der Prüfung müssen alle einzusammelnden Dateien im Ordner H:\\transfer\\LEHRER\\_collect\\ liegen.
5. Der Prüfling meldet sich ab.
6. Der Lehrer sammelt alle abgegebene Dateien ein und schließt die Prüfung.

Anmeldung
^^^^^^^^^

Jeder Prüfling meldet sich an dem Client an. Hierzu ist der bisherige Login + die Erweiterung -exam und das bisherige Kennwort anzugeben.
Nachstehende Abbildungen verdeutlichen dies einmal für einen Windows-Client und für einen Ubuntu-Client:

.. figure:: media/webui-exam-login-windows.png
   :align: center
   :scale: 70%
   :alt: Exam Login Windows Client
   
   Prüfungsanmeldung Windows-Client
   
Nach erfolgreicher Anmeldung am Client sieht der Prüfling die Einrichtung der Prüfungsumgebung.

.. figure:: media/webui-exam-login-setup.png
   :align: center
   :scale: 70%
   :alt: Exam Login Windows Client Setup
   
   Prüfungsanmeldung Windows-Client - Setup

An einem 22.04 Ubuntu-Client mit Gnome sieht die Anmeldung wie folgt aus:

.. figure:: media/webui-exam-login-ubtunu.png
   :align: center
   :scale: 80%
   :alt: Exam Login Ubuntu
   
   Prüfungsanmeldung Ubuntu-Client
   
Angabe des Kennworts.

.. figure:: media/webui-exam-login-ubtunu-password.png
   :align: center
   :scale: 80%
   :alt: Exam Login Ubuntu Password
   
   Prüfungsanmeldung Ubuntu-Client - Eingabe des Kennworts
   
Hat sich der Prüfling erfolgreich am Client angemeldet und ruft den Dateimanager auf, so sieht dieser folgende Netzlaufwerke:

.. figure:: media/webui-exam-login-network-shares.png
   :align: center
   :alt: Exam Login Network Shares
   
   Prüfungsanmeldung: Netzwerklaufwerke

Die bereitgestellten Dateien findet der Prüfling nun im Verzeichnis ``H:\transfer\LEHRER\``.

.. figure:: media/webui-exam-login-network-shares-shared-files.png
   :align: center
   :scale: 70%
   :alt: Exam Login Network Shares Shared Files
   
   Prüfung: Bereitgestellte Dateien
   
In der Prüfung bearbeitet der Prüfling die bereitgestellten Dateien und speichert seine Lösung zur Abgabe in dem Verzeichnis ``H:\transfer\LEHRER\_collect\``.

.. figure:: media/webui-exam-finalise-files.png
   :align: center
   :scale: 70%
   :alt: Exam Finalise files
   
   Prüfung: Dateiabgabe
   
Unter Windows stellt sich dies für den Prüfling wie folgt dar:

Netzwerkfreigaben
   
.. figure:: media/webui-exam-shares-windows.png
   :align: center
   :alt: Exam Shares Windows
   
   Prüfung: Netzwerkfreigaben unter Windows
   
Bereitgestellte Dateien   

.. figure:: media/webui-exam-shares-windows-shared-files.png
   :align: center
   :scale: 70%
   :alt: Exam Windows Shared Files
   
   Prüfung: Bereitgestellte Dateien unter Windows
   
Abgabe unter ``H:\transfer\LEHRER\_collect\``

.. figure:: media/webui-exam-shares-windows-finalised-files.png
   :align: center
   :alt: Exam Windows Files finalised
   
   Prüfung: Dateiabgabe unter Windows
   
   
Abgaben einsammeln
^^^^^^^^^^^^^^^^^^

Der Lehrer sieht in der Schulkonsole die abgegebenen Dateien. Um die Liste mit den Abgaben in der Spalte ``Arbeitsverzeichnis`` zu aktualisieren, klickst Du in der Spalte auf das Symbol mit den ``Recycling-Pfeilen``.

.. figure:: media/webui-exam-sent-files.png
   :align: center
   :alt: Exam Windows Files sent
   
   Prüfung: abgegebene Dateien einsehen
   
Um vor Abschluss der Prüfung alle Abgaben einzusammeln, klickst Du unten links auf ``Von allen einsammeln``.
Klicke nun auf ``Move _collect cirectory from all members``. Es werden nun alle Abgaben in das Verzeichnis des Lehrers zum Einsammeln der Dateien verschoben.

.. figure:: media/webui-exam-collect-all-files.png
   :align: center
   :scale: 70%
   :alt: Exam Collect all Files
   
   Prüfung: Alle Dateien einsammeln
   
.. hint:: 

  Um Überraschungen bei der Abgabe vorzubeugen: Zeige den letzten aktuellen Stand in Deinem Arbeitsverzeichnis mit den Abgaben via Beamer Deinen Prüflingen. So können alle überprüfen, ob sie ihre Daten auch wirklich abgegeben haben.
   
Prüfung beenden
^^^^^^^^^^^^^^^

Nachdem alle Dateien eingsammelt wurden, beendet der Lehrer den Prüfungsmodus.

.. figure:: media/webui-exam-stop-exam-mode.png
   :align: center
   :alt: Stop Exam Mode
   
   Prüfung: beenden
   
Hierzu klickst Du auf das rot hinterlegte Prüfungssymbol im Spaltenkopf, um für alle Prüflingen den Prüfungsmodus zu beenden.

Sollten für Prüflinge untzerschiedliche Prüfungszeiten gelten, so beendest Du pro Prüfling deren Prüfung zeilenweise einzeln.

Abgaben einsehen
^^^^^^^^^^^^^^^^

Hast Du als Lehrer die Prüfung beendet, kannst Du nun in der Schulkonsole unter ``Allgemein -> Meine Dateien`` im Ordner ``transfer`` alle bislang eingesammelten Dateien finden.

.. figure:: media/webui-exam-check-collected-files.png
   :align: center
   :scale: 70%
   :alt: Check colletced Files
   
   Prüfung: Prüfe Dateiabgaben
   
Für die durchgeführte Prüfung gehst Du in den Ordner ``schoolclass_10a_20231209-171650`` - also immer der Ordner mit dem aktuellen Prüfungsdatum.

Dort findest Du pro Prüfling einen Ordner, in dem sich die abgegebenen Dateien befinden.

Die Abgaben kannst Du markieren und herunterladen.

.. figure:: media/webui-exam-download-results.png
   :align: center
   :alt: Download Results
   
   Prüfung: Dateiabgaben herunterladen
   
.. hint::

   Starte nach der Prüfung alle Clients neu und lasse diese mit LINBO synchronisieren.
   

