Installation & Konfiguration
----------------------------

Radius-Server installieren
~~~~~~~~~~~~~~~~~~~~~~~~~~

In den Paketquellen von Linuxmuster.net gibt es das Paket ``linuxmuster-freeradius``. Installieren Sie das Paket mit

.. code-block:: console

   $ apt-get install linuxmuster-freeradius


Firewall konfigurieren
~~~~~~~~~~~~~~~~~~~~~~~

Nun muss die Firewall konfiguriert werden, damit die Anfragen auch auf dem Server ankommen (UDP, Port 1182). Dazu bearbeitet man die Datei ``/etc/linuxmuster/allowed_ports`` und fügt in der Zeile "udp" den entsprechenden Port hinzu.

.. code-block:: console

   ...
   udp domain, ... , 1182

Damit die Änderungen auf der Firewall (IPFire) wirksam werden, geben Sie bitte folgenden Befehl ein:

.. code-block:: console

   $ service linuxmuster-base restart

Falls Sie eine andere Firewall als die empfohlene Firewalllösung (IPFire) verwenden, müssen Sie die entsprechende Firewallregel selbst einrichten!


Radius-Servers testen
~~~~~~~~~~~~~~~~~~~~~

In der Datei ``/etc/freeradius/users`` in der folgenden Zeile das Kommentarzeichen (``#``) entfernen.

.. code-block:: console

   steve  Cleartext-Password := "testing"

Als nächstes überprüft man, ob ``localhost`` in der Datei ``/etc/freeradius/clients`` eingetragen ist. Dieser Eintrag kann nach dem Test wieder entfernt werden.

.. code-block:: console

   client localhost {
      ipaddr = 127.0.0.1
      secret = testing123
   }

Nun kann man, nach einem Neustart des Radius-Servers, die Authentifizierung für diesen User testen.

.. code-block:: console

   $ service freeradius restart
   $ radtest steve testing 127.0.0.1:1182 10 testing123

Als Ausgabe sollte man folgendes erhalten:

.. code-block:: console

   $ radtest steve testing 127.0.0.1:1182 10 testing123
   Sending Access-Request of id 34 to 127.0.0.1 port 1182
          User-Name = "steve"
          User-Password = "testing"
          NAS-IP-Address = 127.0.0.1
          NAS-Port = 0
  rad_recv: Access-Accept packet from host 127.0.0.1 port 1182, id=34, length=20

Wenn man eine ähnliche Ausgabe erhält, kann nun der Zugriff auf das LDAP-Verzeichnis eingerichtet werden, damit man sich mit seinem Benutzernamen und Passwort der linuxmuster.net anmelden kann. Dazu muss der Client (Access Point, Captive Portal Server, Wireless Controller) in die Datei ``/etc/freeradius/clients`` eingetragen werden. Bitte passen Sie den Client Namen, die IP-Adresse und das Passwort entsprechend an.

.. code-block:: console

   client captivePortal {
      ipaddr = 10.16.1.254
      secret = geheim
   }

Radius-Server konfigurieren
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Für die Authentifizierung mit einem Radius-Server gibt es verschiedene Protokolle, welche festlegen, wie die Übertragung und Authentifizierung abläuft. Dieses kann man in der Datei ``/etc/freeradius/eap.conf`` festlegen. Überprüfen Sie folgende Einstellungen und entfernen Sie, falls notwendig, die Kommentarzeichen.

.. code-block:: console

   eap {
      ...
      default_eap_type = peap
      ...
   }

   ...
   peap {
      ...
      default_eap_type = mschapv2
      ...
   }

MD5 kommt als Protokoll nicht in Frage, da die Passwörter nicht als MD5 im LDAP gespeichert sind!

Überprüfen Sie weiterhin den Parameter ``auto_header`` in der Datei ``/etc/freeradius/radiusd.conf``.

.. code-block:: console

   pap {
      auto_header = yes
   }

