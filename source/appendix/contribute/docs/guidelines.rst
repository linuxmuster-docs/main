Leitlinien zur Dokumentation
============================


Strukturguide
-------------

Auf Ebene der Dateien:

rst-Dateien:

- Dateinamen klein schreiben, englisch Begriffe, Leerzeichen vermeiden, Bindestrich (-) statt Unterstrich (_)
- Eine rst-Datei pro Kapitel, möglichst ein englischer Begriff, bsp: configuration.rst

Medien, wie Bilder, etc.:

- In einen Unterordner `media/` des Kapitles ablegen
- Benennung der Medien-Dateien:

  .. code-block:: rst

     laufende-nummer_(unter)kapitelbezeichnung_beschreibung-des-dargestelltem
  
  -  laufende-nummer <-- Bilder ihrer Verwendung nach von oben nach unten fortlaufend durchnummeriert; eine führende Null
  -  (unter)kapitelbezeichnung <-- Titel des Kapitels bzw. des Unterkapitels in dem die Medien-Datei verwendet wird
  -  beschreibung-des-dargestelltem <-- Bei Fenstern zum Beispiel der Namen des Fensters
  -  Unterstrich (_) um die drei Felder voneinander abzugrenzen
  
  
  Beispiel: 
  
  .. code-block:: rst

     ../install-on-xcp-ng/media/01_install-on-xcp-ng_network-sketch.png

  
  Hinzugefügte Dateien erben von der vorhergehenden Datei die Laufende-Nummer und die wird um eine neu aufsteigende Nummerierung ergänzt
		  
     .. figure:: media/00-01_guedelines_view-of-the-file-structure.png
        :align: center
        :alt: propose changes
        
        Beispiel:  ``*1`` erste Ergänzung; ``*2`` zweite Ergänzung
  

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
