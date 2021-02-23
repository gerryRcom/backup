REM ## FEB 2021 (initial version)
REM ##
ECHO OFF
CLS
REM ## Resolve D/M/Y for folder name creation
SET Year=%date:~6,4%
SET Month=%date:~3,2%
SET Day=%date:~0,2%
SET SourceServer=SERVER2
SET SourceFolder1=\\%SourceServer%\FMS_%Year%-%Month%-%Day%_0000
SET SourceFolder2=\\%SourceServer%\Daily_%Year%-%Month%-%Day%_0300
SET SourceFolder3=\\%SourceServer%\Hourly Dbase 1800_%Year%-%Month%-%Day%_1800
SET LogFile=backup-log.txt

echo %SourceFolder1%
echo %SourceFolder2%
echo %SourceFolder3%

SET DestinationFolder1=C:\mybackups\SA1

REM ## Clear out destination folder and copy latest content over from source
REM ##
DEL %DestinationFolder1%\*.* /Q
#ROBOCOPY %SourceFolder1% %DestinationFolder1% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

REM ## First two folders we're just taking a copy of the most recent files (1 day old)
REM ##
DEL %LocalDestination1%\*.* /Q
#ROBOCOPY %LocalSource1% %LocalDestination1% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

#DEL %LocalDestination2%\*.* /Q
#ROBOCOPY %LocalSource2% %LocalDestination2% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

REM ## Second two folders we're taking a mirror copy of the folders
REM ##
#ROBOCOPY %LocalSource3% %LocalDestination3% /MIR /R:1 /W:1 /LOG+:%LogFile%
#ROBOCOPY %LocalSource4% %LocalDestination4% /MIR /R:1 /W:1 /LOG+:%LogFile%
