ECHO OFF
CLS
SET SourceFolder1=C:\DATA
SET SourceFolder2=C:\DATA
SET SourceFolder3=C:\DATA
SET LogFile=backup-log.txt

SET DestinationServer=192.168.122.203
SET DestinationPath=\\%DestinationServer%\mybackups$
SET DestinationFolder1=%DestinationPath%\bup1
SET DestinationFolder2=%DestinationPath%\bup2
SET DestinationFolder3=%DestinationPath%\bup3

REM ## Make sure to use limited remote user/ password if required that only has access to folder
SET DestinationUser=basicuser1
SET DestinationPassword=dgD77vj-v767ctcc7DDD221_

REM ## If we need to establish a connection to remote server with different credentials
REM ## Make sure account is a limited user ac with write access to the folder.
REM ##
net use %DestinationPath% /user:%DestinationServer%\%DestinationUser% %DestinationPassword% /PERSISTENT:NO


REM #1 ROBOCOPY %SourceFolder1% %DestinationPath% /MIR /NOCOPY /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

DEL %SourceFolder1%\sync\*.* /Q
ROBOCOPY %SourceFolder1% %SourceFolder1%\sync /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%
ROBOCOPY %SourceFolder1%\sync %DestinationFolder1% /MIR /R:1 /W:1 /LOG+:%LogFile%

DEL %SourceFolder2%\sync\*.* /Q
ROBOCOPY %SourceFolder2% %SourceFolder2%\sync /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%
ROBOCOPY %SourceFolder2%\sync %DestinationFolder2% /MIR /R:1 /W:1 /LOG+:%LogFile%

DEL %SourceFolder3%\sync\*.* /Q
ROBOCOPY %SourceFolder3% %SourceFolder3%\sync /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%
ROBOCOPY %SourceFolder3%\sync %DestinationFolder3% /MIR /R:1 /W:1 /LOG+:%LogFile%

REM #1 ## Cleanup by moving local files to arch folder for deletion on next run
REM #1 ## Cleanup by closing connection to remote server.
REM #1 ##
REM #1 DEL %SourceFolder1%\arch\*.* /Q
REM #1 MOVE /Y %SourceFolder1%\*.* %SourceFolder1%\arch
NET USE %DestinationPath% /delete