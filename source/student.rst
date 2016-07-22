Handbuch für Schüler
====================

Diese Datei ist ein Platzhalter für eine neu anzulegende Dokumentation. 

Bitte verwenden Sie die förmliche Anrede "Sie" in ihrer Dokumentation.

Für die Struktierung halten Sie sich bitte an unseren Struktur- und Styleguide

Strukturguide
-------------

1. Dateinamen klein schreiben
2. keine Leerzeichen stattdessen den Unterstrich _ benutzen
3. Eine rst-Datei pro Kapitel (möglichst ein englischer Begriff), bsp: howto_printer.rst
4. Für Bilder und Anderes einen Unterordner ``media`` in dem Kapitel-Ordner
5. Auf der letzten "Seite" soll am Ende ein Verweis mit dem Link zur einer eventuellen Ticketgenerierung enthalten. (siehe unten)
6. Die erste Übersichtsseite enthält einen Hinweis auf die Zielgruppe

- Ambitionierte Netzwerkbetreuer oder Dienstleister
- Netzwerkbetreuer
- Benutzer (Lehrer/Schüler) 

Nachfolgend ein Überblick von den Möglichkeit die reStructuredText Ihnen bietet und als Styleguide.

Styleguide
----------

.. attention::
   Ein Backslash \\ in der .rst-Datei dient zur Maskierung des nachfolgenden Zeichens.

Absätze werden durch Leerzeilen voneinander getrennt. Da reStructuredText im Umfeld von Python entstanden ist, hat die Einrückung von Text Auswirkung auf die Formatierung.

Fortlaufende Absätze müssen daher alle gleich eingerückt sein.

| Sollten Sie einen festen Zeilenumbrauch benötigen,
| können Sie diesen mit dem Pipe-Symbol \| vor den
| einzelnen Zeilen erhalten.


Markierungen
------------

Folgende Markierungen werden empfohlen:

\:emphasis:`Hervorhebung` – :emphasis:`Hervorhebung (kursiv)` 

\:strong:`Starke Hervorhebung` – :strong:`Starke Hervorhebung`

\:literal:`Quellcode` – :literal:`print("Hallo Welt!")`

\:subscript:`tiefgestellter Text` – :subscript:`tiefgestellter Text`

\:superscript:`hochgestellter Text` – :superscript:`hochgestellter Text`

Benutzen Sie einen \`backtick\` für das Hervorheben von 

1. `Benutzernamen`
2. `Schaltflächen`
3. `besondere Aktionen`

Benutze Sie zwei ``backticks`` für die Hervorhebung von:

- ``URLs``
- ``URIs``
- ``Dateipfade``
- ``Dateinamen``
- ``Code im Fließtext``

.. hint::
   In der rst-Datei können Sie sich anschauen wie diese Listen / Aufzählung notiert werden.

Überschriften
-------------


werden durch Unterstreichungen, teilweise durch Unter- und Überstreichungen, markiert. Die Zeile mit der Unterstreichung muss ebenso lang sein, wie die Überschrift selbst. Siehe oben


Eine mögliche Konvention ist:

* \= als Unterstreichung für Unterkapitel
* \- als Unterstreichung für Abschnitte
* \^ als Unterstreichung für Unterabschnitte

Infoboxen
--------- 

weitere

.. caution::
   Mögliche Fallstricke

.. important::
   Wichtige Informationen

.. tip::
   Was es noch zu sagen gäbe

.. warning::
   Seien Sie sich immer bewusst was Sie tun

.. admonition:: Wichtiger Hinweis für Erstinstallierer

   Lesen Sie sich die Dokumentation am besten bis zum Ende durch! In diesem Fall sehen Sie wie Sie eine Hinweisbox mit einer eigenen Überschrift erzeugen.

Ende des Styleguide-Abschnittes
-------------------------------

.. admonition:: Bitte helfen Sie mit diese Dokumentation zu verbessern.

   Falls Sie einen Fehler in dieser Dokumentation entdeckt haben, teilen Sie uns diesen mit:
   http://www.linuxmuster.net/flyspray/

.. toctree::
   :glob:
   :maxdepth: 1
   :titlesonly:


