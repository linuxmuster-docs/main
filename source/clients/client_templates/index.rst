.. |zB| unicode:: z. U+00A0 B. .. Zum Beispiel 
  
.. |ua| unicode:: u. U+00A0 a. .. und andere

.. |_| unicode:: U+202F
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. _masterclient-template-label:

=======================
Muster-Client aufsetzen
=======================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

Wie du schon an den Unterkapiteln erkennen kannst, muss du für den Muster-Client drei Schritte durchlaufen.

**Hardwareklasse erstellen**

Mittels der Hardwareklasse teilst du LINBO mit, wie die Konfiguration für die Geräte aussieht. Diese Beschreibung umfasst:

  * Name der Hardwareklasse

  * Allgemeine Informationen
      
     + IP des TFTP-Servers der das Image vorhält
     + Startoptionen des Clients
     + eventuell benötigte Kernel-Optionen für den Boot

  * Angaben zu der Partitionierung des Clients

**Rechneraufnahme**

Bei der Rechneraufnahme legst du fest welche Konfigurationen für jede einzelne Arbeitsstation gelten sollen. Das sind:

  * Raum in dem sich der Rechner befindet
  * Name des Rechners
  * Name der Hardwareklasse, welcher der Rechner angehören soll
  * MAC-Adresse des Rechners
  * IP-Adresse, die der Rechner erhalten soll
  * Art des Gerätes
  * Aktivierung von LINBO

Wie du aus den letzten beiden Punkten erkennen könntest, ist die Aktivierung von LINBO nicht für jedes Gerät zwingend notwendig. 

Zum Beispiel braucht ein Netzwerk-Drucker kein eigenes Image, aber eine IP. Des Weiteren ist seine Aufnahme notwendig, damit er im Active Directory des ``Samba`` vom linuxmuster.net-Server aufgenommen wird und somit dem System bekannt ist.

.. todo:: letzter Absatz ist auf Richtigkeit zu überprüfen.

Es gibt drei Möglichkeiten die Rechneraufnahme durchzuführen, welche das sind, wird dir im Kapitel :ref:`hardware-registration-label` gezeigt.

**OS-Installation**

Im letzten Schritt wird nun das eigentliche Betriebssystem auf dem Muster-Client erstellt, in die Domäne eingebunden und das endgültige Image auf den linuxmuster.net-Server geschrieben. Da sich das Vorgehen je nach verwendetem System unterscheidet, gehen die Unterkapitel von :ref:`client-templates-label` detailliert darauf ein.



.. toctree::
   :maxdepth: 3
   :caption: Musterclients
   :hidden:

   hardware_category/index
   hardware_registration/index
   os_installation/index

