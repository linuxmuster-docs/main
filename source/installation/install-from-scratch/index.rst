.. include:: ../../guided-inst.subst

.. _install-from-scratch-label:

====================
Install-from-Scratch
====================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster.net/u/cweikl>`_
                   `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

In diesem Dokument findest Du eine "Schritt-für-Schritt" Anleitung zur Installation der linuxmuster.net Musterlösung direkt auf der Hardware. Zugleich nutzt Du diese Anleitung zur Installation in vorbereitete VMs.

Lies zuerst die Abschnitte ":ref:`what-is-new-label`" und ":ref:`prerequisites-label`", bevor Du dieses Kapitel durcharbeitest.

Nach der Installation gemäß dieser Anleitung erhältst Du eine einsatzbereite Umgebung bestehend aus

* einer Firewall (OPNsense |reg| für linuxmuster.net),
* und einem Server (linuxmuster.net).

Im Laufe der Installation benötigst Du einen Admin-PC. Das kann ein einfacher Laptop mit einem beliebigen Betriebssystem sein.

**Vorgehensweise**

* Zunächst installierst Du die Firewall OPNsense |reg|.
* Gefolgt von der Installation des Ubuntu-Servers.
* Schließlich richtest Du linuxmuster.net ein.

.. toctree::
  :maxdepth: 1
  :caption: basis_opnsense
  :hidden:

  basis_opnsense
  basis_server
  lmn_pre_install
