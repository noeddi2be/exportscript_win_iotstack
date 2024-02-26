# Exportscript für IOTServer

## Allgemein
Der IOT-Server läuft auf einem Raspberry Pi. Die Zählerdaten werden in eine InfluxDB geschrieben. 
Mit dem Exportscript werden Queries für den Datenexport ausgeführt. Die einzelnen Measurements werden in einzelne CSV Dateien exportiert.
Anschliessend werden die einzelnen CSV Dateien in den Ordner Export (muss vorhanden sein) verschoben, sowie ebenfalls
auch zu einem einzelnen CSV und einem einzelnen Excel-File zusammengefügt.

Zum Ausführen die Verknüpfung "db.bat" ausführen.
Zugangsdaten für den IOTServer müssen angegeben werden.


## Beschreibung innerhalb des Bat-Files

### Export aus der Reader Datenbank
Fuer das Exportscript ist Python erforderlich.
Python kann aus dem Microsoft Store geladen werden.
Dateien befinden sich im Hauptordner unter Export.
echo.

Mit dem Tool koennen Daten aus einer InfluxDB ausgelesen werden.
Um die Daten auslesen zu koennen, muss sich das Geraet auf dem die Datenbank 
installiert ist im selben Netzwerk befinden.
Bei der Standardverbindung funktioniert nur der Testaufbau mit dem Reader AB6178.


### Anderer Reader
Bei einem anderen Reader muss die IP Addresse des Geraets mit der 
installierten InfluxDB ausgewaehlt werden. Zum Beispiel 192.168.1.15
Danach muss der richtige Port gewaehlt werden. Wenn nichts anderes auf der Datenbank 
eingestellt wurde ist dieser: 8086
Zuletzt muessen die letzten 4 Ziffern des Readers angegeben werden. 
Zum Beispiel AB6178.


### Eigene Verbindung eigener Datenbank
Es kann eine Datenbank mit eigenen Measurements abgefragt werden.
Dazu muessen wiederum die IP, der Port und der Name der Datenbank eingegeben werden. 
Ein Beispiel einer Datenbank ist: iot_devices.
Es muss die Anzahl der vorhandenen Measurements eingegeben werden. Zum Beispiel 5 - Fuer 5 verschiedene Werte.
Danach muessen alle 5 Namen der Measurements korrekt eingegeben werden und 
mit Enter bestaetigt werden.
