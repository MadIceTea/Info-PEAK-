@ ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@REM Windows prior to NT, such as 95.
"jruby" -I %ISRB_HOME%\ruby -S "jirb" -risrb %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@REM Windows NT or later.
IF NOT "%~dp0" == "%CD%\" GOTO :CheckEnv
@REM Change the current directory to the user's home when the
@REM script is executed under the directory where isrb.bat exists.
@REM This is because, when you double-click this script file in Windows,
@REM the current directory is changed to the script's directory.
@REM If this causes a problem, you can merely delete the next two lines.
%HOMEDRIVE%
cd %HOMEPATH%
:CheckEnv 
@REM Set ISRB_HOME to the directory where this script is located
@REM unless it was explicitly configured.
IF NOT DEFINED ISRB_HOME SET ISRB_HOME=%~dp0
@REM Start the JRuby process with the interactive (jirb) mode.
jruby -I %ISRB_HOME%ruby -S "jirb" -risrb %* 
if ERRORLEVEL 1 PAUSE

