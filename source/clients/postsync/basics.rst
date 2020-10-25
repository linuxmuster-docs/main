Funktionsweise und Grundlagen der Postsync-Scripte
==================================================

**Allgemeines**
   
Nachdem mit Hilfe von LINBO der Linux-Client die Imagedatei (cloop-Datei) vom Server geholt und auf den Client synchronisiert hat,
kann ein für dieses Image definiertes Postsync-Script angewendet werden.
Dieses ermöglicht es, spezifische Anpassungen (sogenannte Patches) vorzunehmen und die PCs somit auf deren Einsatzumgebung anzupassen.
Hierdurch können z.B. spezielle Anpassungen für Lehrer-PCs, für PCs in speziellen Räumen, oder für alle zu nutzenden Drucker bereitgestellt werden.

**Voraussetzungen für die Nutzung der Scripte**

Die Skripte funktionieren im Prinzip ohne die Installation weiterer Pakete. Wer sich das manuelle Anlegen von Ordnern ersparen möchte, sollte sich auf dem linuxmuster.net-Server das Paket **linuxmuster-client-servertools** installieren:

.. code-block:: console

   sudo apt install linuxmuster-client-servertools

Dieses Paket liefert zudem ein sogenanntes universelles Postsync-Script mit, das individuell angepasst und 
auf die Cloops angewendet werden kann. 

**Wo liegt das Postsync-Script ?**

Das Postsync-Script liegt im Verzeichnis ``/srv/linbo/``. Der Name wird zusammengesetzt aus

  #. dem Name der cloop-Datei, mit welchem das Skript zusammen arbeitet
  #. gefolgt von der Endung ``.postsync``:

.. code:: bash

   /srv/linbo/<LinuxImagename>.cloop.postsync
   
Es weist folgende Rechte auf:

.. code:: bash

   -rw-rw---- 1 root root

**Erweiterung des Standard-Postsyncscriptes**

Soll das Standard-Script ersetzt werden (mit einem sogenannten universellen Postsync-Script)
kopiert man sich die Vorlage zur passenden cloop-Datei:

.. code-block:: console

   cp /usr/lib/linuxmuster-client-servertools/generic.postsync /srv/linbo/<LinuxImagename>.cloop.postsync

.. attention:: 
   Dieses Script wird also auf das jeweilige Cloop angewendet.

