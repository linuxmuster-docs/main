

Computer in Netzwerk aufnehmen
==============================

Zunächst wird ein "Masterclient" eingerichtet, dessen Installation später auf alle Geräte des Computerraums verteilt wird. Dazu muss der Rechner zunächst im Netzwerk bekannt gemacht werden, hierzu gibt es drei alternative Vorgehensweisen.

* Rechneraufnahme am Clientrechner
* Rechneraufnahme in der Schulkonsole 
* Rechneraufnahme an der Serverkonsole


.. _rst_tutorial:

Am Clientrechner
----------------

Starten Sie den Computer und booten Sie vom Netzwerk (PXE). Es gibt oft die Möglichkeit über das Drücken von
F12, F11, F9 usw. in ein Bootmenü zu gelangen bei dem die Bootquelle gewählt werden kann. Andernfalls müssen Sie die Bootreihenfolge im BIOS konfigurieren.
Nach dem Boot vom Netzwerk sehen Sie folgende Maske:

|100000000000032A00000261EE86C6D3_png|

Wechseln Sie auf den Reiter Imaging. Geben Sie das Passwort an, welches Sie während der linuxmuster.net-Installation vergeben hatten. 
Es werden bei der Eingabe keine Zeichen angezeigt.

|100000000000032A00000261CB6C69FF_png|

Entfernen Sie den Haken bei Timeout da Sie sonst nach Ablauf der Zeit automatisch abgemeldet werden. Klicken Sie dann auf ``Registrieren``

|100000000000032A00000261A518120E_png|

Tragen Sie den Raumnamen, den Computernamen und die IP-Adresse ein. Es bietet sich an einen PC im Raum 123 als
r123-pc<Rechnernummer> (z.B. r123-pc02) zu benennen und die IP-Adressen nach dem Schema 10.16.123.2 zu
vergeben. Tragen Sie eine Rechnergruppe (Hardwareklasse) ein, zu der das Gerät gehören soll und bestätigen Sie mit ``Registrieren``.

|100000000000032A00000261E61335F8_png|

.. note:: Sobald alle Rechner aufgenommen wurden, müssen Sie den Import der Rechner entweder in der Schulkonsole oder in der Konsole auf dem Server starten. 
   Sehen Sie dazu auch die nachfolgenden Kapitel.


In der Schulkonsole
-------------------

Sie können die Rechner in der Schulkonsole anlegen. Melden Sie sich dafür unter https://server:242 mit dem Benutzer ``pgmadmin`` und dem Passwort an, 
welches Sie bei der Installation von linuxmuster.net vergeben haben. Beachten Sie dass die Schulkonsole nur von 
Rechnern aus aufgerufen werden kann, die bereits aufgenommen wurden.

|10000000000003FC00000300014A97D9_png|

Wechseln Sie auf den Reiter ``Hosts`` und tragen die Rechner in der Liste ein. Speichern Sie die Liste mit dem Button ``Änderungen übernehmen``. 
Starten Sie dann den Import der Liste mit dem Button ``Hosts jetzt übernehmen``

|10000000000003FC00000300DEB043AA_png|


Auf der Server-Konsole
----------------------

Tragen Sie die Rechner auf der Konsole in die Datei  ``/etc/linuxmuster/workstations`` ein. Benutzen Sie hierfür den Befehl
``nano /etc/linuxmuster/workstations``

|1000000000000288000001881D0CDF67_png|

Starten Sie den Import der Rechner aus der Liste mit dem Befehl ``import_workstations``

|100000000000028800000188CE17749C_png|


.. |10000000000003FC00000300014A97D9_png| image:: media/10000000000003FC00000300014A97D9.png
    :width: 12.011cm
    :height: 9.023cm


.. |10000000000003FC00000300DEB043AA_png| image:: media/10000000000003FC00000300DEB043AA.png


.. |100000000000032A00000261A518120E_png| image:: media/100000000000032A00000261A518120E.png
    :width: 12.002cm
    :height: 9.025cm


.. |1000000000000288000001881D0CDF67_png| image:: media/1000000000000288000001881D0CDF67.png
    :width: 12.002cm
    :height: 7.261cm


.. |100000000000032A00000261CB6C69FF_png| image:: media/100000000000032A00000261CB6C69FF.png
    :width: 12.002cm
    :height: 9.025cm


.. |100000000000032A00000261E61335F8_png| image:: media/100000000000032A00000261E61335F8.png
    :width: 12.002cm
    :height: 9.025cm


.. |100000000000028800000188CE17749C_png| image:: media/100000000000028800000188CE17749C.png
    :width: 12.002cm
    :height: 7.261cm


.. |100000000000032A00000261EE86C6D3_png| image:: media/100000000000032A00000261EE86C6D3.png
    :width: 12.002cm
    :height: 9.025cm

