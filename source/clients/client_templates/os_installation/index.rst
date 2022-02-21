.. |zB| unicode:: z. U+00A0 B. .. Zum Beispiel 
  
.. |ua| unicode:: u. U+00A0 a. .. und andere

.. |_| unicode:: U+202F
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. _client-templates-label:

============================
Betriebssysteme installieren 
============================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

.. todo:: Allgemeiner Text zu den Betriebssystemen ergänzen

Das Partitionierungsschema hast du mit den Schritten in :ref:`hardware-category-label` festgelegt und im darauf aufbauenden Kapitel :ref:`hardware-registration-label` deinem Client zugewiesen. Solltest du das noch nicht gemacht haben, dann wäre jetzt der Zeitpunkt dieses nachzuholen.

.. todo:: Attention-Box mit Hinweisen zu Abhängigkeiten ergänzen.

.. attention:: Folgende Punkte sind sicherzustellen:

   Keine Zeitdifferenz zwischen dem Client und dem linuxmuster.net-Server 

**Festplatte mit LINBO vorbereiten**

Bevor du mit der eigentlichen Installation des Client-Betriebssystem beginnen kannst, musst du die Festplatte mittels LINBO vorbereiten. Dieses wird detailiert unter :ref:`format_hdd_with_linbo-label` beschrieben.

**Betriebssysteme installieren**

:ref:`install-linux-clients-current-label` installieren

:ref:`install-windows10-clients-label` installieren

.. toctree::
   :maxdepth: 3
   :caption: Musterclients
   :hidden:

   format_hdd_with_linbo
   linux-clients/index
   windows10clients/index

