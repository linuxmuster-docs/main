Restore von einem NFS-Share
```````````````````````````

Bei meinen Versuchen von einem NFS-Share zu restaurieren, gelang es der Mondo-Rescue-CD nicht, das Netzwerk zu konfigurieren. In dem Fall müssen Sie die Netzwerkkonfiguration auf der Konsole von Hand einrichten. Gehen Sie so vor:

  - Beenden Sie mondorestore, um auf die Konsole zu gelangen.
  - Finden Sie heraus, welches Netzwerkinterface mit dem NFS-Server verbunden ist. Der Befehl
  
  .. code-block:: bash
  
		ifconfig -a
		
	gibt eine Übersicht aller Netzwerkinterfaces aus.
  
  - Konfigurieren Sie jetzt das Netzwerkinterface (Beispiel, Interface und IP-Adresse müssen ggf. angepasst werden):
  
  .. code-block:: bash
  
	ifconfig eth0 10.16.1.1 netmask 255.240.0.0 up

  - Überprüfen Sie mit ping, ob der NFS-Server erreichbar ist.
  - Starten Sie den Portmap-Dienst:
  
  .. code-block:: bash
  
	portmap
  
  - Mounten Sie nun das NFS-Share nach ``/tmp/isodir`` (Beispiel):
  
  .. code-block:: bash
  
		mount -t nfs -o nolock 10.16.1.10:/home/nfs /tmp/isodir

Starten Sie nun ``mondorestore`` und führen Sie die Restauration durch.
