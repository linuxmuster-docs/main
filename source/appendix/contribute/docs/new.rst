Dokumentation lokal bearbeiten und veröffentlichen
==================================================

Wenn du die Dokumentation erweitern willst, z.B. mit einem eigenen HowTo, ein fehlendes Kapitel ergänzen möchtest oder größere Änderungen machen und testen willst, benötigst du folgende Dinge:

- ein Konto bei `Github <https://github.com/join>`_
- Die Software `git <https://git-scm.com/>`_ (wird zur Verwaltung und Versionierung der Dokumentation verwendet)
- Die Software `sphinx <http://www.sphinx-doc.org>`_ (zum Übersetzen und Testen der Quelldateien), die wiederum python voraussetzt
- optional: SSH-Schlüssel bei Github `hochladen <https://help.github.com/articles/generating-an-ssh-key/>`_ (erleichtert die Arbeit mit git)

Virtualbox-Appliance verwenden
------------------------------

Um den Umgang mit rST/sphinx, git und github zu erleichtern, wird von uns eine virtuelle Umgebung angeboten.

- Installiere VirtualBox (mind. 5.2.2) von hier https://www.virtualbox.org/wiki/Downloads inklusive des Extension Packs
- Lade dir die neueste virtuelle Umgebung von hier herunter: http://www.lehrer.uni-karlsruhe.de/~za3966/lmn/
- Importiere die heruntergeladene OVA-Datei und starte die virtuelle Umgebung

Benutzername: 
  linuxadmin (angezeigt wird: Linux Admin)

Passwort:
  linuxmuster

Manuelle Installation (Ubuntu)
------------------------------

Wer die virtuelle Appliance nicht nutzen will, kann mit folgenden Befehlen unter aktuellen (ab 16.04) Ubuntu-Distributionen git, python und sphinx nachinstallieren:

.. code-block:: console

   $ sudo apt install git
   $ sudo apt install python3-pip
   $ pip3 install sphinx 
   $ pip3 install sphinx_rtd_theme

Nachfolgende Befehle gehen davon aus, dass die virtuelle Umgebung verwendet wird.

Erste Schritte: Offizielle Dokumentation kompilieren
----------------------------------------------------

Jetzt kannst du bereits die bereits heruntergeladene Dokumentation aus
dem offiziellen Repositorium bauen und betrachten. Öffne dazu ein
Terminal, navigiere zum Ordner `linuxmuster-docs/main`, führe `make
html` aus und führe `xdg-open build/html/index.html` aus, um das Ergebnis zu betrachten.

.. code-block:: console

   linuxadmin@lmn-docs:~$ cd linuxmuster-docs/
   linuxadmin@lmn-docs:~/linuxmuster-docs$ cd main/
   linuxadmin@lmn-docs:~/linuxmuster-docs/main$ git pull
   ...
   linuxadmin@lmn-docs:~/linuxmuster-docs/main$ make html
   sphinx-build -b html -d build/doctrees   source build/html
   Running Sphinx v1.6.5
   loading translations [de_DE]... done
   loading pickled environment... done
   ...
   linuxadmin@lmn-docs:~/linuxmuster-docs/main$ xdg-open build/html/index.html

GitHub Konto erstellen
----------------------

Spätestens jetzt sollte ein Konto bei GitHub erstellt werden:
https://github.com/join. Verifziere deine E-Mail-Adresse. Natürlich
kannst du die Dokumentation zu GitHub durchlesen. Weiter geht es dann
unter https://github.com/linuxmuster-docs/main

.. hint::

   Im folgenden wird das Konto "lmn-docs-bot" verwendet. Überall wo
   dieser auftaucht, ersetze ihn durch dein Kontonamen bei GitHub.

Linuxmuster Dokumentation forken
--------------------------------

Öffne  die `linuxmuster.net Dokumentation auf Github <https://github.com/linuxmuster-docs/main>`_ und klicke auf "Fork".

.. figure:: media/fork.png
   :align: center
   :alt: Fork on Github

Öffne nun ein Terminal / eine Eingabeauffoderung (``Strg+Alt+t`` in Ubuntu) and gib folgenden Befehl ein:

.. note::
   Nutze die URL ``git@github.com:lmn-docs-bot/main.git`` falls du bereits einen SSH-Schlüssel bei Github hochgeladen hast!

.. code-block:: console

   linuxadmin@lmn-docs:~$ git clone https://github.com/lmn-docs-bot/main.git my-docs
   Klone nach 'my-docs' ...
   ...
   linuxadmin@lmn-docs:~$ cd my-docs

Du kannst nun mit

.. code-block:: console

   linuxadmin@lmn-docs:~/my-docs$ make html
   linuxadmin@lmn-docs:~/my-docs$ xdg-open build/html/index.html

die Dokumentation in HTML übersetzen und in deinem Browser öffnen.

Dokumentation ändern oder neu erstellen
---------------------------------------

Die Dokumentation ist in der Markupsprache "rST" geschrieben. `Hier <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_ findest du einen guten Überblick über die am häufigsten verwendeten Elemente.

.. hint::
   Bitte beachte auch unbedingt die :doc:`Leitlinien zur Dokumentation <guidelines>`, damit ihre Änderungen schnell eingepflegt werden könnnen!

Im Verzeichnis ``source`` und den entsprechenden Unterordnern befinden sich alle Dokumentationsdateien. Öffne einfach eine dieser Dateien und nimm die gewünschten Änderungen vor. Du kannst auch eine neue Dokumentation in einem der Unterordner anlegen. Erstelle dazu einfach einen Ordner mit einem passenden Namen und die notwendige ``index.rst`` Datei.

.. code-block:: console

   $ mkdir source/howto/foobar
   $ touch source/howto/foobar/index.rst

Schaue dir auch die anderen Dokumentationsdateien an, um mehr über den Aufbau und Syntax zu lernen.

Commit und push
~~~~~~~~~~~~~~~

Hast du alle Änderungen vorgenommen, kannst du sie nun zur Überprüfung einreichen. Dazu sind folgende Schritte notwendig:

.. important::

   Überprüfe bitte zuerst selbst, ob ``make clean; make html`` ohne Fehler
   durchläuft! Falls nicht, behebe bitte alle Fehler und
   Warnungen, bevor du deine Änderungen hochlädst!

.. code-block:: console

   $ make clean; make html

Falls du neue Dateien oder Ordner erstellt hast, müssen diese noch hinzugefügt werden:

.. code-block:: console

   $ git add source/howto/foobar

Gib nun noch einen Kommentar zu deinen Änderungen ein und lade alles in deinen Fork hoch:

.. code-block:: console

   $ git commit -a -m"My great documentation update"
   $ git push

Pull-Request
~~~~~~~~~~~~

Erstelle nun einen "Pull-Request" aus deinem eigenen Fork `<https://github.com/<lmn-docs-bot>/main>`_ (ersetze hier <lmn-docs-bot> durch deinen eigenen github-Namen), indem du auf "New Pull Request" klickst.

.. figure:: media/pr.png
   :align: center
   :alt: PR on Github

Wenn du weitere Änderungen vornimmst und mit ``git commit -a -m"My comment"`` und ``git push`` bei Github hochlädst, werden diese Änderungen automatisch dem Pull Request hinzugefügt, so lange, bis der Pull Request akzeptiert wird.

Wenn der Pull Request akzeptiert wurde: Herzlichen Glückwunsch! Falls ein "Review" erstellt wird und du gebeten wirst, Änderungen vorzunehmen, dann kannst du die Änderungen einfach mit "commit" und "push" ebenfalls hochladen und so den Pull Request verbessern.


Den eigenen Fork aktualisieren
------------------------------

Um später weitere Änderungen vornehmen zu können, kann der eigene Fork
bei GitHub komplett gelöscht werden und ein neuer erzeugt werden.
Alternativ kann der eigene Fork auf den Stand des offiziellen
Repositoriums gebracht werden. Das läuft so ab: Eigene neue Änderungen verstecken, dann einmalig die original-Quellen hinzufügen, dann die Originalversion herunterladen, dann diese Version in den eigenen Fork hochladen, dann eventuell eigene Änderungen wieder aus dem Versteck holen. Und dann kann man wie oben weitermachen.

* Verschiebe alle lokalen Änderungen mit ``git stash`` in den Hintergrund

  .. code:: bash

     ~/my-docs$ git stash

* Füge (einmalig) einen remote-tracking branch hinzu:

  .. code:: bash

     ~/my-docs$ git remote add upstream https://github.com/linuxmuster-docs/main.git

* Hole und merge den aktuellen offiziellen branch:

  .. code:: bash

     ~/my-docs$ git fetch upstream
     ~/my-docs$ git merge upstream/master
     Aktualisiere 76e2e32..be2f941
     Fast-forward

* Wenn der merge nicht in einem "Fast-forward" endet, sollte man
  besser den Fork löschen und neu erzeugen. Andernfalls kann man jetzt
  die offiziellen Änderungen in seinen eigenen Fork hochladen.

  .. code:: bash

     ~/my-docs$ git push

* Jetzt kann man seine lokale Änderungen wieder hervorholen

  .. code:: bash

     ~/my-docs$ git stash pop



