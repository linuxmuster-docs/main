Dokumentation erweitern oder hinzufügen
---------------------------------------

Die Dokumantion ist in der Markupsprache "rST" geschrieben. `Hier <docutils.sourceforge.net/docs/user/rst/quickref.html>`_ finden Sie einen guten Überblick über die am häufigsten verwendeten Elemente.

.. warning::
   Bitte beachten Sie auch unbedingt die :doc:`Leitlinien zur Dokumenation <guidelines>`, damit ihre Änderungen schnell eingepflegt werden könnnen!

Wenn Sie die Dokumentation erweitern wollen, z.B. mit einem eigenen HowTo oder ein fehlendes Kapitel ergänzen möchten, benötigen Sie folgende Dinge:

- `git <https://git-scm.com/>`_ (wird zur Verwaltung und Versionierung der Dokumentation verwendet)
- `sphinx <http://www.sphinx-doc.org>`_ (zum Übersetzen und Testen der Quelldateien)
- ein Konto bei `Github <https://github.com/join>`_
- optional: SSH-Schlüssel bei Github `hochladen <https://help.github.com/articles/generating-an-ssh-key/>`_ (erleichtert die Arbeit mit git sehr)

Installation (Ubuntu)
~~~~~~~~~~~~~~~~~~~~~

Git:

.. code-block:: console

   $ sudo apt install git

Sphinx:

.. code-block:: console

   $ sudo apt install python3-pip
   $ pip install sphinx


Linuxmuster Dokumentation forken
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Öffnen Sie die Linuxmuster Dokumentation auf Github und klicken Sie auf "Fork".

.. figure:: media/fork.png
   :width:  450px
   :align: center
   :alt: Fork on Github
   :figwidth: 450px

Öffnen Sie nun einen Terminal / Eingabeauffoderung (``Strg+Alt+t`` in Ubuntu) and geben Sie folgenden Befehl ein:

.. note::
   Ersetzen Sie "github-account" mit ihrem Github Kontonamen!

.. note::
   Nutzen Sie die URL ``git@github.com:github-account/all-of-me.git`` falls Sie bereits einen SSH-Schlüssel bei Github hochgeladen haben!

.. code-block:: console

   $ git clone https://github.com/github-account/all-of-me.git docs
   $ cd docs

Sie können nun mit

.. code-block:: console

   $ make html
   $ xdg-open build/html/index.html

die Dokumantion in HTML übersetzen und in ihrem Browser öffnen.

Dokumentation ändern oder neu erstellen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. warning::
   Bitte beachten Sie auch unbedingt die :doc:`Leitlinien zur Dokumenation <guidelines>`, damit ihre Änderungen schnell eingepflegt werden könnnen!

Im Verzeichnis ``source`` und den entsprechenden Unterordnern befinden sich alle Dokumentationsdateien. Öffnen Sie einfach eine dieser Dateien und nehmen Sie die gewünschten Änderungen vor. Sie können auch eine neue Dokumentation in einem der Unterordner anlegen. Erstellen Sie dazu einfach einen Ordner mit einem passenden Namen und die notwendige ``index.rst`` Datei.

.. code-block:: console

   $ mkdir source/howto/foobar
   $ touch source/howto/foobar/index.rst

Schaunen Sie sich auch die anderen Dokumentationsdateien an, um mehr über den Aufbau und Syntax zu lernen.

Haben Sie alle Änderungen vorgenommen, können Sie sie nun zur Überprüfung einreichen. Dazu sind folgende Schritte notwendig:

Zuerst überprüfen Sie bitte, ob ``make html`` ohne Fehler (mit wenigen Warnungen) durchläuft.

.. code-block:: console

   $ make html

Falls Sie neue Dateien oder Ordner erstellt haben, müssen diese noch hinzugefügt werden:

.. code-block:: console

   $ git add source/howto/foobar

Geben Sie nun noch einen Kommentar zu ihren Änderungen ein und laden Sie alles in ihren Fork hoch:

.. code-block:: console

   $ git commit -a -m"My great documentation"
   $ git push

Erstellen Sie nun einen "Pull-Request" unter https://github.com/github-account/all-of-me, indem Sie auf "New Pull Request" klicken.

.. figure:: media/pr.png
   :width:  450px
   :align: center
   :alt: PR on Github
   :figwidth: 450px

Wenn Sie weitere Änderungen vornehmen und mit ``git commit -a -m"My comment"`` und ``git push`` bei Github hochladen, werden diese Änderungen automatisch dem Pull Request hinzugefügt.