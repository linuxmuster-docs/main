Netzsegmentierung - Grundlagen
==============================

Im `aktuellen Netzbrief
<http://www.it.kultus-bw.de/,Lde/Startseite/IT-Sicherheit/Netztechnik+_+Netzbrief>`_
des Landes Baden-Württemberg wird empfohlen, das Schulnetzwerk aus
datenschutzrechtichen Erwägungen in mindestens drei Subnetze zu untergliedern: Lehrernetz,
Schülernetz und Servernetz. 

Sehr ausführliche Informationen, wie  dies in linuxmuster.net umgesetzt 
werden kann finden Sie im `linuxmuster.net Wiki <http://www.linuxmuster.net/wiki/dokumentation:addons:subnetting:start>`_

Diese Anleitung soll den einfachsten Spezialfall dokumentieren, 
das Netz in drei Segmente aufzuteilen, so dass die 
Vorgaben des Netzbriefs erfüllt sind.

Eine Erweiterug um weitere Subnetzbereiche, beispielsweise Klassenraumweise, 
ist später ohne Schwierigkeiten möglich. 

Inhalt:

.. toctree::
   :maxdepth: 2

   preface
   server-preparation
   switch-preparation
   switch-configuration
   switch-cascading
   server-setup
