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

Nachdem du die Firewall und den Server wie beschrieben installiert hast, müssen beide Maschinen fertig konfiguriert werden. Um dieses zu vereinfachen stellen wir dir das Skript ``lmn71-prepare`` zur Verfügung.

Das Skript lmn71-prepare
========================

.. todo:: 
   
   Check des Repros zum Release-Datums! Anm. des Autors

Wenn du nicht mehr an deinem Server eingeloggt bist, melde dich erneut an und werde root mit ``sudo -i``.

Führe danach folgende Befehle in der Eingabekonsole aus:

.. code::

   wget -qO - "https://deb.linuxmuster.net/pub.gpg" | sudo apt-key add -

.. hint:: -qO --> [-][q][Großbuchstabe O]

Damit installierst du den Key für das Repository von linuxmuster.net und aktivierst ihn

.. code::

   sudo sh -c 'echo "deb https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'
   sudo apt update
   sudo apt dist-upgrade

Die erste Zeile fügt das linuxmuster 7.1 Repository hinzu. Die nächsten beiden aktualisieren die Softwareliste des Servers und bringen des System auf den aktuellen Stand.

.. code::
   
   sudo apt install linuxmuster-prepare

Lädt das Skript lmn71-prepare auf den Server, dass |...|

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

Installation mit unseren Standardvorgaben

.. code::

   lmn71-prepare -i -u -p server

Nach dem das Skript abgearbeitet ist, es dauert schon eine Weile, steht dem Setup nicht mehr im Wege:
:ref:`setup-label`

.. todo:: Nächstes Kapitel: Anpassung der Netze! LVM weiter unten: verwirrt.

.. todo:: Ab hier ???? Anfrage bei den Entwicklern läuft ob das überhaupt möglich ist.

Installation mit deinem vorbereiteten LVM

Hast du nicht wie zuvor beschreiben bereits ein LVM auf dem Server eingerichtet und dieses bereits gemountet, dann gibst du zur Installation    
   folgendes an: ``./lmn71-prepare -p server -l /dev/sdb`` aus. Hierbei wird auf dem angegebenen Device (hier also 2. Festplatte) ein LVM eingerichtet.

Für weitere Hinweise zum linuxmuster-prepare Skript siehe: https://github.com/linuxmuster/linuxmuster-prepare