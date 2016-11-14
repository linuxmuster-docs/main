Konfiguration linuxmuster.net
=============================

Konfiguration IPFire
--------------------

Geben Sie als Benutzername ``root`` und als Passwort ``muster`` ein. Bestätigen Sie jeweils mit ``Enter``. Anschließend geben Sie den Befehl ``setup`` ein und bestätigen mit ``Enter``.

.. code-block:: console

   $ setup

.. figure:: media/configuration/image61.png
   :align: center
   :alt: Konfiguration Schritt 1

Wählen Sie „Networking“ und bestätigen Sie mit ``Enter``.

.. figure:: media/configuration/image62.png
   :align: center
   :alt: Konfiguration Schritt 2

Wählen Sie „Drivers and card assigments“ und bestätigen mit ``Enter``.

.. figure:: media/configuration/image63.png
   :align: center
   :alt: Konfiguration Schritt 3

Wählen Sie „GREEN“ und bestätigen Sie mit ``Enter``.

.. figure:: media/configuration/image64.png
   :align: center
   :alt: Konfiguration Schritt 4

Wählen Sie die zugehörige Netzwerkkarte aus und bestätigen Sie mit ``Enter``.

.. figure:: media/configuration/image65.png
   :align: center
   :alt: Konfiguration Schritt 5

.. note::
 Sie finden die passende Netzwerkkarte anhand der MAC-Adresse heraus. Diese können Sie hier abgleichen:

.. figure:: media/configuration/image66.png
   :align: center
   :alt: Konfiguration Schritt 6

.. figure:: media/configuration/image67.png
   :align: center
   :alt: Konfiguration Schritt 7

In der Standardkonfiguration stimmt die Reihenfolge der NICs meist, es muss dann nur der Reihe nach ausgewählt werden.

Wiederholen Sie den Vorgang für das Interface RED und BLUE. Wählen Sie im Anschluss „Done“ und bestätigen mit ``Enter``.

.. figure:: media/configuration/image68.png
   :align: center
   :alt: Konfiguration Schritt 8

Bestätigen Sie Ihre Eingaben mit ``Done``.

.. figure:: media/configuration/image69.png
   :align: center
   :alt: Konfiguration Schritt 9

Wählen Sie „´root´ password“ und bestätigen Sie mit ``Enter``.

.. figure:: media/configuration/image70.png
   :align: center
   :alt: Konfiguration Schritt 10

Geben Sie ein neues Passwort für den Account root ein und bestätigen mit ``Ok``.

.. figure:: media/configuration/image71.png
   :align: center
   :alt: Konfiguration Schritt 11

Wiederholen Sie den Vorgang für den Benutzer „admin“. Mit diesem Benutzer / Passwort melden Sie sich später an der Weboberfläche der Firewall an. Verlassen Sie das Setup mit der Schaltfläche ``Quit``.

.. figure:: media/configuration/image72.png
   :align: center
   :alt: Konfiguration Schritt 12

Führen Sie ggf. mit dem Befehl „reboot“ einen Neustart durch.

Konfiguration Server
--------------------

Geben Sie als Benutzername ``root`` ein und als Passwort ``muster``. Anschließend geben Sie die Befehle

.. code-block:: console

   $ aptitude update
   $ aptitude upgrade
   $ aptitude dist-upgrade

ein und bestätigen jeweils mit ``Enter`` bzw. ``Y``.

.. figure:: media/configuration/image73.png
   :align: center
   :alt: Konfiguration Schritt 13

.. note::
 Mit diesem Befehl aktualisieren Sie den Server auf den neusten Stand. Sie müssen ggf. mit der Eingabe ``Y`` das Update bestätigen.

Geben Sie den Befehl

.. code-block:: console

   $ passwd

ein um das ``root``-Passwort zu ändern.

.. figure:: media/configuration/image74.png
   :align: center
   :alt: Konfiguration Schritt 14

Geben Sie den Befehl

.. code-block:: console

   linuxmuster-setup --first

ein und bestätigen Sie mit ``Enter``.

.. figure:: media/configuration/image75.png
   :align: center
   :alt: Konfiguration Schritt 15

Bestätigen Sie die Meldung mit den Hinweisen mit der Schaltfläche ``Ok``.

.. figure:: media/configuration/image76.png
   :align: center
   :alt: Konfiguration Schritt 16

Geben Sie Ihr Länderkürzel ein bzw. bestätigen „DE“ mit ``Enter``.

.. figure:: media/configuration/image77.png
   :align: center
   :alt: Konfiguration Schritt 17

Geben Sie Ihr Bundesland ein bzw. bestätigen Sie „BW“ mit ``Enter``.

.. figure:: media/configuration/image78.png
   :align: center
   :alt: Konfiguration Schritt 18

Geben Sie den Schulstandort ein (Stadt).

.. figure:: media/configuration/image79.png
   :align: center
   :alt: Konfiguration Schritt 19

Geben Sie den Schulnamen Ihrer Schule an.

.. figure:: media/configuration/image80.png
   :align: center
   :alt: Konfiguration Schritt 20

Geben Sie den Domänennamen ein den Sie verwenden möchten. Im Beispiel „SCHULE“.

.. figure:: media/configuration/image81.png
   :align: center
   :alt: Konfiguration Schritt 21

Geben Sie den Servernamen ein. Es ist zu empfehlen den Server ``server`` zu nennen.

.. figure:: media/configuration/image82.png
   :align: center
   :alt: Konfiguration Schritt 22

Geben Sie den Internetdomänennamen des Schulnetzes an den Sie verwenden möchten. Beispielsweise „schule.lokal“.

.. figure:: media/configuration/image83.png
   :align: center
   :alt: Konfiguration Schritt 23

Wählen den gewünschten IP-Adressbereich aus den Sie verwenden möchten.

.. figure:: media/configuration/image84.png
   :align: center
   :alt: Konfiguration Schritt 24

Geben Sie den externen Domänennamen an, auf dem Ihr Server im Internet erreichbar ist. Sofern keine externe Kommunikation vorgesehen ist, können Sie das Feld auch leer lassen.

.. figure:: media/configuration/image85.png
   :align: center
   :alt: Konfiguration Schritt 25

Geben Sie an welche Firewall Sie verwenden. In der XenAppliance wird ``ipfire`` verwendet.

.. figure:: media/configuration/image86.png
   :align: center
   :alt: Konfiguration Schritt 26

Tragen Sie für die Emailfunktion einen SMTP-Host ein mit dem der Server kommunizieren kann oder lassen Sie das Feld frei. Beispielsweise ``mbox1.belwue.de``.

.. figure:: media/configuration/image87.png
   :align: center
   :alt: Konfiguration Schritt 27

Sofern Sie Subnetting nutzen möchten, können Sie dies hier aktivieren.

.. figure:: media/configuration/image88.png
   :align: center
   :alt: Konfiguration Schritt 28

Wählen Sie für die administrativen Domänenbenutzer ein Passwort.

.. figure:: media/configuration/image89.png
   :align: center
   :alt: Konfiguration Schritt 29

Geben Sie das root-Passwort der Firewall ein, das Sie im Schritt „Konfiguration IPFire“ vergeben haben.

.. figure:: media/configuration/image90.png
   :align: center
   :alt: Konfiguration Schritt 30

Wählen Sie die Netzwerkkarte aus, die mit dem Schulnetz (GREEN) verbunden ist. Sofern Sie keine zusätzlichen Adapter installiert haben, bestätigen Sie die Auswahl mit ``Enter``.

.. figure:: media/configuration/image91.png
   :align: center
   :alt: Konfiguration Schritt 31