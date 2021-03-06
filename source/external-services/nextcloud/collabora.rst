===========================
Das Online-Office Collabora
===========================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_

Collabora Online ist eine angepasste Version von LibreOffice Online, einem Online-Office, welches sich auf dem Dockerhost betreiben lässt. 

Mit Collabora können beispielsweise in Moodle und Nextcloud gleichzeitig mehrer Benutzer an einem Dokument arbeiten. Mit Collabora hat man so auch auf Tabletts oder Handys ein Office-Paket zur Verfügung. 

Um Collabora auf dem Dockerhost zu installieren sind die gleichen Schritte wie bei der Nextcloud-Installation notwendig. 

#. Erstellen eines Let's Encrypt - Zertifikats.
#. Erstellen einer Site für die Collabora in nginx.
#. Erstellen und Starten der Collabora App.

.. hint:: Im Folgenden musst du natürlich ``office.meine-schule.de`` durch deine URL ersetzen.

Erstellung des Zertifikats
==========================

Zuerst musst du dir Dienstenamen ausdenken und SSL-Zertifikat besorgen. Also z.B. office.meine-schule.de. 

Dazu legst du einen DNS Eintrag für deine Dockerapp, z.B. office.meine-schule.de, der auf die IP des Dockerhosts zeigt an. Das darf auch ein CNAME sein.

Trage diesen Host in die Datei ``/etc/dehydrated/domains.txt`` ein.

Führe den Befehl ``dehydrated -c`` aus. Jetzt hast du die Zertifikate im Verzeichnis ``/var/lib/dehydrated/certs/`` zur Verfügung, der Docker Host aktualisiert diese per Cronjpb.

Erstellen einer Site für Collabora in nginx
===========================================

Melde dich als root auf deinem Dockerhost an.

Erstelle mit ``mkdir -p /srv/docker/office`` das Verzeichnis, in das alle Collabora-Dateien abgelegt werden.

Erzeuge die Datei office.nginx.conf.

.. code-block:: console

  server {
    listen 80;
    listen [::]:80;
    server_name office.meine-schule.de;

    location ^~ /.well-known/acme-challenge {
    alias /var/www/dehydrated;
      }
    }
  
  server {
    listen 443 ssl;
    server_name office.meine-schule.de;
    add_header X-XSS-Protection "1; mode=block"; #Wenn es nicht geht, notfalls deaktivieren
  
    ssl_certificate /var/lib/dehydrated/certs/office.meine-schule.de/fullchain.pem;
    ssl_certificate_key /var/lib/dehydrated/certs/office.meine-schule.de/privkey.pem;
  
    # static files
    location ^~ /loleaflet {
        proxy_pass https://localhost:9980;
        proxy_set_header Host $http_host;
    }
  
    # WOPI discovery URL
    location ^~ /hosting/discovery {
        proxy_pass https://localhost:9980;
        proxy_set_header Host $http_host;
    }
  
    # Capabilities
    location ^~ /hosting/capabilities {
        proxy_pass https://localhost:9980;
        proxy_set_header Host $http_host;
    }
  
    # main websocket
    location ~ ^/lool/(.*)/ws$ {
        proxy_pass https://localhost:9980;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $http_host;
        proxy_read_timeout 36000s;
    }
  
    # download, presentation and image upload
    location ~ ^/lool {
        proxy_pass https://localhost:9980;
        proxy_set_header Host $http_host;
    }
  
    # Admin Console websocket
    location ^~ /lool/adminws {
        proxy_pass https://localhost:9980;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $http_host;
        proxy_read_timeout 36000s;
    }
  }

Diese conf-Datei geht davon aus, dass dein Collabora auf localhost:9980 erreichbar sein wird. Den Port 9980 kannst du natürlich wieder frei wählen. 

Jetzt musst du noch im Verzeichnis ``/etc/nginx/sites-enabled`` einen Link auf deine ``office.nginx.conf`` anlegen und nginx neu starten.

Melde dich wieder als root am Dockerhost an und lege mit ``ln -s /srv/docker/collabora/office.nginx.conf /etc/nginx/sites-enabled/office.meine-schule.de`` den Link an.

So, jetzt musst du nur noch mit ``systemctl restart nginx.service`` nginx neu starten.

Collabora mit docker-compose einrichten und starten
===================================================

Das Meiste ist bereits getan. Du musst nur noch eine Datei angelegen, die docker-compose sagt, was es machen soll.

Alles was wir jetzt machen, spielt sich im Verzeichnis `/srv/docker/collabora` ab.

Melde dich wieder als root auf dem Dockerhost an und gehe mit ``cd /srv/docker/collabora`` in das Verzeichnis `/srv/docker/collabora`.

Die Datei docker-compose.yml
============================

.. code-block:: console

  version: '2.2'
    
  services:
    collabora:
      image: collabora/code
      restart: always
      ports:
        - 127.0.0.1:9980:9980
      cap_add:
        - MKNOD
      environment:
        - domain=[a-z]*+.meine-schule.de
        - username=admin
        - password=Stgy3431
        - VIRTUAL_HOST=office.staufer-gymnasium.de
        - VIRTUAL_NETWORK=proxy-ssl
        - VIRTUAL_PORT=9980
        - VIRTUAL_PROTO=https
        - ssl.enable=false
        - ssl.termination=true
    
Der Eintrag ``- domain=[a-z]*+.meine-schule.de`` bewirkt, dass alle Rechner in der Domäne meine-schule.de Zugriff auf den Collabora-Service haben.

Möchtest du, dass nur nextcloud.meine-schule.de Zugriff auf den Collabora-Service hat, muss der Eintrag ``- domain=nextcloud.meine-schule.de`` lauten.

Wenn du im Verzeichnis `/srv/docker/collabora` bist, startest du Collabora mit ``docker-compose up -d``. 

Collabora in der Nextcloud nutzen
=================================

Als erstes musst du die App ``Collabora Online`` aktiviereen. Gehe dazu auf A -> + Apps. Auf der Seite ganz unten findest du die deaktivierten Apps. Aktiviere ``Collabora Online``.

Navigiere zu Einstellungen -> Collabora Online Development Edition und trage dort die URL deines Collabora-Services ein.

.. image:: media/collabora-01.png   
   :align: center

Fertig.
