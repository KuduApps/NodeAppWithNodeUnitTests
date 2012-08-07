@ECHO off
IF "%SOURCE%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The SOURCE environment variable was detected ..
   SET SourceDir="%DEPLOYMENT_SOURCE%"
   GOTO END
   :NOPATH
   @ECHO The SOURCE environment variable was NOT detected.
   SET SourceDir=%CD%
   GOTO END
   :END
    
IF "%BUILDTEMP%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The BUILDTEMP environment variable was detected.
   SET TempDir="%BUILDTEMP%"
   GOTO END
   :NOPATH
   @ECHO The BUILDTEMP environment variable was NOT detected.
   SET TempDir=C:\TEMP_SOURCE
   GOTO END
   :END

IF "%TARGET%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The TARGET environment variable was detected.
   SET TargetDir="%TARGET%"
   GOTO END
   :NOPATH
   @ECHO The TARGET environment variable was NOT detected.
   SET TargetDir=C:\TARGET_SOURCE
   GOTO END
   :END
echo %SourceDir%
echo %TempDir%
echo %TargetDir%
xcopy %SourceDir% %TempDir% /E /Y
pushd %TempDir%
call npm install
call npm test
IF ERRORLEVEL 1 ECHO error level is 1 or more
IF ERRORLEVEL 1 GOTO NODEPLOY
   :YESDEPLOY
   @ECHO Deploying files ... 
   xcopy %TempDir% %TargetDir% /E /Y /EXCLUDE:excludeFiles.txt
   :NODEPLOY   
   pushd %SourceDir%
   :END 