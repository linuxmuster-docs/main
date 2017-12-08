Leitlinien zur Dokumentation
============================

Aufbau
------

Logisch aufgebaut wird die Dokumentation in

- Handbuch für Netzwerkbetreuer+Administratoren
- Handbuch für Lehrer
- Handbuch für Schüler

Innerhalb der Handbücher wird unterschieden nach aufgabenbasierten „HowTos“ und Bedienungsanleitungen.

- Für die Erstinstallation im Handbuch für Netzwerkbetreuer+Administratoren werden die wichtigsten HowTos als „Leitfäden“ besonders heraus- und vorangestellt.
- HowTos und Addons, die nicht zur Kerndokumentation gehören werden im Handbuch für Netzwerkbetreuer+Administratoren hintenangestellt.

Inhaltlich bauen sowohl die HowTos als auch die Bedienungsanleitungen in den verschiedenen Handbüchern aufeinander auf. Man soll davon ausgehen, dass die Lehrer auch das Handbuch für Schüler gelesen haben und die Netzwerkbetreuer das Handbuch der Lehrer und Schüler gelesen haben, z.B. das HowTo - „wie man sein Passwort ändert“ gilt für Schüler wie Lehrer wie Netzwerkbetreuer.

Howtos = Schritt-für-Schritt
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Die Idee der „schritt-für-schritt“-Anleitungen wäre grundsätzlich,

- Es kurz zu halten und möglichst viele Screenshots zu machen. Dass das nicht immer geht, weil wir manchmal Konsolenbefehle brauchen, ist klar
- Mit den Screenshots Schritt für Schritt zu erklären, was gemacht werden soll
- Keine technischen Details, die sollten in die techsheets im Wiki.
- Alternative Vorgehensweisen vermeiden. Lieber die User-freundliche Alternative beschreiben und die Expertenalternative in ein techsheet im Wiki oder in einen Anhang

Manuals = Bedienungsanleitungen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Die Bedienungsanleitungen sollten einfach nur Funktionalitäten beschreiben.

Strukturguide
-------------

Auf Ebene der Dateien:

- Dateinamen klein schreiben, Leerzeichen vermeiden, "-"-Bindestrich statt "_"-Unterstrich
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

- Ein Kapitel sollte einen toctree enthalten, wenn es mehrere Dateien gibt

- Ein Kapitel kann ein Label erhalten

  .. code-block:: rst

     .. _knownbugs-label:

     Bekannte Fehler
     ===============

- Mit diesem Sprungpunkt kann man an anderer Stelle auf ihn verweisen

  .. code-block:: rst

     Bitte lesen Sie :ref:`hier <knownbugs-label>` nach, welche Fehler bekannt sind.
