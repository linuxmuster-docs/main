.. |zB| unicode:: z. U+00A0 B. .. Zum Beispiel 
  
.. |ua| unicode:: u. U+00A0 a. .. und andere

.. |_| unicode:: U+202F .. geschütztes Leerzeichen
   :trim:

.. |...| unicode:: U+2026 .. Auslassungszeichen

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. include:: /guided-inst.subst

.. _lmn_pre_install-label:

=============================
Server auf lmn7.1 vorbereiten
=============================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

Nachdem du die Firewall und den Server wie beschrieben installiert hast, müssen beide Maschinen fertig konfiguriert werden. Um dieses zu vereinfachen stellen wir dir das Skript ``lmn71-prepare`` zur Verfügung.

Das Skript lmn71-prepare
========================

.. todo:: 
   
   Check des Repros zum Release-Datums! Anm. des Autors

Installtions des Pakets ``linuxmuster-prepare``
-----------------------------------------------

Wenn du nicht mehr an deinem Server eingeloggt bist, melde dich erneut an.

Führe danach folgende Befehle in der Eingabekonsole aus:

.. code-block:: Bash

   wget -qO - "https://deb.linuxmuster.net/pub.gpg" | sudo apt-key add -

.. hint:: -qO --> [-][q][Großbuchstabe O]

Damit installierst du den Key für das Repository von linuxmuster.net und aktivierst ihn.
Die nächste Zeile fügt das linuxmuster 7.1 Repository hinzu. 

.. code-block:: Bash

   sudo sh -c 'echo "deb https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'

Aktualisiere die Softwareliste des Servers mittels

.. code-block:: Bash
   
   sudo apt update

Damit ist die Vorbereitung abgeschlossen und du installierst das Paket "linuxmuster-prepare".

.. code-block:: Bash
   
   sudo apt install linuxmuster-prepare

Nachdem du den Befehl mit ``J`` bestätigt hast, lädt er das Skript lmn71-prepare auf den Server, dass |...|

   - die benötigten linuxmuster-Pakete und die von ihnen benötigten anderen Pakete installiert,
   - das Betriebssystem des Servers nochmals auf den aktuellen Stand bringt,
   - das root-Passwort auf Muster! setzt und
   - das Netzwerk konfiguriert,
   - im Falle des Serverprofils das LVM einrichtet.

.. attention:: Wichtiger Hinweis, schon jetzt! 

   Solltest du mit deiner Konfiguration von unseren Standard-Vorgaben bei dem zuletzt genannten Punkt abweichen, müssen deine Einstellungen unbedingt vor dem Aufruf des Skiptes lmn71-prepare eingearbeitet sein!

   :ref:`basis_opnsense`
   
   :ref:`basis_server-label`

Letzter Test vor Anwendung des Skriptes "lmn71-prepare"
-------------------------------------------------------

Als letzte Überprüfung bevor du das Skript einsetzt, verbinde dich vom Server aus mit der Firewall via ssh.

.. code-block:: Bash

   ssh root@10.0.0.254

Du solltest dich nach der Eingabe des Passwortes ``Muster!`` auf den Konsole der OPNsense |reg| wiederfinden. Eventuell musst du auch vorher deren Key akzeptieren. Mit ``0`` solltest du dich wieder ausloggen und zurück auf der Server-Konsole sein.

Sollte dieser Test erfolgreich sein, steht der abschließenden Vorbereitung nichts mehr im Wege:

Aufruf lmn71-prepare
--------------------

Wechsele deinen Login und werde ``root``:

.. code-block:: Bash
 
   sudo -i

Für die weitere Konfiguration nutzt du unser lmn71-prepare Script. Hilfe erhälst du mittels

.. code-block:: Bash

   lmn71-prepare -h

Hier ein Auszug mit den benötigten Optionen die du gleich anwenden wirst.

.. code-block:: Bash

   Usage: lmn71-prepare [options]

   [options] are:

   -x, --force                 : Force run on an already configured system.
   -i, --initial               : Prepare the appliance initially for rollout.
   -s, --setup                 : Further appliance setup (network, swapsize).
                                 on the profile).
   |...|
   -p, --profile=<profile>     : Host profile to apply, mandatory. Expected
                                 values are "server" or "ubuntu".
   |...|
   -u, --unattended            : Unattended mode, do not ask, use defaults.
   |...|

#####

Installation mit unseren Standardvorgaben
-----------------------------------------

.. code-block:: Bash

   lmn71-prepare -i -u -p server

Jetzt ist es an der Zeit, dass du dich zurücklehnst und den Verlauf beobachtest.

Nach dem das Skript abgearbeitet ist, steht dem :ref:`setup-label` nichst mehr im Wege.

#####

Installation mit deinen Vorgaben:
---------------------------------

.. code-block:: Bash

   lmn71-prepare -i -x -p server

Ausgabe des Befehls und deine Eingaben

.. code-block:: Bash

   ### lmn71-prepare
   ## Force is given, skipping test for configured system.
   ## Profile
   Enter host profile [server, ubuntu] [server]:

Das vorausgewählte Profile "server" kannst du mit ``[ENTER]`` übernehmen, da du ja den Server einrichten willst.

.. code-block:: Bash

   ## Network
   Enter network interface to use ['ens18']:
  
Das Netzwerk-Interface sollte richtig erkannt sein, da du ja nur eines für den Server eingerichtet hast. Also wieder mit ``[ENTER]`` bestätigen.

.. code-block:: Bash

   Enter ip address with net or bitmask [10.0.0.1/16]: 10.112.0.1/16
  
An dieser Stelle ist die Eingabe eines abweichenden Netzwerk-Bereichs möglich, dafür müsstest du den IP-Bereich und die zuverwendente Netzwerkmaske eingeben. Hier im Beispiel mit 10.112.0.0/16 gezeigt. Gibst du keine ein, übernimmst du unsere Standardvorgabe wie angezeigt mit `` [ENTER]``

.. code-block:: Bash

   Enter firewall ip address [10.112.0.254]:

Die Adresse der Firewall wird automatisch deiner zuvor gemachten Eingabe angepasst. Alternativ könntest du sie anpassen, wenn die Firewall eine andere als die angezeigte haben sollte. Weiter mit ``[ENTER]`` 

.. code-block:: Bash

   Enter hostname [server]: 

Auch hier gilt Übernahme der Vorgabe mit ``[ENTER]``, Änderungen möglich.

.. code-block:: Bash

   Enter domainname [linuxmuster.lan]:

Auch hier sind idivuelle Anpassung möglich, wenn du nicht unsere Standardvorgabe nutzen willst. Dabei gilt aber zu beachten das ...

.. todo:: Hint-Box mit Anmerkungen zu dem Namensraum ergänzen

.. code-block:: Bash

   Enter physical device to use for LVM []: [ENTER]

Da du das LVM, wie von dir zuvor bei der Ubuntu-Servers-Installation festgelegt, verwenden willst musst du an dieser Stelle einfach nur die ``[Enter]``-Taste drücken. Die bei Aufruf des Installationsscripts übergebene Option ``-x`` veranlasst, dass es so eingerichtet wird.

#####

Jetzt ist es an der Zeit, dass du dich zurücklehnst und den Verlauf beobachtest.

Nach dem das Skript abgearbeitet ist, steht dem :ref:`setup-label` nichst mehr im Wege.
