============================
 Zugriffsrechte im Netzwerk
============================

Zugriff über einen Proxy
========================

Standardmäßig sollen die Benutzer der Schulgeräte nur dann Zugriff auf
das Internet, wenn sie sich ausweisen können ("authentication"). Dies
geschieht über einen Webproxy, der in der Firewall läuft und der
wiederum auf den Schulgeräten als Proxy eingetragen sein muss.

Zugriff ohne Proxy
==================

In manchen Fällen will man Geräten zeitweilig oder permanent den
Zugriff auf das Internet geben.

Es gibt eine nicht aktivierte Regel "Allow entire LAN" die bei
Aktivierung aus dem LAN für alle Geräte uneingeschränkten Zugriff
erlaubt.

Darüberhinaus ist unter ``Firewall | Aliase`` ein "NoProxy"-Alias
angelegt, der die ersten zehn IP-Adressen des LAN-Netzwerks und
diejenigen der Server enthält. Für die Adressen dieses Aliases ist
eine aktive Regel "Allow NoProxy-Group" angelegt, die unbeschränkten
Zugriff auf das Internet erlaubt. Eine IP-Adresse aus diesem Pool kann
z.B. für einen Admin-PC oder für einen Masterclient verwendet werden.

