.. _howto-change-own-passwords-label:

===============================
 Ändern des eigenen Passwortes
===============================

.. sectionauthor:: `@Tobias <https://ask.linuxmuster.net/u/Tobias>`_,

Melde dich an der Schulkonsole an, d.h. besuche mit dem Browser die
Webseite ``https://server.linuxmuster.lan`` oder die an deiner Schule
äquivalent vom Administrator eingerichtete Seite und melde dich mit
den Schulkontodaten an.

.. hint:: Dein Benutzername besteht nur aus Kleinbuchstaben und
          eventuell Zahlen.

.. figure:: media/selma-login.png

Klicke auf der Hauptseite auf "Passwort ändern"

.. figure:: media/selma-dashboard.png

Gib das aktuelle und zweimal ein neues Passwort ein. Beachte die
Anforderungen an das neue Passwort, die von Schule zu Schule abweichen
können. Informiere dafür dich bei deinem
Netzwerkberater. Standardmäßig gibt es folgende Regeln

  * Folgende Zeichen sind erlaubt:

    .. code::

       a-z A-Z 0-9 ! § + - @ # $ % & * ( )[ ]{ }

    (D.h. Umlaute oder diakritische Zeichen sind nicht erlaubt)
  * Die Mindestlänge des Passwortes sind 7 Zeichen. 
  * Das Passwort muss aus Großbuchstaben, Kleinbuchstaben und entweder
    Zahlen oder Sonderzeichen (oder beidem) bestehen.

    Beispiele sind: ``Muster!`` oder ``HundKatzeMau5``  

Das erfolgreiche Ändern des Passwortes wird mit einer Meldung bestätigt.

.. figure:: media/selma-pw-success.png

Falls die Änderung nicht erfolgreich war, erhalten Sie eine
Fehlermeldung mit einem Hinweis auf den Fehler.

.. figure:: media/selma-pw-failure.png

In dieser Beispielfehlermeldung bestand das Passwort nur aus
Kleinbuchstaben, Zahlen und Sonderzeichen. Es enthielt keine
Großbuchstaben.

Jetzt kannst du dich ausloggen. Rechts oben, wo in einem Kreis dein
Bild oder Buchstabe steht erreicht man das persönliche Menü.

.. figure:: media/selma-logout-menu.png

Mit dem neuen Passwort kannst du dich an allen Diensten anmelden, die
im Schulnetzwerk mit dem Schulkonto verbunden sind, z.B. auch die
Anmeldung an PCs.

