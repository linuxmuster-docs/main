.. include:: /guided-inst.subst
.. _webui-basics-label:

========================
Schulkonsole des Lehrers
========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix (pics) <https://ask.linuxmuster.net/u/MachtDochNix>`_

Hast Du auf dem Server einen Lehrer-Account, so kannst Du die Steuerung des Unterrichts webbasiert mithilfe der Schulkonsole (WebUI) in einem Browser vornehmen.

.. figure:: media/01_webui-basics_welcome.png
   :align: center
   :alt: WebUI Welcome
       
   Schulkonsole als Lehrer nach der Anmeldung

Die Schulkonsole wird im Browser über ``https://10.0.0.1`` aufgerufen.

Links erscheinen im Menü folgende Auswahlpunkte:

.. figure:: media/02_webui-basics_general-menue-items.png
   :align: center
   :alt: WebUI: Menue items

   Menüeinträge

Mit einem Klick oben rechts auf den blauen Kreis erscheint oben rechts ein
Kontextmenü für den angemeldeten Benutzer, um z.B. das Passwort zu ändern oder die Einstellungen zur 2-Faktor-Authentifizierung (2FA) anzupassen.

.. figure:: media/02_webui-basics_user-overview.png
   :align: center
   :alt: WebUI context menue for active user
   
   Profil nach erfolgter Anmeldung

Allgemein haben die im Menü verwendeten Icons folgende Bedeutung:

Das Menü kannst Du durch Anklicken der drei Striche links neben dem linuxmuster.net-Symbol ein- und ausblenden.

.. figure:: media/03_webui-basics_extend-menue.png
   :align: center
   :alt: WebUI Extend Menue
   
   oben links: Menü ein- und ausklappen
   
.. figure:: media/04_webui-basics_user-icon.png
   :align: center
   :alt: WebUI User Icon
   
   angemeldeter Benutzer

.. figure:: media/06_webui-basics_change-password.png
   :align: center
   :alt: WebUI Change Password

   Kennwort ändern

.. figure:: media/06_webui-basics_change-to-2fa.png
   :align: center
   :alt: WebUI Change Password Authentication to 2FA

   Aktiviere die Zwei-Faktor-Authentifizierung

.. figure:: media/07_webui-basics_logout.png
   :align: center
   :alt: WebUI Logout
   
   Abmelden

.. figure:: media/08_webui-basics_scale-page-ratio.png
   :align: center
   :alt: WebUI Scale Page Ratio

   Seitenverhältnis skalieren
   
.. hint:: 
  
   Bei Vergabe von Kurs- oder Projektnamen solltest Du auf Umlaute und ß verzichten.


Das Menü der Schulkonsole des Lehrers teilt sich in die Bereiche ``Allgemein`` und ``Klassenzimmer`` auf. Nachstehend einige Hinweise zu den Menüpunkten.


Allgemein
=========

Hauptseite
----------

Hier findest Du in der Übersicht Informationen zu Deinem Konto, Deinen zugeordneten Benutzergruppen sowie dem Verbrauch Deines Festplattenkontingents (Quota).


Meine Dateien
-------------

.. figure:: media/02_webui-basics_my-files.png
   :align: center
   :alt: WebUI My Files
   
   Meine Dateien als angemeldeter Lehrer

Hier findest Du die Ordner und Dateien, die z.B. im Unterverzeichnis **Unterricht** abgelegt hast und im Unterricht an die Schüler der Klassen verteilen kannst. Das Verzeichnis ``transfer`` wird u.a. für den Klassenarbeitsmodus benötigt, um Dateien für Klassenarbeiten auszuteilen und die Ergebnisse auch wieder einzusammeln.

Klassenzimmer
=============

Kurs
----

In dem Menüpunkt Kurs werden der aktuelle Raum, Deine zugeordneten Klassen, Deine Gruppen und Projekte aufgelistet.

.. figure:: media/10_webui-basics_my-classes.png
   :align: center
   :alt: WebUI My Courses

   Raum, Klassen, Gruppen, Projekte nach Erstanmeldung

Zu Beginn bist Du noch in keinen Klassen, Gruppen oder Projekten eingeschrieben. Schreibe Dich als Lehrer zuerst in den gewünschten ``Klassen`` ein.  Hierzu klickst Du links im Menü auf ``Einschreiben`` -> ``Schulklassen``. Bei den angezeigten Schulklassen setzt Du für diejenigen Klassen einen Haken, in denen Du Dich einschreiben möchtest.

.. figure:: media/11_webui-class-enrollement.png
   :align: center
   :alt: class enrollement
   
   Einschreibung in Klassen/Kurse/Projekte

Oben erscheint ein blau hinterlegter Hinweis. Um die Einschreibung abzuschließen, musst Du auf ``Jetzt ausführen`` in dem blauen Hinweisfeld klicken. Hierbei wirst Du nach Deinem Benutzerkennwort gefragt, um den Vorgang zu bestätigen.

Verlief die Einschreibung erfolgreich, siehst Du nun im Menüpunkt ``Kurs`` Deine Dir zugewiesenen Klassen unter ``Meine Klassen``.

.. figure:: media/12_webui-classes-enrolled.png
   :align: center
   :alt: classes enrolled
   
   Zugeordnete Klassen

Klickst Du nun auf eine Klasse, so wird diese mit den eingetragenen Benutzern zusammengestellt. Es werden alle Benutzer der Klasse dargestellt.

.. figure:: media/13_webui-class-selected.png
   :align: center
   :alt: class selected

   Ausgewählte Klassen und deren Benutzer

Gruppen erstellen
^^^^^^^^^^^^^^^^^

Du kannst über die Funktion ``Kurs -> Neue Gruppen`` einen neuen Kurs anlegen.

Gib in dem sich öffnenden Fenster den neuen Kursnamen ein und bestätige diesen mit ``OK``.

.. figure:: media/11_webui-basics_new-course.png
   :align: center
   :alt: WebUI New Class
   
   Neuen Kurs erstellen

Der neu angelegte Kurs erscheint im Menü ``Kurs`` -> unter der Rubrik ``Meine Gruppen``.

.. figure:: media/11_webui-basics_my-courses.png
   :align: center
   :alt: WebUI my courses
   
   Meine Gruppen

In obiger Abbildung siehst Du, dass in der neu angelegten Gruppe noch keine Schüler zugewiesen wurden.


Schüler einer Gruppe hinzufügen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Um Schüler einer Gruppe hinzuzufügen, wählst Du die gewünschte Gruppe via Klick auf das Icon des Kurses aus.

.. figure:: media/12_webui-basics_selected_course.png
   :align: center
   :alt: seclected course
   
   Ausgewählter Kurs

In den oberen Zeilen gibt es nun die Möglichkeit über ``Schüler hinzufügen`` einzelne Schüler hinzuzufügen oder über ``Klasse hinzufügen`` eine ganze Schulklasse dem Kurs hinzuzufügen. Klickst Du in das Feld ``Schüler hinzufügen`` und gibst dort die **ersten beiden Buchstaben des Schülernamens** ein, erscheint eine Liste mit Schülern, deren Nachnamen mit diesen Buchstaben beginnen.

.. figure:: media/12_webui-basics_add-class-members.png
   :align: center
   :alt: add pupils to course
   
   Ausgewählter Kurs: Schüler hinzufügen

Wähle einen einzelnen Schüler aus, der zur Gruppe hinzugefügt werden soll. Wiederhole diesen Vorgang für alle weiteren Schüler.

Hast Du alle gewünschten Schüler nacheinander ausgewählt, siehst Du eine Liste mit allen Schülern der Gruppe.

.. figure:: media/13_webui-basics_class-overview.png
   :align: center
   :alt: WebUI Class Overview
   
   Übersicht der Gruppenteilnehmer

Die Gruppe ist nun erstellt.

.. hint::

   Bei einzelnen Schülern siehst Du noch einen roten Button in der Spalte Arbeitsverzeichnis. Dies liegt daran, dass für diese Schüler in Deinem Transferordner noch keine Verzeichnisse angelegt wurden.

   Sollte dies so sein, klicke danach im Menü links auf ``Kurs`` -> ``Meine Gruppen`` -> ``Neu erstellte Gruppe``. Danach erscheinen alle Schüler, die der Gruppe hinzugefügt wurden. Schließe die Einrichtung des Kurses mithilfe des Klicks auf den roten Button ab, der alle Schüler auflistet, für die noch kein Verzeichnis im Transferordner angelegt wurde. Zur Bestätigung musst Du Dein Anmeldekennwort angeben.

Klickst Du nun auf Kurs, siehst Du folgende Ansicht:

.. figure:: media/13_webui-basics_class-selected.png
   :align: center
   :alt: WebUI: Course selected

   Übersicht der Kursteilnehmer

In dieser Übersicht können die pädagogischen Funktionen WLAN-, Internet- & Drucker-Freigabe, Dateiübertragung und Prüfungsmodus genutzt werden.

WLAN-, Internet- & Drucker-Freigabe
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* WLAN-Freigabe

.. figure:: media/14_webui-basics_wlan-icon.png
   :align: center
   :alt: WebUI WLAN Icon

   WLAN Icon

* Internet-Freigabe

.. figure:: media/15_webui-basics_internet-icon.png
   :align: center
   :alt: WebUI Internet Icon

   Internet Icon

* Drucker-Freigabe

.. figure:: media/16_webui-basics_printer-icon.png
   :align: center
   :alt: WebUI Printer Icon
   
   Drucker Icon
   
* Prüfungsmodus

.. figure:: media/17_webui-basics_exam_mode-icon.png
   :align: center
   :alt: WebUI exam mode Icon
   
   Prüfungs Icon

Freigaben zu den jeweiligen Diensten können über ``Haken setzen oder entfernen`` für die jeweiligen Benutzer freigegeben oder gesperrt werden.

Soll ein Dinest für alle freigegeben oder gesperrt werden, dann klickst Du auf das jeweilige Dienste-Symbol im zugeordneten Spaltenkopf.

Beispielsweise wurde hier mit einem Klick auf das WLAN-Symbol für jeden Benutzer des aktuellen Kurses der WLAN-Zugang freigegeben.

.. figure:: media/17_webui-basics_example-wlan-access-for-all.png
   :align: center
   :alt: WebUI Allow WLAN Access
   
   WLAN Zugang für alle Kursteilnehmer freigeben

* Einstellungen (Zahnrad)

.. figure:: media/45_webui-basics_gearwheel-button.png
   :align: center
   :alt: Settings Button
   
   Einstellungen

Unter Einstellungen sind verschiedene Optionen zum Passwort des Benutzers zu finden.

* Löschen (Mülleimer)

.. figure:: media/46_webui-basics_trash-button.png
   :align: center
   :alt: Trash Button
   
   Mülleimer

Mit Hilfe des Mülleimers können einzelne Schüler aus dem Kurs entfernt werden. Dies gilt, bis die Sitzung neu erstellt wird.


Dateien austeilen & einsammeln
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Dateien können für die Unterrichtsarbeit mithilfe der Funktion ``Mit allen teilen & von allen einsammeln`` an Schüler ausgeteilt und wieder eingesammelt werden.

Pro Schüler findest Du in der Spalte ``Übertragung`` die Buttons ``Teilen`` & ``Einsammeln``, um mit einzelnen Schülern Dateien zu teilen oder diese wieder einzusammeln.

Soll dies für alle Schüler des Kurses erfolgen, finden sich unten auf der Seite folgende Buttons:

.. figure:: media/46_webui-basics_share_files.png
   :align: center
   :alt: Share files
   
   Teilen und Einsammlen für alle Schüler des Kurses
   
Weitere Erläuterungen hierzu findest Du im Abschnitt :ref:`exam-and-transfer-label`.

Prüfungsmodus
^^^^^^^^^^^^^

Das Absolventenkappen-Symbol

.. figure:: media/17_webui-basics_exam_mode-icon.png
   :align: center
   :alt: WebUI Graduate Icon

   Prüfungsmodus

stellt den Prüfungsmodus dar. Ausgewählte Schüler oder alle Schüler einer Klasse eines Kurses können dadurch in diesen Modus gesetzt werden. Um alle Schüler des Kurses in den Prüfungsmodus zu versetzen, klickst Du auf das Icon für den Prüfungsmodus im Spaltenkopf. Sollen nur einzelne Schüler in den Prüfungsmodus versetzt werden, wählst Du dies Symbol bei dem jeweiligen Schüler aus.

Im aktivierten Prüfungsmodus wird die Seite wie folgt angezeigt:

.. figure:: media/22_webui-basics_active-exam-modus.png
   :align: center
   :alt: WebUIActive Exam Modus
   
   Aktiver Prüfungsmodus

Bei allen Schülern, die im Prüfungsmodus sind, wird unter Prüfungsaufsicht der Name des Lehrers, der den Modus aktiviert hat, mit rotem Hintergrund dargestellt. Für Schüler im Prüfungsmodus ist automatisch die WLAN-, Internet- & Drucker-Freigabe gesperrt. Dies kann jedoch individuell angepasst werden.

Um den Prüfungsmodus zu beenden, klickst Du oben in der Spalte das Icon für den Prüfungsmodus, um diesen für alle Schüler zu beenden.

Ausführliche Hinweise zum Prüfungsmodus findest Du im Abschnitt :ref:`exam-and-transfer-label`.

Einschreiben
------------

Im Menü ``Einschreiben`` findest Du nachstehende drei Rubriken.

Schulklassen
^^^^^^^^^^^^
   
Hier werden alle Schulklassen der Schule aufgelistet. Durch Klick auf den Klassennamen werden Dir weitere Informationen angezeigt, wie etwa alle Schüler der Klasse. Um Dir eine Schulklasse zuzuordnen aktivierst Du den Haken vor der Klasse und bestätigst dann die Ausführung oben auf der Seite mit ``Jetzt ausführen``.

Drucker
^^^^^^^

Hier werden alle Drucker aufgelistet. Durch Anklicken werden weitere Informationen angezeigt. Drucker müssen zuvor vom Administrator angelegt und eingerichtet worden sein, damit diese hier erscheinen.

Ein Auswählen ist nur erforderlich, wenn man den Drucker auch außerhalb des zugehörigen Raumes nutzen möchte.

Projekte
^^^^^^^^

.. attention::

   Unterschiede zwischen Gruppe und Projekt:

   - Gruppe: Eine Gruppe hat kein Netzlaufwerk (keine Shares), um Dateien gemeinsam abzulegen und auszutauschen. Zudem kann diesen keine E-Mail zugeordnet werden. Insofern ist es nur eine Liste mit Benutzer für einen Kurs (z.B. eine einmalige Schulung).

   - Projekt: Ist ein Zusammenschluss mehrerer Benutzer aus verschiedenen Gruppen, mit einem gemeinsamen Projektlaufwerk (also mit Shares) und der Möglichkeit, hiermit einen Projektverteiler zu erstellen, um via E-Mail Infos weiterzugeben. Letzters erfordert aber eine Konfiguration des SMTP-Relais und ggf. der Edulution UI.


Hier werden alle Deine Projekte aufgelistet. Um ein neues Projekt anzulegen, klicke auf ``Neues Projekt`` und trage den Projektnamen ein.


.. figure:: media/22_webui-basics_new_project_name.png
   :align: center
   :alt: WebUI: New project name

   Neues Projekt erstellen

Klickst Du im Menü wieder auf ``Einschreiben`` und wählst oben rechts im Objektfilter nur die Projekte aus, dann siehst Du übersichtlich alle Dir zugeordneten Projekte.

.. figure:: media/22_webui-basics_new_project.png
   :align: center
   :alt: WebUI: List new project

   Neues Projekt angezeigen

In obiger Abbildung sind noch keine Projektmitglieder zugeordnet. Es gibt bisher nur Dich als Projektverwalter.

Klickst Du auf das Projekt - hier ``P_netzwerkguide`` siehst Du alle Einstellungen und Mitglieder des Projekts.

.. figure:: media/22_webui-basics_project_details.png
   :align: center
   :alt: WebUI: Project details

   Anzeige der Projektinformationen

Um dem neu angelegten Projekt Projektmitglieder hinzuzufügen, klickst Du wie oben dargestellt auf den Button ``Benutzer oder Gruppe hinzufügen``.

Um einzelne Benutzer hinzuzufügen, klickst Du in das Feld ``Nach einem Benutzer suchen`` und gibst dort einige Buchstaben des Names des Benutzers ein. Es werden alle gefundenen Einträge in einer Liste angezeigt. Aus dieser kannst Du einen gewünschten Benutzer auswählen.

.. figure:: media/23_webui-basics_new_project_add_project_members.png
   :align: center
   :alt: WebUI: Add project members

   Projektmitglieder hinzufügen

Diesen Vorgang wiederholst Du für alle gewünschten Benutzer, Schüler aus einer Klasse oder Projektmitglieder anderer Projekte. Alle ausgewählten Benutzer werden dann unter ``Hinzufügen`` aufgelistet.

.. figure:: media/23_webui-basics_new_project_add_project_members2.png
   :align: center
   :alt: WebUI: Add project members (list)

   Liste der hinzuzufügenden Projektmitglieder

Klicke danach auf ``Übernehmen``.

Danach siehst Du, dass sich die Anzahl der zugeordneten Mitglieder in der Übersicht entsprechend erhöht hat. Beim Aufruf der Projektdetails werden diese Mitglieder nun aufgelistet.

.. figure:: media/22_webui-basics_new_project_details2.png
   :align: center
   :alt: WebUI: Project details

   Anzeige der Projektinformationen

Hier kann eine Projektgruppe auch als Verteiler aktiviert werden.


Passwörter drucken
^^^^^^^^^^^^^^^^^^

Hier gibt es die Möglichkeit, eine übersichtliche Liste von Benutzer- & Passwortinformationen im PDF- oder CSV-Format ausdrucken zu lassen bzw. als Datei herunterzuladen.

.. figure:: media/41_webui-basics_user-list-print-overview.png
   :align: center
   :alt: WebUI User List Export
   
   Übersicht der Klassen zum Ausdruck der Passwörter

Der Druck der Passwörter kann durch Anklicken der jeweiligen Klasse klassenspezifisch erfolgen. Markiere die Klasse und klicke auf das Druckersymbol in der Zeile der Klasse. Es erscheint ein neues Fenster.

.. figure:: media/41_webui-basics_user-list-pdf.png
   :align: center
   :alt: WebUI User List Export PDF
   
   Passwörter der Klasse als PDF ausdrucken
   
Wähle die gewünschten Einstellungen aus und es wird die erstellte Datei heruntergeladen und angezeigt.

Im PDF-Format werden die Benutzer neben dem zugehörigen Passwort in Kästchen angezeigt, wie in diesem Beispiel:

.. figure:: media/42_webui-basics_class-users-export.png
   :align: center
   :alt: WebUI class Users Export
   
   PDF-Datei mit den Passwörtern der Schüler des Kurses

