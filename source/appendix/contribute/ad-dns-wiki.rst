.. include::/guided-inst.subst

=======================
Active Directory-Domäne
=======================

.. sectionauthor:: `@MachtDochNiX <https://ask.linuxmuster.net/u/MachtDochNiX>`_

Die Seite ist dem Wiki von samba.org entnommen

https://wiki.samba.org/index.php/Active_Directory_Naming_FAQ

und übersetzt mittels Deepl: 

https://www.deepl.com/translate

Einführung
==========

Das Auswählen eines Active-Directory-Domänennamens ist einer der wichtigsten Schritte beim Einrichten einer Domäne. Wichtig ist, dass er beim ersten Mal richtig gewählt wird, da eine spätere Änderung eine nicht triviale Aufgabe ist. Es gab religiöse Debatten zu diesem Thema, und die Empfehlungen von MS haben sich im Laufe der Zeit geändert.

Was ist eine Active Directory-Domäne?
=====================================

Eine Active-Directory-Domäne ist im Grunde dasselbe wie eine Internet-Domäne. Diese »definiert einen Bereich der administrativen Autonomie, Autorität und Kontrolle« für eine Gruppe von Computern. Active Directory-Domänennamen unterliegen denselben Regeln und Grundsätzen, die auch für herkömmliche Domain-Name-Systems (DNS) gelten. Um die Benennung von Active Directory-Domänen zu verstehen, ist es daher wichtig, DNS zu kennen.

Wie funktioniert DNS?
=====================

DNS ist das System, mit dem Namen in andere Datentypen für den Computergebrauch übersetzt werden, wie eine IP-Adresse (ein A-Datensatz) oder eine Reihe anderer Datensatztypen.

Eine häufig verwendete Analogie ist die eines Telefonbuchs. Ein DNS-Server dient als eine Art Computer-Telefonbuch, mit dem Computernamen schnell in IPs (oder andere Arten von Daten) übersetzt werden können. Dieses Telefonbuch ist jedoch gigantisch groß (es gibt allein ~4 Milliarden IPv4-Adressen) und diese ändert sich ständig, sodass DNS ein hierarchisches System verwendet, um zu bestimmen, welches Telefonbuch oder genauer gesagt welcher Namensserver für welche Adressensätze zuständig ist. 

Praktisch jedes Mal, wenn ein Domänenname aufgelöst wird, sei es durch einen Webbrowser oder eine andere Quelle, wird eine DNS-Anfrage gestellt. Die eigentliche Namensauflösung in Windows ist ein etwas komplexes Thema, aber im Allgemeinen prüft ein Windows-PC seinen lokalen Namen, dann seine Hosts-Datei und stellt dann eine DNS-Anfrage (es sei denn, der Name befindet sich im Cache). Die DNS-Namensserver suchen dann nach der Adresse und geben eine Antwort zurück oder leiten die Anfrage an einen anderen Server zur Auflösung weiter, wenn es sich um einen rekursiven DNS-Server handelt. 

Active Directory DNS-Server sind in der Regel rekursiv und bedienen alle DNS-Anfragen für PCs innerhalb der Domäne. DNS-Namen müssen nicht unbedingt auf eine einzige Adresse aufgelöst werden, diese können auch mehreren anderen Einträgen entsprechen und sogar rekursiv auf andere Einträge verweisen, indem Einträge wie CNAME verwendet werden.

DNS-Anfragen werden hauptsächlich über UDP gesendet. Bei UDP gibt es keine Garantie für die Zustellung von Nachrichten oder Antworten, und da die Benutzer erwarten, dass die Namensauflösung schnell und nahtlos erfolgt, ist die Zeitspanne für eine DNS-Antwort kurz (3 Sekunden ist der Windows-Standard, 5 Sekunden der Linux-Standard). Im Großen und Ganzen ist DNS schnell und zuverlässig, aber es ist wichtig, daran zu denken, dass es sporadisch zu einem Fehler bei der Namensauflösung kommen kann.

DNS-Hierarchie 
--------------

Ein DNS-Name wird durch Punkte in verschiedene Teile unterteilt. Jedes Segment steht für einen anderen Teil der Hierarchie, eine sogenannte Domäne.

Das erste Segment von rechts (.de, .com, .net usw.) wird als Top-Level-Domain (TLD) bezeichnet, jede darunter liegende Domain wird als Subdomain bezeichnet.

Diese Subdomains können ihrerseits Subdomains enthalten, die bis zu 127 Ebenen tief sind.

So ist »example.com« eine Subdomäne der Domäne .com und kann selbst mehrere Subdomänen wie »samdom.example.com« enthalten.

Ein DNS-Name, der auf ein bestimmtes Gerät oder eine bestimmte Datei verweist, wird als »Fully qualified Domain Name« (FQDN) bezeichnet. Technisch gesehen sollte ein FQDN auch die Root-Zone angeben, bei der es sich um einen leeren Domänennamen handelt, der durch einen Punkt am Ende des Domänennamens angegeben wird, z. B. »www.samdom.example.com.«, aber in der Praxis wird die Root-Zone oft weggelassen.

Jeder DNS-Namensserver ist für verschiedene Teile dieser Hierarchie zuständig, die als Zone bezeichnet werden. Eine Zone besteht aus einem DNS-Namen, z. B. »samdom.example.com«, und allen Namen unterhalb dieser Ebene, z. B. »www.samdom.example.com«, »ftp.samdom.example.com« oder »server.samdom.example.com«.

DNS-Server geben autoritative oder endgültige Antworten auf Anfragen mit den Zonen, für die sie konfiguriert sind.

Weitere Einzelheiten zu diesem Verfahren findest Du auf der [http://en.wikipedia.org/wiki/DNS#Address_resolution_mechanism Wikipedia DNS-Seite].

Warum das wichtig ist?
----------------------

Der Domänenname, den Du für Deine Active Directory-Domäne auswählst, wird auch die primäre Domäne sein, für die der AD DNS-Server autorisierend ist.

Alle Ihre PCs in Active Directory haben einen Namen innerhalb dieser Domäne. Damit Active Directory ordnungsgemäß funktioniert, müssen alle Computer, die Teil davon sind, diese Namen korrekt auflösen können.
Das bedeutet, dass er als DNS-Server für alle PCs innerhalb Ihrer Domäne fungieren muss.

Probleme können entstehen, wenn ein DNS-Konflikt auftritt, d. h. wenn zwei DNS-Server denselben Namen für zwei verschiedene Adressen auflösen. Ein DNS-Konflikt ist nicht dasselbe wie ein IP-Adressenkonflikt, er verhindert nicht den Netzwerkverkehr, aber wenn er auftritt, kann man oft das Problem haben, dass der Verkehr zu Adressen fließt, die man nicht beabsichtigt, oder dass Namen, die man aufgelöst haben möchte, überhaupt nicht aufgelöst werden.

Wenn Du unter anderem Deine AD-Domäne »samdom.example.com« nennen, wäre Ihr AD-DNS-Server natürlich für alle Anfragen auf oder unterhalb der Hierarchieebene »samdom.example.com« maßgebend. Er würde direkt auf alle Anfragen für Namen innerhalb dieser Domäne wie »workstation.samdom.example.com« oder »server.samdom.example.com« oder jeden anderen im DNS-Server konfigurierten Namen antworten.

Wenn Su www.samba.org anfragen würdest, wäre das auch kein Problem. Der Server würde erkennen, dass er für die Domäne samba.org nicht maßgeblich ist, und die Anfrage an den Server weiterleiten, der für den Namen zuständig ist, und Dir dann die Antwort zurückschicken.

Was aber, wenn Du auch eine externe Website wie »www.samdom.example.com« hast, die wahrscheinlich von einem anderen externen DNS-Server verwaltet wird? Wenn Du diesen Namen anfordern, wird der DNS-Server feststellen, dass er für die Domäne »samdom.example.com« zuständig ist, und eine Antwort für suchen. Wenn dieser keine Antwort hat, wird die Anfrage nicht an einen anderen Server weitergeleitet, da davon auszugehen ist, dass dieser DNS-Server letzte Autorität für diese Domäne ist. Daher wird dieser Dir die Antwort »kein solcher Name existiert« oder NXDOMAIN zurückgeben.

Auswirkungen auf die Sicherheit 
-------------------------------

Obwohl es sich technisch gesehen nicht um einen Aspekt der Benennung von Domänen an sich handelt, sind die Sicherheitsaspekte von DNS essenziell zu beachten. Ihr AD DNS-Server enthält eine Liste aller PCs innerhalb Ihres Netzwerks. Die meisten DNS-Server lassen es nicht zu, dass jemand eine vollständige Liste von Domänennamen anfordert (auch als Zonentransfer bekannt). Aber es stellt eine die Möglichkeit dar, dass Geräte außerhalb Ihrer Domäne Namen aus dieser Liste auflösen. Dieses ist eine unnötige Preisgabe interner Informationen und stellt ein mögliches Sicherheitsrisiko dar. Ebenso sind die meisten AD-DNS-Server rekursiv, und der Betrieb eines rekursiven DNS-Servers im Internet hat erhebliche Sicherheitsauswirkungen, die über den Rahmen dieser Dokumentation hinausgehen.

Ebenso solltest Du keine DNS-Anfragen für interne Namen außerhalb des internen Netzwerks senden. Selbst wenn Du dem DNS-Server, an den Du diese sendest, vertraust, ist DNS nicht verschlüsselt, sodass jeder Router, der den Datenverkehr weiterleitet, ein ernsthaftes Sicherheitsrisiko darstellt. Ein Angreifer, der diesen Datenverkehr kontrolliert, könnte den Datenverkehr Ihres PCs an jeden beliebigen Ort leiten.

Aus diesen Gründen sollte ein sicherer AD DNS-Server nur auf Anfragen reagieren, die von innerhalb Ihres Netzwerks kommen, und ein anderer DNS-Server sollte DNS-Anfragen von außerhalb Ihres Netzwerks bearbeiten. Außerdem sollten alle Ihre Arbeitsstationen so konfiguriert werden, dass diese nur den eigenen AD DNS-Server für DNS-Anfragen heranziehen und keine externen DNS-Server. Dies ist bekannt als [https://en.wikipedia.org/wiki/Split-horizon_DNS split-horizon DNS].

NetBIOS-Namen
=============

Bevor Windows DNS nutzte, stützte es sich auf ein anderes Benennungssystem NetBIOS (technisch NetBIOS-NS), und den Windows Internet Name Service (WINS).

NetBIOS ähnelt DNS insofern, als es als Verzeichnisdienst dienen kann, ist aber eingeschränkter, da es keine Bestimmungen für eine Namenshierarchie hat und die Namen auf 15 Zeichen begrenzt waren. NetBIOS bietet jedoch ein Mittel zur Peer-to-Peer-Namensauflösung über die Layer-2-Rundfunkdomäne (alle PCs innerhalb desselben Subnetzes).

Microsoft hat dies mit WINS erweitert, um die Namensauflösung über Layer 3 (geroutete) Netzwerke zu ermöglichen. Wenn die Namensauflösung in einem Netzwerk ohne DNS-Dienst funktioniert, wird diese wahrscheinlich von NetBIOS durchgeführt.

Die Tage dieser Systeme liegen zwar größtenteils hinter uns, aber Spuren dieses Altsystems sind noch überall in Windows zu finden.

Beispielsweise sind einige Aspekte des Windows-Netzwerks, wie Networking Neighbourhood und seine Nachkommen, immer noch auf diesen Dienst angewiesen. Insbesondere hat jede AD-Domäne neben ihrem traditionellen DNS-Namen auch einen NetBIOS-Namen. Und jeder Computer in Ihrer Domäne hat auch einen NetBIOS-Namen (selbst wenn Du den NetBIOS-Namensdienst ausschalten). In den meisten Fällen sind dies die ersten 15 Zeichen des PC-Namens.

Warum das wichtig ist?
----------------------

So wie DNS-Namen in Konflikt geraten können, können auch NetBIOS-Namen in Konflikt geraten.

In den meisten Fällen stellt dies kein Problem dar. Windows fragt NetBIOS als letzte Möglichkeit zur Namensauflösung ab, und ohne einen WINS-Server in Ihrem Netzwerk können NetBIOS-Namen die Schicht 2 (das Subnetz) nicht überqueren. Active Directory verhindert zwar bereits, dass Du PCs mit doppelten Namen hast, aber nicht, dass Du doppelte NetBIOS-Namen haben, was im Allgemeinen nur dann der Fall wäre, wenn die ersten 15 Ziffern Ihres Computernamens identisch wären. Solche Namenskonflikte sollten vermieden werden.

NetBIOS-Domänenbenennung 
------------------------

Da NetBIOS [https://support.microsoft.com/en-us/kb/188997 sehr wenige Möglichkeiten hat, welche Domänennamen akzeptabel sind, kannst Du nur wenig tun, um mögliche Namenskonflikte zu vermeiden.

Typischerweise wird empfohlen, den ersten Teil des Domänennamens für die NetBIOS-Domäne zu verwenden (Anmerkung: dies ist ein anderer Name für "Arbeitsgruppe"). Wenn Ihr Domänenname zum Beispiel "samdom.example.com" lautet, kannst Du den NetBIOS-Namen "SAMDOM" wählen.

Was auch immer Du für Deinen NetBIOS-Namen verwendest, achte darauf, dass dieser nur aus einem Wort besteht, nicht länger als 15 Zeichen ist und keine Satzzeichen enthält, auch keine Punkte '.' . Dies scheint besonders bei Windows 10-Clients wichtig zu sein, da es Berichte gibt, dass diese der Domäne nicht beitreten können, wenn der NetBIOS-Domänenname einen Punkt enthält.

Wie soll ich meine Domäne benennen?
===================================

Bevor wir uns Ihre Optionen ansehen, lass uns einige wünschenswerte Eigenschaften betrachten, die unser Domänenname haben sollte:

* Der Domänenname sollte weltweit eindeutig sein. Dadurch wird sichergestellt, dass der Name unabhängig von der Konfiguration des Computers für die DNS-Auflösung entweder richtig aufgelöst wird oder keine Domäne (NXDOMAIN) ergibt. Es sollte nie einen Konflikt mit dem Domänennamen geben!

* Die Domäne sollte mit Ihrer Organisation assoziiert sein. Der Domänenname sollte idealerweise einen Bezug zu Ihrer Organisation haben, damit er leicht zu merken ist.

* Die Domäne sollte unter Ihrer Kontrolle stehen. Ein Domänenname, den Du kontrollierst (weil Du der eingetragene Eigentümer sind), hilft, böswillige Nutzung zu verhindern. Die Registrierung eines Domänennamens ist billig und für jedes Unternehmen ohnehin wünschenswert.

* Der Domänenname sollte immer noch ein gültiger Domänenname sein, sodass Du auf Wunsch SSL-Zertifikate von Drittanbietern dafür erhalten können.

* Der FQDN für einen Active-Directory-Domänennamen ist auf 64 Byte begrenzt, einschließlich der Punkte, ein Active-Directory-Servername zum Beispiel: »s4ad01.office.example.tld«

* Welchen Domänennamen Du auch immer verwendest, dieser sollte nicht über das Internet auflösbar sein. Es ist keine gute Idee, einen AD-Domänen-Computer direkt mit dem Internet zu verbinden.

Mit diesen Kriterien im Hinterkopf können wir uns nun einige Ihrer Optionen ansehen:

Subdomain einer eigenen Domäne 
==============================

In diesem Szenario würdest Du Deine Domäne nach dem Muster »subdomain.domainyouown.tld« benennen, z. B. »samdom.example.com«. Dies ist in der Regel die beste Option, die Du wählen kannst! Dies steht auch im Einklang mit den aktuellen [https://technet.microsoft.com/en-us/library/cc738121%28WS.10%29.aspx best practices] von Microsoft.

Der Name der Subdomain kann zwar beliebig gewählt werden, aber es ist wahrscheinlich eine gute Idee, ihn kurz und einfach zu halten (z. B. »ad.«). Diese Art von Name erfüllt alle oben genannten Kriterien, die wir für einen wünschenswerten Domänennamen aufgestellt haben, vor allem aber:

* Er ist weltweit einzigartig. Da Du die Registrierung der Domäne im Netz (und vermutlich auch deren DNS-Einträge) kontrollieren, kannst Du sicherstellen, dass die von Ihnen intern verwendete Domäne nicht nach außen hin aufgelöst wird.

* Es handelt sich um einen gültigen Domänennamen für den Abruf von SSL-Zertifikaten von Drittanbietern.

Wichtiger Hinweis
-----------------

Bei der Benennung Ihrer Domäne erzeugen Windows und samba-tool auch einen [https://technet.microsoft.com/en-us/library/cc961556.aspx suggestion] Legacy-NetBIOS-Domänennamen.

Standardmäßig sind dies die ersten 15 Zeichen des Domänennamens ganz links.

Wenn Ihre Domäne also "ad.example.com" heißt, dann wäre der Standardvorschlag einfach "AD".

Die Auswahl eines solchen NetBIOS-Domänennamens wäre keine gute Idee, da es sehr wahrscheinlich zu Konflikten mit anderen Domänen kommen würde, die denselben NetBIOS-Namen haben. Dies würde ein Problem darstellen, wenn Du jemals eine Vertrauensbeziehung zwischen diesen beiden Domänen einrichten müssten. Wähle stattdessen einen benutzerdefinierten Namen, der auf Ihrem Domänennamen basiert, z. B. »BEISPIEL« für eine Domäne namens "ad.example.com".

Häufige Einwände
----------------

Meine Benutzer-Logins stimmen nicht mit meiner E-Mail überein
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Es ist richtig, dass der Teil des Benutzernamens, der auf das @-Zeichen folgt, der User Principle Name Suffix (UPN-Suffix), standardmäßig dem Domänennamen entspricht und daher bei diesem Schema standardmäßig "subdomain.domain.tld" lautet. Der UPN Suffix ist jedoch beliebig und konfigurierbar. Du kannst [https://technet.microsoft.com/en-us/library/cc772007.aspx konfigurieren], was immer Du willst, einschließlich der E-Mail Ihrer Benutzer. Er muss für alle Sicherheitsprinzipalobjekte innerhalb einer Verzeichnisstruktur eindeutig sein. Das bedeutet, dass der Präfix eines UPNs wiederverwendet werden kann, nur nicht mit demselben Suffix.

Er unterliegt den folgenden Beschränkungen:

Er muss der DNS-Name einer Domäne sein, muss aber nicht der Name der Domäne sein, die den Benutzer enthält.
Es muss der Name einer Domäne in der aktuellen Domänenstruktur sein (was in Samba AD dasselbe bedeutet), oder ein alternativer Name, der im upnSuffixes-Attribut des Containers Partitionen im Container Konfiguration aufgeführt ist.

Der Stil des Domänennamens ist zu lang
++++++++++++++++++++++++++++++++++++++

Der Zusatz des Suffixes kann so kurz sein, wie Du es Dir wünscht (die Verwendung von nur "ad" oder "ds" ist sehr üblich). Das Eintippen des Domänennamens kann jedoch ganz vermieden werden, indem die Variablen DNS-Suffix und DNS-Suffix-Suchliste gesetzt werden. Wenn diese Variablen gesetzt sind, versuchen die Clients, Single-Label-Domainnamen wie "server" als "server.dnssuffix.tld" aufzulösen. Dies gilt sogar für Zertifikate, sodass Du ein Zertifikat für einen internen Server ausstellen können, das für »https://server/« anstelle von »https://server.samdom.example.com« gilt, wenn Du möchtest. Und wenn Du irgendwann einmal die Verwendung des DNS-Such-Suffixes bei einer DNS-Anfrage vermeiden müssen, kannst Du dies tun, indem Du den FQDN angibst und dabei daran denkst, den abschließenden ».« für die Root-Zone einzuschließen.

Dies funktioniert nicht mit meiner externen Domäne
++++++++++++++++++++++++++++++++++++++++++++++++++

Diese Annahme ist falsch. Der AD DNS-Server ist nur für diese eine Subdomain und die darunter liegenden Namen autoritativ. Er ist nicht für andere Domänennamen zuständig. Wenn Ihr AD-Domänenname also "samdom.example.com" lautet und Du möchtest den Namen "www.example.com" auflösen, wird erkannt, dass der DNS-Server für "www.example.com" nicht autoritativ ist, und die Anfrage an den externen Server weiterleiten, der für diese Domäne autoritativ ist.

Mein NetBIOS-Name kann in Konflikt geraten
++++++++++++++++++++++++++++++++++++++++++

Eine berechtigte Sorge. Der von samba-tool und im Windows DC Promo-Assistenten vorgeschlagene Name ist jedoch nur ein Vorschlag. Du kannst jeden beliebigen NetBIOS-Namen wählen. Die Wahl eines Namens, der auf Ihrem Domänennamen basiert, könnte eine gute Alternative sein, oder wähle einen anderen assoziativen, aber eindeutigen Namen für den NetBIOS-Domänennamen.

Unterschiedliche Namen verwenden, um Hostnamen intern und extern aufzulösen.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ja, da bei diesem Schema kein DNS-Dienst außerhalb Ihres Netzes Namen innerhalb des Netzes auflösen kann, ist ein anderer DNS-Name erforderlich, um denselben Computer innerhalb Deines Netzes aufzulösen. In den meisten Fällen ist dies eine gute Sache, denn die interne und die externe Adresse von Computern sind im Allgemeinen grundverschieden und haben unterschiedliche IP-Adressen.

In manchen Situationen ist es jedoch nicht ratsam, diese zusätzliche Komplikation in Ihre Konfigurationen aufzunehmen. Wenn Du z. B. E-Mail-Einstellungen verteilen, die von den Benutzern konfiguriert werden müssen, könnte die zusätzliche Komplexität, die sich aus der Verwendung eines unterschiedlichen E-Mail-Schemas extern und intern ergibt, für die Benutzer zu komplizioert sein. Auf mobilen Geräten ist dieses Schema möglicherweise nicht einmal praktikabel. Zum Glück gibt es einige Lösungen für dieses Problem:

* Erlaubst Du, dass der Datenverkehr für den externen Namen nach außen und zurück in Ihr Netzwerk geleitet wird.

  Für diese Einrichtung ist oft keine zusätzliche Konfiguration erforderlich. Der an externe IP-Adressen gebundene Datenverkehr kann im Allgemeinen wie jeder andere an das Internet gebundene Datenverkehr behandelt werden, auch wenn sein Ziel letztendlich wieder innerhalb Ihres Netzes liegt.

* Erstelle eine DNS-Zone, die nur den gewünschten Namen auflöst.:

  Es gibt einen Trick, mit dem Du in AD DNS nur einen einzigen Host innerhalb einer Zone auflösen können, während der Rest der Hosts normal vom externen Server aufgelöst wird. Erstelle eine DNS-Zone mit dem Namen "host.domain.tld", zum Beispiel "mail.example.com". Erstelle innerhalb der Zone einen einzelnen A- oder CNAME-Eintrag (CNAME ist wahrscheinlich vorzuziehen), wobei Du den Namen des Eintrags leer läßt. Wie Du im Dialogfeld sehen, wird dieser Name zur Auflösung der übergeordneten Domäne verwendet, in diesem Fall "host.domain.tld".

  "host.domain.tld" wird wie von Dir angegeben von Ihrem DNS-Server aufgelöst, während Anfragen an andere Hosts unter "domain.tld" extern aufgelöst werden, da "host.domain.tld" und "domain.tld" verschiedenen Zonen entsprechen. Wenn Du einen CNAME als übergeordneten Eintrag verwendest, kannst Du diesen auf den Eintrag in Ihrem internen Domänennamen zurückverweisen.

Verwendung einer ungültigen TLD
===============================

In diesem Szenario würdest Du Deine Domäne im Format "domain.invalid.tld" benennen, z. B. »SAMDOM.loca«. Die Verwendung einer ungültigen Top-Level-Domain (TLD) wie .local oder .internal war früher eine sehr gängige Praxis. Tatsächlich waren alle Versionen von Microsofts Small Business Servern so konfiguriert, dass diese eine Domäne in Form von "domain.local" verwendeten. Da die TLD .local offiziell von der ICANN reserviert ist, kannst Du auch sicher sein, dass kein externer DNS-Server diese Domäne auflösen wird. Diese Art von Namen hat jedoch einige wesentliche Probleme:

* Die TLD .local wird von einigen Zeroconf-Systemen verwendet, vor allem von Apples Bonjour-Dienst. Die gleichzeitige Verwendung dieser beiden TLDs wird nicht korrekt funktionieren.

* Ungültige TLDs wie .local oder .internal werden bald nicht mehr in der Lage sein, SSL-Zertifikate von einem der großen Zertifikatsanbieter zu erhalten. Das CA/Browser Forum hat [https://www.digicert.com/internal-names.htm?SSAID=314743 beschlossen], dass für diese ungültigen Domains ab dem 1. November 2015 keine Zertifikate mehr ausgestellt werden sollen. Tatsächlich kannst Du jetzt kein Zertifikat für diese Namen erwerben, wenn diese nach diesem Datum ablaufen. Dies gilt auch für Subject Alternative Names (SAN), die in ansonsten gültigen Zertifikaten verwendet werden (dies ist eine sehr häufige Konfiguration für Microsoft Exchange). Interne Zertifizierungsstellen haben zwar keine solche Einschränkung, aber es ist immer gut, diese Möglichkeit zu haben.

* Es ist möglich, dass die ungültige TLD, die Du jetzt verwendest, in Zukunft zu einer gültigen TLD wird. Während .local von der ICANN reserviert ist, ist für das TLD-System derzeit eine enorme [http://www.gtld.com/ Erweiterung] der von ihm unterstützten generischen TLD (gTLD) geplant, von 22 auf über tausend neue Namen. Dieser Trend wird sich wahrscheinlich fortsetzen.

Aus demselben Grund sollten Namen mit anderen ungültigen TLDs vermieden werden, einschließlich .internal und .lan.

Verwendung Ihres externen Domänennamens
=======================================

In diesem Szenario verwendest Du einfach intern Ihren externen Domänennamen im Format "domain.tld", zum Beispiel "example.com". Dies ist zwar eine gute Option, kann aber auch Ihr DNS-System unnötig kompliziert machen. Wie bereits erläutert, besteht bei einem solchen System die Möglichkeit eines Domänennamenkonflikts, in der Regel zwischen einem Namen, der entweder intern nicht vorhanden ist, oder einem Namen, der extern anders aufgelöst wird als intern. Dies kann dadurch gelöst werden, dass Du die Einträge auf dem externen Server auf Ihrem internen Server duplizieren. Dies kann jedoch unpraktikabel sein, wenn Du viele externe DNS-Einträge hastn oder diese häufig wechselst. Du kannst und sollten ein internes Benennungsschema wählen, das niemals mit Ihrem externen Benennungsschema kollidiert.

Verwendung eines generischen Domänennamens
==========================================

Es wurde vorgeschlagen, dass für Organisationen, die viele Fusionen und Übernahmen durchführen, die Verwendung eines generischen Domänennamens wie "corp.local" eine gute Option sein könnte. Da die Umbenennung und Migration von Domänen oft ein schwieriges und kostspieliges Unterfangen ist, mag dies eine gewisse Berechtigung haben. Aber es gibt keine Garantie dafür, dass der gewählte Domänenname nicht von einem anderen Verwalter gewählt wird, der in dieselbe Richtung denkt wie man selbst. Dies würde eine Domänenfusion erheblich erschweren. Außerdem kann der generische Name zwar vor den Nutzern durch benutzerdefinierte UPN-Suffixe und DNS-Such-Suffixe verborgen werden, aber ein alter Domänenname mit garantierter Einzigartigkeit könnte auf die gleiche Weise verborgen werden.

Verwendung eines anderen Domänennamens
======================================

In diesem Szenario verwendest Du einen anderen, nicht verwendeten Domänennamen als Ihren primären Internet-Domänennamen. Du kannst zum Beispiel eine andere TLD ("example.net" im Gegensatz zu "example.com") oder einen völlig anderen Domänennamen verwenden, der jedoch ganz normal bei der ICANN registriert ist. Der angebliche Vorteil dieses Systems ist die Möglichkeit, einige Domänennamen (z. B. "mail.domain.tld") intern und extern über denselben Namen aufzulösen.

Dies ist zwar im Großen und Ganzen richtig, doch kann derselbe Effekt auch bei anderen Systemen durch einige DNS-Tricks (siehe oben) erzielt werden. Außerdem besteht jedes Mal, wenn Du Namen extern anders auflöst als intern, die Möglichkeit eines unerwünschten DNS-Namenskonflikts, sodass es fraglich ist, ob es überhaupt wünschenswert ist, dies für die gesamte Domäne zu tun.

This scheme also leaks a minor amount of sensitive information (the domain name) onto the net, and represents a minor additional cost (the cost of the domain registration), while offering only marginal advantages. It may however be a valid option for some organizations, such a scheme is often used by ISPs and other internet focused organizations.

