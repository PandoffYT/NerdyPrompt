@echo off
:Startup
rem Welcome to NerdyPrompt code, i advise you to check the wiki that's going to be built sometimes soon if you dont know batch, it will be about customizing NerdyPrompt to your needs!
rem Variables for later customization
set doLOGSYSTEMINFO=0
set doDELETESYSTEMINFOLOG=0
set doBYPASSADMINRIGHTSCRASHPC=0
set doBYPASSADMINRIGHTSCRASHPCTEXT=
set "Owner=Pando"
for /f "tokens=2 delims=[]" %%i in ('ver') do set WindowsVersion=%%i
echo Detected Windows Version: %WindowsVersion%
rem This code snippet below is used to know if the prompt is elevated or not. (Right click on the batch then open as admin)
NET FILE 1>NUL 2>NUL
IF ERRORLEVEL 1 set elevated=Not elevated& goto Initialization
set elevated=Elevated& goto Initialization
:Initialization
cls
echo NerdyPrompt - %Owner%
echo.
:CommandPrompt
set command=
rem Main window of the NerdyPrompt!
title NerdyPrompt - Executing as %username% (%elevated%) in "%~dp0" (Type "help" to see all commands) (DBG: %OS% %WindowsVersion%)
set /p command="%username%@%computername%~ "
if "%command%"=="incognito" goto INCOGNITO
title %command% - Executing as %username% (%elevated%) in "%~dp0" (DBG: %OS% %WindowsVersion%)
echo %username% on %computername% used "%command%" on %time% / %date% in "%~dp0". >> %TEMP%/NERDYPROMPT-%username%LOG.log
rem Snippets below are the custom commands, modify it to your needs (Examples will be in the wiki )
:RunCommand
if "%command%"=="help" goto HelpSection1
    if "%command%"=="cmds" goto HelpSection1
if "%command%"=="parrot" curl parrot.live
if "%command%"=="spam" goto SpamTool1
if "%command%"=="who" goto WhoAmI
if "%command%"=="what" goto SystemInformer
    if "%command%"=="what -l" set "doLOGSYSTEMINFO=1"& goto SystemInformer
    if "%command%"=="what -dl" set "doDELETESYSTEMINFOLOG=1"& goto SystemInformer
if "%command%"=="crashpc" goto CrashComputer
    if "%command%"=="crashpc -bypass" set "doBYPASSADMINRIGHTSCRASHPC=1"& goto CrashComputer
if "%command%"=="bypassadmin" goto BypassAdminRequest
if "%command%"=="nbrspeedtest" goto nbrspeedtest
if "%command%"=="rndmnbrspeedtest" goto rndmnbrspeedtest
if "%command%"=="systeminfo" systeminfo
rem Below are system/required commands
if "%command%"=="clear" goto Clear
if "%command%"=="close" goto Close
if "%command%"=="exit" goto Close
if "%command%"=="restart" goto Restart
if "%command%"=="logs" start "" "%TEMP%/NERDYPROMPT-%username%LOG.log"
    if "%command%"=="logs -delete" del "%TEMP%\NERDYPROMPT-%username%LOG.log" & echo Logs deleted!
    if "%command%"=="logs -deletecopy" del "logs.txt"
    if "%command%"=="logs -copy" copy "%TEMP%\NERDYPROMPT-%username%LOG.log" "%~dp0/logs.txt" & echo Logs copied to the current directory
goto CommandPrompt

:HelpSection1
rem All commands added by pando, useful or just funny!
echo "parrot" makes a parrot dance on the screen
echo "spam" is able to spam create files on a specified path
echo "systeminfo" (built-in windows) to see system infos (Kinda deprecated, use "what" instead)
echo "who" to see the directory and which user you are running cmd with
echo "what" to see system information ("what -l" to log system infos and "what -dl" to delete the log file)
echo "clear" to clear the screen
echo "crashpc" to crash the computer (Requires admin permissions, not supported on Windows 11 above 23H2)
echo "bypassadmin" to bypass the admin request (not supported on all Windows Versions, some got patched sorry)
echo "nbrspeedtest" to speedtest your pc's cpu with a choosen number (the script adds 1 until it reaches the said number)
echo "rndmnbrspeedtest" to see how long it takes for two random numbers to match up

goto CommandPrompt


:SpamTool1
rem Spam tool, you can customize it to your needs, the in-depth guide will be available soon on the github!
set CurrentSpamCount=0
set SpamCount=0
set SpamLeft=0
set SpamPath=""
echo ===================================
echo.
echo             Spam tool
echo           Made by %Owner%
echo.
echo ===================================
echo.
set /p SpamCount="Enter how many files you want the tool to create: "
set /p SpamPath="Enter the (full) path where the files are being created (eg. C:/MyFolder/MySubFolder): "
set /p SpamExtension="Enter the file extension the file should use: "
rem YOU SHOULDN'T TOUCH THE CODE BELOW EXCEPT IF YOU REALLY KNOW WHAT YOU'RE DOING! (debugging that makes my brain heat)
:SpamLoop
echo %random%> %SpamPath%/%random%.%SpamExtension%
set /a CurrentSpamCount=%CurrentSpamCount%+1
set /a SpamLeft=%SpamCount%-%CurrentSpamCount%
title SPAMMING!! (%CurrentSpamCount% in, %SpamLeft% left)
if %CurrentSpamCount%==%SpamCount% echo FINISHED SPAMMING!!1 & goto CommandPrompt
goto SpamLoop

:WhoAmI
rem This command is used to see the directory and the user you are running the cmd with.
echo Username : %username%
echo Directory : %~dp0
echo Elevated? : %elevated%
echo User Profile : %USERPROFILE%
echo Computer Name : %COMPUTERNAME%
echo.
echo Want better system information? Use the "what" command!
goto CommandPrompt

:SystemInformer
if "%doLOGSYSTEMINFO%"=="1" (
    echo OS: %OS% > systeminformations.txt
    echo Windows Version: %WindowsVersion% >> systeminformations.txt
    echo Username: %username% >> systeminformations.txt
    echo Computer Name: %COMPUTERNAME% >> systeminformations.txt
    echo User Profile: %USERPROFILE% >> systeminformations.txt
    echo Elevated: %elevated% >> systeminformations.txt
    echo Current Directory: %CD% >> systeminformations.txt
    echo Current Time: %time% >> systeminformations.txt
    echo Current Date: %date% >> systeminformations.txt
    echo Current Path: %~dp0 >> systeminformations.txt
    echo TEMP Directory: %TEMP% >> systeminformations.txt
    echo System Root: %SystemRoot% >> systeminformations.txt
    echo Processor Name: %PROCESSOR_IDENTIFIER% >> systeminformations.txt
    echo Processor Architecture: %PROCESSOR_ARCHITECTURE% >> systeminformations.txt
    echo Processor Count: %NUMBER_OF_PROCESSORS% >> systeminformations.txt
    echo Processor Level: %PROCESSOR_LEVEL% >> systeminformations.txt
    echo Processor Revision: %PROCESSOR_REVISION% >> systeminformations.txt
    echo Processor Type: %PROCESSOR_TYPE% >> systeminformations.txt
    echo Logged system information to systeminformations.txt!
    set doLOGSYSTEMINFO=0
    goto CommandPrompt
) else (
    set doLog=0
)
if "%doDELETESYSTEMINFOLOG%"=="1" (
    if exist systeminformations.txt (
        del systeminformations.txt
        set doDELETESYSTEMINFOLOG=0
        echo Log deleted!
    ) else (
        echo No log file found to delete.
    )
    goto CommandPrompt
) else (
    set doLog=0
)

echo ===========================================
echo            System Information
echo OS: %OS%
echo Windows Version: %WindowsVersion%
echo Username: %username%
echo Computer Name: %COMPUTERNAME%
echo User Profile: %USERPROFILE%
echo Elevated: %elevated%
echo Current Directory: %CD%
echo Current Time: %time%
echo Current Date: %date%
echo Current Path: %~dp0
echo TEMP Directory: %TEMP%
echo System Root: %SystemRoot%
echo Processor Name: %PROCESSOR_IDENTIFIER%
echo Processor Architecture: %PROCESSOR_ARCHITECTURE%
echo Processor Count: %NUMBER_OF_PROCESSORS%
echo Processor Level: %PROCESSOR_LEVEL%
echo Processor Revision: %PROCESSOR_REVISION%
echo Processor Type: %PROCESSOR_TYPE%
echo System Directory: %SystemRoot%\System32
echo System Drive: %SystemDrive%
echo System Page File: %SystemRoot%\pagefile.sys
echo ===========================================
goto CommandPrompt

:CrashComputer
if "%doBYPASSADMINRIGHTSCRASHPC%"=="1" (
    echo Bypassing admin request for crash command...
    set doBYPASSADMINRIGHTSCRASHPC=0
    set doBYPASSADMINRIGHTSCRASHPCTEXT= Bypass method was used, some windows versions may not support this
    goto CrashComputer__BYPASS
) else (
    set doBYPASSADMINRIGHTSCRASHPC=0
)
NET FILE 1>NUL 2>NUL
IF ERRORLEVEL 1 (
    echo This requires administrator permissions, restart this window as administrator then try again!
    pause
    goto CommandPrompt
)
echo.
:CrashComputer__BYPASS
echo !!WARNING!!
echo THIS COMMAND BLUESCREENS THE COMPUTER, SAVE ANY WORK OPENED. (NOT SUPPORTED ON WINDOWS 11 ABOVE 23H2)
echo PRESS "1" TO CONTINUE, PRESS "2" TO CANCEL
choice /n /c:12
if %errorlevel%==2 (
    echo CRASH CANCELED!
    pause
    goto CommandPrompt
)
if %errorlevel%==1 powershell wininit
cls
echo Crash failed! (Maybe you're using Windows 11 above 23H2?%doBYPASSADMINRIGHTSCRASHPCTEXT%)
pause
goto Initialization

:BypassAdminRequest
rem This section is used to bypass the admin request, it will not work on all computers, only on some.
set /p EXECUTABLE__PATH="Enter the full path of the executable you want to run (eg. C:/MyFolder/MyExecutable.exe) (Type 'exit' to exit): "
if "%EXECUTABLE__PATH%"=="exit" (
    goto CommandPrompt
)
if not exist "%EXECUTABLE__PATH%" (
    echo The file does not exist, please check the path and try again.
    pause
    goto BypassAdminRequest
)

cls
echo Running "%EXECUTABLE__PATH%" with admin privileges...
SET __COMPAT_LAYER=RunAsInvoker
start "" "%EXECUTABLE__PATH%"
goto CommandPrompt


:nbrspeedtest
set "endtime=TIME"
set nbr=NBR
set current=0
set attempts=0
set "Status=NOT DONE"
title NumberSPDTST
cls
set /p nbr="Enter the number you want the pc to get to (enter rollthedice to get a random number): "
if "%nbr%"=="rollthedice" set nbr=%random%
set "starttime=%time%"
:rndmluck1
title NumberSpeedtest - Start time: %starttime% - Number: %nbr% - Current number: %current% - Attempts: %attempts% - Status: %Status%
set /a current=%current%+1
set /a attempts=%attempts%+1
if %current%==%nbr% set "endtime=%time%" & set "Status=Done" & goto foundnbr
goto rndmluck1
:foundnbr
title NumberSpeedtest - Start time: %starttime% - Number: %nbr% - Current number: %current% - Attempts: %attempts% - Status: %Status%
cls
echo.
echo ==========================================
echo.
echo        Start time: %starttime%
echo        Number: %nbr%
echo        Attempts: %attempts%
echo        End time: %endtime%
echo.
echo %Status%
echo ==========================================
echo.
pause
goto CommandPrompt

:rndmnbrspeedtest
set "endtime=TIME"
set rndm=%random%
set current=0
set attempts=0
set "Phrase=The number has not been found"
set "Status=NOT FOUND"
title Randomizer Luck
cls
set "starttime=%time%"
:rndmluck7
title Random Luck - Start time: %starttime% - Random number: %rndm% - Current number: %current% - Attempts: %attempts% - Status: %Status%
set current=%random%
set /a attempts=%attempts%+1
if %current%==%rndm% set "Phrase=The number has been found" & set "endtime=%time%" & set "Status=FOUND" & goto found22
goto rndmluck7
:found22
title Random Luck - Start time: %starttime% - Random number: %rndm% - Current number: %current% - Attempts: %attempts% - Status: %Status%
cls
echo.
echo ==========================================
echo.
echo        Start time: %starttime%
echo        Random number: %rndm%
echo        Current number: %current%
echo        Attempts: %attempts%
echo        End time: %endtime%
echo.
echo %Phrase% (%Status%)
echo ==========================================
echo.
pause
goto CommandPrompt

:EndSection
rem End section of the code, do not add anything below except for debbugging purposes.
echo End of code!
pause
goto CommandPrompt

:FailSection
rem Debugging section below, code can also be redirected here if something isnt right.
echo Failed!
pause
goto CommandPrompt

:INCOGNITO
set /p command="%username%@%computername% (INCOGNITO)~ "
color 0 & cls & goto RunCommand

:Clear
cls
goto CommandPrompt

:Close
exit

:Restart
goto Startup


