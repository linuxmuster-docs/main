Dist-Upgarde durchführen
========================

Nachdem die Paketquellen in einer Datei für Apt eingetragen wurden, prüfen Sie vor dem weiteren Upgrade, ob im IPFire auf der **Webproxy-Seite noch MAC-Adressen in der Sperrliste** eingetragen sind.
Sind hier MAC-Adressen noch eingetragen mpssen Sie diese löschen und diese Änderungen mit der Schaltfläche **Speichern und Neustart** übernehmen.

Danach können nun die Paketquellen aktualisiert und die Pakete selbst aktualisiert werden.

Dazu sind auf der Eingabekonsole als Benutzer root folgende Befehle einzugeben:

.. code:: bash

    # apt-get update && apt-get dist-upgrade

    Paketaktualisierung (Upgrade) wird berechnet...Fertig
    Die folgenden Pakete werden ENTFERNT:
       tftpd-hpa
    Die folgenden NEUEN Pakete werden installiert:
      atftpd ipcalc
    Die folgenden Pakete werden aktualisiert (Upgrade):
      linuxmuster-base linuxmuster-ipfire linuxmuster-linbo linuxmuster-migration
      sophomorix-base sophomorix-doc-html sophomorix-pgldap sophomorix2

Sollte die Paketaktualisierung verletzte Abhängigkeiten für tftpd-hpa melden, so installieren Sie zunächst gezielt atftpd oder installieren Sie das deinstallierte linuxmuster-linbo nach dem upgrade neu.
