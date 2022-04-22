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

Wenn du nicht mehr an deinem Server eingeloggt bist, melde dich erneut an.

Führe danach folgende Befehle in der Eingabekonsole aus:

.. code::

   wget -qO - "https://deb.linuxmuster.net/pub.gpg" | sudo apt-key add -

.. hint:: -qO --> [-][q][Großbuchstabe O]

Damit installierst du den Key für das Repository von linuxmuster.net und aktivierst ihn.
Die nächste Zeile fügt das linuxmuster 7.1 Repository hinzu. 

.. code::

   sudo sh -c 'echo "deb https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'

Aktualisiere die Softwareliste des Servers mittels

.. code::
   
   sudo apt update

Damit ist die Vorbereitung abgeschlossen und du startest mit der Installation.

.. code::
   
   sudo apt install linuxmuster-prepare

Nachdem du den Befehl mit ``J`` bestätigt hast, lädt er das Skript lmn71-prepare auf den Server, dass |...|

   - die benötigten linuxmuster-Pakete und die von ihnen benötigten anderen Pakete installiert,
   - das Betriebssystem des Servers nochmals auf den aktuellen Stand bringt,
   - das root-Passwort auf Muster! setzt und
   - das Netzwerk konfiguriert,
   - im Falle des Serverprofils das LVM einrichtet.

.. attention:: Wichtgier Hinweis, schon jetzt! Solltest du mit deiner Konfiguration von unseren Vorgaben bei den beiden zuletzt genannten Punkten abweichen, müssen deine Einstellungen unbedingt vor dem Aufruf des Skiptes lmn71-prepare gemäß der Anleitung eingearbeitet sein!

Als letzte Überprüfung bevor du das Skript einsetzt, verbinde dich vom Server aus mit der Firewall via ssh.

.. code::

   ssh root@10.0.0.254

Du solltest dich danach auf den Konsole der OPNsense |reg| wiederfinden. Eventuell musst du auch vorher deren Key akzeptieren. Mit ``0`` solltest du dich wieder ausloggen und zurück auf der Server-Konsole sein.

Sollte dieser Test erfolgreich sein, steht der abschließenden Vorbereitung nichts mehr im Wege:

Wechsele deinen Login und werde ``root``:

.. code::
 
   sudo -i

Für die weitere Konfiguration nutzt du unser lmn71-prepare Script. Hilfe erhälst du mittels

.. code::

   lmn-prepare -h

Hier ein Auszug mit denen benötigten Optionen die du gleich anwenden wirst.

.. code::

   Usage: lmn71-prepare [options]

   [options] are:

   -x, --force                 : Force run on an already configured system.
   -i, --initial               : Prepare the appliance initially for rollout.
   -s, --setup                 : Further appliance setup (network, swapsize).
                                 Note: You have to use either -i or -s.
   -t, --hostname=<hostname>   : Hostname to apply (optional, works only with
                                 server profile).
   -n, --ipnet=<ip/bitmask>    : Ip address and bitmask assigned to the host
                                 (optional, default is 10.0.0.x/16, depending
   ...                            on the profile).
   -p, --profile=<profile>     : Host profile to apply, mandatory. Expected
   ...                           values are "server" or "ubuntu".
                                 Profile name is also used as hostname, except for
                                 "server" if set with -t.
   -c, --createcert            : Create self signed server cert (to be used only
                                 in setup mode and with ubuntu profile).
   -l, --pvdevice=<device>     : Initially sets up lmv on the given device
                                 (server profile only).
   -f, --firewall=<ip>         : Firewall ip address (default *.*.*.254).
   -g, --gateway=<ip>          : Gateway ip address (default is firewall ip).
   -d, --domain=<domainname>   : Domainname (default linuxmuster.lan).
   -r, --serverip=<serverip>   : Ip address of the server (unattended mode only).
   -w, --swapsize=<size>       : Swapfile size in GB (default "2").
   -a, --rootpw=<password>     : Set root password (only with -s).
   -b, --reboot                : Reboots finally (only in unattended mode).
   ...
   -u, --unattended            : Unattended mode, do not ask, use defaults.
   -e, --default               : Sets default (10.0.0.0/16) network addresses,
                                 triggers setup and unattended modes, needs profile
                                 (uses saved profile from initial run).
   -o, --do-it-like-babo       : Like above, but uses babo (10.16.0.0/12) network
                                 addresses.
   -j, --no-keys               : Do not create ssh keys
                                 (only in setup mode and together with -x).
   -k, --no-pw                 : Do not set admin password
                                 (only in setup mode and together with -x).
   -h, --help                  : Print this help.
   


Installation mit unseren Standardvorgaben

.. code::

   lmn71-prepare -i -u -p server

Jetzt ist es an der Zeit, dass du dich zurücklehnst und den Verlauf beobachtest.
Nach dem das Skript abgearbeitet ist, steht dem :ref:`setup-label` nichst mehr im Wege.

#####

Installation mit deinen Vorgaben:

.. code::

   lmn71-prepare -i -x -p server

Ausgabe des Befehls und deine Eingaben

.. code::

   ### lmn71-prepare
   ## Force is given, skipping test for configured system.
   ## Profile
   Enter host profile [server, ubuntu] [server]: [ENTER]

   ## Network
   Enter network interface to use ['ens18']: [ENTER]

   Enter ip address with net or bitmask [10.0.0.1/16]: [ENTER]
  alternative Eingabe möglich

   Enter firewall ip address [10.112.0.254]:
  wird automatisch angepasst
   Enter hostname [server]: [ENTER]

   Enter domainname [linuxmuster.lan]: verw-gymlue.lan
  deine Wahl
   Enter physical device to use for LVM []: [ENTER]
  Hier einfach Enter übernimmt die von dir gemachten LVMs

#####

.. todo:: Nächstes Kapitel: Anpassung der Netze! LVM weiter unten: verwirrt.

.. todo:: Ab hier ???? Anfrage bei den Entwicklern läuft ob das überhaupt möglich ist.

Installation mit deinem vorbereiteten LVM

Hast du nicht wie zuvor beschreiben bereits ein LVM auf dem Server eingerichtet und dieses bereits gemountet, dann gibst du zur Installation    
   folgendes an: ``./lmn71-prepare -p server -l /dev/sdb`` aus. Hierbei wird auf dem angegebenen Device (hier also 2. Festplatte) ein LVM eingerichtet.

Für weitere Hinweise zum linuxmuster-prepare Skript siehe: https://github.com/linuxmuster/linuxmuster-prepare
