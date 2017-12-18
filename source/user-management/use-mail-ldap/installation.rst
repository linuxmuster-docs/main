Installation
============

Rechte für Gruppen festlegen
----------------------------
Der Bereich für die Eingabe der eigenen Mail-Adresse muss zunächst in der Schulkonsole 
aktiviert werden. Dazu erstellt man im Verzeichnis

.. code-block:: bash

   /etc/linuxmuster/schulkonsole/permissions.d

die Datei ``all-pages-mymail`` mit dem Inhalt 

.. code-block:: console

   ALL=start_mymail

und im gleichen Verzeichnis die Datei ``all-programs-mymail`` mit dem Inhalt

.. code-block:: console

   ALL=set_user_mymail

Die erste Datei ``all-pages-myemail`` erlaubt es allen Benutzern, den
Bereich auf der Startseite der Schulkonsole zur Änderung der
Mailadresse zu sehen. Die zweite Datei ``all-programs-mymail`` erlaubt
es dem Benutzer, die Funktion zur Änderung der Mailadresse zu
verwenden.

Sollen nur die Lehrer in der Lage sein, eine eigene Mailadresse zu verwenden, so lauten
die Dateinamen ``teachers-pages-mymail`` mit dem Eintrag

.. code-block:: console

   teachers=start_mymail

und ``teachers-programs-mymail`` mit dem Eintrag

.. code-block:: console

   teachers=set_user_mymail

Analog kann die Funktion auch lediglich für Administratoren freigeschaltet werden.

Es ist auch möglich, die Seite freizugeben (über die pages-Datei),
nicht aber die Funktion zur Änderung. In diesem Fall kann der Benutzer
den Eintrag zwar sehen, ist aber nicht in der Lage, ihn zu verändern.

Rechte übernehmen
-----------------
Nachdem die Dateien fertig editiert wurden, müssen die neuen Einstellungen ins System 
übernommen werden. Das geschieht durch zwei Skripte im Verzeichnis
``/usr/share/schulkonsole/scripts``. Diese Skripte müssen ausgeführt werden, also

.. code-block:: bash

   server ~ # /usr/share/schulkonsole/scripts/update-permissions.sh
   server ~ # /usr/share/schulkonsole/scripts/make-menus.sh

Nach Ausführung dieser Skripte erscheint auf der Startseite der Schulkonsole für die
berechtigten Benutzer ein neuer Bereich zur Änderung der Adresse.
