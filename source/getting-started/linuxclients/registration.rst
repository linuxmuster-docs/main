Computer in Netzwerk aufnehmen
==============================

Neue Rechner werden durch direkten Eintrag in die Datei
``/etc/linuxmuster/workstations`` und anschließendem Aufruf von
``import_workstations`` aufgenommen.

Ermitteln Sie die MAC-Adresse des ersten Clients, z.B. indem Sie den
Client per PXE booten.

.. image:: ../../clients/windows10clients/media/registration/linbo-empty-startpage.png

Lesen Sie die "MAC-Adresse" im LINBO-Startbildschirm ab.

Öffnen Sie die Datei ``/etc/linuxmuster/workstations`` auf dem Server.

.. code-block:: console

   server ~ # nano /etc/linuxmuster/workstations

Tragen Sie dort den Rechner ein mit folgender Syntax

.. code-block:: bash

   Raum;Rechnername;Gruppe;MAC;IP;;;;;;PXE-Flag;

Raum
  Geben Sie hier den Namen des Raums (z.B. r100 oder g1r100)
  ein. Beachten Sie bitte, dass die Bezeichnung des Raumes oder auch
  des Gebäudes mit einem Kleinbuchstaben beginnen muss. Sonderzeichen
  sind nicht erlaubt.

Rechnername 
  z.B. in der Form r100-pc01 (max. 15 Zeichen), (evtl. Gebäude
  berücksichtigen g21r100-pc01) eingeben. Beachten Sie bitte, dass als
  Zeichen nur Buchstaben und Zahlen erlaubt sind. Als Trennzeichen
  darf nur das Minus-Zeichen ``-`` verwendet werden. Leerzeichen,
  Unterstriche oder andere Sonderzeichen (wie z.B. Umlaute, ß oder
  Satzzeichen) dürfen Sie hier unter keinen Umständen verwenden.

IP Adresse  
  Die IP-Adresse sollte zum Raum passen und **muss** außerhalb des
  Bereichs für die Rechneraufnahme liegen. Abhängig von Ihren
  Netzdaten z.B. 10.16.100.1 für diesen PC eingeben, üblicherweise
  **nicht** zwischen 10.16.1.100 und 10.16.1.200 (Bereich für die
  Rechneraufnahme).  

Rechnergruppe 
  In der Rechnergruppe, bspw. `xenial` werden mehrere (idealerweise
  alle) ähnlichen Rechner zusammengefasst, die eine (nahezu)
  identische Konfiguration bekommen. 

Beispielkonfiguration.

.. code-block:: bash

   r100;r100-pc01;xenial;08:00:27:57:1D:C5;10.16.100.1;;;;;;1;

Der registrierte Client wird nun mit dem Konsolenbefehl

.. code-block:: console

   server ~# import_workstations

ins System aufgenommen und der Rechnergruppe `xenial` zugewiesen. Wenn
Sie mit dem zuvor heruntergeladenen Standard-Linuxclient eine
Rechnergruppe `xenial` erstellt haben, kann nun der Rechner fertig
eingerichtet werden.
