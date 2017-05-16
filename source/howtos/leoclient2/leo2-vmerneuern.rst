Basis und Snapshots verwalten
=============================

Jede virtuelle Maschine besitzt neben der Basis
``/PFAD/MASCHINENNAME/MASCHINENNAME.vdi`` einen Standard-Snapshot.

Zuerst sollte man eine solide VM-Basis erstellt haben. Da alle darauf
basierenden weiteren Snapshots unbrauchbar werden, wenn die Basis
aktualisiert werden muss.

Aufbauend auf diese Basis können dann weitere Snapshots erzeugt werden.

VM-Basis aktualisieren
----------------------

Mit Hilfe des Skripts ``leoclient2-base-snapshot-renew`` wird der
aktuelle Zustand der virtuellen Maschine zur neuen Basis.

.. hint::
   
   Durch eine Erneuerung der Basis werden alle (anderen) darauf
   aufbauenden Snapshots unbrauchbar.

Nach dem Aufruf des Skripts ``leoclient2-base-snapshot-renew`` mit root-Rechten

.. code-block:: console

   $ sudo leoclient2-base-snapshot-renew

sind einige selbsterklärende Fragen zu beantworten.

-   Soll der Vorgang abgebrochen werden? (J/N)
-   Name der virtuellen Maschine?          (VM, die erneuert werden soll)
-   Speicherort der virtuellen Maschine?   (VM, die erneuert werden soll)

Das Skript startet dann zunächst VirtualBox, um die Sicherungspunkte
zu löschen. 
Eine eventuelle Warnung, die aufgrund fehlender Verbinungen erscheint,
kann ignoriert werden. Die Ursache ist z.B. bei dem vorkonfigurierten
Ubuntu von linuxmuster.net die fehlende Verbindung zu den Homes als
linuxadmin.

.. figure:: media/leoclient2-base-snapshot-renew.png
   :align: center
   :alt: VirtualBox-Optionen für Snapshots

   VirtualBox-Optionen für Snapshots

- Klicken Sie rechts oben auf die Schaltfläche "Sicherungspunkte (1)".
- Klicken Sie auf den Snapshot, löschen Sie diesen mit einem
  Rechtsklick oder mit dem entsprechenden Icon und bestätigen Sie mit
  "Löschen" den nächsten Dialog.

Haben Sie im aktuellen Zustand bereits Änderungen vorgenommen, so kann
das Löschen des Snapshots eine Weile dauern.  Im Anschluss kann die VM
gestartet werden und (weitere) gewünschte Änderungen durchgeführt
werden.

- Schalten Sie die VM aus und beenden Sie VirtualBox

Das Skript erzeugt eine neue Basisfestplatte unter
``/PFAD/MASCHINENNAME/MASCHINENNAME.vdi`` und komprimiert sie (Das
dauert einige Minuten).  Darüber hinaus wird noch ein neuer
Standard-Snapshot erzeugt und gezippt. Der Name des neuen Snapshots,
hier: ``{c81442ac-4e03-487c-a05a-e82b8918c834}.vdi``, erscheint in der
Konsolenausgabe.

.. code-block:: console

   ...
   ##### Processing snapshot: standard #####
   * Zipping standard:
     * Image:   /virtual/winxp/snapshot-store/standard/{c81442ac-4e03-487c-a05a-e82b8918c834}.vdi
     * Dir:     /virtual/winxp/snapshot-store/standard
     * File:    {c81442ac-4e03-487c-a05a-e82b8918c834}.vdi
   ...
	      

- Vergleichen Sie den neuen Snapshot-Dateinamen und löschen Sie den
  alten Standard-Snapshot entsprechend dem Muster ``sudo rm
  /PFAD/MASCHINENNAME/{..alterSnapshot..}.vdi*``

  .. code-block:: console

     $ ls -1 /virtual/winxp/snapshot-store/standard/
     {4a895e9c-a6e9-416d-b612-b643035c0103}.vdi
     {4a895e9c-a6e9-416d-b612-b643035c0103}.vdi.zip
     {c81442ac-4e03-487c-a05a-e82b8918c834}.vdi
     {c81442ac-4e03-487c-a05a-e82b8918c834}.vdi.zip
     filesize.vdi
     filesize.vdi.zipped
     $ sudo rm /virtual/winxp/snapshot-store/standard/{4a895e9c-a6e9-416d-b612-b643035c0103}.vdi*
	  
- Sollten Sie weitere Snapshots zur virtuellen Maschine haben, haben
  diese ihre Basis verloren. Löschen Sie diese Snapshots (als root)
  oder erzeugen Sie sie erneut aus dem bestehenden neuen
  Standard-Snapshot.

  .. code-block:: console

     $ ls -1 /virtual/winxp/snapshot-store/Software2016
     {4a895e9c-a6e9-416d-b612-b643035c0103}.vdi
     {4a895e9c-a6e9-416d-b612-b643035c0103}.vdi.zip
     filesize.vdi
     filesize.vdi.zipped
     $ sudo leoclient2-snapshot-create -m winxp -s Software2016
       adding: {c81442ac-4e03-487c-a05a-e82b8918c834}.vdi (deflated 100%)
       OK: Snapshot {c81442ac-4e03-487c-a05a-e82b8918c834}.vdi wurde als Software2016 gesetzt.




.. _leoclient2-snapshot-neu:

Neue Snapshots erzeugen
-----------------------

Das Skript :download:`leoclient2-snapshot-create
<media/leoclient2-snapshot-create>` legt mit dem aktuellen Zustand der
VM einen neuen auswählbaren Snapshot an oder den Standard-Snapshot
neu.

.. hint::
   
   Die Basis, d.h. die zugrundeliegende Basisfestplatte wird dabei nicht
   verändert. Eine veränderte Hardwarekonfiguration speichert das Skript
   auch nicht.
   
Vorgehensweise:

- Laden Sie das Skript herunter: :download:`leoclient2-snapshot-create <media/leoclient2-snapshot-create>`
- Legen Sie es unter ``/usr/bin/leoclient2-snapshot-create`` ab und machen Sie es ausführbar. 

  .. code-block:: console
     
     $ sudo mv leoclient2-snapshot-create /usr/bin/
     $ sudo chmod 755 /usr/bin/leoclient2-snapshot-create
  
- Starten Sie als Benutzer die VM (z.B. hier winxp)

  .. code-block:: console

     $ leovirtstarter2
  
- Installieren Sie Software nehmen Sie die Änderungen vor, fahren Sie die VM herunter.
- Rufen Sie das Skript (als root) ohne Argument ``-s`` auf, um den Standard-Snapshot neu zu setzen, 

  .. code-block:: console
   
     $ sudo leoclient2-snapshot-create -m winxp

- oder mit einem Argument ``-s``, um einen neuen Snapshot zu erzeugen.

  .. code-block:: console
     
     $ sudo leoclient2-snapshot-create -m winxp -s Software2016

  Jetzt erscheint im Auswahlmenü von ``leovirtstarter2`` ein neuer
  Snapshot mit dem Namen ``Software2016``.

