@echo off
chcp 65001 >nul
title Bladesong - Встановлення Українізатора

echo ========================================================
echo        BLADESONG - ВСТАНОВЛЕННЯ УКРАЇНІЗАТОРА
echo ========================================================
echo.

set "TARGET="
if exist "%~dp0Bladesong.exe" set "TARGET=%~dp0"
if exist "%~dp0..\Bladesong.exe" set "TARGET=%~dp0.."
if exist "%~dp0Bladesong\Binaries" set "TARGET=%~dp0"
if exist "%~dp0..\Bladesong\Binaries" set "TARGET=%~dp0.."
if not defined TARGET (
    if exist "%~dp0Bladesong\Content\Localization\Game" set "TARGET=%~dp0"
)

if not defined TARGET (
    echo [УВАГА] Не вдалося автоматично визначити папку гри.
    echo Будь ласка, переконайтеся, що файли знаходяться у папці гри.
    set /p "TARGET=Введіть шлях до папки гри (Enter - поточна папка): "
    if not defined TARGET set "TARGET=%~dp0"
)

echo Встановлення файлів у: %TARGET%...

if exist "%TARGET%\Bladesong\Content\Localization\Game\en\Game.locres" (
    if not exist "%TARGET%\Bladesong\Content\Localization\Game\en\Game_en_original.locres" (
        copy /y "%TARGET%\Bladesong\Content\Localization\Game\en\Game.locres" "%TARGET%\Bladesong\Content\Localization\Game\en\Game_en_original.locres" >nul
    )
)

for %%C in (en uk uk-UA ru) do (
    if not exist "%TARGET%\Bladesong\Content\Localization\Game\%%C" mkdir "%TARGET%\Bladesong\Content\Localization\Game\%%C" 2>nul
    copy /y "%~dp0Bladesong\Content\Localization\Game\%%C\Game.locres" "%TARGET%\Bladesong\Content\Localization\Game\%%C\Game.locres" >nul
)

set "CFG=%LOCALAPPDATA%\Bladesong\Saved\Config\Windows\GameUserSettings.ini"
if exist "%CFG%" (
    echo Налаштування конфігурації GameUserSettings.ini...
    powershell -NoProfile -Command "$cfg = '%CFG%'; $txt = Get-Content -LiteralPath $cfg -Raw; if ($txt -match 'Language=') { $txt = $txt -replace 'Language=[a-zA-Z0-9_-]+', 'Language=uk' } else { $txt = $txt -replace '(\[/Script/Bladesong\.BladesongSettings\])', "`$1`nLanguage=uk" }; Set-Content -LiteralPath $cfg -Value $txt"
)

echo.
echo ========================================================
echo [УСПІХ] Українізатор успішно встановлено та активовано!
echo ========================================================
echo.
pause
