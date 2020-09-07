REM ## Sept 2020 (initial version)
REM ##
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

REM ## Config below for second backup which is local to local
REM ##
SET LocalSource1=C:\SysContent\LS1
SET LocalSource2=C:\SysContent\LS2
SET LocalSource3=C:\SysContent\LS3
SET LocalSource4=C:\SysContent\LS4

SET LocalDestination1=C:\mybackups\LB1
SET LocalDestination2=C:\mybackups\LB2
SET LocalDestination3=C:\mybackups\LB3
SET LocalDestination4=C:\mybackups\LB4

REM ## First two folders we're just taking a copy of the most recent files (1 day old)
REM ##
DEL %LocalDestination1%\*.* /Q
ROBOCOPY %LocalSource1% %LocalDestination1% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

DEL %LocalDestination2%\*.* /Q
ROBOCOPY %LocalSource2% %LocalDestination2% /MAXAGE:1 /R:1 /W:1 /LEV:1 /LOG+:%LogFile%

REM ## Second two folders we're taking a mirror copy of the folders
REM ##
ROBOCOPY %LocalSource3% %LocalDestination3% /MIR /R:1 /W:1 /LOG+:%LogFile%
ROBOCOPY %LocalSource4% %LocalDestination4% /MIR /R:1 /W:1 /LOG+:%LogFile%
