@echo off
@REM set source, where backup comes from
set source_dir=C:\SourceDirectory
@REM set desination, where backups are store
set destination_dir=D:\DestinationDirectory
@REM TODO: set max size 

@REM make copy 
xcopy "%source_dir%" "%destination_dir%" /s /e /y
@REM go to destination
cd %destination_dir%

@REM Get directory listing in reverse order

@REM for /d %%F in ("%destination%\*") do (
@REM     set /a index+=1
@REM     set "folders[!index!]=%%F"
@REM )

@REM remame them

@REM delete the after max