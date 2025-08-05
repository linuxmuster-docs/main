.. include:: /guided-inst.subst

.. _migration-label:

===============================
 Migration auf linuxmuster 7.3
===============================

.. sectionauthor:: `@cweikl <https://ask.linuxmuster,net/u/cweikl>`_ 


Um auf die linuxmuster 7.3 zu migrieren:

1. linuxmuster 7.1 wird noch eingesetzt: Migriere zunächst auf linuxmuster v7.2 und migriere anschliessend die bisherigen Linbo 2.4 Images auf Linbo 4.
2. Führe für linuxmuster v7.2 ein Update auf die aktuellsten Pakete durch.
3. Falls Du OPNsense |reg| als Firewall einsetzt, aktualisiere diese auf Version > v25.1.
4. Führe danach das Release-Upgrade durch.

.. hint::

    Der Fileserver für inuxmuster.net 7.3 kann optional installiert werden (Drei-Server-Lösung. Es kann aber weiterhin wie bisher auch ein Weiterbetrieb als Zwei-Server-Lösung erfolgen. Wir empfehlen den Fileserver z.B. in einer eigenen VM zu installieren, da hierdurch deutliche Performancesteigerungen in Verbidnung mit Samba erreicht werden. Dies empfehlen wir insbesondere mittleren bis grösseren Schulen. Kleinere Schulen können problemlos linuxmuster.net 7.3 als Zwei-Server-Lösung weiterbetreiben.
    
    Grundsätzlich kann linuxmuster.net 7.3 weiterhin als Zwei-Server-Lösung betrieben werden und es kann jederzeit später eine Erweiterung / Umstellung auf den zusätzlichen File-Server erfolgen. Die Migration/ das Update auf v7.2 erfolgt zunächst immer als Zwei-Server-Lösung und es erfolgt danach eine Erweiterung um den Fileserver.


