ECHO OFF
CLS
SET SourceServer=\\10.0.2.4\SysActive$
SET SourceFolder1=\\10.0.2.4\SysActive$\SA1
SET SourceFolder2=\\10.0.2.4\SysActive$\SA2
SET SourceFolder3=\\10.0.2.4\SysBackup$\SB1
SET SourceFolder4=\\10.0.2.4\SysBackup$\SB2
SET LogFile=backup-log.txt

SET DestinationFolder1=C:\mybackups\SA1
SET DestinationFolder2=C:\mybackups\SA2
SET DestinationFolder3=C:\mybackups\SB1
SET DestinationFolder4=C:\mybackups\SB2

REM ## Make sure to use limited remote user/ password if required that only has access to folder
SET SourceUser=WIN-SCN48HMT9HJ\basicuser1
SET SourcePass=dgD77vj-v767ctcc7DDD221_

REM ## If we need to establish a connection to remote server with different credentials
REM ## Make sure account is a limited user ac with write access to the folder.
REM ##
net use %SourceServer% /user:%SourceUser% %SourcePass% /PERSISTENT:NO

REM ## Clear out destination folder and copy latest content over from source
REM ##
DEL %DestinationFolder1%\*.* /Q
ROBOCOPY %SourceFolder1% %DestinationFolder1% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

DEL %DestinationFolder2%\*.* /Q
ROBOCOPY %SourceFolder2% %DestinationFolder2% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

DEL %DestinationFolder3%\*.* /Q
ROBOCOPY %SourceFolder3% %DestinationFolder3% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

DEL %DestinationFolder4%\*.* /Q
ROBOCOPY %SourceFolder4% %DestinationFolder4% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

REM ## Closing connection to remote server.
REM ##
NET USE %SourceServer% /delete