@echo off
setlocal ENABLEDELAYEDEXPANSION
cd %~dp0
call lib.cmd
call configs.cmd

%msg% "Qual profile voce deseja carregar?"

cd "%dirProfiles%"
set /a c=0
for /d %%i in (*) do (
	set /a c=c+1
	echo     !c! - %%i
)

%breakline%
set /p ProfileLoadNumber=Numero da opcao: 

set /a folder=0
set /a c=0
for /d %%i in (*) do (
	set /a c=c+1
	IF %ProfileLoadNumber%==!c! (
		set "folder=%%i"
	)
)
TIMEOUT 1

echo Finalizando GitHubDesktop.exe
taskkill /f -im GitHubDesktop.exe
TIMEOUT 2

echo Finalizando GitHubDesktop.exe
taskkill /f -im GitHubDesktop.exe
TIMEOUT 2

cd %AppData%
copy "%dirProfiles%\%folder%\000003.log" "GitHub Desktop\IndexedDB\file__0.indexeddb.leveldb\000003.log" /y

cd %~dp0
call SystemTrayNotification.bat  -tooltip info -time 3000 -title "Profile Github Desktop" -text "Profile restaurado!" -icon Information
%githubExec%