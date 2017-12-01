Dokumentation erweitern oder hinzufügen
=======================================

Die Dokumentation ist in der Markupsprache "rST" geschrieben. `Hier <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_ finden Sie einen guten Überblick über die am häufigsten verwendeten Elemente.

.. hint::
   Bitte beachten Sie auch unbedingt die :doc:`Leitlinien zur Dokumentation <guidelines>`, damit ihre Änderungen schnell eingepflegt werden könnnen!

Wenn Sie die Dokumentation erweitern wollen, z.B. mit einem eigenen HowTo, ein fehlendes Kapitel ergänzen möchten oder größere Änderungen machen und testen wollen, benötigen Sie folgende Dinge:

- `git <https://git-scm.com/>`_ (wird zur Verwaltung und Versionierung der Dokumentation verwendet)
- `sphinx <http://www.sphinx-doc.org>`_ (zum Übersetzen und Testen der Quelldateien)
- ein Konto bei `Github <https://github.com/join>`_
- optional: SSH-Schlüssel bei Github `hochladen <https://help.github.com/articles/generating-an-ssh-key/>`_ (erleichtert die Arbeit mit git sehr)

Installation (Ubuntu)
---------------------

Git:

.. code-block:: console

   $ sudo apt install git

Sphinx:

.. code-block:: console

   $ sudo apt install python3-pip
   $ pip install sphinx


Linuxmuster Dokumentation forken
--------------------------------

Öffnen Sie die Linuxmuster Dokumentation auf Github und klicken Sie auf "Fork".

.. figure:: media/fork.png
   :align: center
   :alt: Fork on Github

Öffnen Sie nun einen Terminal / Eingabeauffoderung (``Strg+Alt+t`` in Ubuntu) and geben Sie folgenden Befehl ein:

.. note::
   Ersetzen Sie "github-account" mit ihrem Github Kontonamen!

.. note::
   Nutzen Sie die URL ``git@github.com:github-account/main.git`` falls Sie bereits einen SSH-Schlüssel bei Github hochgeladen haben!

.. code-block:: console

   $ git clone https://github.com/github-account/main.git docs
   $ cd docs

Sie können nun mit

.. code-block:: console

   $ make html
   $ xdg-open build/html/index.html

die Dokumentation in HTML übersetzen und in ihrem Browser öffnen.

Dokumentation ändern oder neu erstellen
---------------------------------------

.. hint::
   Bitte beachten Sie auch unbedingt die :doc:`Leitlinien zur Dokumentation <guidelines>`, damit ihre Änderungen schnell eingepflegt werden könnnen!

Im Verzeichnis ``source`` und den entsprechenden Unterordnern befinden sich alle Dokumentationsdateien. Öffnen Sie einfach eine dieser Dateien und nehmen Sie die gewünschten Änderungen vor. Sie können auch eine neue Dokumentation in einem der Unterordner anlegen. Erstellen Sie dazu einfach einen Ordner mit einem passenden Namen und die notwendige ``index.rst`` Datei.

.. code-block:: console

   $ mkdir source/howto/foobar
   $ touch source/howto/foobar/index.rst

Schauen Sie sich auch die anderen Dokumentationsdateien an, um mehr über den Aufbau und Syntax zu lernen.

Haben Sie alle Änderungen vorgenommen, können Sie sie nun zur Überprüfung einreichen. Dazu sind folgende Schritte notwendig:

.. important::
   Überprüfen Sie bitte zuerst, ob ``make html`` ohne Fehler durchläuft! Falls nicht, beheben Sie bitte alle Fehler und Warnungen, bevor Sie Ihre Änderungen hochladen!

.. code-block:: console

   $ make html

Falls Sie neue Dateien oder Ordner erstellt haben, müssen diese noch hinzugefügt werden:

.. code-block:: console

   $ git add source/howto/foobar

Geben Sie nun noch einen Kommentar zu Ihren Änderungen ein und laden Sie alles in Ihren Fork hoch:

.. code-block:: console

   $ git commit -a -m"My great documentation"
   $ git push

Erstellen Sie nun einen "Pull-Request" unter `<https://github.com/github-account/main>`_, indem Sie auf "New Pull Request" klicken.

.. figure:: media/pr.png
   :align: center
   :alt: PR on Github

Wenn Sie weitere Änderungen vornehmen und mit ``git commit -a -m"My comment"`` und ``git push`` bei Github hochladen, werden diese Änderungen automatisch dem Pull Request hinzugefügt.


Den eigenen Fork aktualisieren
------------------------------

Um später weiter Änderungen vornehmen zu können, kann der eigene Fork
gelöscht werden und ein neuer erzeugt werden.

Alternativ kann der eigene Fork auf den Stand des offiziellen Repositoriums gebracht werden:

* Verschiebe alle lokalen Änderungen mit ``git stash`` in den Hintergrund

  .. code:: bash

     ~/docs$ git stash

* Füge (einmalig) einen remote-tracking branch hinzu:

  .. code:: bash

     ~/docs$ git remote add upstream https://github.com/linuxmuster-docs/main.git

* Hole und merge den aktuellen offiziellen branch:

  .. code:: bash

     ~/docs$ git fetch upstream
     ~/docs$ git merge upstream/master
     Aktualisiere 76e2e32..be2f941
     Fast-forward

* Wenn der merge nicht in einem "Fast-forward" endet, sollte man
  besser den Fork löschen und neu erzeugen. Andernfalls kann man jetzt
  die offiziellen Änderungen hochladen.

  .. code:: bash

     ~/docs$ git push

* Jetzt kann man seine lokale Änderungen wieder hervorholen

  .. code:: bash

     ~/docs$ git stash pop



