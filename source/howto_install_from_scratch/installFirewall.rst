Installation und Konfiguration der Firewall
===========================================

Linuxmuster.net nutzt `IPFire <http://ipfire.org>`_ als Firewall-Lösung. Bevor Sie also linuxmuster.net benutzen können, muss zuerst die Firewall installiert werden.

Installation
------------

Installieren Sie IPFire `wie im Wiki <http://wiki.ipfire.org/en/installation/start>`_ beschrieben.

.. hint::

   - Es müssen ein IPFire-Root-Passwort und ein Admin-Passwort (z.B. für den Webzugang) vergeben werden. Das Admin-Passwort kann jederzeit geändert werden.

   - Das zu vergebende Passwort für „root“ muss man sich merken, denn es wird beim Setup der linuxmuster.net Pakete abgefragt. Sobald der passwortlose Zugang zum Firewall-Rechner eingerichtet ist, kann man das root-Passwort von ipfire auch jederzeit ändern.

Folgende Punkte sollten bei der Installation berücksichtigt werden:

- Es empfiehlt sich, den Hostnamen schon auf ``ipfire`` einzustellen.

- Wählen Sie bei Typ der Netzwerkkonfiguration **GREEN + RED + BLUE** aus.

  .. important:: linuxmuster.net 6.2 setzt drei Netzwerke auf der IPFire-Firewall voraus. Stellen Sie also sicher, dass der Rechner, auf dem Sie installieren, drei Netzwerkkarten hat. Bei Installation in virtuellen Umgebungen müssen Sie drei virtuelle Netzwerkadapter definieren auch wenn Sie das blaue Netz nicht nutzen (vgl. Einrichten der Netzwerkbrücken unter Xen-Virtualisierung). Ordnen Sie in diesem Fall dem dritten Adapter einfach ein nicht genutztes Netz zu.

- Das externe Netzwerkadapter (ROT) konfigurieren Sie entsprechend Ihrer Internetanbindung (IP, Netmask, DNS und Gateway/DHCP).

- GRÜN (internes Interface): IP-Adresse ``10.16.1.254`` [#]_ mit der Netzmaske ``255.240.0.0``.

- BLAU (WLAN-Interface): IP-Adresse ``172.16.16.254`` mit Netzmaske: ``255.255.255.0``.

- ORANGE (DMZ-Interface, optional): Falls „GREEN + RED + ORANGE + BLUE“ gewählt wurde, vergeben Sie schließlich die Adresse ``172.16.17.254`` mit der Netzmaske: ``255.255.255.0``.

- Aktivieren Sie nicht den DHCP-Dienst für das GRÜNE Netzwerk!

.. [#] Sie können auch andere IP-Bereiche vergeben. Lesen Sie dazu die Hinweise zu internen IP-Adressen in linuxmuster.net

Konfiguration
-------------

Nach erfolgreicher Installation der Firewall muss für die linuxmuster.net-spezifische Konfiguration

- der SSH-Dienst und
- der Proxyzugriff für den Server

aktiviert werden, damit in den nächsten Installationsschritten der linuxmuster.net-Server die weitere Konfiguration der Firewall übernehmen kann.

Sie können die notwendigen Einstellungen entweder über das Webinterface oder auf der Konsole des IPFire vornehmen.

SSH-Dienst aktivieren
`````````````````````

Webinterface
''''''''''''

Verbinden Sie den internen Netzwerkadapter (GRÜN) der IPFire-Firewall sowie einen weiteren Rechner, dessen Netzwerkadapter Sie mit einer statischen IP aus dem linuxmuster.net-Netz (z.B. 10.16.1.4 mit Netzmaske 255.240.0.0) versehen, mit dem LAN-Switch. Nun erreichen Sie mit einem Browser die Administrationsoberfläche des IPFire unter der URL https://10.16.1.254:444. Loggen Sie sich als Benutzer ``admin`` ein.

Setzen Sie auf der Konfigurationsseite für den SSH-Dienst (unter System | SSH-Zugriff) Häkchen bei:

- SSH-Zugriff,
- Passwortbasierte Authentifizierung zulassen und
- Authentifizierung auf Basis öffentlicher Schlüssel zulassen.

.. image:: media/ipfire-ssh-access.png
   :alt: Ipfire SHH Access
   :align: center

.. important:: Vergessen Sie nicht die Änderungen durch Betätigen der Schaltfläche Speichern dauerhaft ins System zu übernehmen.

.. caution:: Ändern Sie nicht den voreingestellten Port 222, da sonst der linuxmuster.net-Server den IPFire nicht mehr erreichen kann.

IPFire-Konsole
''''''''''''''

Alternativ kann man den SSH-Zugriff auch direkt auf der Kommandozeile des IPFire-Rechners aktivieren, damit entfällt die Konfiguration eines weiteren Rechners mit einer IP des künftigen grünen Netzes.

Dazu bearbeitet man die Datei ``/var/ipfire/remote/settings``, sodass diese den folgenden Inhalt hat:

.. code:: bash

   ENABLE_SSH_KEYS=on
   ENABLE_SSH_PASSWORDS=on
   ENABLE_SSH_PORTFW=off
   ENABLE_SSH=on

Außerdem legt man mit den Befehlen

.. code-block:: console

   $ touch /var/ipfire/remote/enablessh
   $ chown nobody:nobody /var/ipfire/remote/enablessh

die Datei enablessh an, damit der SSH-Dienst gestartet werden kann. Der Befehl

.. code-block:: console

   $ /etc/rc.d/init.d/sshd restart

startet den Dienst schließlich, was auf der Konsole mit einem [OK] quittiert wird.

Proxy-Zugriff für den Server aktivieren
```````````````````````````````````````

Webinterface
''''''''''''

Tragen Sie auf der Webproxy-Konfigurationsseite des IPFire (unter Netzwerk | Webproxy) im Abschnitt `Netzwerkbasierte Zugriffskontrolle` im Eingabefeld unterhalb von `Uneingeschränkte IP-Adressen` (eine pro Zeile) die IP-Adresse des Servers ein. Betätigen Sie danach die Schaltfläche Speichern und Neustart auf der Seite unten.

IPFire-Konsole
''''''''''''''

Alternativ kann man die IP-Adresse auch von Hand in die Datei ``/var/ipfire/proxy/advanced/acls/src_unrestricted_ip.acl`` eintragen. Dazu wird zunächst der Ordner ``acls`` angelegt

.. code-block:: console

   mkdir /var/ipfire/proxy/advanced/acls
   chown nobody:nobody /var/ipfire/proxy/advanced/acls

und in diesem Ordner die Datei ``src_unrestricted_ip.acl`` erzeugt.

.. code-block:: console

   touch /var/ipfire/proxy/advanced/acls/src_unrestricted_ip.acl
   chown nobody:nobody /var/ipfire/proxy/advanced/acls/src_unrestricted_ip.acl

In die erstellte Datei wird die IP des Servers eingetragen (z.B. 10.16.1.1). Danach muss der Webproxy-Dienst neu gestartet werden:

.. code-block:: console

   /etc/rc.d/init.d/squid restart

Jetzt ist das Firewallsystem soweit vorkonfiguriert, dass Sie den linuxmuster.net-Server installieren können.

.. hint::
   Werden in der Weboberfläche des IPFire Aktualisierungen gemeldet, dann können sie eingespielt werden! Lesen Sie dazu das Kapitel IPFire aktualisieren.
