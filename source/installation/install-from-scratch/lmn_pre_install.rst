.. include:: /guided-inst.subst

.. _lmn_pre_install-label:

=============================
Server auf lmn7.1 vorbereiten
=============================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

Nachdem Du die Firewall und den Server wie beschrieben installiert hast, müssen beide Maschinen fertig konfiguriert werden. Um dieses zu vereinfachen, stellen wir Dir das Skript ``lmn71-prepare`` zur Verfügung.

Das Skript lmn71-prepare
========================

.. todo::

   Check des Repro zum Release-Datums! Anm. des Autors

Installation des Pakets ``linuxmuster-prepare``
------------------------------------------------

Wenn Du nicht mehr an Deinem Server eingeloggt bist, melde Dich erneut an.

Führe danach folgende Befehle in der Eingabekonsole aus:

.. code-block:: Bash

   wget -qO - "https://deb.linuxmuster.net/pub.gpg" | sudo apt-key add -

.. hint:: -qO --> [-][q][Großbuchstabe O]

Damit installierst Du den Key für das Repository von linuxmuster.net und aktivierst ihn.

Die nächste Zeile fügt das Linuxmuster 7.1 Repository hinzu.

.. code-block:: Bash

   sudo sh -c 'echo "deb https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'

Aktualisiere die Softwareliste des Servers mittels

.. code-block:: Bash

   sudo apt update

Damit ist die Vorbereitung abgeschlossen und Du installierst das Paket "linuxmuster-prepare".

.. code-block:: Bash

   sudo apt install linuxmuster-prepare

Nachdem Du den Befehl mit ``J`` bestätigt hast, wird das Skript lmn71-prepare auf den Server geladen, welches |...|

   - die benötigten Linuxmuster-Pakete und die benötigten anderen Pakete installiert,
   - das Betriebssystem des Servers nochmals auf den aktuellen Stand bringt,
   - das root-Passwort auf Muster! setzt,
   - das Netzwerk konfiguriert und
   - im Falle des Serverprofils das LVM eingerichtet.

.. attention:: Wichtiger Hinweis, schon jetzt! 

   Solltest Du mit Deiner Konfiguration von unseren Standard-Vorgaben bei dem zuletzt genannten Punkt abweichen, müssen Deine Einstellungen unbedingt vor dem Aufruf des Skriptes lmn71-prepare eingearbeitet sein!

   :ref:`basis_opnsense`
   
   :ref:`basis_server-label`

Letzter Test vor Anwendung des Skriptes "lmn71-prepare"
-------------------------------------------------------

Als letzte Überprüfung, bevor Du das Skript einsetzt, verbinde Dich vom Server aus mit der Firewall via ssh.

.. code-block:: Bash

   ssh root@10.0.0.254

Du solltest Dich nach der Eingabe des Passwortes ``Muster!`` auf der Konsole der OPNsense |reg| wiederfinden. Eventuell musst Du auch vorher deren Key akzeptieren. Mit ``0`` solltest Du Dich wieder ausloggen und zurück auf der Server-Konsole sein.

Sollte dieser Test erfolgreich sein, steht der abschließenden Vorbereitung nichts mehr im Wege:

Aufruf lmn71-prepare
--------------------

Wechsele Deinen Log-in und werde ``root``:

.. code-block:: Bash
 
   sudo -i

Für die weitere Konfiguration nutzt Du unser lmn71-prepare Script. Hilfe erhältst Du mittels

.. code-block:: Bash

   lmn71-prepare -h

Hier ein Auszug mit den benötigten Optionen, die Du gleich anwenden wirst.

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

#####

Installation mit unseren Standard-Vorgaben
------------------------------------------

.. code-block:: Bash

   lmn71-prepare -i -p server

.. Jetzt ist es an der Zeit, dass Du Dich zurücklehnst und den Verlauf beobachtest.

.. Nach dem das Skript abgearbeitet ist, steht dem :ref:`setup-label` nichst mehr im Wege.

#####

Installation mit Deinen Vorgaben:
---------------------------------

.. code-block:: Bash

   lmn71-prepare -i -x -p server

#####

Ausgaben des Befehls und Deine Eingaben
---------------------------------------

.. hint:: Im Folgenden beschreiben wir die Eingaben für unsere Standard-Vorgaben. In der Regel kannst Du diese einfach mit ``Enter`` übernehmen. Wo Eingaben nötig bzw. Anpassungen möglich sind, erhältst Du nachstehend einen Hinweis.

Du hast das Skript aufgerufen und erhältst folgende Ausgabe:

.. code-block:: Bash

   ### lmn71-prepare
   ## Force is given, skipping test for configured system.
   ## Profile
   Enter host profile [server, ubuntu] [server]:

Das vorausgewählte Profil `server` kannst Du mit ``[ENTER]`` übernehmen, da Du ja den Server einrichten willst.

#####

.. code-block:: Bash

   ## Network
   Enter network interface to use ['ens18']:

Das Netzwerk-Interface sollte richtig erkannt sein, da Du ja nur eines für den Server eingerichtet hast. Also wieder mit ``[ENTER]`` bestätigen.

#####

.. code-block:: Bash

   Enter ip address with net or bitmask [10.0.0.1/16]:

.. hint:: An dieser Stelle ist die Eingabe eines abweichenden Netzwerk-Bereichs möglich, dafür müsstest Du den IP-Bereich und die zu verwendende Netzwerkmaske eingeben. Gibst Du keine ein, übernimmst Du mit ``[ENTER]`` unsere Standard-Vorgabe, wie angezeigt.

#####

.. code-block:: Bash

   Enter firewall ip address [10.0.0.254]:

Die Adresse der Firewall wird automatisch Deiner zuvor gemachten Eingabe angepasst. 

.. hint:: Alternativ könntest Du sie anpassen, wenn die Firewall eine andere als die angezeigte haben sollte.

#####

.. code-block:: Bash

   Enter gateway ip address [10.0.0.254]:

Auch die Adresse des Gateways sollte automatisch angepasst sein.

.. hint:: Ansonsten müsstest Du hier nochmals tätig werden.

#####

.. code-block:: Bash

   Enter hostname [server]: 

Auch hier gilt Übernahme der Vorgabe mit ``[ENTER]``.

.. hint:: Änderungen möglich.

#####

.. code-block:: Bash

   Enter domainname [linuxmuster.lan]:

.. hint:: Auch hier ist eine individuelle Anpassung möglich, wenn Du nicht unsere Standard-Vorgabe nutzen willst. Dabei gilt aber zu beachten, dass |...|

.. attention:: 

   |...| die Länge des ersten Teils der Domäne maximal 15 Zeichen betragen darf.
  
   Die Domäne „muster-gymnasium.de“ überschreitet diese Grenze um ein Zeichen, da „muster-gymnasium“ 16 Zeichen lang ist.

   Eine gute Wahl ist beispielsweise ``linuxmuster.lan``!

#####

.. code-block:: Bash

   Enter physical device to use for LVM []: /dev/sdb

Für die Verwendung unserer Vorgaben musst Du den Speicherort für das LVM angeben. Die benötigte Eingaben hast Du zuvor ja ermittelt.

Falls nicht, kannst Du dies hier :ref:`lsblk-command` nachlesen.

Nachstehend erfolgt die Angabe beispielhaft für die zweite erkannte Festplatte:

.. code::

   /dev/sdb

.. hint:: Bei anderen Partitionsgrößen hast Du das LVM bei der Ubuntu-Servers-Installation angelegt. Um es zu verwenden, musst Du an dieser Stelle einfach nur die ``[Enter]``-Taste drücken. Die bei Aufruf des Installationsscripts übergebene Option ``-x`` veranlasst, dass es so übernommen wird.

#####

Jetzt ist es an der Zeit, dass Du Dich zurücklehnst und den Verlauf beobachtest.

Nachdem das Skript abgearbeitet ist, steht dem :ref:`setup-label` nichts mehr im Wege.
