.. include:: ../../guided-inst.subst

.. _basis_file_server-label:

=========================================
Anlegen und Installieren des File-Servers
=========================================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

Der File-Server von linuxmuster.net wird vollständig in das AD des linuxmuster.net Servers integriert. Die Netzwerkfreigaben werden auf dem linuxmuster.net Server definiert und mithilfe einer DFS-Konfiguration für die konfigurierte Schule bereitgestellt. Es werden so alle persönlichen Netzlaufwerke, die Projektfreigaben, sowie die Klassenfreigaben auf diesem File-Server bereitgestellt.

Vorteile:
- Trennung der Dienste (AD Service, File Service)
- verbesserte Backupstrategie (jeweils eigenständiges Backup für die Dateien als auch für das AD)
- verbesserte Sicherheit (bei einem Multi-School Setup kann jeweils ein eigenständier File-Server pro Schule eingesetzt werden.)
- einfache Wartung und vereinfachte Updates
- deutliche Leistungsverbesserung - gerade bei grossen Schulinstallationen

Installation Ubuntu-Server
==========================

Führe die Installation des für den File-Server benötigten Ubuntu 24.04 LTS Servers so aus, wie zuvor :ref:`basis_server-label` beschrieben. Es wird nur eine Festplattte benötigt, passe die Plattenkapazität an die Anforderungen Eurer Schule an.

Passe die Partitionierung und Formatierung der Festplatte entsprechend an. Zudem musst Du eine statische IP-Adresse aus dem LAN dem File-Server zuweisen.

Nutze die Daten gemäß Deines IP-Adresskonzeptes oder gib nachstehende Daten ein, die in der Dokumentation durchgängig für das LAN verwendet werden:

- Netzbereich: 10.0.0.0/16
- IP-Adresse:  10.0.0.2
- Netzmaske:   10.0.0.254
- Gateway:     10.0.0.254
- DNS:         10.0.0.254
- Domäne:      linuxmuster.lan

Die Domäne wird bei der Integration später noch automatisch angepasst.

Die Installation endet bei dem Punkt ``Automatische Updates abschalten``.

Führe danach die Vorbereitung des Ubuntu Servers weiter wie in :ref:`lmn_pre_install-label` beschrieben. Durchlaufe folgende Schritte:

1. Zeitservereinstellungen überprüfen
2. Cloud-init deinstallieren
3. Default-Locale setzen
4. Paketquellen eintragen - siehe nachstehende Schritte


Paketquellen eintragen
======================

Nachdem Du als Benutzer ``linuxadmin`` am file-server angemeldet bist, wechselst Du nun zum Benutzer root mit:

.. code::

   sudo -i

1. Importiere den Schlüssel für die Paketquellen

.. code::

   wget -qO- "https://deb.linuxmuster.net/pub.gpg" | gpg --dearmour -o /usr/share/keyrings/linuxmuster.net.gpg
   
2. Füge die Paketquellen hinzu

.. code::

   sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linuxmuster.net.gpg] https://deb.linuxmuster.net/ lmn73 main" > /etc/apt/sources.list.d/lmn73.list'
   
File-Server Installation
========================

Aktualisiere den Server und installiere die linuxmuster.net File-Server-Pakete:

.. code::

   sudo apt update && sudo apt install linuxmuster-fileserver

Bei der Paketinstallation wird für die Kerberos-Authentifizierung ein sog. Realm abgefragt. Dieser bleibt zu diesem Zeitpunkt frei. Bei der späteren Integration des File-Servers in den AD/DC wird dies dann automatisch angepasst.

.. hint::

   Für Anwender einer Virtualisierungslösung empfehlen wir an dieser Stelle einen Snapshot zu erstellen!

Weiteres Vorgehen
=================

1. Nun muss der linuxmuster.net Server (AD/DC) im nächsten Schritt vorbereitet werden.
2. Proxmox muss in das interne Netz gebracht werden.
3. Es muss das Setup für lmnv7.3 (AD/DC) durchgeführt werden.
4. Der File-Server ist in das AD einzubinden und es sind die Freigaben/Shares auf dem lmn-Server zu definieren.



