@echo off
setlocal ENABLEDELAYEDEXPANSION
cd %~dp0
call lib.cmd
call configs.cmd

%msg% "Perfies existentes"
cd "%dirProfiles%"
set /a c=0
for /d %%i in (*) do (
	set /a c=c+1
	echo     !c! - %%i
)

%breakline%
set /p ProfileName=Entre com o nome do profile: 
taskkill /f -im GitHubDesktop.exe
TIMEOUT 5
cd %AppData%
IF NOT EXIST "%dirProfiles%%ProfileName%" (
	mkdir "%dirProfiles%%ProfileName%" 
)
copy "GitHub Desktop\IndexedDB\file__0.indexeddb.leveldb\000003.log" "%dirProfiles%%ProfileName%\000003.log" /y

TIMEOUT 5
cd %~dp0
call SystemTrayNotification.bat  -tooltip info -time 3000 -title "Profile Github Desktop" -text "Profile Criado!" -icon Information
%githubExec%