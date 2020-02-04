@echo off
:loop
echo list disk|diskpart|find "Online"
set "disk=."
set /p "disk=Pick disk number above to destroy/reformat: "
echo.
echo list disk|diskpart|find "Disk %disk%"
if errorlevel 1 (
echo  Invalid drive selection!
pause
goto :loop
) else (
echo select Disk %disk%
echo clean
echo create partition primary
echo select partition 1
echo format FS=NTFS label=Drive quick
echo active
echo exit
)| diskpart
