Weitere L2-Switches mit VLans anbinden
======================================

In der hier dargestellten Konfiguration des L3-Switches gibt es vier LAG-Ports.
Drei von diesen LAG-Ports (2,3,4) sind dazu gedacht, um eine Anbindung zu weiteren L2-Switches zu ermöglichen, die ebenfalls für die Nutzung der VLANs zu konfigurieren sind.

Wesentlich ist, dass ebenfalls alle VLANs, die auf dem L3-Switch eingerichtet wurden, hier ebenfalls erstellt werden. Danach muss eine LinkAggregation mit zwei Ports erstellt werden, die die Anbindung zum LAG-Port des L3-Switches zur Verfügung stellt. Diese LA ist dann als Trunk zu definieren, der alle VLANs (20,30,40,50,100,200) tagged.

Danach werden die einzelnen Ports als untagged Ports einem der gewünschten VLANs zugeordnet. Die Clients sind dann entsprechend auf den gewünschten VLAN-Port anzuschliessen.

Ist es ein Switch in einem PC-Raum, so ist der Uplink als LinkAggregation und Trunk mit den o.g. getaggten VLANs zu definieren. Alle anderen Ports sind dann z.B. als Access Ports zu definieren, die dem VLAN 100 (Raum 100) zugeordnet sind, so dass alle angeschlossenen PCs in diesem VLAN sind.

.. hint::

   Es sollten alle Switch Konfigurationen, VLANs und Port-Belegungen sehr genau pro Switch dokumentiert sein. Hierzu ist 
   es hilfreich in jedem Verteilerschrank eine entsprechende Dokumentation zu hinterlegen. Als Hilfestellung zur 
   Erstellung dieser Dokumentation kann folgende Datei dienen:

   :download:`Einfache Dokumentation mit Calc  <./media/filedownload/einfache_vlandoku_mit_calc.zip>`.
  

