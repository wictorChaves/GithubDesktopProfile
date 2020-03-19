@echo off
set "breakline=type nul | more /e /p"

rem CONFIGS
set dirProfiles="%~dp0\Profiles\"
set githubExec="%homepath%\AppData\Local\GitHubDesktop\GitHubDesktop.exe"

%breakline%
set /p ProfileName=Entre com o nome do profile: 
taskkill /f -im GitHubDesktop.exe
TIMEOUT 2
cd %AppData%
"c:\Program Files\7-Zip\7z.exe" a -mx %ProfileName%.zip "GitHub Desktop"
move %ProfileName%.zip %dirProfiles%
start "" %githubExec%
pause