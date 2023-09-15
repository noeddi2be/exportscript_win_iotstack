@echo off
mode 150,50

rem Readme Scection

echo.
echo README
echo.
echo.
echo Export aus der Reader Datenbank
echo ===============================
echo.
echo.
echo Fuer das Exportscript ist Python erforderlich.
echo Python kann aus dem Microsoft Store geladen werden.
echo Dateien befinden sich im Hauptordner unter Export.
echo.
echo Mit dem Tool koennen Daten aus einer InfluxDB ausgelesen werden.
echo Um die Daten auslesen zu koennen, muss sich das Geraet auf dem die Datenbank 
echo installiert ist im selben Netzwerk befinden.
echo Es kann die Standardverbindung oder eine eigene Verbindung gewaehlt werden. 
echo Bei der Standardverbindung funktioniert nur der Testaufbau mit dem Reader AB6178.
echo.
echo.
echo Anderer Reader 
echo ==============
echo. 
echo Bei einem anderen Reader muss die IP Addresse des Geraets mit der 
echo installierten InfluxDB ausgewaehlt werden. Zum Beispiel 192.168.1.15
echo Danach muss der richtige Port gewaehlt werden. Wenn nichts anderes auf der Datenbank 
echo eingestellt wurde ist dieser: 8086
echo Zuletzt muessen die letzten 4 Ziffern des Readers angegeben werden. 
echo Zum Beispiel AB6178.
echo.
echo.
echo Eigene Verbindung eigener Datenbank
echo ===================================
echo.
echo Es kann eine Datenbank mit eigenen Measurements abgefragt werden.
echo Dazu muessen wiederum die IP, der Port und der Name der Datenbank eingegeben werden. 
echo Ein Beispiel einer Datenbank ist: iot_devices.
echo Es muss die Anzahl der vorhandenen Measurements eingegeben werden. Zum Beispiel 5 - Fuer 5 verschiedene Werte.
echo Danach muessen alle 5 Namen der Measurements korrekt eingegeben werden und 
echo mit Enter bestaetigt werden.
echo. 
echo. 
echo.



rem Initialisierung Variablen
set asw=0
set ip=""
set port=""
set database=""



rem Auswahl
echo   [1] Standardverbindung
echo   [2] Eigene Verbindung zu Reader Datenbank mit Standartwerten
echo   [3] Eigene Verbindung zu eigener Datenbank mit eigenen Measurements
echo.
echo.
set /p asw="Bitte Auswahl eingeben: "

if %asw%==1 goto standard
if %asw%==2 goto reader
if %asw%==3 goto eigen

if %asw% LSS 1 goto error
if %asw% GTR 3 goto error

:error
echo Falsche eingabe, versuche es erneut!
echo.
set /p asw="Bitte Auswahl eingeben: "

if %asw%==1 goto standard
if %asw%==2 goto reader
if %asw%==3 goto eigen

if %asw% LSS 1 goto error
if %asw% GTR 3 goto error



:standard
rem Standartreader Werte

set QUERY0=SELECT * FROM Momentanverbrauch_Export
set QUERY1=SELECT * FROM Momentanverbrauch_Import
set QUERY2=SELECT * FROM Spannung_L1
set QUERY3=SELECT * FROM Spannung_L2
set QUERY4=SELECT * FROM Spannung_L3
set QUERY5=SELECT * FROM Strom_L1
set QUERY6=SELECT * FROM Strom_L2
set QUERY7=SELECT * FROM Strom_L3
set QUERY8=SELECT * FROM Timestamp
set QUERY9=SELECT * FROM UID_Message
set QUERY10=SELECT * FROM Zaehlerstand_Export
set QUERY11=SELECT * FROM Zaehlerstand_Import
set QUERY12=SELECT * FROM Zaehlernummer

@echo on
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY0%" > temp\1.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY1%" > temp\2.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY2%" > temp\3.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY3%" > temp\4.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY4%" > temp\5.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY5%" > temp\6.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY6%" > temp\7.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY7%" > temp\8.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY8%" > temp\9.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY9%" > temp\10.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY10%" > temp\11.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY11%" > temp\12.csv
curl -H "Accept: application/csv" -G "http://192.168.1.215:8086/query?db=reader_AB6178" --data-urlencode "q=%QUERY12%" > temp\13.csv

@echo off
goto python



:reader
rem Eigener Reader
echo.
echo Format Eingabe der IP-Adresse: 192.168.1.1 - xxx.xxx.xxx.xxx
set /p ip="Bitte IP-Adresse eingeben: "

echo.
echo Format Eingabe des Port: 0000
set /p port="Bitte Port eingeben: "

echo.
echo Format Eingabe des Reader: ABxxxx
set /p database="Bitte Reader Nummer eingeben: "


set QUERY0=SELECT * FROM Momentanverbrauch_Export
set QUERY1=SELECT * FROM Momentanverbrauch_Import
set QUERY2=SELECT * FROM Spannung_L1
set QUERY3=SELECT * FROM Spannung_L2
set QUERY4=SELECT * FROM Spannung_L3
set QUERY5=SELECT * FROM Strom_L1
set QUERY6=SELECT * FROM Strom_L2
set QUERY7=SELECT * FROM Strom_L3
set QUERY8=SELECT * FROM Timestamp
set QUERY9=SELECT * FROM UID_Message
set QUERY10=SELECT * FROM Zaehlerstand_Export
set QUERY11=SELECT * FROM Zaehlerstand_Import
set QUERY12=SELECT * FROM Zaehlernummer

@echo on
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY0%" > temp\1.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY1%" > temp\2.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY2%" > temp\3.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY3%" > temp\4.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY4%" > temp\5.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY5%" > temp\6.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY6%" > temp\7.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY7%" > temp\8.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY8%" > temp\9.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY9%" > temp\10.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY10%" > temp\11.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY11%" > temp\12.csv
curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY12%" > temp\13.csv

@echo off
goto python



:eigen
rem Eigene Datenbank

rem Variablen Definition
echo.
echo Format Eingabe der IP-Adresse: 192.168.1.1 - xxx.xxx.xxx.xxx
set /p ip="Bitte IP-Adresse eingeben: "

echo.
echo Format Eingabe des Port: 0000
set /p port="Bitte Port eingeben: "

echo.
echo Format Eingabe des Datenbank: Bsp: iot_devices
set /p database="Bitte Reader Nummer eingeben: "


rem Variable expansion Delayed
setlocal enabledelayedexpansion

echo.
echo Format Eingabe der Anzahl Measurements:
set /p num="Bitte Zahl eingeben: "
echo. 

rem Initialize export number
set exportnumber=1

FOR /L %%y IN (1, 1, %num%) DO (
   echo Format Eingabe des Measurements: Bsp. shelly_out1
   set /p measurement="Bitte Measurement zum Exportieren eingeben: "
   set QUERY0=SELECT * FROM !measurement!

   curl -H "Accept: application/csv" -G "http://%ip%:%port%/query?db=reader_%database%" --data-urlencode "q=%QUERY0%" > "temp\!exportnumber!.csv"
   echo !exportnumber! success!

   rem Increment export number
   set /a exportnumber+=1
)

endlocal
goto python


:python
rem Python Script
echo Python Srcipt - Bitte Geduld, Daten werden exportiert...
python concat.py

@echo on
pause
exit