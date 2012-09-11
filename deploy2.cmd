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
    
IF "%DEPLOYMENT_TEMP%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The DEPLOYMENT_TEMP environment variable was detected.
   SET TempDir="%DEPLOYMENT_TEMP%"
   GOTO END
   :NOPATH
   @ECHO The DEPLOYMENT_TEMP environment variable was NOT detected.
   SET TempDir=C:\DEPLOYMENT_TEMP
   GOTO END
   :END

IF "%DEPLOYMENT_TARGET%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The DEPLOYMENT_TARGET environment variable was detected.
   SET TargetDir="%DEPLOYMENT_TARGET%"
   GOTO END
   :NOPATH
   @ECHO The DEPLOYMENT_TARGET environment variable was NOT detected.
   SET TargetDir=C:\DEPLOYMENT_TARGET
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