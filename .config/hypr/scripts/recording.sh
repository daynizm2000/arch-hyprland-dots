#!/bin/bash


RECORDING_DIR="$HOME/Videos"
LOCK_FILE="/tmp/gpu-screen-recorder.pid"
LOG_FILE="/tmp/gpu-screen-recorder.log"


AUDIO_SOURCE="default_output"


mkdir -p "$RECORDING_DIR"

start_recording() {
    filename="$RECORDING_DIR/recording_$(date +'%Y-%m-%d_%H-%M-%S').mp4"

    gpu-screen-recorder \
        -w screen \
        -f 60 \
        -q high \
        -a "$AUDIO_SOURCE" \
        -o "$filename" \
        > "$LOG_FILE" 2>&1 &

    echo $! > "$LOCK_FILE"

    notify-send \
        -i /usr/share/icons/YAMIS/apps/scalable/mpv.svg \
        "Screen Recording" \
        "Start Record"
}

stop_recording() {
    if [ -f "$LOCK_FILE" ]; then
        pkill -INT -f gpu-screen-recorder

        rm -f "$LOCK_FILE"

        notify-send \
            -i /usr/share/icons/YAMIS/apps/scalable/mpv.svg \
            "Screen Recording" \
            "End Record"
    fi
}

if [ -f "$LOCK_FILE" ] && pgrep -f gpu-screen-recorder > /dev/null; then
    stop_recording
else
    start_recording
fi
