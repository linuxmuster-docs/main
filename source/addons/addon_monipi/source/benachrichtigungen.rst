Benachrichtigungen im Fehlerfall
================================

Auf dem MoniPi ist im Auslieferungszunstand kein aktiver Benachrichtigungsweg konfiguriert. 
Um Fehler sehen zu können muss man sich am Webinterface anmelden, was natürlich nicht 
alltagstauglich ist.

Um dieses Problem zu lösen, sei an dieser Stelle auf verschiedene Apps verwiesen, mit 
denen man den Status seines MoniPi anzeigen lassen kann.

- `"Nagios Checker" Extension für Firefox <https://addons.mozilla.org/de/firefox/addon/nagios-checker/>`_
- `"aNag" Android App <https://play.google.com/store/apps/details?id=info.degois.damien.android.aNag>`_

Für Chromium/Chrome und iOS stehen ebenfalls Ereiterungen und Apps zur Verfügung, prinzipiell sollte jede App
funktionieren, die Nagios/Icinga Instanzen abfragen kann.

Wenn man Benachrichtigungen per Mail wünscht, muss man zunächst auf der Konsole 
dem MoniPi Mailversand "beibringen" und anschließend in der Konfiguration von Check-MK
entsprechende Notifications definieren.

