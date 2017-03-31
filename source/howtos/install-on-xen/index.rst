Installationsleitfaden XEN
==========================

In diesem Dokument finden Sie Anleitungen zum Installieren der von
Netzint bereitgestellten XenAppliance der linuxmuster.net-Musterlösung
in der Version 6.2. Es werden diverse Installationsautomatismen
verwendet, sodass keine erweiterten Kenntnisse für die Installation
notwendig sind. Eine vollständige Installation des Hypervisors, der
Import aller VMs sowie deren Konfiguration dauert ca. 80 Minuten.

Citrix XenServer eignet sich für den virtuellen Betrieb von
linuxmuster.net besonders, da er nahtlos dem OpenSource-Konzept
entspricht. Es ist der führende Enterprise-OpenSource-Hypervisor und
wird in den weltgrößten Rechenzentren eingesetzt. Der Betrieb wird auf
jeglicher Markenhardware unterstützt und es gibt zahlreiche
professionelle 3rd-Party Software für Backup und andere Features. Die
meiste „Noname-Hardware“ kann ebenfalls nativ verwendet werden. Für
einen Großteil der restlichen Hardware werden oft von den Herstellern
Erweiterungen für XenServer angeboten, somit sind auch diese lauffähig.

Für die Installation benötigen Sie lediglich

* einen Installationsdatenträger Citrix XenServer 7.1 (zu finden auf `XenServer Webseite <http://xenserver.org>`_)
* sowie die Erweiterungs-DVD `linuxmuster-SupplementalPack` (zu finden auf http://www.netzint.de/education/linuxmuster-net/xenserver-appliance-6-2)

Nach der Installation gemäß dieser Anleitung erhalten Sie eine einsatzbereite Umgebung bestehend aus

* Server,
* Firewall (IPFire) und
* Administrationsoberfläche (XOA) sowie
* optionale Erweiterungen.

Alle weiteren Schritte für spezifische Anpassungen finden Sie in den weiterführenden Leitfäden zur Installation.

Inhalt:

.. toctree::
   :maxdepth: 2

   requirements
   xenserver
   administration
   configuration
   lvm
   backup
