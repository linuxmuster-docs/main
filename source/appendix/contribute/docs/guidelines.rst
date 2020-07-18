Leitlinien zur Dokumentation
============================


Strukturguide
-------------

Auf Ebene der Dateien:

**rst-Dateien**

- Dateinamen klein schreiben, englisch Begriffe, Leerzeichen vermeiden, Bindestrich (-) statt Unterstrich (_)
- Eine rst-Datei pro Kapitel, möglichst ein englischer Begriff, bsp: configuration.rst

**Medien, wie Bilder, etc.**

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
		  
     .. figure:: media/09_guedelines_view-of-the-file-structure.png
        :align: center
        :alt: propose changes
        
        Beispiel:  ``*1`` erste Ergänzung; ``*2`` zweite Ergänzung

**Medien und Bilder, die in der Dokumentation mehrfach genutzt werden.**

  Sie sollten von diesem Schema abweichen. Zwar müssen sie ebenfalls in dem Ordner media des ausrufenden Kapitels vorhanden sein, aber nicht mit einer laufenden Nummer und Kapitelbezeichnung benannt sein. Beispiel wäre die SVG-Grafik follow_arrow.svg in media des root-Verzeichnis der Dokumentation.
  
  Hintergund: sphinx legt für jede Grafik beim ``./makeinstall`` im build Verzeichnis eine Kopie im Unterversichnis images an. So wird vermieden, das ein und dieselbe Grafik mehrmals vorhanden ist.


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
		  
     .. figure:: media/04_edit-on-github_propose-changes.png
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
