#!/bin/bash

# Переменные твоих цветов из Gradience
ACCENT="#7F70FF"
BG="#0c0512"
FG="#eff1f5"
DESTRUCTIVE="#ff7b63"
WARNING="#f8e45c"
SUCCESS="#8ff0a4"
CARD_BG="rgba(167, 139, 250, 0.08)"

# Список всех CSS файлов темы
CSS_FILES=$(find . -name "*.css" -type f)

for file in $CSS_FILES; do
    echo "🔄 Обрабатываю: $file"
    
    # Временный файл
    tmp_file="/tmp/$(basename $file).tmp"
    
    # Читаем оригинальный файл и заменяем цвета
    cat "$file" | sed -E "
        # Основные цвета Catppuccin Mocha
        s/#1e1e2e/$BG/g;
        s/#181825/$BG/g;
        s/#11111b/$BG/g;
        s/#313244/#1b0d2f/g;
        s/#45475a/#241f31/g;
        s/#585b70/#3d3846/g;
        s/#6c7086/#5e5c64/g;
        
        # Текст и акценты
        s/#cdd6f4/$ACCENT/g;
        s/#bac2de/$FG/g;
        s/#a6adc8/$FG/g;
        s/#9399b2/$FG/g;
        s/#7f849c/$FG/g;
        
        # Акцентные цвета Catppuccin (sky, mauve, etc.)
        s/#89dceb/$ACCENT/g;
        s/#74c7ec/$ACCENT/g;
        s/#94e2d5/$SUCCESS/g;
        s/#a6e3a1/$SUCCESS/g;
        s/#f38ba8/$DESTRUCTIVE/g;
        s/#fab387/$WARNING/g;
        s/#f9e2af/$WARNING/g;
        s/#cba6f7/$ACCENT/g;
        s/#b4befe/$ACCENT/g;
        s/#f5c2e7/#c061cb/g;
        s/#f2cdcd/#99c1f1/g;
        
        # RGBA варианты (прозрачность)
        s/rgba\(30, 30, 46,/rgba(12, 5, 18,/g;
        s/rgba\(205, 214, 244,/rgba(127, 112, 255,/g;
        s/rgba\(239, 241, 245,/rgba(127, 112, 255,/g;
        
        # Обновляем @define-color если они еще старые
        s/@define-color theme_selected_bg_color #[0-9a-fA-F]+;/@define-color theme_selected_bg_color $ACCENT;/g;
        s/@define-color theme_bg_color #[0-9a-fA-F]+;/@define-color theme_bg_color $BG;/g;
        s/@define-color theme_base_color #[0-9a-fA-F]+;/@define-color theme_base_color $BG;/g;
        s/@define-color theme_fg_color #[0-9a-fA-F]+;/@define-color theme_fg_color $FG;/g;
        s/@define-color error_color #[0-9a-fA-F]+;/@define-color error_color $DESTRUCTIVE;/g;
        s/@define-color warning_color #[0-9a-fA-F]+;/@define-color warning_color $WARNING;/g;
    " > "$tmp_file"
    
    # Копируем обратно
    mv "$tmp_file" "$file"
done

# Особо обработаем GTK3 файл (где много @define-color)
if [ -f "gtk-3.0/gtk.css" ]; then
    echo "🎯 Особо обрабатываю gtk-3.0/gtk.css"
    
    cat > /tmp/gtk3_patch.py << 'EOF'
#!/usr/bin/env python3
import re

with open('gtk-3.0/gtk.css', 'r') as f:
    content = f.read()

# Заменяем все @define-color
replacements = {
    'theme_fg_color': '#eff1f5',
    'theme_text_color': '#eff1f5', 
    'theme_bg_color': '#0c0512',
    'theme_base_color': '#0c0512',
    'theme_selected_bg_color': '#7F70FF',
    'theme_selected_fg_color': 'rgba(17, 17, 27, 0.87)',
    'insensitive_bg_color': '#0c0512',
    'insensitive_fg_color': 'rgba(239, 241, 245, 0.5)',
    'insensitive_base_color': '#0c0512',
    'theme_unfocused_fg_color': '#eff1f5',
    'theme_unfocused_text_color': '#eff1f5',
    'theme_unfocused_bg_color': '#0c0512',
    'theme_unfocused_base_color': '#0c0512',
    'theme_unfocused_selected_bg_color': '#7F70FF',
    'theme_unfocused_selected_fg_color': 'rgba(17, 17, 27, 0.87)',
    'unfocused_insensitive_color': 'rgba(239, 241, 245, 0.5)',
    'borders': 'rgba(239, 241, 245, 0.12)',
    'unfocused_borders': 'rgba(239, 241, 245, 0.12)',
    'warning_color': '#f8e45c',
    'error_color': '#ff7b63',
    'success_color': '#8ff0a4',
    'theme_button_background_normal': '#1b0d2f',
    'theme_button_decoration_focus': '#7F70FF',
    'theme_button_foreground_normal': '#eff1f5',
    'theme_button_foreground_active': '#0c0512',
    'theme_button_background_active': '#7F70FF',
}

for var_name, color in replacements.items():
    pattern = rf'@define-color {re.escape(var_name)} [^;]+;'
    replacement = f'@define-color {var_name} {color};'
    content = re.sub(pattern, replacement, content)

with open('gtk-3.0/gtk.css', 'w') as f:
    f.write(content)
EOF
    
    python3 /tmp/gtk3_patch.py
fi

# Для GNOME Shell если есть
if [ -d "gnome-shell" ]; then
    echo "🎨 Обновляю gnome-shell"
    find gnome-shell -name "*.css" -exec sed -i "
        s/#1e1e2e/#0c0512/g;
        s/#181825/#0c0512/g;
        s/#cdd6f4/#7F70FF/g;
        s/#89dceb/#7F70FF/g;
        s/#eff1f5/#7F70FF/g;
        s/rgba(30, 30, 46,/rgba(12, 5, 18,/g;
    " {} \;
fi

echo "✅ Готово! Обнови кэш и проверь:"
echo "gtk4-update-icon-cache"
echo "gnome-shell --replace &"
