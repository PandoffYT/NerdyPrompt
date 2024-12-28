@echo off
rem !- BETA VERSION -! EXPECT THINGS TO BREAK
if exist "%appdata%/NerdyPrompt" (
    goto Startup
) else (
    md %appdata%\NerdyPrompt
    md %appdata%\NerdyPrompt\Settings
    goto Startup
)
:Startup
rem Welcome to NerdyPrompt code, i advise you to check the wiki that's going to be built sometimes soon if you dont know batch, it will be about customizing NerdyPrompt to your needs!
rem Variable for later customization
set "Owner=Pando"
rem This code snippet below is used to know if the prompt is elevated or not. (Right click on the batch then open as admin)
NET FILE 1>NUL 2>NUL
IF ERRORLEVEL 1 set elevated=Not elevated& goto Initialization
set elevated=Elevated& goto Initialization
set SettingsPath=%appdata%/NerdyPromp/Settings
:Initialization
cls
echo NerdyPrompt - %Owner%
echo.
:CommandPrompt
rem Main window of the NerdyPrompt!
title NerdyPrompt - Executing as %username% (%elevated%) in "%~dp0"  (Type "cmds" to see all useful commands)
set /p command="%username%@%computername%~ "
title %command% - Executing as %username% (%elevated%) in "%~dp0"
echo %username% on %computername% used "%command%" on %time% and %date% at the directory "%~dp0". >> logs.txt
rem Snippets below are the custom commands, modify it to your needs (Examples will be in the wiki )
if "%command%"=="cmds" goto HelpSection1
if "%command%"=="parrot" curl parrot.live
if "%command%"=="spam" goto SpamTool1
if "%command%"=="settings" goto Settings
%command%
goto CommandPrompt

:HelpSection1
rem All commands added by pando, useful or just funny!
echo "settings" to mess with NerdyPrompt settings
echo "parrot" makes a parrot dance on the screen
echo "spam" is able to spam create files on a specified path
echo "systeminfo" (built-in windows) to see system infos
pause
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
if %CurrentSpamCount%==%SpamCount% title FINISHED & pause & goto CommandPrompt
goto SpamLoop

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

:Settings
rem I placed settigns here because it's a feature that's being currently worked on, it will later be placed somewhere else
cls
rem Here are the settings you can customize to your needs
echo [1] Show windows version string on NerdyPrompt startup (Below the "NerdyPrompt - %Owner%" line)
choice /n /c 1
set SelectedSetting=%errorlevel%

:ChangeSelectedSetting
if %SelectedSetting%==1 goto ShowWindowsVersionStringOnStartup-Settings

:ShowWindowsVersionStringOnStartup-Settings
echo.
echo Show windows version string on NerdyPrompt startup (Current Value=%ShowWindowsVersionStringOnStartup%)
echo.
echo [1] Enable
echo [2] Disable
choice /n /c 12 /m "Select an option: "

if %errorlevel%=1 set ShowWindowsVersionStringOnStartup=Enabled
if %errorlevel%=2 set ShowWindowsVersionStringOnStartup=Disabled

echo %ShowWindowsVersionStringOnStartup%> %SettingsPath%/ShowWindowsVersionStringOnStartup.txt
set /p ShowWindowsVersionStringOnStartup=<%SettingsPath%/ShowWindowsVersionStringOnStartup.txt
goto CommandPrompt


