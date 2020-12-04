Nutzung der Remote Server Administration Tools zum Anpassen der GPO
===================================================================

.. sectionauthor:: @michael_kohls <https://ask.linuxmuster.net/u/michael_kohls>

Das Anpassen der vom SAMBA-Server bereitgestellten GPO erfolgt von einem Windows-PC aus.

Installation der RSAT (Remote Server Administration Tools)
----------------------------------------------------------
Zur Verwaltung des Active Directory (AD) benötigt man die Microsoft Remote Server Administration Tools (RSAT). Diese werden von Microsoft bereitgestellt. (Home-Versionen von Windows werden nicht unterstützt!)

Für Windows10-Versionen vor 1809 müssen diese noch als separtes Installationspaket heruntergeladen werden: https://www.microsoft.com/en-us/download/details.aspx?id=45520

Ab Version 1809 sind die RSAT ein optionales Feature. Die Installation erfolgt über ``Start`` -> ``Apps und Features`` -> ``optionale Features`` -> ``Feature hinzufügen`` -> ``RSAT: Group Policy Management Tools``.

Verwendung der Gruppenrichtlinienverwaltung
-------------------------------------------
Starten Sie die Gruppenrichtlinienverwaltung durch Eingabe von ``gpmc.mmc``.
.. image:: media/01-gpmc.png
  :alt: GPMC
   :align: center
   

