@echo off
chcp 65001 >nul
title Bladesong - Видалення Українізатора

set "DEST=%~dp0..\Content\Localization\Game"
if not exist "%DEST%" set "DEST=%~dp0Bladesong\Content\Localization\Game"
if exist "%DEST%\en\Game_en_original.locres" copy /y "%DEST%\en\Game_en_original.locres" "%DEST%\en\Game.locres" >nul

set "CFG=%LOCALAPPDATA%\Bladesong\Saved\Config\Windows\GameUserSettings.ini"
if exist "%CFG%" (
    powershell -NoProfile -Command "$cfg = '%CFG%'; $txt = Get-Content -LiteralPath $cfg -Raw; $txt = $txt -replace 'Language=[a-zA-Z0-9_-]+', 'Language=en'; Set-Content -LiteralPath $cfg -Value $txt"
)

echo [УСПІХ] Українізатор видалено, повернено оригінальну мову.
pause
