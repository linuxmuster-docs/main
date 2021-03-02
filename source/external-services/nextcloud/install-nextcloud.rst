.. _linuxmuster-install-nextcloud-label:

======================
Nextcloud installieren
======================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_

Auf einem Dockerhost ist die Installation einer Nextcloud sehr schnell getan. Dazu sind lediglich drei Schritte notwendig: 

#. Erstellen eines Let's Encrypt - Zertifikats.
#. Erstellen einer Site für die Nextcloud in nginx.
#. Erstellen und Starten der Nextcloud Docker App.

.. hint:: Im Folgenden musst du natürlich ``nextcloud.meine-schule.de`` durch deine URL ersetzen.

Erstellung des Zertifikats
==========================

Zuerst musst du dir einen Dienstenamen ausdenken und SSL-Zertifikate besorgen. Also z.B. nextcloud.meine-schule.de. 

Dazu legst du einen DNS Eintrag für deine Dockerapp, z.B. nextcloud.meine-schule.de, der auf die IP des Dockerhosts zeigt an. Das darf auch ein CNAME sein.

Im allgemeinen wirst du eine E-Mail an Belwue, mit der Bitte diesen Eintrag für dich vorzunehmen, schreiben. 

Trage diesen Host in die Datei ``/etc/dehydrated/domains.txt`` ein.

Führe den Befehl ``dehydrated -c`` aus. Jetzt hast du die Zertifikate im Verzeichnis ``/var/lib/dehydrated/certs/`` zur Verfügung, der Docker Host aktualisiert diese per Cronjpb.

Erstellen einer Site für die Nextcloud in nginx
===============================================

Wir benutzen nginx als Reverse-Proxy. So können auf deinem Dockerhost viele Services wie beispielsweise mrbs.meine-schule.de und nextcloud.meine-schule.de unter der gleichen IP-Adresse laufen.

Wenn beispielsweise ein Benutzer die Seite nextcloud.meine-schule.de aufruft, schaut sich nginx die URL, die aufgerufen wurde an und liefert dann die entsprechende Seite.

Melde dich als root auf deinem Dockerhost an.

Erstelle mit ``mkdir -p /srv/docker/nextcloud`` das Verzeichnis, in das alle Nextcloud-Dateien abgelegt werden.

Erzeuge die Datei nextcloud.nginx.conf.

.. code-block:: console

  server {
    listen 80;
    listen [::]:80;
    server_name nextcloud.meine-schule.de;
    
    location / {
      return 301 https://nextcloud.staufer-gymnasium.de$request_uri;
      }
      
    location ^~ /.well-known/acme-challenge {
      alias /var/www/dehydrated;
      }
      
    }
    
  server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name    nextcloud.meine-schule.de;
    ssl_certificate /var/lib/dehydrated/certs/nextcloud.meine-schule.de/fullchain.pem;
    ssl_certificate_key /var/lib/dehydrated/certs/nextcloud.meine-schule.de/privkey.pem;
    ssl_protocols TLSv1.2;
    ssl_prefer_server_ciphers on;
    location /.well-known/carddav {
      return 301 $scheme://$host/remote.php/dav;
    }
    location /.well-known/caldav {
      return 301 $scheme://$host/remote.php/dav;
    }
    location / {
       proxy_read_timeout 600s;
       client_max_body_size 0;
       proxy_set_header Connection "";
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload";
        access_log /var/log/nginx/nextcloud.access.log;
        error_log /var/log/nginx/nextcloud.error.log;
       proxy_pass http://localhost:7770;
    }
  }

Diese conf-Datei geht davon aus, dass deine Nextcloud auf localhost:7770 erreichbar sein wird. Den Prot 7770 kannst du natürlich frei wählen. 

Jetzt musst du noch im Verzeichnis ``/etc/nginx/sites-enabled`` einen Link auf deine ``nextcloud.nginx.conf`` anlegen und nginx neu starten.

Melde dich wieder als root am Dockerhost an und lege mit ``ln -s /srv/docker/nextcloud/nextcloud.nginx.conf /etc/nginx/sites-enabled/nextcloud.meine-schule.de`` den Link an.

So, jetzt musst du nur noch mit ``systemctl restart nginx.service`` nginx neu starten.

Nextcloud mit docker-compose einrichten und starten
===================================================

Das Meiste ist bereits getan. Jetzt musst du nur noch drei Dateien angelegen, die docker-compose sagen, was es machen soll.

Alles was wir jetzt machen, spielt sich im Verzeichnis `/srv/docker/nextcloud` ab. Später werden auch dort sämtliche Daten liegen. Für eine Datensicherung musst du nur dieses Verzeichnis sichern. Einfacher geht's nicht.

Melde dich wieder als root auf dem Dockerhost an und gehe mit ``cd /srv/docker/nextcloud`` in das Verzeichnis `/srv/docker/nextcloud`.

Die Datei Dockerfile
--------------------

.. code-block:: console

  FROM nextcloud:stable
  RUN apt-get update && apt-get install -y smbclient libsmbclient-dev && pecl install smbclient && docker-php-ext-enable smbclient && rm -rf /var/lib/apt/lists/*
  
Wenn du experimentierfreudig bist, kannst du statt `stable` auch `latest` schreiben.

Mit der zweiten Zeile werden die Vorbereitungen für die Einbindungen der Home-Verzeichnisse (Samba-Shares) durchgeführt.

Die Datei db.env
----------------

.. code-block:: console

  MYSQL_ROOT_PASSWORD=geheim
  MYSQL_PASSWORD=geheim
  MYSQL_DATABASE=nextcloud
  MYSQL_USER=nextcloud
  
Hier sind die Zugangsdaten für die Datenbank hinterlegt.

Die Datei docker-compose.yml
----------------------------

.. code-block:: console

    version: '3'

  services:
    db2:
      image: mariadb
      command: --transaction-isolation=READ-COMMITTED --binlog-format=ROW
      restart: always
      volumes:
        - ./db:/var/lib/mysql
      env_file:
        - db.env
  
    redis2:
      image: redis:alpine
      restart: always
  
    app2:
      build:
        context: .
        dockerfile: Dockerfile
      restart: always
      ports:
        - 7771:80
      volumes:
        - ./nextcloud:/var/www/html
      environment:
        - MYSQL_HOST=db2
        - REDIS_HOST=redis2
      env_file:
        - db.env
      depends_on:
        - db2
        - redis2
  
    cron2:
      build:
        context: .
        dockerfile: Dockerfile
      restart: always
      volumes:
        - ./nextcloud:/var/www/html 
      entrypoint: /cron.sh
      depends_on:
        - db2
        - redis2
  
  volumes:
    db:
    nextcloud:
    
In der Datei `docker-compose.yml` werden die Services deiner Nextcloud beschrieben. 

Das Verzeichnis `/var/www/html` des Webservers wird unter dem Verzeichnis `/srv/docker/nextcloud/nextcloud` auf dem Dockerhost abgelegt. Und das Datenverzeichnis `/var/lib/mysql` der Maria Datenbank wird unter dem Verzeichnis `/srv/docker/nextcloud/db` auf dem Dockerhost abgelegt.

Damit sind alle Daten im Verzeichnis `/srv/docker/nextcloud`.

Wenn du im Verzeichnis `/srv/docker/nextcloud` bist, startest du die Nextcloud mit ``docker-compose up -d --build``. 

Jetzt must du mit einem Browser die Startseite `https://nextcloud.meine-schule.de` deiner neuen Nextcloud aufrufen und einen Benutzernamen und ein Passwort für den Nextcloud-admin angeben.

.. image:: media/install-01.png
   :alt: Server - Einstellungen
   :align: center

Da die Nextcloud hinter dem nginx-Proxy liegt und nicht weiß, ob die Benutzer die Nextcloud über http oder https aufrufen, wird eine Anmeldung über eine Nextcloud-Client-App scheitern. Mit einem Eintrag in `/srv/docker/nextcloud/nextcloud/config/config.php` kannst du das Problem lösen:

.. code-block:: console

  ...
    'ldapProviderFactory' => 'OCA\\User_LDAP\\LDAPProviderFactory',
    # Das ist der Eintrag ########################
    'overwriteprotocol' => 'https',
    ##############################################
  );

