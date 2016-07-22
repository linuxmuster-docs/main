Übersicht
---------

.. note:: Das notwendige Paket **mondo** befindet sich in einem externen Repository.
	Dieses muss also vor der Installation eingebunden werden. Zur Vorgehensweise
	siehe Abschnitt :doc:`installation`.

.. _Mondo Rescue: http://www.mondorescue.org/

Backup und Restore des Servers können in linuxmuster.net 6.1 mit dem Opensource-Tool `Mondo Rescue`_ realisiert werden. Es ermöglicht:

  - Vollbackup im Live-Betrieb;
  - Automatische Backups per Cronjob;
  - Backup-Strategien mit inkrementellen und differentiellen Backups;
  - Backup auf Wechselplatte/NFS-Share;
  - Restore von Festplatte, NFS oder CD-/DVD-Medien;
  - Komplettwiederherstellung des Servers inklusive LVM- oder Raidsystem;
  - Wiederherstellung einzelner Dateien und Verzeichnisse im Live-Betrieb.

.. _MondoRescue HOWTO: http://www.mondorescue.org/docs/mondorescue-howto.html

Weiterführende Informationen zu Mondo Rescue finden Sie im `MondoRescue HOWTO`_.

.. attention::
	Führen Sie nach der Erstinstallation des Servers - noch bevor Sie Benutzer und Arbeitsstationen einrichten - testweise ein Vollbackup und danach einen Restore durch, um sicherzugehen, dass *MondoRescue* mit Ihrer Hardware kompatibel ist. Falls Probleme mit IDE-Festplatten auftreten, sollten Sie SATA-Platten einsetzen oder ein alternatives Backupverfahren wählen.
