@echo off
setlocal enabledelayedexpansion

set "folderToMove=temp"
set "prefix="
set "newFolder=Export" 

for /d %%I in ("%folderToMove%\..") do (
   set "parentFolder=%%~dpI"
)

mkdir "%parentFolder%\%newFolder%"

for %%F in ("%folderToMove%\*") do (
   set "fileName=%%~nxF"
   move "%%F" "%parentFolder%\%newFolder%\%prefix%!fileName!"
)
echo Process Finished - Exit now.
exit
