
Default Profil kopieren
=======================

Linuxmuster.net sieht vor dass **Programminstallationen von "pgmadmin"** durchgeführt werden. Damit alle User die bei der Installation vorgenommenen Änderungen bekommen muss das Profil des "pgmadmin" nach "Default" kopiert werden. Um das Profil zu kopieren ist wie folgt vorzugehen:

1. Starten Sie den Rechner nach der Installation von Programmen neu ohne Synchronisation

.. attention:: 
              Der Neustart ist notwenig, da das Profil des "pgmadmin" ansonsten nicht kopiert werden kann
              
2. Melden Sie sich als lokaler User mit Admin-Rechten an dem Rechner an 
3. Kopieren Sie die Datei https://www.forensit.com/Downloads/Support/DefProf.zip und entpacken sie nach ``C:\Windows\system32\Defprof.exe``. Befindet sich Defprof.exe schon in ``C:\Windows\system32\`` dann geht es direkt mit Schritt 4. weiter. 
4. Führen Sie als lokaler User mit Admin-Rechten **- darf nicht pgmadmin sein -** den Befehl ``C:>defprof pgmadmin.SCHULE`` aus.
5. Melden Sie sich als lokaler User ab und als pgmadmin an
6. Fahren Sie den Rechner herunter
7. Starten Sie den Rechner neu und erstellen ein neues Image mit linbo

.. note:: 
         Screenshots werden noch eingefügt
