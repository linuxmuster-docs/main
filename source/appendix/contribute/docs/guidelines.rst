Leitlinien zur Dokumentation
============================


Strukturguide
-------------

Auf Ebene der Dateien:

- Dateinamen klein schreiben, englisch Begriffe, Leerzeichen vermeiden, "-"-Bindestrich statt "_"-Unterstrich
- Eine rst-Datei pro Kapitel, möglichst ein englischer Begriff, bsp: configuration.rst
- Medien, wie Bilder, etc.: Einen Unterordner `media/` erstellen, bei vielen Bildern einen Ordner mit dem Namen der Kapiteldatei, darin Dateien abspeichern, bsp: `media/configuration/screenshot-usage.png`

Styleguide
----------

- Verwende "Du"
- Benutze zwei ````backticks```` für URLs, URIs, Dateipfade und Dateinamen und Code im Fließtext (inline)
- Benutze einen ```backtick``` für das Hervorheben für Benutzernamen, Schaltflächen, besondere Aktionen
- für Konsolenbefehle nutze

  .. code-block:: rst

     .. code-block:: console

	# mein kommando --force
	output

- Für Bilder kann man image oder figure verwenden. Bei figure kann man Bildunterschriften hinzufügen

  .. code-block:: rst
		  
     .. figure:: media/proposeChanges.png
        :align: center
        :alt: propose changes

	Bildunterschriften 


- Ein Kapitel sollte einen toctree enthalten, wenn es mehrere Dateien gibt

- Ein Kapitel kann ein Label erhalten

  .. code-block:: rst

     .. _knownbugs-label:

     Bekannte Fehler
     ===============

- Mit diesem Sprungpunkt kann man an anderer Stelle auf ihn verweisen

  .. code-block:: rst

     Bitte lesen Sie :ref:`hier <knownbugs-label>` nach, welche Fehler bekannt sind.
