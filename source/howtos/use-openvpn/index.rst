OpenVPN nutzen
==============

Um auf den linuxmuster.net Server von außen zuzugreifen, können Sie eine VPN-Verbindung herstellen. Diese ermöglicht es, eine verschlüsselte Verbindung zum Server aufzubauen.

Hierzu hat der Netzwerkbetreuer auf dem IPFire-Server bereits den OpenVPN-Server aktiviert. 

Ob dies so ist, können Sie selbst in der Schulkonsole kontrollieren. 

VPN-Zertifikat erstellen
------------------------

Melden Sie sich an der Schulkonsole an und gehen Sie mit der Bildlaufleiste zum Ende der Übersichtseite Ihres Kontos zum Bereich `OpenVPN-Zertifikat`. 

Sehen Sie nachstehende Eingabemöglichkeit, 

.. image:: media/create-vpn-certificate.png

so erstellen Sie für sich ein OpenVPN-Zertifikat, indem Sie ein Kennwort für das Zertifikat festlegen. Bestätigen Sie dieses Kennwort in der darunter liegenden Zeile und klicken Sie dann den Button `Zertifikat erstellen und herunterladen`.

Danach erhalten Sie die Bestätigung, dass das Zertifikat für Sie erstellt wurde:

.. image:: media/creation-vpn-certificate-validated-1.png

.. image:: media/creation-vpn-certificate-validated-2.png

Die Dateien des Zertifikates finden Sich nun in Ihrem Home-Laufwerk im Verzeichnis `OpenVPN`.

.. image:: media/openvpn-directory-certificate-files.png

Laden Sie diese Dateien herunter. Sie benötigen diese zur Nutzung Ihres VPN-Clients.
Haben Sie Zertifikate für sich erstellt, müssen Sie Ihren Administrator bitten, diese noch zu aktivieren.

VPN-Client einrichten
---------------------

Haben Sie sich die Schlüssel- und Konfigurationsdateien heruntergeladen, benötigen Sie noch eine Client- Software für den Zugriff via OpenVPN.

Windows-Clients
^^^^^^^^^^^^^^^

Sie benötigen den aktuellen OpenVPN-Client 2.4 (OpenSource - Download_: 

.. _https://swupdate.openvpn.org/community/releases/openvpn-install-2.4.0-I601.exe) 


**Konfiguration**



Linux-Clients
^^^^^^^^^^^^^

Sie benötigen ebenfalls den aktuellen OpenVPN-Client. Installieren Sie diesen mit Ihrer Paketverwaltung. Unter Ubuntu geben Sie bitte folgende Befehle zur Installation an:

.. code:: 

   sudo apt-get update
   sudo apt-get install openvpn

**Konfiguration**

   










