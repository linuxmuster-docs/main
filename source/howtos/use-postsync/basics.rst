Funktionsweise und Grundlagen der Postsync-Scripte
==================================================

**Allgemeines**

Nachdem der Linux-Client mit Linbo seinen lokalen Cache mit dem Cloop auf dem Server synchronisiert hat, wird ein vorhandenes Postsync-Script angewendet, das für ein sog. Cloop (also ein Client-Image) auf dem Server vorhanden ist. 
Wird ein sog. universelles Postsync-Script erstellt, so können sog. Patches – also spezifische Anpassungen – für die Patchklasse, den Raum und ggf. einzelne Rechner angewendet werden.

Nach der Synchronisation werden die Clients durch das Script vollständig auf deren Einsatzumgebung angepasst wird. Hierdurch können z.B. spezielle Anpassungen für Lehrer – PCs in einzelnen Räumen, oder für alle zu nutzenden Drucker bereitgestellt werden.

**Wo liegt das Postsync-Script ?**

Das Postsync-Script liegt im Verzeichnis:

.. code:: bash

   /var/linbo/<LinuxImagename>.cloop.postsync
   
Es weist folgende Rechte auf:

.. code:: bash

   -rw-rw---- 1 root root

.. attention:: 
   Dieses Script wird also auf das jeweilige Cloop angewendet.

