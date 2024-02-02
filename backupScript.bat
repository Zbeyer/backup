@echo off
@REM set source, where backup comes from
set source_dir=C:\SourceDirectory
@REM set desination, where backups are store
set destination_dir=D:\DestinationDirectory
@REM set max size 
set max_value=5

@REM make copy 
xcopy "%source_dir%" "%destination_dir%" /s /e /y
@REM go to destination
cd %destination_dir%

rem Increase folder names in reverse order
for /f "tokens=*" %%F in ('dir /ad /b /o-n "%destination_dir%"') do (
    set "folder_name=%%F"
    
    rem Extract the numeric part of the folder name
    for /f "tokens=2 delims=Folder" %%N in ("%%F") do set /a "new_number=%%N + 1"

    rem Construct the new folder name
    set "new_name=!new_number!"

    rem Rename the folder
    ren "%destination_dir%\!folder_name!" "!new_name!"

    rem Check the folder size and delete if it's above max
    for /f %%A in ('dir /s /b "%destination_dir%\!new_name!" ^| find /c /v ""') do (
        if %%A gtr %max_value% (
            echo Deleting folder "!new_name!" as it's above 80.
            rd /s /q "%destination_dir%\!new_name!"
        )
    )
)
