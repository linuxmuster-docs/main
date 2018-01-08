Netzsegmentierung - Grundlagen
==============================

In Schulen sind Netzwerke grundsätzlich in getrennte logische Bereiche zu unterteilen und voneinander zu trennen. In allen Bundesländern gibt es die Vorgabe, dass das schulische Verwaltungsnetz vom sog. pädagogischen Netz zu trennen ist.

Für das pädagogische Schulnetz wird darüber hinaus empfohlen, dieses aus datenschutzrechtlichen Gründen in wenigstens drei logische Subnetze zu untergliedern: Lehrernetz, Schülernetz und Servernetz. 
Bei größeren Netzinstallationen ist aufgrund der Performance zudem anzuraten, weitere logische Subnetze zu erstellen, so dass z.B. pro Computerraum ein weiteres Subnetz erstellt wird.

Grundlegende Informationen zum Aufbau von Schulnetzen und deren Untergliederung mithilfe von VLANs finden sich auf der Seite `Lehrer*innenfortbildung BW - IT-Infrastruktur an Schulen
<https://lehrerfortbildung-bw.de/st_digital/netz/it-infrastruktur/fb1/1_swi_lan/>`_

In dieser Dokumentation soll der Fall dokumentiert werden, dass das pädagogische Netzwerk in mehrere Segmente aufgeteilt wird und diese über das gesamte Netzwerk hinweg genutzt werden. Hierbei wird eingangs die Struktur erläutert, die mithilfe der Netzsegmentiertung erreicht werden soll. Im Anschluss wird schrittweise deren Umsetzung mithilfe von sog. L2-Switches, L3-Switches und die erforderliche Anpassung von linuxmuster.net dargestellt. Hierzu werden die Konfigurationsschritte am Beispiel eines Cisco SG300 L3-Switches und der Anbindung eines L2-Switches anhand eines HP2650 L2-Switches dargestellt.

Es können ebenfalls andere managebare L2- und L3-Switches eingesetzt werden. Die Konfigurationsschritte sind dann entsprechend auf die jeweiligen Geräte anzupassen. Entscheidend für die Anpassung dieser Schritte ist es, das Segmentierungskonzept nachvollzogen zu haben.
 
Eine Erweiterung (oder Reduzierung) um weitere Subnetzbereiche, beispielsweise klassenraumweise oder der Wegfall der DMZ, ist ohne Schwierigkeiten möglich. 

.. toctree::
   :maxdepth: 2

   preface
   server-preparation
   switch-preparation
   switch-configuration
   switch-cascading
   server-setup
   troubleshooting
