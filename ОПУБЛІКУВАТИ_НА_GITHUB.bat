@echo off
chcp 65001 >nul
title Публікація українізатора на GitHub

echo ========================================================
echo        ПУБЛІКАЦІЯ УКРАЇНІЗАТОРА BLADESONG НА GITHUB
echo ========================================================
echo.
echo Інструкція (1 хвилина):
echo 1. Відкрийте у браузері https://github.com/new
echo 2. У полі "Repository name" вкажіть: Bladesong-Ukrainizator
echo 3. Залиште репозиторій Public (Публічний).
echo 4. НЕ ставте галочки біля "Add a README" чи ".gitignore".
echo 5. Натисніть кнопку "Create repository".
echo 6. Скопіюйте посилання на ваш новий репозиторій (HTTPS).
echo.
echo ========================================================
set /p REPO_URL="Вставте посилання на ваш репозиторій GitHub: "

if "%REPO_URL%"=="" (
    echo [ПОМИЛКА] Посилання не введено.
    pause
    exit /b 1
)

echo.
echo Додавання віддаленого репозиторію...
git remote remove origin 2>nul
git remote add origin %REPO_URL%
git branch -M main

echo.
echo Відправка файлів на GitHub...
git push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo [УСПІХ] Проєкт успішно опубліковано на GitHub!
    echo Тепер перейдіть у розділ "Releases" вашого репозиторію
    echo та прикріпіть архів Bladesong_Ukrainizator.zip.
    echo ========================================================
) else (
    echo.
    echo [УВАГА] Не вдалося автоматично відправити файли.
    echo Переконайтеся, що ви авторизовані у GitHub або скористайтеся
    echo GitHub Desktop.
)

echo.
pause
