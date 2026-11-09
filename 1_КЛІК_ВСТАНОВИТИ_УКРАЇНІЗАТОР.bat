@echo off
chcp 1251 >nul
title Bladesong - Встановлення Українізатора

echo ========================================================
echo        BLADESONG - ВСТАНОВЛЕННЯ УКРАЇНІЗАТОРА
echo ========================================================
echo.
set "TARGET="

REM 1. Check current and parent folder
if exist "%~dp0Bladesong.exe" set "TARGET=%~dp0"
if not defined TARGET if exist "%~dp0..\Bladesong.exe" set "TARGET=%~dp0.."
if not defined TARGET if exist "%~dp0Bladesong\Binaries" set "TARGET=%~dp0"
if not defined TARGET if exist "%~dp0..\Bladesong\Binaries" set "TARGET=%~dp0.."

REM 2. Steam Registry
if not defined TARGET (
    for /f "tokens=2* delims=	 " %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do (
        set "STEAMPATH=%%B"
    )
)

if defined STEAMPATH (
    for %%G in (Bladesong "Bladesong Playtest" "Bladesong Demo") do (
        if not defined TARGET if exist "%STEAMPATH%\steamapps\common\%%~G\Bladesong.exe" set "TARGET=%STEAMPATH%\steamapps\common\%%~G"
        if not defined TARGET if exist "%STEAMPATH%\steamapps\common\%%~G\Bladesong\Binaries" set "TARGET=%STEAMPATH%\steamapps\common\%%~G"
    )
    if exist "%STEAMPATH%\steamapps\libraryfolders.vdf" (
        for /f "tokens=4 delims=	""" %%L in ('findstr /I /C:"path" "%STEAMPATH%\steamapps\libraryfolders.vdf" 2^>nul') do (
            for %%G in (Bladesong "Bladesong Playtest" "Bladesong Demo") do (
                if not defined TARGET if exist "%%~L\steamapps\common\%%~G\Bladesong.exe" set "TARGET=%%~L\steamapps\common\%%~G"
                if not defined TARGET if exist "%%~L\steamapps\common\%%~G\Bladesong\Binaries" set "TARGET=%%~L\steamapps\common\%%~G"
            )
        )
    )
)

REM 3. Scan drives and user folders
if not defined TARGET (
    for %%D in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if exist "%%D:\" (
            for %%S in (
                "%%D:\SteamLibrary\steamapps\common"
                "%%D:\Games\SteamLibrary\steamapps\common"
                "%%D:\Steam\steamapps\common"
                "%%D:\Program Files (x86)\Steam\steamapps\common"
                "%%D:\Program Files\Steam\steamapps\common"
                "%%D:\Games"
            ) do (
                for %%G in (Bladesong "Bladesong Playtest" "Bladesong Demo") do (
                    if not defined TARGET if exist "%%~S\%%~G\Bladesong.exe" set "TARGET=%%~S\%%~G"
                    if not defined TARGET if exist "%%~S\%%~G\Bladesong\Binaries" set "TARGET=%%~S\%%~G"
                )
            )
        )
    )
)

if not defined TARGET (
    for %%P in ("%USERPROFILE%\Downloads" "%USERPROFILE%\Desktop") do (
        for %%G in (Bladesong "Bladesong Playtest" "Bladesong Demo" "Bladesong[by etiska]") do (
            if not defined TARGET if exist "%%~P\%%~G\Bladesong.exe" set "TARGET=%%~P\%%~G"
            if not defined TARGET if exist "%%~P\%%~G\Bladesong\Binaries" set "TARGET=%%~P\%%~G"
        )
    )
)

REM 4. Zapyt u korystuvacha, yakshcho avtoposhuk ne znaishov
if not defined TARGET (
    echo [УВАГА] Не вдалося автоматично визначити папку гри.
    echo.
    echo Перетягніть папку гри Bladesong у це вікно консолі
    set /p "TARGET=або введіть повний шлях до папки гри: "
)

if defined TARGET (
    set "TARGET=%TARGET:"=%"
)

if not defined TARGET (
    echo [ПОМИЛКА] Папку гри не вказано.
    pause
    exit /b 1
)

if not exist "%TARGET%\Bladesong.exe" (
    if not exist "%TARGET%\Bladesong\Binaries" (
        echo [ПОМИЛКА] У вказаній папці не знайдено Bladesong.exe або Bladesong\Binaries!
        echo Перевірте шлях: "%TARGET%"
        pause
        exit /b 1
    )
)

echo.
echo Знайдено гру: "%TARGET%"
echo Встановлення української локалізації...

set "SRC=%~dp0Bladesong\Content\Localization\Game"
set "DST=%TARGET%\Bladesong\Content\Localization\Game"

REM Zberezhennia oryhinalu dlia chystoho vydalennia
if not exist "%DST%\en" mkdir "%DST%\en" 2>nul
if exist "%SRC%\en\Game_en_original.locres" (
    if not exist "%DST%\en\Game_en_original.locres" (
        copy /y "%SRC%\en\Game_en_original.locres" "%DST%\en\Game_en_original.locres" >nul
    )
) else (
    if exist "%DST%\en\Game.locres" (
        if not exist "%DST%\en\Game_en_original.locres" (
            copy /y "%DST%\en\Game.locres" "%DST%\en\Game_en_original.locres" >nul
        )
    )
)

REM Kopiuvannia u movni sloty
for %%C in (en uk uk-UA ru) do (
    if not exist "%DST%\%%C" mkdir "%DST%\%%C" 2>nul
    if exist "%SRC%\%%C\Game.locres" (
        fc /b "%SRC%\%%C\Game.locres" "%DST%\%%C\Game.locres" >nul 2>nul
        if errorlevel 1 (
            copy /y "%SRC%\%%C\Game.locres" "%DST%\%%C\Game.locres" >nul
        )
    )
)

REM Nalashtuvannia GameUserSettings.ini
set "CFG=%LOCALAPPDATA%\Bladesong\Saved\Config\Windows\GameUserSettings.ini"
if exist "%CFG%" (
    echo Налаштування конфігурації GameUserSettings.ini...
    powershell -NoProfile -Command "$c = [Environment]::GetFolderPath('LocalApplicationData') + '\Bladesong\Saved\Config\Windows\GameUserSettings.ini'; if (Test-Path -LiteralPath $c) { $t = (Get-Content -LiteralPath $c) -replace 'Language=.*', 'Language=uk'; Set-Content -LiteralPath $c -Value $t }"
)

echo.
echo ========================================================
echo [УСПІХ] Українізатор успішно встановлено та активовано!
echo ========================================================
echo.
pause
