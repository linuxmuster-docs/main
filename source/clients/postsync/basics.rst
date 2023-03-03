Funktionsweise und Grundlagen der Postsync-Scripte
==================================================

**Allgemeines**
   
Nachdem mit Hilfe von LINBO der Linux-Client die Imagedatei (qcow2-Datei) vom Server geholt und auf den Client synchronisiert hat,
kann ein für dieses Image definiertes Postsync-Script angewendet werden.
Dieses ermöglicht es, spezifische Anpassungen (sogenannte Patches) vorzunehmen und die PCs somit auf deren Einsatzumgebung anzupassen.
Hierdurch können z.B. spezielle Anpassungen für Lehrer-PCs, für PCs in speziellen Räumen, oder für alle zu nutzenden Drucker bereitgestellt werden.

**Wo liegt das Postsync-Script ?**

Ein Beispiel für ein universelles Postsync-Script liegt im Verzeichnis ``/srv/linbo/examples/postsync``. 

Das Postsync-Script ist in dem Verzeichnis abzulegen, in dem sich das Image befindet, auf das das Script angewendet werden soll. Der Name für das Postsync-Script wird dann zusammengesetzt aus

.. code:: bash

   # dem Namen der qcow2-Image-Datei, mit welchem das Skript zusammen arbeitet
   #. gefolgt von der Endung ``.postsync``:

   /srv/linbo/images/<LinuxImageVerzeichnis>/<LinuxImageName>.postsync

   # für das Image focalfossa also
   # /srv/linbo/images/focalfossa/focalfossa.postsync 
   
Es weist folgende Rechte auf:

.. code:: bash

   -rw-rw-r-- 1 root root

**Anwendung des Postsync-Scriptes**

Soll das sogenannte universelle Postsync-Script angewendet werden, so ist dieses zuerst als Vorlage in das gewünschte Image-Verzeichnis zu kopieren:

.. code-block:: console
   
   cp /srv/linbo/examples/postsync/generic.postsync /srv/linbo/<LinuxImageVerzeichnis>/<LinuxImageName>.postsync

Für das Image focalfossa wäre der Befehl also:

.. code-block:: console

   cp /srv/linbo/examples/postsync/generic.postsync /srv/linbo/focalfossa/focalfossa.postsync


.. attention:: 
   Dieses Script wird also auf das jeweilige qcow2 Image angewendet.

