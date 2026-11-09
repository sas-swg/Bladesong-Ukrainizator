@echo off
chcp 1251 >nul
title Bladesong - Видалення Українізатора

echo ========================================================
echo         BLADESONG - ВИДАЛЕННЯ УКРАЇНІЗАТОРА
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

set "DST=%TARGET%\Bladesong\Content\Localization\Game"
set "SRC=%~dp0Bladesong\Content\Localization\Game"

echo Відновлення оригінальних файлів гри...

REM Vidnovlennia anhliiskoho oryhinalu
if exist "%DST%\en\Game_en_original.locres" (
    copy /y "%DST%\en\Game_en_original.locres" "%DST%\en\Game.locres" >nul
) else if exist "%SRC%\en\Game_en_original.locres" (
    copy /y "%SRC%\en\Game_en_original.locres" "%DST%\en\Game.locres" >nul
)

REM Ochyshchennia pidminenykh ukrainskykh ta rosiiskykh failiv
if exist "%DST%\uk\Game.locres" del /q "%DST%\uk\Game.locres" 2>nul
if exist "%DST%\uk-UA\Game.locres" del /q "%DST%\uk-UA\Game.locres" 2>nul

if exist "%DST%\en\Game_en_original.locres" (
    if exist "%DST%\ru" copy /y "%DST%\en\Game_en_original.locres" "%DST%\ru\Game.locres" >nul
)

REM Povernennia movy na en u GameUserSettings.ini
set "CFG=%LOCALAPPDATA%\Bladesong\Saved\Config\Windows\GameUserSettings.ini"
if exist "%CFG%" (
    echo Повернення англійської мови в GameUserSettings.ini...
    powershell -NoProfile -Command "$c = [Environment]::GetFolderPath('LocalApplicationData') + '\Bladesong\Saved\Config\Windows\GameUserSettings.ini'; if (Test-Path -LiteralPath $c) { $t = (Get-Content -LiteralPath $c) -replace 'Language=.*', 'Language=en'; Set-Content -LiteralPath $c -Value $t }"
)

echo.
echo ========================================================
echo [УСПІХ] Українізатор видалено, повернено оригінальну мову.
echo ========================================================
echo.
pause
