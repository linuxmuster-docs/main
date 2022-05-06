.. |-| unicode:: U+2013 .. Gedankenstrich

.. |zB| unicode:: z. U+00A0 B. .. Zum Beispiel 
  
.. |ua| unicode:: u. U+00A0 a. .. und andere

.. |_| unicode:: U+202F .. geschütztes Leerzeichen
   :trim:

.. |...| unicode:: U+2026 .. Auslassungszeichen
   :trim:

.. |copy| unicode:: 0xA9 .. Copyright-Zeichen
   :ltrim:

.. |reg| unicode:: U+00AE .. Trademark
   :ltrim:

.. include:: /guided-inst.subst

.. _install-from-scratch-label:

====================
Install-from-Scratch
====================

.. sectionauthor:: `@rettich <https://ask.linuxmuster.net/u/rettich>`_,
                   `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

In diesem Dokument findest du eine "Schritt-für-Schritt" Anleitung zur Installation der linuxmuster.net Musterlösung direkt auf der Hardware. 
Zugleich nutzt du diese Anleitung zur Installation in vorbereitete VMs.

Lies zuerst die Abschnitte ":ref:`what-is-new-label`" und
":ref:`prerequisites-label`", bevor du dieses Kapitel durcharbeitest.

Nach der Installation gemäß dieser Anleitung erhältst du eine
einsatzbereite Umgebung bestehend aus
 
* einer Firewall (OPNsense |reg| für linuxmuster.net),
* und einem Server (linuxmuster.net).

Im Laufe der Installation benötigst du einen Admin-PC. Das kann ein einfacher Laptop mit einem beliebigen Betriebssystem sein.  

**Vorgehensweise**

* Zunächst installierst du die Firewall OPNsense |reg|.
* Gefolgt von der Installation des Ubuntu-Servers.
* Schließlich richtest du linuxmuster.net ein.

.. toctree::
  :maxdepth: 1
  :caption: basis_opnsense
  :hidden:

  basis_opnsense
  basis_server
  lmn_pre_install
