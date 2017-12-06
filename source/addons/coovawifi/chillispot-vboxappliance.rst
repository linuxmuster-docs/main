{{tag> }} {{indexmenu_n>530}}

linuxmuster-chilli Virtual Appliance
====================================

Die im Torrent {{:torrentfiles:coovachilli-ova.torrent|}} enthaltene
OVA-Datei enthält eine virtuelle Appliance, auf der die komplette
linuxmuster-chilli Umgebung bereits vorinstalliert ist.

Inbetriebnahme
--------------

Auspacken der Appliance
~~~~~~~~~~~~~~~~~~~~~~~

Die Appliance kann problemlos mit Virtualbox geöffnet werden. Der
neuralgische Punkt ist die Konfiguration der Netzwerkkarten für die
virtuelle Maschine.

Konfiguration
~~~~~~~~~~~~~

Die Anmeldedaten für die Appliance sind

::

    Benutzer: coovaadmin
    Passwort: muster

Nach der ersten Anmeldung muss der Befehl

::

    linuxmuster-chilli-turnkey

ausgeführt werden. Dabei wird das Passwort des administrativen Benutzers
*coovaadmin* geändert und ein neues SSL Zertifikat für den apache
Webserver erzeugt. Anschließend wird CoovaChilli interaktiv für die
Arbeit in der linuxmuster.net-Umgebung konfiguriert. `Details hierzu
finden sich in der konfigurationsanleitung für
linuxmuster-chilli <.chillispot.konfiguration>`__.

{{page>..:navmenu&nofooter&noindent}} ``<menu col=3,align="center">``
``<item>``\ Zurück...||.:chillispot.chilliipfireconfig_blau|dokumentation:handbuch:icons:doc-go-previous.png\ ``</item>``
``<item>``\ Inhaltsverzeichnis|des
Handbuchs|..:start|dokumentation:handbuch:icons:doc-go-home.png\ ``</item>``
``<item>``\ Weiter...||.:chillispot.installation|dokumentation:handbuch:icons:doc-go-next.png\ ``</item>``
``</menu>``
