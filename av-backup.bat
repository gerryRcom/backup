REM ## FEB 2021 (initial version)
REM ##
ECHO OFF
CLS
REM ## Resolve D/M/Y to match folder name format
SET Year=%date:~6,4%
SET Month=%date:~3,2%
SET Day=%date:~0,2%
SET DestinationServer=localhost
SET DestinationFolder1=\\%DestinationServer%\c$\mybackups\av
SET LogFile=backup-log.txt

REM ## Set source folders to match auto created folders we want to backup
SET SourceFolder1=C:\DATA\av\FMS_%Year%-%Month%-%Day%_0000
SET SourceFolder2=C:\DATA\av\Daily_%Year%-%Month%-%Day%_0300
SET SourceFolder3="C:\DATA\av\Hourly Dbase 1800_%Year%-%Month%-%Day%_1800"

REM ## Use Mirror to replace the content in the destination with todays data
REM ##
DEL %DestinationFolder1%\* /Q
ROBOCOPY %SourceFolder1% %DestinationFolder1%\FMS /MIR /R:1 /W:1 /LOG+:%LogFile%
ROBOCOPY %SourceFolder2% %DestinationFolder1%\Daily /MIR /R:1 /W:1 /LOG+:%LogFile%
ROBOCOPY %SourceFolder3% %DestinationFolder1%\Hourly1800 /MIR /R:1 /W:1 /LOG+:%LogFile%
