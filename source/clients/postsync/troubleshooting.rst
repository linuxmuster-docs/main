Troubleshooting
===============

**Welche Möglichkeiten der Fehlersuche gibt es ?**

Vom linuxmuster.net Server aus kann man sich auf dem Client mithilfe von **linbo_ssh** anmelden. Es lassen sich so dann die Postsync-Ausgaben / Fehlermeldungen auf dem Client einsehen.

Das Postsync-Script schreibt eine LOG-Datei, die auf dem Client unter 

.. code:: bash

    /var/log/postsync.log
    
abgelegt wird.

Auf dem linuxmuster.net Server gibt man hierzu folgendes an, um den Client 
zu starten, zu synchronisieren und dann in den Linbo-Bildschirm zu gelangen, 
um die Log-Datei einzusehen:

.. code:: bash
   
   linbo-remote -i <IP-Adresse des Clients> -b 5 -w 130 -c sync:1
   linbo-ssh <client-name / oder IP-Adresse>
   less /var/log/postsync.log

Herunterfahren der Clients mit:

.. code:: bash

   linbo-remote -i <Client-name / IP-Adresse> -c halt

Bei Einsatz des universellen Postsync-Scriptes stehen am Anfang der LOG-Datei z.B. folgende Angaben, die die Infos zu Raum, Rechnername etc. ausgeben:

 .. figure:: media/01-output-postsync-log.png
       :align: center
       :alt: Output Postsync-LOG

Hier kann kontrolliert werden, ob der gewünschte Rechner, Raum, die korrekte Patchklasse und Hostgruppe ausgewählt wurden. Zudem wwerden die übertragenen Dateien / Scripte dargestellt.







