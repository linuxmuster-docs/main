.. |zB| unicode:: z. U+00A0 B. .. Zum Beispiel 
  
.. |ua| unicode:: u. U+00A0 a. .. und andere

.. |_| unicode:: U+202F .. geschütztes Leerzeichen
   :trim:

.. |...| unicode:: U+2026 .. Auslassungszeichen
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. include:: /guided-inst.subst

.. _lmn_pre_install-label:

=============================
Server auf lmn7.1 vorbereiten
=============================

Nachdem du ``from scratch`` installiert hast, musst du vorab mit dem Skript ``lmn71-appliance`` den soeben installierten und vorbereiteten Ubuntu-Server vor dem ersten Setup für linuxmuster v7.1 vorbereiten.

.. hint::
   
   Die Anpassung des Netzbereichs / des Profils ist vor Aufruf des eigentlichen Setups auszuführen.

Das Skript lmn71-appliance
--------------------------

Das Skript lmn71-appliance ...

- bringt das Betriebssystem auf den aktuellen Stand,
- installiert das Paket linuxmuster-prepare und
- startet dann das Vorbereitungsskript linuxmuster-prepare,
- das die für das jeweilige Appliance-Profil benötigten Pakete installiert,
- das Netzwerk konfiguriert,
- das root-Passwort auf Muster! setzt und
- im Falle des Serverprofils LVM einrichtet.

Melde dich am neu installierten Ubuntu 18.04 Server an und werde root mit ``sudo -i``.
Führe danach folgende Befehle in der Eingabekonsole aus:

.. code::

   sudo sh -c 'echo "deb https://deb.linuxmuster.net/ lmn71 main" > /etc/apt/sources.list.d/lmn71.list'
   sudo apt-get update
   sudo apt-get dist-upgrade

.. todo:: Check des Repros bei Release

.. code::
   
   # wget https://raw.githubusercontent.com/linuxmuster/linuxmuster-prepare/master/lmn71-appliance
   # chmod +x lmn71-appliance
   # ./lmn71-appliance -p server -u

.. hint:: 
 bei Release

   
   Hast du nicht wie zuvor beschreiben bereits ein LVM auf dem Server eingerichtet und dieses bereits gemountet, dann gibst du zur Installation    
   folgendes an: ``./lmn71-appliance -p server -l /dev/sdb`` aus. Hierbei wird auf dem angegebenen Device (hier also 2. Festplatte) ein LVM eingerichtet.


Für weitere Hinweise zum linuxmuster-prepare Skript siehe: https://github.com/linuxmuster/linuxmuster-prepare

.. todo:: Überprüfen ob der nächste momentan kommentierte Absatz raus kann. siehe auch https://ask.linuxmuster.net/t/lmn-7-1-linuxmuster-prepare-webui-laeuft-nicht/8655/13?u=machtdochnix

.. Fahre den Server herunter und erstelle einen Snapshot in der Virtualisierungsumgebung. Starte danach den server wieder und führe dann das Setup für die lmn v7.1 aus.


Paketquellen lmn71
------------------

Die Paketquellen, die für die lmn71 eingebunden werden müssen, werden von o.g. Skript lmn71-applicance bereits korrekt eingetragen.
Es wurden somit in den Paketquellen die ``linuxmuster.net sources`` eingetragen und der Schlüssel des Paketserver importiert.

Solltest du diesen Vorgang manuell durchführen müssen, gehst du wie folgt vor:

* Zunächst wirst du wieder root mit ``sudo -i``.
* Dann lädst du den key für das repository für lmn71 mit ``wget -qO - "https://deb.linuxmuster.net/pub.gpg" | sudo apt-key add -`` herunter.
* Jetzt fügst du das linuxmuster 7.1 repository hinzu und aktualisierst: 

.. todo:: Verbindungscheck zur OPNsense einfügen
   
   ssh root@opnsense

   Key akzeptieren

