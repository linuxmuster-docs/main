.. HOWTO E-Mail im LDAP documentation master file, created by Frank Schütte
   sphinx-quickstart on Sun Jan 31 13:14:00 2016.

linuxmuster.net: E-Mail-Adressen im LDAP verwalten
==================================================

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

Weitere Informationen zu diesem Thema finden Sie unter http://www.linuxmuster.net/flyspray/task/508.

.. toctree::
   :maxdepth: 2

   installation
   nutzung

