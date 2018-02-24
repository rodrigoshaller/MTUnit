@echo off

set metaeditor="C:\Program Files\MetaTrader 5\metaeditor64.exe"
set metaTerminal="C:\Program Files\MetaTrader 5\terminal64.exe"
set doxygenCfgName=Doxyfile
set include_path="C:\Program Files\MetaTrader 5\MQL5"
set runnersPath=Runners

set file_path=%1
set file_path=%file_path:"=%
set file_name=%2
set file_name=%file_name:"=%
set file_ext=%3
set file_ext=%file_ext:"=%
set command=%4

for %%I in ("%file_path%\..") do set "grandparent=%%~fI"

set autoRunConfigIni="%grandparent%\Runners\autoRunTest.ini"
set mtUnitHelper="%grandparent%\Runners\mtUnitHelper.exe"
set mtUnitLogger="%grandparent%\Runners\mtUnitLogger.exe"
set mtUnitTestsCompiler="%grandparent%\Runners\mtUnitTestsCompiler.exe"
set logFile="%grandparent%\Runners\logFile.log"

ECHO Generating MTUnitAllTests.mqh
%mtUnitHelper% mtUnitTestsCompiler
IF /I "%ERRORLEVEL%" NEQ "1" (
    ECHO Error while generating MTUnitAllTests.mqh... Aborting!
	EXIT
)

ECHO Compiling files...
%metaeditor% /compile:"%file_path%\%file_name%.%file_ext%" /inc:%include_path% %command% /log
IF /I "%ERRORLEVEL%" NEQ "1" (
	type "%file_path%\%file_name%.log"
	del "%file_path%\%file_name%.log"
	ECHO Error while compiling files... Aborting!
	EXIT
)
ELSE (
type "%file_path%\%file_name%.log"
del "%file_path%\%file_name%.log"
)

ECHO -------------------------------------------------------------------------
ECHO.
ECHO Preparing to run tests...
ECHO.

%mtUnitHelper% mtUnitEALinker "%file_path%\%file_name%.%file_ext%"
IF /I "%ERRORLEVEL%" NEQ "1" (
    ECHO Error while editing autoRunTest.ini file... Aborting!
	EXIT
)

%metaTerminal% /config:%autoRunConfigIni%
IF /I "%ERRORLEVEL%" NEQ "0" (
    ECHO Error while trying to open metaTerminal... Aborting!
	EXIT
)

ECHO -------------------------------------------------------------------------
ECHO.
ECHO Tests done...
ECHO.

%mtUnitHelper% mtUnitLogger
IF /I "%ERRORLEVEL%" NEQ "1" (
    ECHO Error while trying to write logFile... Aborting!
	EXIT
)

type %logFile%