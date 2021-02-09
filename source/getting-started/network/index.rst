.. include:: /guided-inst.subst

.. _network-label:

===============================
Anpassung des Netzwerkbereiches
===============================

.. sectionauthor:: `@Name des Autors in ask <https://ask.linuxmuster.net/u/Dein_Name>`_

.. hint:: Verlinkung der Unterabschnitte:

   * Für die Migration

   * Netzbereich abweichend von 10.0.0.0/16 ohne Segmentierung

   * Netzbereich abweichend von 10.0.0.0/16 mit Segementierung 


.. todo:: Inhalt ergänzen
          ...

Default-Netzbereich verwenden
-----------------------------

...

+--------------------------------------------------------------------+-------------------------------------------+
| Absicherung der Proxmox UI                                         | |follow_me2proxmox-ui-protection_a|       |
+--------------------------------------------------------------------+-------------------------------------------+

Migration
---------

...

+--------------------------------------------------------------------+-------------------------------------------+
| Migration                                                          | |follow_me2network-migration|             |
+--------------------------------------------------------------------+-------------------------------------------+

Netzbereich-Anpassung
---------------------

...

+--------------------------------------------------------------------+-------------------------------------------+
| Netzbereich-Anpassung mit Segmentierung                            | |follow_me2network-with-segmentation|     |
+--------------------------------------------------------------------+-------------------------------------------+
| Netzbereich-Anpassung ohne Segmentierung                           | |follow_me2network-without-segmentation|  | 
+--------------------------------------------------------------------+-------------------------------------------+

Template für den Inhalt einer noch leeren Seite
-----------------------------------------------

Sicherlich ist der Inhalt dieser Seite nicht das was du gesucht und erwartest hast. Dieser Part der Dokumentation ist leider noch nicht mit Informationen gefüllt.

Eventuell kannst du uns helfen dieses zu ändern. Es gibt verschiedene Möglichkeiten uns zu unterstützen:

* Du weißt, was hier stehen müsste und könntest uns Text und/oder Screenshots liefern.

    Schicke deinen unformatierten Text oder die Bilder an dokumentation(et)linuxmuster.net oder einfach in unser Forum `<https://ask.linuxmuster.net/c/weiterentwicklung/doku>`_.

* Du hast schon Erfahrung mit der vereinfachten Auszeichnugssprache RST (reStructuredText) oder willst sie erlernen.

    Unsere :ref:`guidelines-label` zeigen dir welche Absprachen wir diesbezüglich getroffen haben. Schicke uns deinen Inhalt für diese Seite an eine der zuvor genannten Adressen.

* Hast du eventuell schon einen git-hub-Account oder wolltest dich schon immer mit git befassen.
 
    Wir nutzen für die Organisation unserer Dokumentation git. Aus dem in github gehosteten RST-Files werden automatisch via ReadTheDocs (Sqhinx) diese Seiten hier erzeugt. 
 
    So hättest du direkt die Möglichkeit unsere Dokumentation zu verbessern. Dafür gibt es den Button der sich immer oben rechts auf den Seiten befindet: **Edit on GitHub**. Eine Beschreibung findest du hier: :ref:`edit-on-github-label`

* Du willst git auf deinem Rechner einsetzen um dort lokal arbeiten zu können.

    Auch dafür stehen wir dir hilfreich zur Seite, wie das geht haben wir hier :ref:`new-label` beschrieben.
  
Also wir würden uns freuen, wenn du uns unterstützen würdest. 

Wie immer bei linuxmuster.net niemand ist bei uns allein.
Für Fragen einfach einen Post an die im ersten Punkt genannten Adressen. (E-Mail oder Forum) 

Muster für Tabelle:

====== ===== ===== =======
\          XOR
--------------------------
\      Input       Output
------ ----------- -------
Lfd-Nr A     B     A xor B     
====== ===== ===== =======
1      0     0     0
2      0     1     1
3      1     0     1
4      1     1     0
====== ===== ===== =======

Muster für Verlinkung:


.. toctree::
  :maxdepth: 1
  :caption: Netzwerk Anpassungen
  :hidden:
  
  migration/index
  preliminarysettings/index
  networksegmentation/index
  segmentation/index
  proxmox-ui-protection
  network-test
