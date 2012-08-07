@ECHO off
IF "%DEPLOYMENT_SOURCE%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The DEPLOYMENT_SOURCE environment variable was detected.
   SET SourceDir="%DEPLOYMENT_SOURCE%"
   GOTO END
   :NOPATH
   @ECHO The DEPLOYMENT_SOURCE environment variable was NOT detected.
   SET SourceDir=%CD%
   GOTO END
   :END
    
IF "%TEMP_SOURCE%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The TEMP_SOURCE environment variable was detected.
   SET TempDir="%TEMP_SOURCE%"
   GOTO END
   :NOPATH
   @ECHO The TEMP_SOURCE environment variable was NOT detected.
   SET TempDir=C:\TEMP_SOURCE
   GOTO END
   :END

IF "%TARGET_SOURCE%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The TARGET_SOURCE environment variable was detected.
   SET TargetDir="%TARGET_SOURCE%"
   GOTO END
   :NOPATH
   @ECHO The TARGET_SOURCE environment variable was NOT detected.
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