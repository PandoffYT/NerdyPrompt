@echo off
NET FILE 1>NUL 2>NUL
IF ERRORLEVEL 1 set elevated=Not elevated& goto CommandPrompt
set elevated=Elevated
cls
echo NerdyPrompt - Pando
echo.
:CommandPrompt
title NerdyPrompt - Executing as %username% (%elevated%) in "%~dp0"  (Type "cmds" to see all useful commands)
set /p command="%username%@%computername%~ "
title %command% - Executing as %username% (%elevated%) in "%~dp0"
echo %username% on %computername% used "%command%" on %time% and %date% at the directory "%~dp0". >> logs.txt
if "%command%"=="cmds" goto HelpSection1
if "%command%"=="parrot" curl parrot.live
if "%command%"=="spam" goto SpamTool1
%command%
goto CommandPrompt

:HelpSection1
echo "parrot" makes a parrot dance on the screen
echo "spam" is able to spam create files on a specified path
pause
goto CommandPrompt


:SpamTool1
set CurrentSpamCount=0
set SpamCount=0
set SpamLeft=0
set SpamPath=""
echo ===================================
echo.
echo             Spam tool
echo            Made by pando
echo.
echo ===================================
echo.
set /p SpamCount="Enter how many files you want the tool to create: "
set /p SpamPath="Enter the (full) path where the files are being created (eg. C:/MyFolder/MySubFolder): "
set /p SpamExtension="Enter the file extension the file should use: "
:SpamLoop
echo %random%> %SpamPath%/%random%.%SpamExtension%
set /a CurrentSpamCount=%CurrentSpamCount%+1
set /a SpamLeft=%SpamCount%-%CurrentSpamCount%
title SPAMMING!! (%CurrentSpamCount% in, %SpamLeft% left)
if %CurrentSpamCount%==%SpamCount% title FINISHED & pause & goto CommandPrompt
goto SpamLoop



