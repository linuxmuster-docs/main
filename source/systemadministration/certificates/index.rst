.. include:: /guided-inst.subst
.. _renew-certificates-label:

Erneuerung der Zertifikate
==========================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_

Beim Setup des linuxmuster.net Servers wird ein selbst-signiertes Zertifikat auf dem Server und ggf. auf der Firewall OPNSense |reg| erstellt.

Aus verschiedenen Gründen kann es erforderlich sein, eines der oder alle Zertifikate oder gar die CA für die Zertifikate zu erneuern.

Hierzu gibt es auf dem Server das Skript ``linuxmuster-renew-certs``.

.. hint::

   noch zu testen und zu ergänzen


Das Skript
----------

Zur Erneuerung der beim Setup erstellten selbstsignierten Zertifikate gibt es das Skript ``linuxmuster-renew-certs``:

.. code::

   Usage: linuxmuster-renew-certs [options]
   [options] may be:
   -c <list>, --certs=<list> : Comma separated list of certificates to be renewed
                           	    ("ca", "server" and/or "firewall" or "all").
   -d <#>,    --days=<#>     : Set number of days (default: 7305).
   -f,        --force        : Skip security prompt.
   -n,        --dry-run      : Test only if the firewall certs can be renewed.
   -r,        --reboot       : Reboot server and firewall finally.
   -h,        --help         : Print this help.

Empfehlungen
------------

Es wird empfohlen, vor der Erneuerung des Firewallzertifikats zu überprüfen, ob die ursprünglich beim Setup erzeugte Zertifikatskette noch gültig ist und das Zertifikat erneuert werden kann (Option -n).

Nach erfolgter Zertifikatserneuerung müssen Server und/oder Firewall neu gestartet werden, damit Änderungen wirksam werden.
CA-, Server- und Firewallzertifikate könne unabhängig voneinander mit unterschiedlicher Gültigkeitsdauer erneuert werden (Option -c).

Wenn das CA-Zertifikat erneuert wird, müssen zwingend auch Server- und Firewallzertifikate erneuert werden, da diese auf der CA basieren.

Gültigkeitsdauer prüfen
-----------------------

• auf dem Server:

.. code::
      
   openssl x509 -in <pem-Datei> -noout -text

• auf der Firewall:
  - System: Sicherheit: Zertifikate
  - System: Zugang: Tester
  - Dienste: Squid: Einmalige Anmeldung: Kerberos-Authentifizierung


