@echo off
setlocal enabledelayedexpansion

@REM set source, where backup comes from
set source_dir=C:\palworld\Pal\Saved\SaveGames\
@REM set destination, where backups are stored
set destination_dir=C:\palbackup\
@REM set max size 
set "max_name=72"

echo Going to %destination_dir%
rem go to destination
cd /d "%destination_dir%"

echo Getting list of folders in reverse order
rem Retrieve the list of folders in reverse order
for /f "tokens=*" %%F in ('dir /b /ad /o-n "%destination_dir%"') do (
    set "folders=!folders! "%%F""
)

echo Renaming...
rem Loop through the folders in reverse order and rename them by increasing their names by 1
for %%F in (%folders%) do (
    set "folder_name=%%~nxF"
    set /a "new_name=folder_name + 1"
    ren "%%F" "!new_name!"
)

echo Making copy...
rem make a copy 
xcopy "%source_dir%" "%destination_dir%" /s /e /y

echo Deleting folders larger than %max_name%...
rem Loop through the folders and delete those exceeding the maximum size
for /d %%F in ("%destination_dir%*") do (
    set "folder_name=%%~nxF"
    if !folder_name! gtr %max_name% (
        rd /s /q "%%F"
        echo Deleted folder: %%F
    )
)
