.. HOWTO E-Mail im LDAP documentation master file, created by Frank Schütte
   sphinx-quickstart on Sun Jan 31 13:14:00 2016.

.. _howto-use-mail-ldap-label:

=============================================
(v6.2) Individuelle E-Mail-Adressen verwalten
=============================================

Zielgruppe: Netzwerkberater und Supportfirmen

Einige Programme greifen standardmäßig auf die im LDAP unter dem
Attribut `mail` gespeicherte Mail-Adresse zu. Beispiele dafür sind
`moodle`, `owncloud`, ...

Standardmäßig wird für diesen Zweck die interne Mailadresse des
linuxmuster.net Servers verwendet (<Benutzer>@<Domain>).

Diese Dokumentation beschreibt, wie man von diesem Standard abweichen
und die hinterlegte Adresse mit der Schulkonsole bearbeiten kann. Die
Installation sollte der Netzwerkbetreuer oder Administrator
ausführen. Jeder Nutzer kann dann selbst seine eigene Adresse
verwalten. Sollte für einen Benutzer keine Adresse eingetragen sein,
wird automatisch oben genannte Standardadresse verwendet.

.. toctree::
   :maxdepth: 2

   installation
   nutzung

Weitere Informationen
---------------------

- `Hintergrundinformationen zum Thema dieses Kapitels <http://www.linuxmuster.net/flyspray/task/508>`_
- :ref:`use-horde-label`
- `Hintergrundinformationen zur Nutzung des internen Webmailers <https://www.linuxmuster.net/wiki/dokumentation:techsheets:hordeconfiguration>`_
- `Hintergrundinformationen zum Betrieb eines Mailservers <https://www.linuxmuster.net/wiki/dokumentation:techsheets:mailserver>`_
- `Hintergrundinformationen zur Änderung der Domain <https://www.linuxmuster.net/wiki/dokumentation:techsheets:linuxmustersetup>`_
- `Community-Dokumentation zur Thema Mail <https://www.linuxmuster.net/wiki/anwenderwiki:mail:start>`_    
