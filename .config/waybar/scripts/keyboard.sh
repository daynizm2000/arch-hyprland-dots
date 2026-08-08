#!/bin/bash

# Парсим ТОЛЬКО твою китайскую клавиатуру за 300 рублей
keyboard_info=$(hyprctl devices | grep -A 15 "sino-wealth-gaming-kb")

# Проверяем раскладку
if echo "$keyboard_info" | grep -q "active keymap.*Russian"; then
    echo '{"text": "ru", "class": "ru"}'
elif echo "$keyboard_info" | grep -q "active keymap.*English"; then
    echo '{"text": "us", "class": "us"}'  
else
    echo '{"text": "??", "class": "error"}'
fi
