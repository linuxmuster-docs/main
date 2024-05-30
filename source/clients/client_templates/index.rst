.. include:: ../../guided-inst.subst

.. _masterclient-template-label:

=======================
Muster-Client aufsetzen
=======================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_,
                   `@MachtDochNix <https://ask.linuxmuster.net/u/MachtDochNix>`_

linuxmuster.net ermöglicht es, Clients mithilfe von LINBO automatisiert zu verwalteen. Auf den Clients kann ein Betriebssystem oder es können mehrere Multi-Boot Betriebssysteme auf dem Client installiert, aktualisiert, ausgerollte und zurückgesetzt werden. Mithilfe von LINBO erfolgt so ein automatischens Ausrollen der Clients im Netzwerk, das Verteilen zusätzlich zu installierender Software oder die Wiederherstellung eines funktionierenden Clients in den Ausgangszustand z.B. nach einer Laborübung, in der die Clients gezielt umkonfiguriert wurde.

Die Nutzung von LINBO erfordert die Einrichtung eines Muster-Clients. Dies erfordert nachstehende ``drei Installationsschritte``:

**Hardwareklasse erstellen**

Mittels der Hardwareklasse teilst Du LINBO mit, welche Konfiguration für die Geräte anzuwenden ist. Dies umfasst:

  * Name der Hardwareklasse

  * Allgemeine Informationen
      
     + IP des TFTP-Servers, der das Image vorhält.
     + Startoptionen des Clients
     + eventuell benötigte Kernel-Optionen für den Start-Vorgang

  * Angaben zu der Partitionierung des Clients

**Rechneraufnahme**

Bei der Rechneraufnahme legst Du fest, welche Konfigurationen für jede einzelne Arbeitsstation gelten sollen. Das sind:

  * Raum, in dem sich der Rechner befindet,
  * Name des Rechners
  * Name der Hardwareklasse, welcher der Rechner angehören soll,
  * MAC-Adresse des Rechners
  * IP-Adresse, die der Rechner erhalten soll,
  * Art des Gerätes
  * Aktivierung von LINBO

Wie Du aus den letzten beiden Punkten erkennen kannst, ist die Aktivierung von LINBO nicht für jedes Gerät zwingend notwendig. So benötigt z.B. ein Netzwerk-Drucker kein eigenes Image. Dieser benötigt nur eine IP und eine Raumzuordnung. Aber seine Aufnahme ist notwendig, damit er im Active Directory des ``Samba-Dienstes`` des linuxmuster.net Servers aufgenommen wird und somit dem System bekannt ist.

Es gibt drei Möglichkeiten die Rechneraufnahme durchzuführen. Diese findest Du im Kapitel :ref:`hardware-registration-label` ausführlich beschrieben.

**OS-Installation**

Im letzten Schritt wird nun das eigentliche Betriebssystem auf dem Muster-Client erstellt, in die Domäne eingebunden und das endgültige Image auf den linuxmuster.net Server geschrieben. Da sich das Vorgehen je nach verwendetem System unterscheidet, gehen die Unterkapitel von :ref:`client-templates-label` detailliert darauf ein.

.. toctree::
   :maxdepth: 3
   :caption: Musterclients
   :hidden:

   hardware_category/index
   hardware_registration/index
   os_installation/index

.. hint::
   Damit Clients in die Domäne aufgenommen werden können, muss auf dem Server vorher die Standard-GPO erzeugt werden. Dies ist auch ``notwendig``, wenn ausschließlich Linux-Clients eingesetzt werden.

Die Standard-GPO wird auf dem Server erzeugt durch:

.. code:: 

  # sophomorix-school --gpo-create default-school
  
Anschließend den Samba-Dienst noch neu starten:

.. code:: 

  # systemctl restart samba-ad-dc.service
  

