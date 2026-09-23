.. attention::

   **Datenschutz: Löschung von Benutzerdaten in extern angebundenen Diensten**

   Wird ein/e Benutzer/in im AD der linuxmuster.net gelöscht, wirkt sich das nicht automatisch auf bereits dort
   gespeicherte Daten in extern angebundenen Diensten aus. Je nach Konfiguration des jeweiligen Dienstes werden
   entfernte Benutzer/innen beim nächsten LDAP-Sync ggf. nur gesperrt oder deaktiviert, ihre personenbezogenen
   Daten (Kursinhalte, Dateien, Nachrichten etc.) bleiben aber bestehen.

   Aus datenschutzrechtlicher Sicht (Löschpflicht, Speicherbegrenzung) müssen Administrator/innen sicherstellen,
   dass personenbezogene Daten gelöschter Benutzer/innen auch in den angebundenen externen Diensten zeitnah
   entfernt werden. Unterstützt der angebundene Dienst keine automatische Löschung (sondern nur eine
   Sperrung/Deaktivierung) gelöschter LDAP-Benutzer/innen, so müssen diese Konten samt ihrer Daten
   **regelmäßig manuell** im jeweiligen Dienst gelöscht werden, um den Datenschutzanforderungen zu genügen.
