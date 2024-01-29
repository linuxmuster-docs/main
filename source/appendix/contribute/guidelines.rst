.. _guidelines-label:

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

     (unter)kapitelbezeichnung_laufende-nummer_beschreibung-des-dargestellten
  
  -  (unter)kapitelbezeichnung <-- Titel des Kapitels bzw. des Unterkapitels in dem die Medien-Datei verwendet wird
  -  laufende-nummer <-- Bilder ihrer Verwendung von oben nach unten fortlaufend durchnummeriert; eine führende Null
  -  beschreibung-des-dargestellten <-- Bei Fenstern zum Beispiel der Namen des Fensters
  -  Unterstrich (_) um die drei Felder voneinander abzugrenzen
  
  
  Beispiel: 
  
  .. code-block:: rst

     ../install-on-xcp-ng/media/install-on-xcp-ng_01_network-sketch.png

  
  Hinzugefügte Dateien erben von der vorhergehenden Datei die Laufende-Nummer und diese wird um eine neu aufsteigende Nummerierung ergänzt.
		  
     .. figure:: media/09_guedelines_view-of-the-file-structure.png
        :align: center
        :alt: propose changes
        
        Beispiel:  ``*1`` erste Ergänzung; ``*2`` zweite Ergänzung

**Medien und Bilder, die in der Dokumentation mehrfach genutzt werden.**

  Du solltest von diesem Schema abweichen, da diese nur in dem root-Verzeichnis vorhanden sein müssen. Indem auf die laufenden Nummern und Kapitelbezeichnungen verzichtet wird, werden sie als solche kenntlich gemacht. Beispiel wäre die SVG-Grafik follow_arrow.svg die dann mit /media/follow_arrow.svg in der Datei /guided_inst.subst eingebunden wird.
  
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

- Für Bilder kann man image oder figure verwenden. Bei figure kann man Bildunterschriften hinzufügen.

  .. code-block:: rst
		  
     .. figure:: media/04_edit-on-github_propose-changes.png
        :align: center
        :alt: propose changes

	Bildunterschriften 


- Ein Kapitel sollte einen ``toctree`` enthalten, wenn es mehrere Dateien gibt.

- Ein Kapitel kann ein Label erhalten bzw. muss eines erhalten wenn es als Sprungziel dienen könnte. 

  .. code-block:: rst

     .. _knownbugs-label:

     Bekannte Fehler
     ===============

  Die Bennung dieser Sprungpunkte sollen immer mit ``-label`` enden.

- Mit diesem Sprungpunkt kann man an anderer Stelle auf ihn verweisen

  .. code-block:: rst

     Bitte lies :ref:`hier <knownbugs-label>` nach, welche Fehler bekannt sind.

- Um eine Tabelle
     
  =========== ============ ==================
  Spalte A    Spalte B     Spalte C
  =========== ============ ==================
  Bla         Balbla       Blablabla
  Blub        Blubblub     Blubblubblub
  Rababa      Rababarababa Rabararabararabara
  =========== ============ ==================
  
  einzustellen, nutze folgende einfache Syntax:
  
  .. code-block:: rst

     =========== ============ ==================
     Überschrift Überschrift  Überschrift 
     Spalte A    Spalte B     Spalte C
     =========== ============ ==================
     Bla         Balbla       Blablabla
     Blub        Blubblub     Blubblubblub
     Rababa      Rababarababa Rabararabararabara
     =========== ============ ==================

