@echo off
setlocal ENABLEDELAYEDEXPANSION
set "breakline=type nul | more /e /p"

rem CONFIGS
set dirProfiles="%~dp0\Profiles\"
set githubExec="%homepath%\AppData\Local\GitHubDesktop\GitHubDesktop.exe"

cd %dirProfiles%

%breakline%
echo     ---------------------------------------------
echo         Qual profile voce deseja carregar?
echo     ---------------------------------------------
%breakline%

set /a c=0
for /r %%i in (*.zip) do (
	set /a c=c+1
	echo     !c! - %%i
)

%breakline%
set /p ProfileLoadNumber=Numero da opcao: 

set /a folder=0
set /a c=0
for /r %%i in (*) do (
	set /a c=c+1
	IF %ProfileLoadNumber%==!c! (
		set "folder=%%i"
	)
)

cd %AppData%
rmdir "GitHub Desktop" /s /q
echo Pasta atual excluida
TIMEOUT 2
%githubExec%
echo Criando nova pasta com as novas permissoes
TIMEOUT 2
echo Finalizando GitHubDesktop.exe
taskkill /f -im GitHubDesktop.exe
TIMEOUT 2

"c:\Program Files\7-Zip\7z.exe" -aoa x %folder% -o%AppData%
echo Profile restaurado!
start "" %githubExec%
pause