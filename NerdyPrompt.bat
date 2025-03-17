@echo off
:Startup
rem Welcome to NerdyPrompt code, i advise you to check the wiki that's going to be built sometimes soon if you dont know batch, it will be about customizing NerdyPrompt to your needs!
rem Variables for later customization
set "Owner=Pando"
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
title NerdyPrompt - Executing as %username% (%elevated%) in "%~dp0"  (Type "cmds" to see all useful commands)
set /p command="%username%@%computername%~ "
title %command% - Executing as %username% (%elevated%) in "%~dp0"
echo %username% on %computername% used "%command%" on %time% and %date% at the directory "%~dp0". >> %TEMP%/NERDYPROMPT-%username%LOG.log
rem Snippets below are the custom commands, modify it to your needs (Examples will be in the wiki )
if "%command%"=="cmds" goto HelpSection1
if "%command%"=="parrot" curl parrot.live
if "%command%"=="spam" goto SpamTool1
if "%command%"=="who" goto WhoAmI
if "%command%"=="close" goto Close
if "%command%"=="restart" goto Restart
if "%command%"=="crashpc" goto CrashComputer
if "%command%"=="nbrspeedtest" goto nbrspeedtest
if "%command%"=="rndmnbrspeedtest" goto rndmnbrspeedtest
goto CommandPrompt

:HelpSection1
rem All commands added by pando, useful or just funny!
echo "parrot" makes a parrot dance on the screen
echo "spam" is able to spam create files on a specified path
echo "systeminfo" (built-in windows) to see system infos
echo "who" to see the directory and which user you are running cmd with
echo "crashpc" to crash the computer the cmd is executed on (REQUIRES ELEVATION, PLEASE SAVE ANY WORK, I WILL NOT BE RESPONSIBLE FOR ANY LOSS WORK)
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
goto CommandPrompt

:CrashComputer
NET FILE 1>NUL 2>NUL
IF ERRORLEVEL 1 echo This requires administrator permissions, restart this windows as adminisitrator then try again! & pause & goto CommandPrompt
echo.
echo !!WARNING!!
echo THIS COMMAND BLUESCREENS THE COMPUTER IT'S EXECUTED ON, SAVE ANY WORK OPENED THEN PRESS "1" TO CONTINUE, PRESS "2" TO CANCEL
choice /n /c:12
if errorlevel 1 powershell wininit
if errorlevel 2 echo CRASH CANCELED! & pause & goto CommandPrompt

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

:Close
exit

:Restart
goto Startup


