# Bladesong — Повний українізатор (Ukrainian Localization)

Версія локалізації: 3.0 (Повна літературна вичитка)  
Сумісність: Bladesong (ранній доступ / повна версія)  
Обсяг: 403 простори імен, 15 213 локалізаційних ключів  

---

## 1. Опис проєкту

Цей проєкт надає повний і вичитаний переклад відеогри Bladesong українською мовою. Перекладено весь наявний текстовий масив гри:
- Сюжетні лінії, діалоги, записи журналів завдань;
- Усі репліки персонажів у таборі та випадкові зустрічі;
- Інтерфейс користувача, меню налаштувань, підказки та навчальні матеріали;
- Описи ковальських властивостей, деталі клинків, руни, матеріали та системні показники;
- Досягнення та записи компендіуму.

Локалізація пройшла повну вичитку з виправленням граматичного узгодження родів персонажів, коректним відтворенням англійських ідіом та адаптацією зброярської термінології.

---

## 2. Авторство та умови вільного використання

- Автор локалізації: Автор проєкту (розробник українізатора).
- Умови поширення та ліцензія: Вільне використання (Permissive / Open License).

Цей переклад створено для розвитку українського ігрового простору та вільного доступу гравців. Будь-яка особа чи організація має право:
1. Вільно завантажувати, встановлювати та поширювати цей українізатор на будь-яких ресурсах.
2. Включати його до складу власних збірок, модпаків або модифікацій без потреби отримання спеціальних дозволів.
3. Офіційним розробникам гри (David Krummenacher / Team SolEtude) надається безумовне право безкоштовно інтегрувати цей переклад безпосередньо до офіційного дистрибутива гри в Steam або інших магазинах.
4. Модифікувати, вдосконалювати та адаптувати локалізацію під майбутні оновлення гри.

За можливості рекомендується зберігати згадку про первинне авторство.

---

## 3. Інструкція зі встановлення

### Спосіб 1: Автоматичний (рекомендовано)
1. Завантажте релізний архів або клонуйте цей репозиторій.
2. Скопіюйте вміст у кореневу папку зі встановленою грою Bladesong (туди, де знаходиться Bladesong.exe).
3. Запустіть файл `1_КЛІК_ВСТАНОВИТИ_УКРАЇНІЗАТОР.bat` (або `Install_Ukrainizator.bat`).
4. Скрипт автоматично перевірить структуру папок, створить резервну копію оригінальних файлів і встановить українську мову за замовчуванням.

### Спосіб 2: Ручний
1. Скопіюйте папку `Bladesong` з цього репозиторію в кореневу папку гри з підтвердженням заміни файлів.
2. Переклад замінює файли `Game.locres` для мовних конфігурацій гри, тому гра відображатиметься українською мовою.

---

## 4. Видалення
Для повернення до оригінальної англійської версії запустіть `Видалити_Українізатор.bat` або відновіть файл `Game_en_original.locres`.

---
---

# Bladesong — Full Ukrainian Localization

Localization Version: 3.0 (Full Literary Proofreading)  
Compatibility: Bladesong (Early Access / Full Release)  
Scope: 403 namespaces, 15,213 localization keys  

---

## 1. Project Overview

This repository provides a comprehensive and high-quality Ukrainian fan localization for the video game Bladesong. The entire in-game text has been translated and thoroughly reviewed:
- Main storyline, dialogues, cutscenes, and quest logs;
- Camp encounters, merchant interactions, and NPC dialogues;
- User interface, settings, tooltips, and tutorials;
- Blacksmithing and swordsmithing mechanics, blade traits, parts, runes, and physics parameters;
- Steam achievements and lore compendium.

The localization has undergone rigorous verification, ensuring proper character gender agreements, authentic rendering of English idioms, and technically accurate bladesmithing terminology.

---

## 2. Authorship and Terms of Free Use

- Localization Author: Project Author (Community Contributor).
- License: Open Permissive Terms (MIT License / Free Public Domain Dedication).

This project was created to support the Ukrainian gaming community. Anyone is free to:
1. Freely download, install, mirror, and redistribute this localization across any platform or website.
2. Include these files in fan patches, mod compilations, or repackaged installers without requiring special permissions.
3. The official developers of Bladesong (David Krummenacher / Team SolEtude) are explicitly granted full permission to integrate, modify, and distribute this localization as part of the official game build on Steam or any other storefront without fees or restrictions.
4. Modify, update, and maintain the translation for future game patches.

Attribution to the original author is appreciated when feasible.

---

## 3. Installation Guide

### Method 1: Automatic (Recommended)
1. Download the release archive or clone this repository.
2. Place the files into your root Bladesong game directory (where Bladesong.exe resides).
3. Run `Install_Ukrainizator.bat` (or `1_КЛІК_ВСТАНОВИТИ_УКРАЇНІЗАТОР.bat`).
4. The script will verify game directories, safely back up original files, and set Ukrainian as the active language.

### Method 2: Manual
1. Copy the `Bladesong` folder from this repository into your root Bladesong directory, confirming file replacement when prompted.

---

## 4. Uninstallation
To restore the original English files, execute `Uninstall_Ukrainizator.bat`.

---

## 5. License
Distributed under the MIT License. See `LICENSE` for details.
