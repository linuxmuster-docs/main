Funktionsweise und Grundlagen der Postsync-Scripte
==================================================

**Allgemeines**
   
Nachdem mit Hilfe von LINBO der Linux-Client die Imagedatei (qcow2-Datei) vom Server geholt und auf den Client synchronisiert hat,
kann ein für dieses Image definiertes Postsync-Script angewendet werden.
Dieses ermöglicht es, spezifische Anpassungen (sogenannte Patches) vorzunehmen und die PCs somit auf deren Einsatzumgebung anzupassen.
Hierdurch können z.B. spezielle Anpassungen für Lehrer-PCs, für PCs in speziellen Räumen, oder für alle zu nutzenden Drucker bereitgestellt werden.

**Wo liegt das Postsync-Script ?**

Das Postsync-Script liegt im Verzeichnis ``/srv/linbo/``. Der Name wird zusammengesetzt aus

  #. dem Name der qcow2-Datei, mit welchem das Skript zusammen arbeitet
  #. gefolgt von der Endung ``.postsync``:

.. code:: bash

   /srv/linbo/<LinuxImagename>.qcow2.postsync
   
Es weist folgende Rechte auf:

.. code:: bash

   -rw-rw---- 1 root root

**Erweiterung des Standard-Postsyncscriptes**

Soll das Standard-Script ersetzt werden (mit einem sogenannten universellen Postsync-Script)
kopiert man sich die Vorlage zur passenden cloop-Datei:

.. code-block:: console
   
   cd
   wget https://github.com/linuxmuster/linuxmuster-client-servertools/blob/34da5e5f6f12090f65b9b379516af3a4cd4b168d/usr/lib/linuxmuster-client-servertools/generic.postsync
   cd /root/
   cp generic.postsync /srv/linbo/<LinuxImagename>.qcow2.postsync

.. attention:: 
   Dieses Script wird also auf das jeweilige qcow2 Image angewendet.

