@echo off
setlocal ENABLEDELAYEDEXPANSION
cd %~dp0
call lib.cmd
call configs.cmd

%msg% "Qual profile voce deseja carregar?"

cd %dirProfiles%
set /a c=0
for /r %%i in (*.zip) do (
	set /a c=c+1
	echo     !c! - %%i
)

%breakline%
set /p ProfileLoadNumber=Numero da opcao: 

set /a folder=0
set /a c=0
for /r %%i in (*.zip) do (
	set /a c=c+1
	IF %ProfileLoadNumber%==!c! (
		set "folder=%%i"
	)
)

cd %AppData%
rmdir "GitHub Desktop" /s /q
echo Pasta atual excluida
TIMEOUT 3
%githubExec%
echo Criando nova pasta com as novas permissoes
TIMEOUT 2
echo Finalizando GitHubDesktop.exe
taskkill /f -im GitHubDesktop.exe
TIMEOUT 2

"c:\Program Files\7-Zip\7z.exe" -aoa x %folder% -o%AppData%

start "" %githubExec%

cd %~dp0
call SystemTrayNotification.bat  -tooltip info -time 3000 -title "Profile Github Desktop" -text "Profile restaurado!" -icon Information