Troubleshooting
===============

**Welche Möglichkeiten der Fehlersuche gibt es ?**

Vom linuxmuster.net Server aus kann man sich auf dem Client mithilfe 
von **linbo_ssh** anmelden und dort z.B. den Synchronisationsvorgang 
aktivieren. Es lassen sich so dann die Postsync-Ausgaben / Fehlermeldungen 
auf dem Client einsehen.

Das Postsync-Script schreibt eine LOG-Datei, die auf dem Client unter 

.. code:: bash

    /mnt/var/log/postsync.log 
    
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

.. hint:: Hinweise zu linbo-remote und linbo-ssh

   `linbo im Community-Wiki <https://wiki.linuxmuster.net/community/anwenderwiki:linbo:start?s[]=linbo&s[]=remote>`_
      
..
   https://www.linuxmuster.net/wiki/dokumentation:handbuch:linbo:linbo.remote
  
..  
   https://www.linuxmuster.net/wiki/dokumentation:handbuch51:clients:linbo:linbo_remote?s[]=linbo&s[]=ssh

