#!/bin/bash

gpu_info=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)

if [ $? -eq 0 ]; then
    temp=$(echo "$gpu_info" | sed 's/ //g')  # Убираем пробелы
    echo "{\"text\": \"${temp}\", \"tooltip\": \"GPU Temperature: ${temp}°C\"}"
else
    echo "{\"text\": \"ERR\", \"tooltip\": \"NVIDIA not working\"}"
fi
