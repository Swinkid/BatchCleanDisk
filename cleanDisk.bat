@echo off
goto check_Permissions

:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto disk_type
    ) else (
        echo ****   RUN FILE AS ADMINISTRATOR  ****
    )
    cmd /k

:disk_type
    echo **** SIMPLE DISK CLEANER V1.1 ****
    set "SELECT_TYPE=."
    set "SELECTED_DISK_TYPE=NTFS"

    echo What type of drive are you formatting?
    echo 1 - SD Card (FAT32)
    echo 2 - USB/HDD (NTFS)
    set /p SELECT_TYPE=Select disk type:

    if %SELECT_TYPE%==1 set SELECTED_DISK_TYPE=FAT32
    if %SELECT_TYPE%==2 set SELECTED_DISK_TYPE=NTFS

    if %SELECT_TYPE%==. (
      echo Please select a type...
      goto disk_type
    )

    goto disk_clean

:disk_clean:
    :loop
    echo list disk|diskpart|find "Online"
    set "disk=."
    set /p "disk=Pick disk number above to reformat: "
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
    echo format FS=%SELECTED_DISK_TYPE% label=Drive quick
    echo assign letter=R
    echo active
    echo exit
    )| diskpart
    exit
