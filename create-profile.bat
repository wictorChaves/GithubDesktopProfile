@echo off
setlocal ENABLEDELAYEDEXPANSION
cd %~dp0
call lib.cmd
call configs.cmd

%breakline%
set /p ProfileName=Entre com o nome do profile: 
taskkill /f -im GitHubDesktop.exe
TIMEOUT 2
cd %AppData%
"c:\Program Files\7-Zip\7z.exe" a -mx %ProfileName%.zip "GitHub Desktop"
move %ProfileName%.zip %dirProfiles%
start "" %githubExec%

cd %~dp0
call SystemTrayNotification.bat  -tooltip info -time 3000 -title "Profile Github Desktop" -text "Profile Criado!" -icon Information