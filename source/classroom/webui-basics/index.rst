.. _webui-basics-label:

========================
Schulkonsole des Lehrers
========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix (pics) <https://ask.linuxmuster.net/u/MachtDochNix>`_

Hast Du auf dem Server einen Lehrer-Account, so kannst Du die Steuerung des Unterrichts web-basiert mithilfe der Schulkonsole in einem Browser vornehmen.

.. figure:: media/01_webui-basics_welcome.png
   :align: center
   :alt: WebUI Welcome
       
   Schulkonsole als Lehrer nach der Anmeldung

Die Schulkonsole wird im Browser über ``https://10.0.0.1`` aufgerufen. Je nachdem welcher Benutzer angemeldet ist, erscheinen
zugehörige Menüpunkte.

.. figure:: media/02_webui-basics_user-overview.png
   :align: center
   :alt: WebUI Welcome
   
   Profil nach erfolgter Anmeldung

Die Icons haben folgende Bedeutung:

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

Das Menü der Schulkonsole des Lehrers teilt sich in die Bereiche ``Allgemein`` und ``Klassenzimmer`` auf.

Allgemein
=========

Hauptseite
----------

.. figure:: media/01_webui-basics_welcome.png
   :align: center
   :alt: WebUI Main Page
   
   Hauptseite als angemeldeter Lehrer

Hier findest Du Informationen zu Deinem Konto, Deinen zugeordneten Benutzergruppen sowie dem Verbrauch Deines Festplattenkontingents (Quota).


Meine Dateien
-------------

.. figure:: media/02_webui-basics_my-files.png
   :align: center
   :alt: WebUI My Files
   
   Meine Dateien als angemeldeter Lehrer

Hier findest Du die Ordner und Dateien, die z.B. im Unterverzeichnis **Unterricht** abgelegt hast und im Unterricht an die Schüler der Klassen verteilen kannst. Das Verzeichnis ``transfer`` wird u.a. für den Klassenarbeitsmodus benötigt, um Dateien für Klassenarbeiten auszuteilen und die Ergebnisse auch wieder einzusammeln.

Klassenzimmer
=============

Unterricht
----------

Klassen / Kurse, in denen Du Mitglied bist, werden hier aufgelistet.

.. figure:: media/10_webui-basics_my-classes.png
   :align: center
   :alt: WebUI My Classes

   Unterricht nach der Erstanmeldung als Lehrer

Zu Beginn bist Du noch in keinen Klassen / Kursen oder Projekten eingeschrieben. Schreibe Dich als Lehrer zuerst in den gewünschten Klassen / Kursen ein.  Hierzu klickst Du links im Menü auf ``Einschreiben`` -> ``Schulklassen``. Bei den angezeigten Schulklassen setzt Du für diejenigen Klassen einen Haken, in denen Du Dich einschreiben möchtest.

.. figure:: media/11_webui-class-enrollement.png
   :align: center
   :alt: class enrollement
   
   Einschreibung in Klassen

Oben erscheint ein blau hinterlegter Hinweis. Um die Die Einschreibung abzuschließen, musst Du auf ``Jetzt ausführen`` in dem blauen Hinweisfeld klicken.
Verlief die Einschreibung erfolgreich, siehst Du nun im Menüpunkt ``Unterricht`` Deine Dir zugewiesenen Klassen / Kurse.

.. figure:: media/12_webui-classes-enrolled.png
   :align: center
   :alt: classes enrolled
   
   Eingeschriebene Klassen

Klickst Du nun auf eine Klasse, so wird diese mit den eingetragenen Benutzern zusammengestellt. Es werden alle Benutzer der Klasse dargestellt.

.. figure:: media/13_webui-class-selected.png
   :align: center
   :alt: class selected

   Ausgewählte Klassen und deren Benutzer

Kurse erstellen
^^^^^^^^^^^^^^^

Du kannst über die Funktion oben rechts ``Neuer Kurs`` einen neuen Kurs anlegen. 

.. figure:: media/11_webui-basics_new-class-button.png
   :align: center
   :alt: WebUI New Class Button
   
   Wähle den Eintrag Neuer Kurs

Gib in dem sich öffnenden Fenster den neuen Kursnamen ein und bestätige diesen mit ``OK``.

.. figure:: media/11_webui-basics_new-class.png
   :align: center
   :alt: WebUI New Class
   
   Neuen Kurs erstellen

Der neu angelegte Kurs erscheint im Menü ``Unterricht`` -> unter der Rubrik ``Meine Kurse``.

.. figure:: media/11_webui-basics_my-courses.png
   :align: center
   :alt: WebUI my courses
   
   Meine Kurse

In obiger Abbildung siehst Du, dass in dem neu angelegten Kurs noch keine Schüler zugewiesen wurden.


Schüler einem Kurs hinzufügen
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Um Schüler einem Kurs hinzuzufügen, wählst Du den gewünschten Kurse via Klick auf das Icon des Kurses aus.

.. figure:: media/12_webui-basics_selected_course.png
   :align: center
   :alt: seclected course
   
   Ausgwählter Kurs

In den oberen Zeilen gibt es nun die Möglichkeit über ``Schüler hinzufügen`` einzelne Schüler hinzuzufügen oder über ``Klasse hinzufügen`` eine ganze Schulklasse dem Kurs hinzuzufügen. Klickst Du in das Feld ``Schüler hinzufügen`` und gibst dort die **ersten beiden Buchstaben des Schülernamens** ein, erscheint eine Liste mit Schülern, deren Nachnamen mit diesen Buchstaben beginnen.

.. figure:: media/12_webui-basics_add-class-members.png
   :align: center
   :alt: add pupils to course
   
   Ausgwählter Kurs: Schüler hinzufügen

Hast Du alle gewünschten Schüler nacheinander ausgewählt, siehst Du eine Liste mit allen Schülern des Kurses. Um diese in den Kurs zu übernehmen, klickst Du abschließend unten rechts auf ``Speichern & übernehmen``.

Wählst Du einen bestimmten Kurs oder eine bestimmte Klasse aus, findest Du folgende Ansicht vor.

.. figure:: media/13_webui-basics_class-overview.png
   :align: center
   :alt: WebUI Class Overview
   
   Übersicht der Kursteilnehmer

In dieser Übersicht können die pädagogischen Funktionen WLAN-, Internet- & Drucker-Freigabe, Dateien-Übertragungs-Funktion und Prüfungsmodus genutzt werden.

WLAN-, Internet-Freigabe & Drucker-Freigabe
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

Freigaben zu den jeweiligen Diensten können über ``Haken setzen oder entfernen`` für die jeweiligen Benutzer freigegeben oder gesperrt werden. Über das Kästchen direkt unter einem Dienstsymbol kann die Freigabe oder Sperrung zu dem jeweiligen Dienst auf alle Benutzer angewendet werden. 

Beispielsweise wurde hier mit einem Klick unter das WLAN-Symbol für jeden Benutzer des aktuellen Kurses der WLAN-Zugang freigegeben. Dieses muss nur noch unten rechts mit ``Speichern & übernehmen`` angewendet werden.

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

Mit Hilfe des Mülleiners können einzelne Schüler aus dem Kurs entfernt werden. Dies gilt, bis die Sitzung neu erstellt wird.

Sämtliche Änderungen müssen mit ``Speichern & Übernehmen`` angewendet werden.

Dateien austeilen & einsammeln
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Dateien können für die Unterrichtsarbeit mithilfe der Funktion ``Teilen & Einsammeln`` an Schüler ausgeteilt und wieder eingesammelt werden. 

Auf der Kursseite findest Du im unteren Bereich die Buttons ``Teilen`` und ``Einsammeln``, welche sich auf alle Kursteilnehmer beziehen. 

.. figure:: media/46_webui-basics_share_files.png
   :align: center
   :alt: Share files
   
   Teilen

.. figure:: media/46_webui-basics_collect_files.png
   :align: center
   :alt: collect files
   
   Einsammeln


Neben jedem Benutzer selbst gibt es ``Austeilen`` und ``Einsammeln`` Funktionen, welche nur auf die einzelnen Benutzer angewendet werden.


.. figure:: media/46_webui-basics_share_files_per_user.png
   :align: center
   :alt: collect files
   
   Einsammeln

Weitere Erläuterungen hierzu findest Du im Abschnitt :ref:`exam-and-transfer-label`.

Prüfungsmodus
^^^^^^^^^^^^^

Das Absolventenkappen-Symbol

.. figure:: media/17_webui-basics_exam_mode-icon.png
   :align: center
   :alt: WebUI Graduate Icon

   Prüfungsmodus

stellt den Prüfungsmodus dar. Ausgewählte Schüler oder alle Schüler einer Klasse eines Kurses können dadurch in diesen Modus gesetzt werden (nach Klick auf ``Speichern & Übernehmen`` unten rechts). Im aktivierten Prüfungsmodus wird die Seite wie folgt angezeigt:

.. figure:: media/22_webui-basics_active-exam-modus.png
   :align: center
   :alt: WebUIActive Exam Modus
   
   Aktiver Prüfungsmodus

Bei allen Schülern, die im Prüfungsmodus sind, wird unter Prüfungsaufsicht der Name des Lehrers, die den Modus aktiviert hat, mit rotem Hintergrund dargestellt. Schülern im Prüfungsmodus ist automatisch die WLAN-, Internet- & Drucker-Freigabe gesperrt. Dies kann jedoch individuell angepasst werden. 

Um den Prüfungsmodus zu beenden, entfernst Du den Haken bei jedem Kursmitglied (Klick unter das Prüfungsmodus-Icon) und übernimmst die Einstellungen mit ``Speichern & Übernehmen``.

Ausführliche Hinweise zum Prüfungsmodus findest Du im Abschnitt :ref:`exam-and-transfer-label`.

Einschreiben
------------

Im Menü ``Einschreiben`` findest Du nachstehende drei Rubriken.

Schulklassen
^^^^^^^^^^^^

.. figure:: media/22_webui-basics_school_classes.png
   :align: center
   :alt: WebUI School Classes
   
   Schulklassen
   
Hier werden alle Schulklassen der Schule aufgelistet. Durch Klick auf den Klassennamen werden Dir weitere Informationen angezeigt, wie etwa alle Schüler der Klasse.

.. figure:: media/22_webui-basics_school_classes_details.png
   :align: center
   :alt: WebUI Details for School Classes
   
   Details der Schulklassen

Drucker
^^^^^^^

Hier werden alle Drucker aufgelistet. Durch Anklicken werden weitere Informationen angezeigt. 

Ein Auswählen ist nur erforderlich, wenn man den Drucker auch außerhalb des zugehörigen Raumes nutzen möchte.

Projekte
^^^^^^^^

Hier werden alle Projekte aufgelistet. Zu Beginn ist die Liste leer. Du musst zuest Projekte anlegen und diesen beitreten.

.. figure:: media/22_webui-basics_projects.png
   :align: center
   :alt: WebUI projects
   
   Projekte

Projekte unterscheiden sich von Kursen: 

* Mehrere Lehrer können in eine Projektgruppe aufgenommen werden. 
* Projekte verfügen über eigene Tauschverzeichnisse
* Projekte können wiederverwendet werden.
* Unterrichtssteuerung (Passwörter ändern, Internet sprerren, etc.) ist **nicht** möglich.

**Projekt anlegen**

Um ein Projket anzulegen klickst Du im Menü ``Klassenzimmmer -> Einschreiben -> Neues Projekt``.

.. figure:: media/22_webui-basics_new_project.png
   :align: center
   :alt: WebUI create new project
   
   Neues Projekt anlegen

Es erscheint ein neues Fenster, in dem Du den Namen für das anzulegende Projekt einträgst.

.. figure:: media/22_webui-basics_new_project_name.png
   :align: center
   :alt: WebUI New Project Name

   Namen für das Projekt festlegen


Du darfst nur Kleinbuchstaben und Zahlen in dem Projektnamen verwenden. Bestätige das Anlegen des neuen Projektes mit ``OK``.

**Projektmitglieder verwalten**

Durch Anklicken eines bestimmten Projekts, werden weitere Informationen angezeigt, wie etwa die Mitglieder und Administratoren des Projekts.

.. figure:: media/22_webui-basics_new_project_details.png
   :align: center
   :alt: WebUI New Project Deatils

   Weitere Projektinformationen

Über die Funktion ``Beitretbar`` kann die Beitrittmöglichkeit und über die Funktion ``Nicht anzeigen`` die Sichtbarkeit eingestellt werde. 
Klicke die Option ``Beitretbar`` an, damit Benutzer dem Projekt hinzugefügt werden können. 

.. figure:: media/23_webui-basics_new_project_joinable.png
   :align: center
   :alt: WebUI New Project Joinable

   Projektoption "beitretbar" setzen 

Mitglieder können nun über den Button ``Benutzer oder Gruppe hinzufügen`` dem Projekt zugeordnet werden. Danach erscheint ein Fenster, in dem Du nach Benutzer, Klassen oder Gruppen suchen kannst.

.. figure:: media/23_webui-basics_new_project_add_project_members.png
   :align: center
   :alt: WebUI Manage Project Members
   
   Projektmitglieder hinzufügen

Gebe in einer der Zeilen die ersten beiden Anfangsbuchstaben ein und es werden Dir unter Benutzer, Klasse oder Gruppe die bereits existierenden Einträge aufgelistet. Wähle aus der Liste die gewünschten aus. Wiederhole diese Vorgang für weitere Benutzer oder Gruppen. Die bereits ausgewählten Benutzer oder Gruppen werden Dir unten links in dem Fenster unter der Überschrift ``Hinzufügen`` aufgelistet. Findest Du hier alle gewnüschten Benutzer und Gruppen, klicke auf ``Übernehmen``, um diese dem Projekt hinzuzufügen.

**Projekt löschen**

Klicken auf das jeweilige Projekt und wähle unten links ``Projekt löschen``. Bestätige diesen Vorgang im nächsten Fenster mit ``LÖSCHEN``.


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
   
   PDF-Datei mit den Passwörtern der Schüler der Klasse


